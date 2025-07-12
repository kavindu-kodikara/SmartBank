<%--
  Created by IntelliJ IDEA.
  User: kv
  Date: 7/9/2025
  Time: 5:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Bank | Create Account</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @font-face {
            font-family: 'Neon';
            src: url('https://fonts.cdnfonts.com/css/neon-80s');
            font-weight: normal;
        }

        :root {
            --primary: #4361ee;
            --primary-light: #e6e9ff;
            --primary-dark: #3a0ca3;
            --secondary: #4cc9a0;
            --secondary-dark: #3aa888;
            --danger: #ef233c;
            --light: #ffffff;
            --light-gray: #f8f9fa;
            --medium-gray: #e9ecef;
            --dark-gray: #6c757d;
            --dark: #212529;
            --glass: rgba(255, 255, 255, 0.85);
            --glass-border: rgba(0, 0, 0, 0.08);
            --glass-highlight: rgba(255, 255, 255, 0.95);
        }

        body {
            font-family: 'Rajdhani', 'Segoe UI', sans-serif;
            background-color: var(--light-gray);
            color: var(--dark);
            min-height: 100vh;
            padding-top: 2rem ;
            padding-bottom: 2rem ;
            display: flex;
            align-items: center;
        }

        .login-container {
            width: 100%;
            max-width: 420px;
            margin: 0 auto;
            padding: 2rem;
            background: var(--glass);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid var(--glass-border);
            position: relative;
            overflow: hidden;
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(
                    to bottom right,
                    rgba(255, 255, 255, 0.1),
                    rgba(255, 255, 255, 0.3),
                    rgba(255, 255, 255, 0.1)
            );
            transform: rotate(30deg);
            animation: shine 8s infinite linear;
            z-index: -1;
        }

        @keyframes shine {
            0% { transform: translateX(-100%) rotate(30deg); }
            100% { transform: translateX(100%) rotate(30deg); }
        }

        .login-logo {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-logo img {
            width: 80px;
            margin-bottom: 1rem;
        }

        .login-logo h1 {
            font-family: 'Neon', sans-serif;
            font-size: 2.5rem;
            color: var(--primary-dark);
            margin: 0;
            letter-spacing: 1px;
        }

        .login-logo p {
            color: var(--dark-gray);
            font-size: 0.9rem;
        }

        .form-control {
            background: var(--glass-highlight);
            border: 1px solid var(--glass-border);
            border-radius: 12px;
            padding: 0.75rem 1rem;
            margin-bottom: 1rem;
            transition: all 0.3s;
        }

        .form-control:focus {
            background: var(--glass-highlight);
            border-color: var(--primary);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.15);
        }

        .input-group-text {
            background: var(--glass-highlight);
            border: 1px solid var(--glass-border);
            border-right: none;
            border-radius: 12px 0 0 12px !important;
        }

        .btn-login {
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 0.75rem;
            font-weight: 600;
            width: 100%;
            margin-top: 1rem;
            transition: all 0.3s;
        }

        .btn-login:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }

        .verification-code {
            display: flex;
            justify-content: space-between;
            margin: 1.5rem 0;
        }

        .verification-code input {
            width: 50px;
            height: 60px;
            text-align: center;
            font-size: 1.5rem;
            font-weight: bold;
            border-radius: 10px;
            border: 1px solid var(--glass-border);
            background: var(--glass-highlight);
        }

        .verification-code input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.15);
            outline: none;
        }

        .login-footer {
            text-align: center;
            margin-top: 2rem;
            font-size: 0.85rem;
            color: var(--dark-gray);
        }

        .login-footer a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
        }

        .login-footer a:hover {
            text-decoration: underline;
        }

        .security-alert {
            background: rgba(239, 35, 60, 0.1);
            border-left: 4px solid var(--danger);
            padding: 0.75rem;
            border-radius: 0 8px 8px 0;
            margin-bottom: 1.5rem;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
        }

        .security-alert i {
            color: var(--danger);
            margin-right: 0.5rem;
            font-size: 1.2rem;
        }

        .login-step {
            display: none;
            animation: fadeIn 0.5s ease-in;
        }

        .login-step.active {
            display: block;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .resend-code {
            text-align: center;
            margin-top: 1rem;
            font-size: 0.85rem;
        }

        .resend-code a {
            color: var(--primary);
            text-decoration: none;
            cursor: pointer;
        }

        .resend-code a:hover {
            text-decoration: underline;
        }

        .password-strength {
            margin-top: -0.5rem;
            margin-bottom: 1rem;
            height: 5px;
            background: var(--medium-gray);
            border-radius: 5px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: width 0.3s, background-color 0.3s;
        }

        .password-requirements {
            font-size: 0.8rem;
            color: var(--dark-gray);
            margin-bottom: 1rem;
        }

        .password-requirements ul {
            padding-left: 1.2rem;
            margin-bottom: 0;
        }

        .password-requirements li {
            margin-bottom: 0.3rem;
        }

        .requirement-met {
            color: var(--secondary-dark);
        }

        .requirement-met::before {
            content: "✓ ";
        }

        .requirement-not-met::before {
            content: "✗ ";
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.cdnfonts.com/css/neon-80s" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="login-container">
        <div class="login-logo">
            <img src="resources/logo.png" alt="Smart Bank Logo">
            <h1>SMART BANK</h1>
            <p>Create your online account</p>
        </div>

        <div class="security-alert">
            <i class="fas fa-shield-alt"></i>
            <span>For your security, choose a strong password and don't share it with anyone.</span>
        </div>

        <div class="login-step active" id="step1">
            <div id="accountForm">
                <div class="mb-3">
                    <label for="newUsername" class="form-label">Choose your Online ID</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control" id="newUsername" placeholder="Enter a username" required>
                    </div>
                    <small class="text-muted">This will be your login username (3-20 characters)</small>
                </div>

                <div class="mb-3">
                    <label for="newPassword" class="form-label">Create Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" id="newPassword" placeholder="Create a password" required>
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" id="confirmPassword" placeholder="Re-enter your password" required>
                    </div>
                    <div id="passwordMatch" class="text-danger small mt-1" style="display: none;">
                        <i class="fas fa-exclamation-circle"></i> Passwords do not match
                    </div>
                </div>

                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="termsAgreement" required>
                    <label class="form-check-label" for="termsAgreement">
                        I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>
                    </label>
                </div>

                <button id="createAccountBtn" class="btn btn-login">Create Account <i class="fas fa-user-plus ms-2"></i></button>
            </div>

            <div class="login-footer">
                Already have an account? <a href="#">Sign in here</a>
            </div>
        </div>

        <div class="login-step" id="step2">
            <h5 class="text-center mb-4">Verify Your Email</h5>
            <p class="text-center">We've sent a verification code to your email address.</p>

            <div class="verification-code">
                <input type="text" maxlength="1" pattern="[0-9]" inputmode="numeric" autocomplete="one-time-code">
                <input type="text" maxlength="1" pattern="[0-9]" inputmode="numeric" autocomplete="one-time-code">
                <input type="text" maxlength="1" pattern="[0-9]" inputmode="numeric" autocomplete="one-time-code">
                <input type="text" maxlength="1" pattern="[0-9]" inputmode="numeric" autocomplete="one-time-code">
                <input type="text" maxlength="1" pattern="[0-9]" inputmode="numeric" autocomplete="one-time-code">
                <input type="text" maxlength="1" pattern="[0-9]" inputmode="numeric" autocomplete="one-time-code">
            </div>

            <div class="resend-code">
                <span>Didn't receive a code? </span>
                <a id="resendCode">Resend code</a>
            </div>

            <button type="button" class="btn btn-login" id="verifyEmail">Verify Email <i class="fas fa-check ms-2"></i></button>

            <div class="login-footer mt-3">
                <a href="#" id="changeEmail">Need to change your email?</a>
            </div>
        </div>

        <div class="login-step" id="step3">
            <div class="text-center">
                <div class="mb-4">
                    <i class="fas fa-check-circle text-success" style="font-size: 4rem;"></i>
                </div>
                <h3 class="mb-3">Account Created Successfully!</h3>
                <p>Your Smart Bank account is now ready to use.</p>
                <button type="button" class="btn btn-login mt-4" id="goToDashboard">
                    Go to Login <i class="fas fa-arrow-right ms-2"></i>
                </button>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="setupAccount.js"></script>
</body>
</html>
