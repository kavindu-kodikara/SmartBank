package com.kv.app.core.service;

import com.kv.app.core.entity.User;

import java.util.List;

public interface UserService {
    public List<User> findAll();
    public User findByUsername(String username);
    public void save(User user);
    public User findById(Long id);
    public void update(User user);
}
