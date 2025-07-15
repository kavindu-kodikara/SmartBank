package com.kv.app.core.dto;

import java.io.Serializable;

public class AdminDashboardDataDto implements Serializable {
    private String totUsers;
    private String totAccounts;
    private String totTransactions;
    private String totBalances;

    public AdminDashboardDataDto() {
    }

    public AdminDashboardDataDto(String totUsers, String totAccounts, String totTransactions, String totBalances) {
        this.totUsers = totUsers;
        this.totAccounts = totAccounts;
        this.totTransactions = totTransactions;
        this.totBalances = totBalances;
    }

    public String getTotUsers() {
        return totUsers;
    }

    public void setTotUsers(String totUsers) {
        this.totUsers = totUsers;
    }

    public String getTotAccounts() {
        return totAccounts;
    }

    public void setTotAccounts(String totAccounts) {
        this.totAccounts = totAccounts;
    }

    public String getTotTransactions() {
        return totTransactions;
    }

    public void setTotTransactions(String totTransactions) {
        this.totTransactions = totTransactions;
    }

    public String getTotBalances() {
        return totBalances;
    }

    public void setTotBalances(String totBalances) {
        this.totBalances = totBalances;
    }
}
