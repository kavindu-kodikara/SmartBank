package com.kv.app.core.service;

import com.kv.app.core.dto.TransactionDataDto;

public interface ScheduleTransactionService {
    public void scheduleTransaction(TransactionDataDto transactionData);
}
