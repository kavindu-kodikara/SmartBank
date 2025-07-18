package com.kv.app.core.service.admin;

import com.kv.app.core.dto.AdminDashboardDataDto;
import com.kv.app.core.entity.Account;
import com.kv.app.core.entity.User;

import java.util.List;

public interface AdminDashboardService {
    public AdminDashboardDataDto getDashboardData();
    public List<User> getAllUsers();
    public List<Account> getAllAccounts();
    public boolean deposit(String accountId, double amount);
}
