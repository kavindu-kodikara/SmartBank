package com.kv.app.core.service.user;

import com.kv.app.core.entity.Transaction;

import java.util.List;
import java.util.Map;

public interface UserTransactionHistoryService {
    public Map<String,Object> getRecentTransactions(Long userId);
    public String getAllTransactions(Long userId);
    public Transaction getTransaction(Long transactionId);
}
