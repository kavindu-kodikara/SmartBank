package com.kv.app.core.service;

import com.kv.app.core.dto.TransactionDataDto;

public interface TransactionService {
    public void internalTransaction(TransactionDataDto transactionData);
    public void externalTransaction(TransactionDataDto transactionData);
}
