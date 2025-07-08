<%--
  Created by IntelliJ IDEA.
  User: kv
  Date: 7/7/2025
  Time: 2:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Bank | Secure Login</title>
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
            <p>Secure online banking</p>
        </div>

        <div class="security-alert">
            <i class="fas fa-shield-alt"></i>
            <span>For your security, please do not share your login details with anyone.</span>
        </div>

        <!-- Step 1: Username/Password -->
        <div class="login-step active" id="step1">
            <form id="loginForm">
                <div class="mb-3">
                    <label for="username" class="form-label">Online ID</label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="username" placeholder="Enter your online ID" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="password" placeholder="Enter your password" required>
                    </div>
                </div>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="rememberMe">
                    <label class="form-check-label" for="rememberMe">Remember my Online ID</label>
                </div>
                <button type="submit" class="btn btn-login">Continue <i class="fas fa-arrow-right ms-2"></i></button>
            </form>

            <div class="login-footer">
                <a href="#" id="forgotPassword">Forgot Online ID or Password?</a>
            </div>
        </div>

        <!-- Step 2: Verification Code -->
        <div class="login-step" id="step2">
            <h5 class="text-center mb-4">Two-Step Verification</h5>
            <p class="text-center">We've sent a verification code to your registered device.</p>

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

            <button type="button" class="btn btn-login" id="verifyCode">Verify <i class="fas fa-check ms-2"></i></button>

            <div class="login-footer mt-3">
                <a href="#" id="useDifferentMethod">Use a different verification method</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Handle login form submission
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        e.preventDefault();

        // In a real application, you would validate credentials here
        // For demo purposes, we'll just proceed to verification

        // Hide step 1 and show step 2
        document.getElementById('step1').classList.remove('active');
        document.getElementById('step2').classList.add('active');

        // Focus first verification code input
        document.querySelector('.verification-code input').focus();
    });

    // Handle verification code input
    const codeInputs = document.querySelectorAll('.verification-code input');
    codeInputs.forEach((input, index) => {
        input.addEventListener('input', function(e) {
            if (this.value.length === 1) {
                if (index < codeInputs.length - 1) {
                    codeInputs[index + 1].focus();
                } else {
                    // Last input filled, auto-submit
                    document.getElementById('verifyCode').click();
                }
            }
        });

        // Handle backspace
        input.addEventListener('keydown', function(e) {
            if (e.key === 'Backspace' && this.value.length === 0 && index > 0) {
                codeInputs[index - 1].focus();
            }
        });
    });

    // Handle verify code button
    document.getElementById('verifyCode').addEventListener('click', function() {
        // In a real application, you would verify the code here
        // For demo purposes, we'll just redirect to dashboard
        window.location.href = 'user';
    });

    // Handle resend code
    document.getElementById('resendCode').addEventListener('click', function() {
        // In a real application, you would resend the verification code
        alert('A new verification code has been sent to your registered device.');
    });

    // Handle use different method
    document.getElementById('useDifferentMethod').addEventListener('click', function() {
        // In a real application, you would show alternative verification methods
        alert('Alternative verification methods would be shown here.');
    });

    // Handle forgot password
    document.getElementById('forgotPassword').addEventListener('click', function(e) {
        e.preventDefault();
        alert('Password recovery process would be initiated here.');
    });

    // Auto-focus username field on page load
    document.getElementById('username').focus();
</script>
</body>
</html>
