package com.kv.app.core.service;

import java.util.Map;

public interface OTPService {
    public Map verifyOTP(String otpCode, String username);
}
