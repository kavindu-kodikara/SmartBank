package com.kv.app.transaction;

import com.kv.app.core.entity.Account;
import com.kv.app.core.exception.InsufficientBalanceException;
import com.kv.app.core.interceptor.AuditLogInterceptor;
import com.kv.app.core.service.AccountService;
import jakarta.ejb.Stateless;
import jakarta.interceptor.Interceptors;
import jakarta.persistence.EntityManager;
import jakarta.persistence.LockModeType;
import jakarta.persistence.PersistenceContext;

@Stateless
@Interceptors({AuditLogInterceptor.class})
public class AccountSessionBean implements AccountService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void credit(String accountNumber, Double amount) {

        if(amount < 10){
            throw new IllegalArgumentException("Amount must be greater than 10");
        }

        Account account = em.find(Account.class, accountNumber, LockModeType.PESSIMISTIC_WRITE);
        account.setBalance(account.getBalance() + amount);
        em.merge(account);
    }

    @Override
    public void debit(String accountNumber, Double amount) {

        Account account = em.find(Account.class, accountNumber, LockModeType.PESSIMISTIC_WRITE);

        if(amount < 10){
            throw new IllegalArgumentException("Amount must be greater than 10");
        }

        if(account.getBalance() < amount+1000){
            throw new InsufficientBalanceException("Insufficient balance");
        }

        account.setBalance(account.getBalance() - amount);
        em.merge(account);

    }
}
