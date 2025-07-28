package com.kv.app.transaction;

import com.kv.app.core.dto.TransactionDataDto;
import com.kv.app.core.entity.Account;
import com.kv.app.core.entity.Transaction;
import com.kv.app.core.entity.TransactionType;
import com.kv.app.core.exception.InvalidAccountException;
import com.kv.app.core.interceptor.AuditLogInterceptor;
import com.kv.app.core.service.AccountService;
import com.kv.app.core.service.TransactionService;
import jakarta.annotation.security.PermitAll;
import jakarta.ejb.*;
import jakarta.interceptor.Interceptors;
import jakarta.persistence.EntityManager;
import jakarta.persistence.LockModeType;
import jakarta.persistence.PersistenceContext;

import java.util.Date;

@Stateless
@TransactionAttribute(TransactionAttributeType.REQUIRED)
@ApplicationException(rollback = true)
@Interceptors({AuditLogInterceptor.class})
@PermitAll
public class TransactionSessionBean implements TransactionService {

    @EJB
    private AccountService accountService;

    @PersistenceContext
    private EntityManager em;

    @Override
    public void internalTransaction(TransactionDataDto transactionData) {

        Account fromAccount = em.find(Account.class, transactionData.getFromAccount(),LockModeType.PESSIMISTIC_WRITE);
        Account toAccount = em.find(Account.class, transactionData.getToAccount(),LockModeType.PESSIMISTIC_WRITE);

        accountService.debit(transactionData.getFromAccount(), transactionData.getAmount());
        accountService.credit(transactionData.getToAccount(), transactionData.getAmount());


        Transaction transaction = new Transaction(new Date(), transactionData.getAmount(), TransactionType.TRANSFER,transactionData.getDescription(),fromAccount,toAccount);

        em.persist(transaction);

    }

    @Lock
    @Override
    public String externalTransaction(TransactionDataDto transactionData) {

        Account account = em.find(Account.class, transactionData.getToAccount(), LockModeType.PESSIMISTIC_WRITE);
        if(account == null) {
            throw new InvalidAccountException("Account not found");
        }

        accountService.debit(transactionData.getFromAccount(), transactionData.getAmount());
        accountService.credit(transactionData.getToAccount(), transactionData.getAmount());

        Account fromAccount = em.find(Account.class, transactionData.getFromAccount());
        Account toAccount = em.find(Account.class, transactionData.getToAccount());
        Transaction transaction = new Transaction(new Date(), transactionData.getAmount(), TransactionType.TRANSFER, transactionData.getDescription(), fromAccount,toAccount);

        em.persist(transaction);
        em.flush();
        return String.valueOf(transaction.getId());
    }
}
