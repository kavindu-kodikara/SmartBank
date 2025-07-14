package com.kv.app.user;

import com.google.gson.Gson;
import com.kv.app.core.dto.TransactionDto;
import com.kv.app.core.entity.Account;
import com.kv.app.core.entity.Transaction;
import com.kv.app.core.entity.User;
import com.kv.app.core.service.user.UserTransactionHistoryService;
import jakarta.ejb.EJBException;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import javax.xml.crypto.Data;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Stateless
public class TransactionHistorySessionBean implements UserTransactionHistoryService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Map<String,Object> getRecentTransactions(Long userId) {

        User user = em.find(User.class, userId);
        List<Account> accountList = user.getAccounts();

        List<Transaction> transactionList = em.createNamedQuery("Transaction.findRecentByUserId", Transaction.class)
                .setParameter("accountId", accountList.get(0).getAccountNumber())
                .setMaxResults(5)
                .getResultList();

        return Map.of(
                "transactionList",transactionList,
                "accountId",accountList.get(0).getAccountNumber()
        );
    }

    @Override
    public String getAllTransactions(Long userId) {
        User user = em.find(User.class, userId);
        List<Account> accountList = user.getAccounts();

        Map<String, LinkedHashMap<String, List<TransactionDto>>> transactionMap = new LinkedHashMap<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd");

        for (Account account : accountList) {
            List<Transaction> transactions = em.createNamedQuery("Transaction.findByAccountNumber", Transaction.class)
                    .setParameter("accNumber", account.getAccountNumber())
                    .getResultList();

            List<TransactionDto> dtoList = transactions.stream()
                    .map(TransactionDto::new)
                    .collect(Collectors.toList());

            TreeMap<LocalDate, List<TransactionDto>> sortedGrouped = dtoList.stream()
                    .collect(Collectors.groupingBy(
                            tx -> tx.getTimestamp().toInstant()
                                    .atZone(ZoneId.systemDefault())
                                    .toLocalDate(),
                            TreeMap::new,
                            Collectors.toList()
                    ));

            NavigableMap<LocalDate, List<TransactionDto>> reversed = sortedGrouped.descendingMap();

            LinkedHashMap<String, List<TransactionDto>> formattedMap = new LinkedHashMap<>();
            for (Map.Entry<LocalDate, List<TransactionDto>> entry : reversed.entrySet()) {
                String formattedDate = entry.getKey().format(formatter);
                formattedMap.put(formattedDate, entry.getValue());
            }

            transactionMap.put(account.getAccountNumber(), formattedMap);
        }

        Gson gson = new Gson();
        return gson.toJson(transactionMap);
    }

}
