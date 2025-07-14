<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="com.kv.app.core.service.user.UserAccountService" %>
<%@ page import="com.kv.app.core.entity.Account" %>
<%@ page import="java.util.List" %>
<%@ page import="com.kv.app.core.entity.User" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="com.kv.app.core.service.user.UserTransactionHistoryService" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.kv.app.core.entity.Transaction" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.google.gson.Gson" %><%--
  Created by IntelliJ IDEA.
  User: kv
  Date: 7/7/2025
  Time: 3:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Bank | Transaction History</title>
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
            background: linear-gradient(90deg, transparent, rgba(67, 97, 238, 0.1), transparent);
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
            background: rgba(67, 97, 238, 0.1);
            color: var(--primary-dark);
        }

        .nav-link.active {
            background: rgba(67, 97, 238, 0.1);
            color: var(--primary-dark);
        }

        .nav-link i {
            width: 24px;
            margin-right: 12px;
            font-size: 1.1rem;
            color: var(--primary);
            transition: all 0.3s;
        }

        .nav-link.active i {
            color: var(--primary-dark);
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
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
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

        /* Account Cards */
        .account-card {
            position: relative;
            overflow: hidden;
            border-radius: 16px;
            padding: 1.5rem;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            background: var(--glass);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
        }

        .account-card::after {
            content: '';
            position: absolute;
            bottom: -50%;
            right: -50%;
            width: 100%;
            height: 100%;
            background: radial-gradient(
                    circle,
                    rgba(67, 97, 238, 0.15) 0%,
                    transparent 70%
            );
            transition: all 0.6s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .account-card:hover::after {
            bottom: -30%;
            right: -30%;
        }

        .account-card.primary {
            background: linear-gradient(135deg, rgba(67, 97, 238, 0.15), rgba(67, 97, 238, 0.1));
        }

        .account-card.savings {
            background: linear-gradient(135deg, rgba(76, 201, 160, 0.15), rgba(76, 201, 160, 0.1));
        }

        .account-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            background: var(--glass-highlight);
        }

        .balance {
            font-size: 2rem;
            font-weight: 700;
            margin: 0.5rem 0;
        }

        .balance.primary {
            color: var(--primary-dark);
        }

        .balance.savings {
            color: var(--secondary-dark);
        }

        .account-badge {
            background-color: rgba(255, 255, 255, 0.9);
            color: var(--primary-dark);
            font-weight: 500;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        /* Cards */
        .card {
            background: var(--glass);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 16px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-bottom: 1.5rem;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            background: var(--glass-highlight);
        }

        .card-header {
            background: transparent;
            border-bottom: 1px solid var(--glass-border);
            border-radius: 16px 16px 0 0 !important;
            padding: 1.25rem 1.5rem;
        }

        /* Quick Actions */
        .quick-action {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 1.25rem 0.5rem;
            border-radius: 12px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
            color: var(--dark);
            position: relative;
            overflow: hidden;
        }

        .quick-action::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(67, 97, 238, 0.08), rgba(76, 201, 160, 0.08));
            z-index: -1;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .quick-action:hover::before {
            opacity: 1;
        }

        .quick-action i {
            font-size: 1.5rem;
            width: 48px;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(67, 97, 238, 0.1);
            color: var(--primary);
            border-radius: 50%;
            margin-bottom: 0.75rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .quick-action:hover i {
            background: var(--primary);
            color: white;
            transform: scale(1.1);
        }

        /* Transactions */
        .transaction-item {
            padding: 1rem;
            margin-bottom: 0.75rem;
            border-radius: 12px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: var(--glass);
            border-left: 4px solid transparent;
        }

        .transaction-item:hover {
            transform: translateX(5px);
            background: var(--glass-highlight);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .transaction-item.credit {
            border-left-color: var(--secondary);
        }

        .transaction-item.debit {
            border-left-color: var(--danger);
        }

        /* Buttons */
        .btn-primary {
            background: var(--primary);
            border: none;
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }

        /* Transaction History Specific Styles */
        .transaction-filter {
            background: var(--glass);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid var(--glass-border);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .transaction-date-group {
            margin-bottom: 2rem;
        }

        .transaction-date-header {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--dark-gray);
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid var(--glass-border);
        }

        .transaction-type-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .badge-internal {
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary-dark);
        }

        .badge-external {
            background-color: rgba(76, 201, 160, 0.1);
            color: var(--secondary-dark);
        }

        .transaction-details {
            display: flex;
            align-items: center;
        }

        .transaction-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary);
        }

        .transaction-icon.credit {
            background-color: rgba(76, 201, 160, 0.1);
            color: var(--secondary-dark);
        }

        .transaction-icon.debit {
            background-color: rgba(239, 35, 60, 0.1);
            color: var(--danger);
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
        <img src="../resources/logo.png" alt="logo" width="50px"/>
        <span class="fw-bold fs-4">SMART BANK</span>
    </div>
    <div class="sidebar-nav mt-3">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="index.jsp">
                    <i class="fas fa-home"></i>
                    <span>Dashboard</span>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="transferFunds.jsp">
                    <i class="fas fa-exchange-alt"></i>
                    <span>Transfers</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="scheduledTransfer.jsp">
                    <i class="fas fa-clock"></i>
                    <span>Scheduled</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="transactionHistory.jsp">
                    <i class="fas fa-history"></i>
                    <span>History</span>
                </a>
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
        </div>
    </nav>

    <!-- Dashboard Header -->
    <div class="dashboard-header fade-in">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 style="font-weight: 700;">Transaction History</h1>
                <p class="mb-0">View all your completed transactions</p>
            </div>
            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                <span class="badge bg-light text-primary">
                    <i class="fas fa-filter me-1"></i> Last 30 Days
                </span>
            </div>
        </div>
    </div>

    <!-- Transaction History -->
    <div class="card fade-in" style="animation-delay: 0.1s;">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><i class="fas fa-list me-2 text-primary"></i> Transaction History</h5>

            <%
                User user = (User) request.getSession().getAttribute("user");
                InitialContext ic = new InitialContext();

                try {

                    UserAccountService userAccountService = null;
                    userAccountService = (UserAccountService) ic.lookup("java:global/smart-bank-ear/user-module/UserAccountSessionBean!com.kv.app.core.service.user.UserAccountService");
                    List<Account> accountList = userAccountService.getAccounts(user.getId());
                    pageContext.setAttribute("accountList", accountList);

                } catch (NamingException e) {
                    throw new RuntimeException(e);
                }

            %>

            <div>
                <select class="form-select" id="fromAccount" required >
                    <c:forEach var="account" items="${accountList}">
                        <option value="${account.accountNumber}">
                            Savings Checking •••• ${account.accountNumber.substring(account.accountNumber.length() - 4)}
                            (Rs. <fmt:formatNumber value="${account.balance}" pattern="#,##0.00" />)
                        </option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <%

            UserTransactionHistoryService userTransactionHistoryService = null;
            try {
                userTransactionHistoryService = (UserTransactionHistoryService) ic.lookup("java:global/smart-bank-ear/user-module/TransactionHistorySessionBean!com.kv.app.core.service.user.UserTransactionHistoryService");
            } catch (NamingException e) {
                throw new RuntimeException(e);
            }
            request.setAttribute("transactionJson", userTransactionHistoryService.getAllTransactions(user.getId()));

        %>
        <div class="card-body" id="transactionContainer">
            <!-- Today's Transactions -->
            <div class="transaction-date-group">
                <h6 class="transaction-date-header">Today, May 15, 2023</h6>

                <div class="transaction-item credit">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="transaction-details">
                            <div class="transaction-icon credit">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Salary Deposit</h6>
                                <small>Acme Corp • <span class="badge transaction-type-badge badge-external">External</span></small>
                            </div>
                        </div>
                        <div class="text-end">
                            <div class="fw-bold text-success">+$4,500.00</div>
                            <small class="text-muted">Completed • 09:00 AM</small>
                        </div>
                    </div>
                </div>

                <div class="transaction-item debit">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="transaction-details">
                            <div class="transaction-icon debit">
                                <i class="fas fa-home"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Mortgage Payment</h6>
                                <small>FutureHomes • <span class="badge transaction-type-badge badge-external">External</span></small>
                            </div>
                        </div>
                        <div class="text-end">
                            <div class="fw-bold text-danger">-$1,250.00</div>
                            <small class="text-muted">Completed • 08:30 AM</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Yesterday's Transactions -->
            <div class="transaction-date-group">
                <h6 class="transaction-date-header">Yesterday, May 14, 2023</h6>

                <div class="transaction-item debit">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="transaction-details">
                            <div class="transaction-icon debit">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Grocery Store</h6>
                                <small>Fresh Market • <span class="badge transaction-type-badge badge-external">External</span></small>
                            </div>
                        </div>
                        <div class="text-end">
                            <div class="fw-bold text-danger">-$87.43</div>
                            <small class="text-muted">Completed • 06:45 PM</small>
                        </div>
                    </div>
                </div>

                <div class="transaction-item credit">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="transaction-details">
                            <div class="transaction-icon credit">
                                <i class="fas fa-percentage"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Interest Payment</h6>
                                <small>Smart Bank • <span class="badge transaction-type-badge badge-internal">Internal</span></small>
                            </div>
                        </div>
                        <div class="text-end">
                            <div class="fw-bold text-success">+$23.18</div>
                            <small class="text-muted">Automated • 12:00 AM</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- May 10, 2023 Transactions -->
            <div class="transaction-date-group">
                <h6 class="transaction-date-header">May 10, 2023</h6>

                <div class="transaction-item debit">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="transaction-details">
                            <div class="transaction-icon debit">
                                <i class="fas fa-exchange-alt"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Transfer to Savings</h6>
                                <small>Savings Account • <span class="badge transaction-type-badge badge-internal">Internal</span></small>
                            </div>
                        </div>
                        <div class="text-end">
                            <div class="fw-bold text-danger">-$500.00</div>
                            <small class="text-muted">Completed • 02:15 PM</small>
                        </div>
                    </div>
                </div>

                <div class="transaction-item credit">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="transaction-details">
                            <div class="transaction-icon credit">
                                <i class="fas fa-utensils"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Dinner Refund</h6>
                                <small>Gourmet Bistro • <span class="badge transaction-type-badge badge-external">External</span></small>
                            </div>
                        </div>
                        <div class="text-end">
                            <div class="fw-bold text-success">+$45.25</div>
                            <small class="text-muted">Completed • 11:30 AM</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- May 5, 2023 Transactions -->
            <div class="transaction-date-group">
                <h6 class="transaction-date-header">May 5, 2023</h6>

                <div class="transaction-item debit">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="transaction-details">
                            <div class="transaction-icon debit">
                                <i class="fas fa-car"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Car Insurance</h6>
                                <small>SafeDrive Insurance • <span class="badge transaction-type-badge badge-external">External</span></small>
                            </div>
                        </div>
                        <div class="text-end">
                            <div class="fw-bold text-danger">-$125.75</div>
                            <small class="text-muted">Completed • 09:45 AM</small>
                        </div>
                    </div>
                </div>

                <div class="transaction-item debit">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="transaction-details">
                            <div class="transaction-icon debit">
                                <i class="fas fa-mobile-alt"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Phone Bill</h6>
                                <small>Telecom Plus • <span class="badge transaction-type-badge badge-external">External</span></small>
                            </div>
                        </div>
                        <div class="text-end">
                            <div class="fw-bold text-danger">-$89.99</div>
                            <small class="text-muted">Completed • 08:00 AM</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Load More Button -->
            <div class="d-grid mt-4">
                <button class="btn btn-outline-primary">
                    <i class="fas fa-chevron-down me-1"></i> Load More Transactions
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const transactionData = ${transactionJson};
    console.log(transactionData);

    document.getElementById("fromAccount").addEventListener("change", function () {
        loadTransactionData(this.value);
    });

    document.addEventListener("DOMContentLoaded", function () {
        const defaultAccount = document.getElementById("fromAccount").value;
        loadTransactionData(defaultAccount);
    });

    function loadTransactionData(selectedAccount){
        const container = document.getElementById("transactionContainer");
        container.innerHTML = "";

        if (!transactionData[selectedAccount]) {
            container.innerHTML = "<p>No transactions found.</p>";
            return;
        }

        const accountTransactions = transactionData[selectedAccount];

        Object.keys(accountTransactions).forEach(date => {
            const groupDiv = document.createElement("div");
            groupDiv.classList.add("transaction-date-group");

            const header = document.createElement("h6");
            header.classList.add("transaction-date-header");
            header.textContent = date;
            groupDiv.appendChild(header);

            accountTransactions[date].forEach(tx => {
                const typeClass = tx.toAccount == selectedAccount ? "credit" : "debit";
                const amountPrefix = typeClass == "credit" ? "+" : "-";
                const amountColor = typeClass == "credit" ? "text-success" : "text-danger";

                let iconHtml = "";

                if (tx.transactionType === "TRANSFER") {
                    iconHtml = '<i class="fas fa-exchange-alt"></i>';
                } else {
                    iconHtml = '<i class="fas fa-dollar-sign"></i>';
                }

                let userHtml = "";

                if (tx.toAccount == selectedAccount) {
                    userHtml = '<small>From '+tx.fromUserFname+' • <span class="badge transaction-type-badge badge-external">' + tx.transactionType + '</span></small>';
                } else {
                    userHtml = '<small>To '+tx.toUserFname+' • <span class="badge transaction-type-badge badge-external">' + tx.transactionType + '</span></small>';
                }

                let typeHtml = typeClass === "credit" ? '<div class="transaction-item credit">' : '<div class="transaction-item debit">';

                const transactionHtml =
                    '<div class="transaction-item '+typeClass+'">' +
                    '<div class="d-flex justify-content-between align-items-center">' +
                    '<div class="transaction-details">' +
                    '<div class="transaction-icon '+typeClass+'">' +
                    iconHtml +
                    '</div>' +
                    '<div>' +
                    '<h6 class="mb-1">' + tx.description + '</h6>' +
                    userHtml +
                    '</div>' +
                    '</div>' +
                    '<div class="text-end">' +
                    '<div class="fw-bold '+amountColor+'">Rs. ' + amountPrefix + tx.amount + '.00</div>' +
                    '<small class="text-muted">Completed • '+ formatTime(tx.timestamp) +'</small>' +
                    '</div>' +
                    '</div>' +
                    '</div>';

                groupDiv.innerHTML += transactionHtml;
            });


            container.appendChild(groupDiv);
        });
    }

    // Helper to format timestamp to "HH:MM AM/PM"
    function formatTime(timestamp) {
        const date = new Date(timestamp);
        let hours = date.getHours();
        const minutes = date.getMinutes().toString().padStart(2, "0");
        const ampm = hours >= 12 ? "PM" : "AM";
        hours = hours % 12 || 12;
        return hours+":"+minutes+" "+ampm;
    }
</script>

<script>
    // Toggle sidebar on mobile
    document.getElementById('sidebarToggle').addEventListener('click', function() {
        document.getElementById('sidebar').classList.toggle('show');
    });

    // Add hover effect to navigation items
    const navItems = document.querySelectorAll('.nav-item');
    navItems.forEach(item => {
        item.addEventListener('mouseenter', function() {
            const link = this.querySelector('.nav-link');
            if (!link.classList.contains('active')) {
                link.style.transform = 'translateX(5px)';
            }
        });
        item.addEventListener('mouseleave', function() {
            const link = this.querySelector('.nav-link');
            if (!link.classList.contains('active')) {
                link.style.transform = 'translateX(0)';
            }
        });
    });



    // Add ripple effect to buttons
    const buttons = document.querySelectorAll('.btn');
    buttons.forEach(button => {
        button.addEventListener('click', function(e) {
            const x = e.clientX - e.target.getBoundingClientRect().left;
            const y = e.clientY - e.target.getBoundingClientRect().top;

            const ripple = document.createElement('span');
            ripple.classList.add('ripple-effect');
            ripple.style.left = `${x}px`;
            ripple.style.top = `${y}px`;

            this.appendChild(ripple);

            setTimeout(() => {
                ripple.remove();
            }, 1000);
        });
    });
</script>
</body>
</html>
