<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="com.kv.app.core.service.user.UserAccountService" %>
<%@ page import="com.kv.app.core.entity.Account" %>
<%@ page import="java.util.List" %>
<%@ page import="com.kv.app.core.entity.User" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="com.kv.app.core.service.user.UserTransactionHistoryService" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.kv.app.core.entity.Transaction" %><%--
  Created by IntelliJ IDEA.
  User: kv
  Date: 7/7/2025
  Time: 1:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Bank | Transfer Funds</title>
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

        /* Transfer Form */
        .transfer-form {
            background: var(--glass);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--glass-border);
        }

        .form-control, .form-select {
            background-color: rgba(255, 255, 255, 0.9);
            border: 1px solid var(--glass-border);
            border-radius: 12px;
            padding: 0.75rem 1rem;
            transition: all 0.3s;
        }

        .form-control:focus, .form-select:focus {
            background-color: white;
            border-color: var(--primary);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
        }

        .form-label {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--dark);
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

        .btn-outline-primary {
            border: 2px solid var(--primary);
            color: var(--primary);
            background: transparent;
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .btn-outline-primary:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.2);
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

        /* Transfer History Section */
        .transfer-history {
            margin-top: 2rem;
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
                <a class="nav-link active" href="transferFunds.jsp">
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
                <a class="nav-link" href="transactionHistory.jsp">
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
                <h1 style="font-weight: 700;">Transfer Funds</h1>
                <p class="mb-0">Send money to other accounts securely</p>
            </div>
            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                    <span class="badge bg-light text-primary">
                        <i class="fas fa-shield-alt me-1"></i> Security: Active
                    </span>
            </div>
        </div>
    </div>

    <!-- Transfer Form Section -->
    <div class="row">
        <div class="col-lg-8">
            <div class="transfer-form fade-in">
                <h4 class="mb-4"><i class="fas fa-paper-plane me-2 text-primary"></i> New Transfer</h4>

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

                <div id="transferForm">
                    <!-- From Account -->
                    <div class="mb-4">
                        <label for="fromAccount" class="form-label">From Account</label>
                        <select class="form-select" id="fromAccount" required >
                            <option value="0" selected disabled>Select an account</option>
                            <c:forEach var="account" items="${accountList}">
                                <option value="${account.accountNumber}">
                                    Savings Checking •••• ${account.accountNumber.substring(account.accountNumber.length() - 4)}
                                    (Rs. <fmt:formatNumber value="${account.balance}" pattern="#,##0.00" />)
                                </option>
                            </c:forEach>
                        </select>

                    </div>

                    <!-- Transfer Type -->
                    <div class="mb-4">
                        <label class="form-label">Transfer Type</label>
                        <div class="d-flex gap-3">
                            <div class="form-check flex-grow-1">
                                <input class="form-check-input" type="radio" name="transferType" id="internalTransfer" value="internal" checked>
                                <label class="form-check-label w-100 p-3 rounded border" for="internalTransfer">
                                    <i class="fas fa-users me-2"></i> Internal Transfer
                                    <small class="d-block text-muted mt-1">Between your accounts</small>
                                </label>
                            </div>
                            <div class="form-check flex-grow-1">
                                <input class="form-check-input" type="radio" name="transferType" id="externalTransfer" value="external">
                                <label class="form-check-label w-100 p-3 rounded border" for="externalTransfer">
                                    <i class="fas fa-user-friends me-2"></i> External Transfer
                                    <small class="d-block text-muted mt-1">To another bank account</small>
                                </label>
                            </div>
                        </div>
                    </div>

                    <!-- To Account (dynamic based on transfer type) -->
                    <div class="mb-4" id="internalRecipientSection">
                        <label for="toAccount" class="form-label">To Account</label>
                        <select class="form-select" id="toAccount">
                            <option value="0" selected disabled>Select an account</option>
                            <c:forEach var="account" items="${accountList}">
                                <option value="${account.accountNumber}">
                                    Savings Checking •••• ${account.accountNumber.substring(account.accountNumber.length() - 4)}
                                    (Rs. <fmt:formatNumber value="${account.balance}" pattern="#,##0.00" />)
                                </option>
                            </c:forEach>
                        </select>

                    </div>

                    <div class="mb-4 d-none" id="externalRecipientSection">
                        <label for="externalAccount" class="form-label">Recipient Details</label>
                        <div class="row g-3">
                            <div class="col-12">
                                <input type="text" class="form-control" id="accountNumber" placeholder="Account Number">
                            </div>
                            <div class="col-12">
                                <input type="text" class="form-control" id="recipientName" placeholder="Recipient Name">
                            </div>
                        </div>
                    </div>

                    <!-- Amount -->
                    <div class="mb-4">
                        <label for="amount" class="form-label">Amount</label>
                        <div class="input-group">
                            <span class="input-group-text">Rs</span>
                            <input type="number" class="form-control" id="amount" placeholder="0.00" min="0.01" step="0.01" required>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="mb-4">
                        <label for="description" class="form-label">Description</label>
                        <input type="text" class="form-control" id="description" placeholder="e.g. Rent payment, Gift, etc.">
                    </div>

                    <!-- Schedule Options -->
                    <div class="mb-4 d-none" id="scheduleTransferBtn">
                        <label class="form-label">Schedule Transfer</label>
                        <div class="d-flex gap-3">
                            <div class="form-check flex-grow-1">
                                <input class="form-check-input" type="radio" name="scheduleType" id="transferNow" value="now" checked>
                                <label class="form-check-label w-100 p-3 rounded border" for="transferNow">
                                    <i class="fas fa-bolt me-2"></i> Transfer Now
                                    <small class="d-block text-muted mt-1">Processed immediately</small>
                                </label>
                            </div>
                            <div class="form-check flex-grow-1 " >
                                <input class="form-check-input" type="radio" name="scheduleType" id="transferLater" value="later">
                                <label class="form-check-label w-100 p-3 rounded border" for="transferLater">
                                    <i class="fas fa-calendar-alt me-2"></i> Schedule for Later
                                    <small class="d-block text-muted mt-1">Set a future date</small>
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="mb-4 d-none" id="scheduleDateSection">
                        <div class="row">
                            <div class="col-5">
                                <label for="transferDate" class="form-label">Transfer Date</label>
                                <input type="date" class="form-control" id="transferDate" >
                            </div>
                            <div class="col-5 offset-1">
                                <label for="transferDate" class="form-label">Transfer Time</label>
                                <input type="time" class="form-control" id="transferTime" >
                            </div>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                        <button type="button" class="btn btn-outline-primary me-md-2">
                            <i class="fas fa-times me-1"></i> Cancel
                        </button>
                        <button id="transferBtn" class="btn btn-primary">
                            <i class="fas fa-paper-plane me-1"></i> Send Transfer
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Transfer Limits & Info -->
        <div class="col-lg-4">
            <div class="card fade-in" style="animation-delay: 0.1s;">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-info-circle me-2 text-primary"></i> Transfer Information</h5>
                </div>
                <div class="card-body">
                    <div class="alert alert-light p-3 mb-3 rounded">
                        <h6><i class="fas fa-tachometer-alt me-2 text-primary"></i> Transfer Limits</h6>
                        <ul class="mb-0">
                            <li>Daily limit: Rs.100,000</li>
                            <li>Per transaction: Rs.20,000</li>
                            <li>Monthly limit: Rs.500,000</li>
                        </ul>
                    </div>

                    <div class="alert alert-light p-3 mb-3 rounded">
                        <h6><i class="fas fa-clock me-2 text-primary"></i> Processing Times</h6>
                        <ul class="mb-0">
                            <li>Internal transfers: Instant</li>
                            <li>External transfers: Instant</li>
                            <li>International: 1-2 business days</li>
                        </ul>
                    </div>

                    <div class="alert alert-light p-3 rounded">
                        <h6><i class="fas fa-shield-alt me-2 text-primary"></i> Security Tips</h6>
                        <ul class="mb-0">
                            <li>Always verify recipient details</li>
                            <li>Never share your security codes</li>
                            <li>Report suspicious activity immediately</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Transfer History -->
    <div class="transfer-history fade-in" style="animation-delay: 0.2s;">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-history me-2 text-primary"></i> Recent Transfers</h5>
                <a href="transactionHistory.jsp" class="btn btn-primary btn-sm">
                    View All
                </a>
            </div>
            <div class="card-body">

                <%

                    UserTransactionHistoryService userTransactionHistoryService = null;
                    try {
                        userTransactionHistoryService = (UserTransactionHistoryService) ic.lookup("java:global/smart-bank-ear/user-module/TransactionHistorySessionBean!com.kv.app.core.service.user.UserTransactionHistoryService");
                    } catch (NamingException e) {
                        throw new RuntimeException(e);
                    }
                    Map<String,Object> dataMap = userTransactionHistoryService.getRecentTransactions(user.getId());
                    List<Transaction> transactionList = (List<Transaction>) dataMap.get("transactionList");
                    String accountNumber = (String) dataMap.get("accountId");
                    pageContext.setAttribute("transactionList", transactionList);
                    pageContext.setAttribute("accountNumber", accountNumber);

                %>

                <c:forEach var="transaction" items="${transactionList}">
                    <c:choose>
                        <c:when test="${transaction.toAccount.accountNumber == accountNumber}">
                            <div class="transaction-item credit">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="mb-1">${transaction.description}</h6>
                                        <small><fmt:formatDate value="${transaction.timestamp}" pattern="MMM dd ': at' HH:mm" /> • ${transaction.fromAccount.user.fname}</small>
                                    </div>
                                    <div class="text-end">
                                        <div class="fw-bold text-success">+Rs. <fmt:formatNumber value="${transaction.amount}" pattern="#,##0.00" /></div>
                                        <small class="text-muted">Completed</small>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="transaction-item debit">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="mb-1">${transaction.description}</h6>
                                        <small><fmt:formatDate value="${transaction.timestamp}" pattern="MMM dd ': at' HH:mm" /> • ${transaction.toAccount.user.fname}</small>
                                    </div>
                                    <div class="text-end">
                                        <div class="fw-bold text-danger">-Rs. <fmt:formatNumber value="${transaction.amount}" pattern="#,##0.00" /></div>
                                        <small class="text-muted">Completed</small>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                </c:forEach>

            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/transferFunds.js"></script>
</body>
</html>
