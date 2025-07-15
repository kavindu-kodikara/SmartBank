package com.kv.app.transaction;

import com.kv.app.core.entity.Account;
import com.kv.app.core.entity.InterestRecord;
import com.kv.app.core.entity.Transaction;
import com.kv.app.core.entity.TransactionType;
import jakarta.ejb.Schedule;
import jakarta.ejb.Singleton;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.Date;
import java.util.List;

@Singleton
public class InterestScheduler {

    @PersistenceContext
    private EntityManager em;

    @Schedule(hour = "0", minute = "0", second = "0", persistent = false)
//    @Schedule(minute = "*", hour = "*", persistent = false)
    public void applyDailyInterest() {
        List<Account> accountList = em.createQuery("SELECT a FROM Account a", Account.class)
                .getResultList();

        for (Account account : accountList) {
            if (account.getBalance() != null && account.getBalance() > 0) {
                double dailyRate = 10.0 / 365;
                double interest = account.getBalance() * (dailyRate / 100);
                interest = Math.round(interest * 100.0) / 100.0;

                account.setBalance(account.getBalance() + interest);

                Transaction transaction = new Transaction(new Date(), interest, TransactionType.INTEREST,"Daily Interest Payment",null,account);

                InterestRecord interestRecord = new InterestRecord(new Date(), interest, account);

                em.merge(account);
                em.persist(transaction);
                em.persist(interestRecord);
            }
        }
    }
}
