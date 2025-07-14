package com.kv.app.core.exception;

import jakarta.ejb.ApplicationException;

@ApplicationException(rollback = true)
public class InvalidAccountException extends  RuntimeException {
    public InvalidAccountException(String message) {
        super(message);
    }
}
