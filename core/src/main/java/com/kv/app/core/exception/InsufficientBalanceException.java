package com.kv.app.core.exception;

import jakarta.ejb.ApplicationException;

@ApplicationException(rollback = true)
public class InsufficientBalanceException extends  RuntimeException {
    public InsufficientBalanceException(String message) {
        super(message);
    }
}
