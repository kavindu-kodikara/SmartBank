<%--
  Created by IntelliJ IDEA.
  User: kv
  Date: 7/18/2025
  Time: 3:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Bank | Unauthorized Access</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Reuse your existing styles */
        :root {
            --primary: #4361ee;
            --primary-light: #e6e9ff;
            --primary-dark: #3a0ca3;
            --secondary: #4cc9a0;
            --danger: #ef233c;
            --light: #ffffff;
            --dark: #212529;
        }

        body {
            font-family: 'Rajdhani', 'Segoe UI', sans-serif;
            background-color: #f8f9fa;
            color: var(--dark);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .error-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .error-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 16px;
            padding: 3rem;
            text-align: center;
            max-width: 600px;
            width: 100%;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(0, 0, 0, 0.08);
        }

        .error-icon {
            font-size: 5rem;
            color: var(--danger);
            margin-bottom: 1.5rem;
            animation: pulse 2s infinite;
        }

        .error-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: var(--primary-dark);
        }

        .error-description {
            font-size: 1.1rem;
            margin-bottom: 2rem;
            color: #6c757d;
        }

        .btn-primary {
            background: var(--primary);
            border: none;
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }

        .error-search {
            margin-top: 2rem;
        }

        .search-box {
            position: relative;
            max-width: 400px;
            margin: 0 auto;
        }

        .search-box input {
            padding-left: 2.5rem;
            border-radius: 12px;
            border: 1px solid rgba(0, 0, 0, 0.1);
        }

        .search-box i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary);
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .floating {
            animation: float 3s ease-in-out infinite;
        }

        /* Footer */
        .error-footer {
            text-align: center;
            padding: 1.5rem;
            color: #6c757d;
            font-size: 0.9rem;
        }

        /* Responsive */
        @media (max-width: 576px) {
            .error-card {
                padding: 2rem 1.5rem;
            }

            .error-title {
                font-size: 2rem;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
<div class="error-container">
    <div class="error-card">
        <div class="error-icon floating">
            <i class="fas fa-lock"></i>
        </div>
        <h1 class="error-title">401 - Unauthorized Access</h1>
        <p class="error-description">
            You must be logged in to access this page.
            <br>
            Please sign in to continue to your account.
        </p>
        <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg px-4 gap-3">
                <i class="fas fa-sign-in-alt me-2"></i>Login
            </a>
        </div>
    </div>
</div>

<footer class="error-footer">
    <div class="container">
        <p class="mb-0">
            &copy; 2025 Smart Bank. All rights reserved.
            <a href="privacy.jsp" class="text-decoration-none">Privacy Policy</a> |
            <a href="terms.jsp" class="text-decoration-none">Terms of Service</a>
        </p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
