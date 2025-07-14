package com.kv.app.core.dto;

import com.kv.app.core.entity.Transaction;
import com.kv.app.core.entity.User;

import java.io.Serializable;
import java.util.Date;

public class TransactionDto implements Serializable {
    private Long id;
    private Date timestamp;
    private Double amount;
    private String transactionType;
    private String description;

    private String fromAccount;
    private String fromUserFname;

    private String toAccount;
    private String toUserFname;

    public TransactionDto(Transaction t) {
        this.id = t.getId();
        this.timestamp = t.getTimestamp();
        this.amount = t.getAmount();
        this.transactionType = t.getTransactionType().name();
        this.description = t.getDescription();

        if (t.getFromAccount() != null) {
            this.fromAccount = t.getFromAccount().getAccountNumber();
            User fromUser = t.getFromAccount().getUser();
            this.fromUserFname = fromUser != null ? fromUser.getFname() : null;
        }

        if (t.getToAccount() != null) {
            this.toAccount = t.getToAccount().getAccountNumber();
            User toUser = t.getToAccount().getUser();
            this.toUserFname = toUser != null ? toUser.getFname() : null;
        }
    }

    public TransactionDto() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getFromAccount() {
        return fromAccount;
    }

    public void setFromAccount(String fromAccount) {
        this.fromAccount = fromAccount;
    }

    public String getFromUserFname() {
        return fromUserFname;
    }

    public void setFromUserFname(String fromUserFname) {
        this.fromUserFname = fromUserFname;
    }

    public String getToAccount() {
        return toAccount;
    }

    public void setToAccount(String toAccount) {
        this.toAccount = toAccount;
    }

    public String getToUserFname() {
        return toUserFname;
    }

    public void setToUserFname(String toUserFname) {
        this.toUserFname = toUserFname;
    }
}

