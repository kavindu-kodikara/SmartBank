package com.kv.app.core.entity;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Date;

@Entity
@NamedQueries({
        @NamedQuery(name = "Transaction.findRecentByUserId",
                query = "SELECT t FROM Transaction t " +
                        "WHERE t.fromAccount.accountNumber = :accountId OR t.toAccount.accountNumber = :accountId " +
                        "ORDER BY t.timestamp DESC"),
        @NamedQuery(
                name = "Transaction.findByAccountNumber",
                query = "SELECT t FROM Transaction t " +
                        "WHERE t.fromAccount.accountNumber = :accNumber OR t.toAccount.accountNumber = :accNumber " +
                        "ORDER BY t.timestamp ASC"
        )

})
public class Transaction implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @Column(name = "timestamp")
    private Date timestamp;
    @Column(name = "amount")
    private Double amount;
    @Column(name = "transactionType")
    @Enumerated(EnumType.STRING)
    private TransactionType transactionType;
    @Column(name = "description")
    private String description;

    @ManyToOne
    private Account fromAccount;

    @ManyToOne
    private Account toAccount;

    public Transaction() {
    }

    public Transaction(Date timestamp, Double amount, TransactionType transactionType,String description, Account toAccount) {
        this.timestamp = timestamp;
        this.amount = amount;
        this.transactionType = transactionType;
        this.toAccount = toAccount;
        this.description = description;
    }

    public Transaction(Date timestamp, Double amount, TransactionType transactionType,String description, Account fromAccount, Account toAccount) {
        this.timestamp = timestamp;
        this.amount = amount;
        this.transactionType = transactionType;
        this.fromAccount = fromAccount;
        this.toAccount = toAccount;
        this.description = description;
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

    public TransactionType getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(TransactionType transactionType) {
        this.transactionType = transactionType;
    }

    public Account getFromAccount() {
        return fromAccount;
    }

    public void setFromAccount(Account fromAccount) {
        this.fromAccount = fromAccount;
    }

    public Account getToAccount() {
        return toAccount;
    }

    public void setToAccount(Account toAccount) {
        this.toAccount = toAccount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
