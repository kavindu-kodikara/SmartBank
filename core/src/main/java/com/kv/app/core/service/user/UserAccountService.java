package com.kv.app.core.service.user;

import com.kv.app.core.entity.Account;

import java.util.List;

public interface UserAccountService {
    public List<Account> getAccounts(Long userId);
}
