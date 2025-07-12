package com.kv.app.core.service.user;

import com.kv.app.core.dto.UserDto;
import com.kv.app.core.entity.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    public List<User> findAll();
    public User findByUsername(String username);
    public Map<String, Object> registerUser(UserDto userDto);
    public boolean createUsername(String username, String password, String userId);
}
