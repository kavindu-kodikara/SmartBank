package com.kv.app.transaction;

import com.kv.app.core.dto.TransactionDataDto;
import com.kv.app.core.entity.Account;
import com.kv.app.core.entity.Transaction;
import com.kv.app.core.entity.TransactionType;
import com.kv.app.core.exception.InvalidAccountException;
import com.kv.app.core.service.AccountService;
import com.kv.app.core.service.TransactionService;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.Date;

@Stateless
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class TransactionSessionBean implements TransactionService {

    @EJB
    private AccountService accountService;

    @PersistenceContext
    private EntityManager em;

    @Override
    public void internalTransaction(TransactionDataDto transactionData) {

        accountService.debit(transactionData.getFromAccount(), transactionData.getAmount());
        accountService.credit(transactionData.getToAccount(), transactionData.getAmount());

        Account fromAccount = em.find(Account.class, transactionData.getFromAccount());
        Account toAccount = em.find(Account.class, transactionData.getToAccount());

        Transaction transaction = new Transaction(new Date(), transactionData.getAmount(), TransactionType.TRANSFER,transactionData.getDescription(),fromAccount,toAccount);

        em.persist(transaction);

    }

    @Override
    public void externalTransaction(TransactionDataDto transactionData) {

        Account account = em.find(Account.class, transactionData.getToAccount());
        if(account == null) {
            throw new InvalidAccountException("Account not found");
        }

        accountService.debit(transactionData.getFromAccount(), transactionData.getAmount());
        accountService.credit(transactionData.getToAccount(), transactionData.getAmount());

        Account fromAccount = em.find(Account.class, transactionData.getFromAccount());
        Account toAccount = em.find(Account.class, transactionData.getToAccount());
        Transaction transaction = new Transaction(new Date(), transactionData.getAmount(), TransactionType.TRANSFER, transactionData.getDescription(), fromAccount,toAccount);

        em.persist(transaction);
    }
}
