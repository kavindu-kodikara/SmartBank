package com.kv.app.auth;

import com.kv.app.core.entity.User;
import com.kv.app.core.interceptor.AuditLogInterceptor;
import com.kv.app.core.service.OTPService;
import com.kv.app.core.service.user.UserService;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.interceptor.Interceptors;

import java.util.Map;

@Stateless
@Interceptors({AuditLogInterceptor.class})
public class OTPSessionBean implements OTPService {

    @EJB
    private UserService userService;

    @Override
    public Map<String, Object> verifyOTP(String otpCode, String username) {
        User user = userService.findByUsername(username);
        return Map.of(
                "isValid", user.getVerificationCode().equals(otpCode),
                "role", user.getUserType()
        );
    }
}
