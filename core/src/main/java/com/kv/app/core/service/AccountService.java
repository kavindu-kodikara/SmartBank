package com.kv.app.core.service;

import com.kv.app.core.dto.TransactionDataDto;

public interface AccountService {
    public void credit(String accountNumber, Double amount);
    public void debit(String accountNumber, Double amount);
}
