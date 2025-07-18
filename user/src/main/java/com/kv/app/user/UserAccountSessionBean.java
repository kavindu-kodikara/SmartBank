package com.kv.app.user;

import com.kv.app.core.entity.Account;
import com.kv.app.core.entity.User;
import com.kv.app.core.service.user.UserAccountService;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;

@Stateless
@RolesAllowed("USER")
public class UserAccountSessionBean implements UserAccountService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<Account> getAccounts(Long userId) {
        User user = em.find(User.class, userId);
        List<Account> accountList = em.createNamedQuery("Account.findAllByUser", Account.class).setParameter("user", user).getResultList();
        System.out.println(accountList.size());
        return accountList;
    }
}
