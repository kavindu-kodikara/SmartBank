package com.kv.app.core.entity;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.List;

@Entity
@NamedQueries({
        @NamedQuery(name = "Account.findAllByUser",query = "select a from Account a where a.user =:user")
})
public class Account implements Serializable {

    @Id
    @Column(name = "accountNumber",unique = true)
    private String accountNumber;
    @Column(name = "balance")
    private Double balance;
    @Column(name = "active")
    private boolean active = true;

    @ManyToOne
    private User user;

    @OneToMany(mappedBy = "fromAccount",cascade = CascadeType.ALL,fetch = FetchType.LAZY)
    private List<Transaction> outgoingTransactions;

    @OneToMany(mappedBy = "toAccount",cascade = CascadeType.ALL,fetch = FetchType.LAZY)
    private List<Transaction> incomingTransactions;

    @OneToMany(mappedBy = "fromAccount",cascade = CascadeType.ALL,fetch = FetchType.LAZY)
    private List<ScheduledTransfer> outgoingScheduledTransfer;

    @OneToMany(mappedBy = "toAccount",cascade = CascadeType.ALL,fetch = FetchType.LAZY)
    private List<ScheduledTransfer> incomingScheduledTransfer;

    public Account() {
    }

    public Account(String accountNumber, Double balance, User user) {
        this.accountNumber = accountNumber;
        this.balance = balance;
        this.user = user;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public Double getBalance() {
        return balance;
    }

    public void setBalance(Double balance) {
        this.balance = balance;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<ScheduledTransfer> getOutgoingScheduledTransfer() {
        return outgoingScheduledTransfer;
    }

    public void setOutgoingScheduledTransfer(List<ScheduledTransfer> outgoingScheduledTransfer) {
        this.outgoingScheduledTransfer = outgoingScheduledTransfer;
    }

    public List<ScheduledTransfer> getIncomingScheduledTransfer() {
        return incomingScheduledTransfer;
    }

    public void setIncomingScheduledTransfer(List<ScheduledTransfer> incomingScheduledTransfer) {
        this.incomingScheduledTransfer = incomingScheduledTransfer;
    }

    public List<Transaction> getOutgoingTransactions() {
        return outgoingTransactions;
    }

    public void setOutgoingTransactions(List<Transaction> outgoingTransactions) {
        this.outgoingTransactions = outgoingTransactions;
    }

    public List<Transaction> getIncomingTransactions() {
        return incomingTransactions;
    }

    public void setIncomingTransactions(List<Transaction> incomingTransactions) {
        this.incomingTransactions = incomingTransactions;
    }
}
