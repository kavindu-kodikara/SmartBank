package com.kv.app.admin;

import com.kv.app.core.dto.AdminDashboardDataDto;
import com.kv.app.core.entity.*;
import com.kv.app.core.interceptor.AuditLogInterceptor;
import com.kv.app.core.service.TransactionService;
import com.kv.app.core.service.admin.AdminDashboardService;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.interceptor.Interceptors;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.Date;
import java.util.List;

@Stateless
@RolesAllowed("ADMIN")
public class AdminDashboardSessionBean implements AdminDashboardService {

    @PersistenceContext
    EntityManager em;

    @Override
    public AdminDashboardDataDto getDashboardData() {

        Long totUser = em.createQuery("SELECT COUNT(u) FROM User u WHERE u.userType =:userType",Long.class).setParameter("userType", UserType.USER).getSingleResult();

        Long totAccount = em.createQuery("SELECT COUNT(a) FROM Account a",Long.class).getSingleResult();
        Long totTransaction = em.createQuery("SELECT COUNT(t) FROM Transaction t",Long.class).getSingleResult();
        Double totBalance = em.createQuery("SELECT SUM(a.balance) FROM Account a",Double.class).getSingleResult();

        return new AdminDashboardDataDto(String.valueOf(totUser),String.valueOf(totAccount),String.valueOf(totTransaction),formatBalance(totBalance));

    }

    @Override
    public List<User> getAllUsers() {
        return em.createQuery("SELECT u FROM User u WHERE u.userType =:userType", User.class).setParameter("userType",UserType.USER).getResultList();
    }

    @Override
    public List<Account> getAllAccounts() {
        return em.createQuery("SELECT a FROM Account a", Account.class).getResultList();
    }


    @Override
    @Interceptors({AuditLogInterceptor.class})
    public boolean deposit(String accountId, double amount) {

        Account account = em.find(Account.class, accountId);
        if(account == null) {
            return false;
        }

        account.setBalance(account.getBalance() + amount);

        Transaction transaction = new Transaction(new Date(), amount, TransactionType.DEPOSIT,"Bank deposit",null,account);

        em.merge(account);
        em.persist(transaction);

        return true;

    }

    public String formatBalance(double number) {
        if (number >= 1_000_000_000) {
            return String.format("%.1fB", number / 1_000_000_000.0);
        } else if (number >= 1_000_000) {
            return String.format("%.1fM", number / 1_000_000.0);
        } else if (number >= 1_000) {
            return String.format("%.1fK", number / 1_000.0);
        } else {
            return String.format("%.0f", number);
        }
    }

}
