<%@ page import="javax.naming.InitialContext" %>
<%@ page import="com.kv.app.core.service.admin.AdminDashboardService" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="com.kv.app.core.dto.AdminDashboardDataDto" %>
<%@ page import="java.util.List" %>
<%@ page import="com.kv.app.core.entity.User" %>
<%@ page import="com.kv.app.core.entity.Account" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%--
  Created by IntelliJ IDEA.
  User: kv
  Date: 7/7/2025
  Time: 3:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Bank | Admin Dashboard</title>
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
            --admin-primary: #6a11cb;
            --admin-secondary: #2575fc;
        }

        body {
            font-family: 'Rajdhani', 'Segoe UI', sans-serif;
            background-color: var(--light-gray);
            color: var(--dark);
            min-height: 100vh;
        }

        /* Side Navigation */
        .sidebar {
            width: 250px;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            background: var(--glass);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-right: 1px solid var(--glass-border);
            z-index: 1000;
            box-shadow: 4px 0 15px rgba(0, 0, 0, 0.05);
        }

        .sidebar-brand {
            padding: 1.5rem;
            border-bottom: 1px solid var(--glass-border);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .nav-item {
            margin: 0.25rem 1rem;
            position: relative;
            overflow: hidden;
            border-radius: 8px;
        }

        .nav-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(106, 17, 203, 0.1), transparent);
            transition: 0.5s;
        }

        .nav-item:hover::before {
            left: 100%;
        }

        .nav-link {
            color: var(--dark);
            padding: 0.75rem 1rem;
            display: flex;
            align-items: center;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border-radius: 8px;
        }

        .nav-link:hover {
            background: rgba(106, 17, 203, 0.1);
            color: var(--admin-primary);
        }

        .nav-link.active {
            background: rgba(106, 17, 203, 0.1);
            color: var(--admin-primary);
        }

        .nav-link i {
            width: 24px;
            margin-right: 12px;
            font-size: 1.1rem;
            color: var(--admin-primary);
            transition: all 0.3s;
        }

        .nav-link.active i {
            color: var(--admin-primary);
            transform: scale(1.1);
        }

        /* Main Content */
        .main-content {
            margin-left: 250px;
            padding: 2rem;
            transition: margin 0.3s;
        }

        /* Top Navigation */
        .top-nav {
            background: var(--glass);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 16px;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid var(--glass-border);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .top-nav-right {
            margin-left: auto;
            display: flex;
            align-items: center;
        }

        /* Dashboard Header */
        .dashboard-header {
            background: linear-gradient(135deg, var(--admin-primary), var(--admin-secondary));
            color: white;
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .dashboard-header::before {
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
        }

        @keyframes shine {
            0% { transform: translateX(-100%) rotate(30deg); }
            100% { transform: translateX(100%) rotate(30deg); }
        }

        /* Admin Cards */
        .admin-card {
            position: relative;
            overflow: hidden;
            border-radius: 16px;
            padding: 1.5rem;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            background: var(--glass);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            margin-bottom: 1.5rem;
        }

        .admin-card::after {
            content: '';
            position: absolute;
            bottom: -50%;
            right: -50%;
            width: 100%;
            height: 100%;
            background: radial-gradient(
                    circle,
                    rgba(106, 17, 203, 0.15) 0%,
                    transparent 70%
            );
            transition: all 0.6s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .admin-card:hover::after {
            bottom: -30%;
            right: -30%;
        }

        .admin-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            background: var(--glass-highlight);
        }

        /* Form Styles */
        .admin-form {
            background: var(--glass);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 16px;
            padding: 2rem;
            border: 1px solid var(--glass-border);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .form-label {
            font-weight: 600;
            color: var(--dark);
        }

        .form-control {
            border-radius: 12px;
            padding: 0.75rem 1rem;
            border: 1px solid var(--glass-border);
            background: rgba(255, 255, 255, 0.8);
        }

        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(106, 17, 203, 0.25);
            border-color: var(--admin-primary);
        }

        /* Buttons */
        .btn-admin {
            background: linear-gradient(135deg, var(--admin-primary), var(--admin-secondary));
            border: none;
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            color: white;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .btn-admin:hover {
            background: linear-gradient(135deg, var(--admin-primary), #1a5df1);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(106, 17, 203, 0.3);
            color: white;
        }

        /* Table Styles */
        .admin-table {
            background: var(--glass);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 16px;
            overflow: hidden;
            border: 1px solid var(--glass-border);
        }

        .admin-table th {
            background: rgba(106, 17, 203, 0.1);
            color: var(--admin-primary);
            font-weight: 600;
            padding: 1rem;
        }

        .admin-table td {
            padding: 1rem;
            vertical-align: middle;
            border-top: 1px solid var(--glass-border);
        }

        .admin-table tr:hover td {
            background: rgba(106, 17, 203, 0.05);
        }

        /* Animations */
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-8px); }
        }

        .floating {
            animation: float 4s ease-in-out infinite;
        }

        .pulse {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .fade-in {
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Stats Cards */
        .stat-card {
            border-radius: 16px;
            padding: 1.5rem;
            color: white;
            position: relative;
            overflow: hidden;
            margin-bottom: 1.5rem;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2));
        }

        .stat-card i {
            font-size: 2.5rem;
            opacity: 0.3;
            position: absolute;
            right: 1.5rem;
            top: 1.5rem;
        }

        .stat-card .stat-value {
            font-size: 2rem;
            font-weight: 700;
            margin: 0.5rem 0;
        }

        .stat-card.users {
            background: linear-gradient(135deg, #8e2de2, #4a00e0);
        }

        .stat-card.accounts {
            background: linear-gradient(135deg, #11998e, #38ef7d);
        }

        .stat-card.transactions {
            background: linear-gradient(135deg, #f46b45, #eea849);
        }

        .stat-card.balance {
            background: linear-gradient(135deg, #0575e6, #021b79);
        }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.show {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.cdnfonts.com/css/neon-80s" rel="stylesheet">
</head>
<body>
<!-- Side Navigation -->
<div class="sidebar" id="sidebar">
    <div class="sidebar-brand">
        <img src="${pageContext.request.contextPath}/resources/logo.png" alt="logo" width="50px"/>
        <span class="fw-bold fs-4">SMART BANK</span>
        <small class="text-muted">Admin Panel</small>
    </div>
    <div class="sidebar-nav mt-3">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link active" href="admin_dashboard.jsp">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#userManagement" data-bs-toggle="collapse">
                    <i class="fas fa-users"></i>
                    <span>User Management</span>
                    <i class="fas fa-angle-down ms-auto"></i>
                </a>
                <div class="collapse show" id="userManagement">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="#registerUser" data-bs-toggle="tab">
                                <i class="fas fa-user-plus"></i>
                                <span>Register User</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#viewUsers" data-bs-toggle="tab">
                                <i class="fas fa-list"></i>
                                <span>View Users</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#accountManagement" data-bs-toggle="collapse">
                    <i class="fas fa-wallet"></i>
                    <span>Account Management</span>
                    <i class="fas fa-angle-down ms-auto"></i>
                </a>
                <div class="collapse" id="accountManagement">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="#depositFunds" data-bs-toggle="tab">
                                <i class="fas fa-money-bill-wave"></i>
                                <span>Deposit Funds</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#viewAccounts" data-bs-toggle="tab">
                                <i class="fas fa-list"></i>
                                <span>View Accounts</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="nav-item mt-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </a>
            </li>
        </ul>
    </div>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Top Navigation -->
    <nav class="top-nav d-lg-none d-md-block d-sm-block">
        <div class="container-fluid">
            <button class="btn btn-link me-3 d-lg-none" id="sidebarToggle">
                <i class="fas fa-bars fa-lg"></i>
            </button>
            <div class="top-nav-right">
                <div class="dropdown">
                    <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" id="dropdownUser" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="https://via.placeholder.com/40" alt="admin" width="40" height="40" class="rounded-circle me-2">
                        <span class="d-none d-sm-inline">Admin User</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownUser">
                        <li><a class="dropdown-item" href="#"><i class="fas fa-user me-2"></i> Profile</a></li>
                        <li><a class="dropdown-item" href="#"><i class="fas fa-cog me-2"></i> Settings</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="logout.jsp"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <!-- Dashboard Header -->
    <div class="dashboard-header fade-in">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 style="font-weight: 700;">Welcome, Admin</h1>
                <p class="mb-0">Last login: Today at 08:47 from your workstation</p>
            </div>
            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                    <span class="badge bg-light" style="color: var(--admin-primary);">
                        <i class="fas fa-shield-alt me-1"></i> Admin Privileges
                    </span>
            </div>
        </div>
    </div>

    <%

        try {

            InitialContext ic = new InitialContext();
            AdminDashboardService adminDashboardService = (AdminDashboardService) ic.lookup("java:global/smart-bank-ear/admin-module/AdminDashboardSessionBean!com.kv.app.core.service.admin.AdminDashboardService");
            AdminDashboardDataDto dashboardData = adminDashboardService.getDashboardData();
            List<User> userList = adminDashboardService.getAllUsers();
            List<Account> accountList = adminDashboardService.getAllAccounts();
            request.setAttribute("dashboardData",dashboardData);
            request.setAttribute("userList",userList);
            request.setAttribute("accountList",accountList);

        }catch (NamingException e){
            throw new RuntimeException(e);
        }

    %>

    <!-- Tab Content -->
    <div class="tab-content">
        <!-- Dashboard Tab -->
        <div class="tab-pane fade show active" id="dashboard">
            <!-- Stats Cards -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="stat-card users floating">
                        <i class="fas fa-users"></i>
                        <h5>Total Users</h5>
                        <div class="stat-value"><fmt:formatNumber value="${dashboardData.totUsers}" pattern="#,##0" /></div>
                        <small>Smart Bank</small>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card accounts floating" style="animation-delay: 0.2s;">
                        <i class="fas fa-wallet"></i>
                        <h5>Active Accounts</h5>
                        <div class="stat-value"><fmt:formatNumber value="${dashboardData.totAccounts}" pattern="#,##0" /></div>
                        <small>Smart Bank</small>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card transactions floating" style="animation-delay: 0.4s;">
                        <i class="fas fa-exchange-alt"></i>
                        <h5>Transactions</h5>
                        <div class="stat-value"><fmt:formatNumber value="${dashboardData.totTransactions}" pattern="#,##0" /></div>
                        <small>Smart Bank</small>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card balance floating" style="animation-delay: 0.6s;">
                        <i class="fas fa-dollar-sign"></i>
                        <h5>Total Balance</h5>
                        <div class="stat-value">Rs. ${dashboardData.totBalances}</div>
                        <small>Smart Bank</small>
                    </div>
                </div>
            </div>

            <!-- Recent Activity -->

        </div>

        <!-- Register User Tab -->
        <div class="tab-pane fade" id="registerUser">
            <div class="row">
                <div class="col-md-8 mx-auto">
                    <div class="admin-form fade-in">
                        <h4 class="mb-4 text-center" style="color: var(--admin-primary);">
                            <i class="fas fa-user-plus me-2"></i> Register New User
                        </h4>
                        <div id="userRegistrationForm">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="firstName" class="form-label">First Name</label>
                                    <input type="text" class="form-control" id="firstName" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="lastName" class="form-label">Last Name</label>
                                    <input type="text" class="form-control" id="lastName" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" required>
                            </div>
                            <div class="mb-3">
                                <label for="mobile" class="form-label">Mobile Number</label>
                                <input type="tel" class="form-control" id="mobile" required>
                            </div>
                            <div class="mb-3">
                                <label for="nic" class="form-label">NIC/Passport Number</label>
                                <input type="text" class="form-control" id="nic" required>
                            </div>
                            <div class="mb-3">
                                <label for="initialDeposit" class="form-label">Initial Deposit</label>
                                <input type="number" class="form-control" id="initialDeposit" min="0" step="0.01">
                            </div>
                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-admin px-5" id="registerBtn">
                                    <i class="fas fa-user-plus me-2"></i> Register User
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- View Users Tab -->
        <div class="tab-pane fade" id="viewUsers">
            <div class="admin-card fade-in">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5><i class="fas fa-users me-2" style="color: var(--admin-primary);"></i> Registered Users</h5>
                    <div class="input-group" style="max-width: 300px;">
                        <input type="text" class="form-control" placeholder="Search users...">
                        <button class="btn btn-outline-secondary" type="button">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table admin-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Mobile</th>
                            <th>NIC</th>
                            <th>Accounts</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>


                        <c:forEach var="user" items="${userList}">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.fname} ${user.lname}</td>
                                <td>${user.email}</td>
                                <td>${user.mobile}</td>
                                <td>${user.nic}</td>
                                <td>${user.accounts.size()}</td>
                                <td>
                                    <button class="btn btn-sm btn-admin">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>

            </div>
        </div>

        <!-- Deposit Funds Tab -->
        <div class="tab-pane fade" id="depositFunds">
            <div class="row">
                <div class="col-md-8 mx-auto">
                    <div class="admin-form fade-in">
                        <h4 class="mb-4 text-center" style="color: var(--admin-primary);">
                            <i class="fas fa-money-bill-wave me-2"></i> Deposit Funds to Account
                        </h4>
                        <form id="depositFundsForm">
                            <div class="mb-3">
                                <label for="accountNumber" class="form-label">Account Number</label>
                                <input type="text" class="form-control" id="accountNumber" required>
                            </div>
                            <div class="mb-3">
                                <label for="depositAmount" class="form-label">Amount to Deposit</label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" class="form-control" id="depositAmount" min="0.01" step="0.01" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="depositDescription" class="form-label">Description</label>
                                <input type="text" class="form-control" id="depositDescription" placeholder="e.g., Initial deposit, Bonus, etc.">
                            </div>
                            <div class="mb-3">
                                <label for="depositReceipt" class="form-label">Upload Receipt (Optional)</label>
                                <input type="file" class="form-control" id="depositReceipt">
                            </div>
                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-admin px-5">
                                    <i class="fas fa-plus-circle me-2"></i> Deposit Funds
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- View Accounts Tab -->
        <div class="tab-pane fade" id="viewAccounts">
            <div class="admin-card fade-in">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5><i class="fas fa-wallet me-2" style="color: var(--admin-primary);"></i> All Accounts</h5>
                    <div class="input-group" style="max-width: 300px;">
                        <input type="text" class="form-control" placeholder="Search accounts...">
                        <button class="btn btn-outline-secondary" type="button">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table admin-table">
                        <thead>
                        <tr>
                            <th>Account #</th>
                            <th>Type</th>
                            <th>Owner</th>
                            <th>Balance</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="account" items="${accountList}">
                            <tr>
                                <td>•••• ${account.accountNumber.substring(account.accountNumber.length() - 4)}</td>
                                <td>Saving</td>
                                <td>${account.user.fname} ${account.user.lname}</td>
                                <td>Rs. <fmt:formatNumber value="${account.balance}" pattern="#,##0"/></td>
                                <td><span class="badge bg-success">Active</span></td>
                                <td>
                                    <button class="btn btn-sm btn-admin">
                                        <i class="fas fa-money-bill-wave"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="admin.js"></script>