<%--
  Created by IntelliJ IDEA.
  User: kv
  Date: 7/7/2025
  Time: 11:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Bank | Dashboard</title>
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
                <a class="nav-link active" href="index.jsp">
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
                <h1 style="font-weight: 700;">Welcome back, John</h1>
                <p class="mb-0">Last login: Today at 08:47 from your mobile device</p>
            </div>
            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                    <span class="badge bg-light text-primary">
                        <i class="fas fa-shield-alt me-1"></i> Security: Active
                    </span>
            </div>
        </div>
    </div>

    <!-- Account Summary -->
    <div class="row mb-4">
        <div class="col-md-6 mb-4">
            <div class="account-card primary floating">
                <div class="d-flex justify-content-between align-items-start">
                    <div>
                        <h5>Primary Checking</h5>
                        <p class="mb-2">•••• •••• •••• 4567</p>
                        <h2 class="balance primary">$12,456.78</h2>
                        <p class="mb-0"><i class="fas fa-arrow-up me-1"></i> 2.4% from last month</p>
                    </div>
                    <div>
                        <span class="account-badge">Active</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 mb-4">
            <div class="account-card savings floating" style="animation-delay: 0.2s;">
                <div class="d-flex justify-content-between align-items-start">
                    <div>
                        <h5>Savings Account</h5>
                        <p class="mb-2">•••• •••• •••• 8910</p>
                        <h2 class="balance savings">$24,789.32</h2>
                        <p class="mb-0"><i class="fas fa-arrow-up me-1"></i> 3.7% interest applied</p>
                    </div>
                    <div>
                        <span class="account-badge">Active</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card fade-in" style="animation-delay: 0.1s;">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-bolt me-2 text-primary"></i> Quick Actions</h5>
                </div>
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-4 col-md-2 mb-3">
                            <a href="transferFunds.jsp" class="quick-action">
                                <i class="fas fa-paper-plane"></i>
                                <span>Send Money</span>
                            </a>
                        </div>
                        <div class="col-4 col-md-2 mb-3">
                            <a href="#" class="quick-action">
                                <i class="fas fa-money-bill-wave"></i>
                                <span>Pay Bills</span>
                            </a>
                        </div>
                        <div class="col-4 col-md-2 mb-3">
                            <a href="scheduledTransfer.jsp" class="quick-action">
                                <i class="fas fa-clock"></i>
                                <span>Schedule</span>
                            </a>
                        </div>
                        <div class="col-4 col-md-2 mb-3">
                            <a href="#" class="quick-action">
                                <i class="fas fa-qrcode"></i>
                                <span>Scan & Pay</span>
                            </a>
                        </div>
                        <div class="col-4 col-md-2 mb-3">
                            <a href="#" class="quick-action">
                                <i class="fas fa-credit-card"></i>
                                <span>Cards</span>
                            </a>
                        </div>
                        <div class="col-4 col-md-2 mb-3">
                            <a href="#" class="quick-action">
                                <i class="fas fa-ellipsis-h"></i>
                                <span>More</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Recent Transactions -->
        <div class="col-lg-8 mb-4">
            <div class="card fade-in" style="animation-delay: 0.2s;">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fas fa-list me-2 text-primary"></i> Recent Transactions</h5>
                    <a href="transactionHistory.jsp" class="btn btn-primary btn-sm">
                        View All
                    </a>
                </div>
                <div class="card-body">
                    <div class="transaction-item credit">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-1">Salary Deposit</h6>
                                <small>Today at 09:00 • Acme Corp</small>
                            </div>
                            <div class="text-end">
                                <div class="fw-bold text-success">+$4,500.00</div>
                                <small class="text-muted">Completed</small>
                            </div>
                        </div>
                    </div>
                    <div class="transaction-item debit">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-1">Mortgage Payment</h6>
                                <small>Today at 08:30 • FutureHomes</small>
                            </div>
                            <div class="text-end">
                                <div class="fw-bold text-danger">-$1,250.00</div>
                                <small class="text-muted">Completed</small>
                            </div>
                        </div>
                    </div>
                    <div class="transaction-item debit">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-1">Grocery Store</h6>
                                <small>Yesterday at 18:45 • Fresh Market</small>
                            </div>
                            <div class="text-end">
                                <div class="fw-bold text-danger">-$87.43</div>
                                <small class="text-muted">Completed</small>
                            </div>
                        </div>
                    </div>
                    <div class="transaction-item credit">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-1">Interest Payment</h6>
                                <small>Yesterday at 00:00 • Smart Bank</small>
                            </div>
                            <div class="text-end">
                                <div class="fw-bold text-success">+$23.18</div>
                                <small class="text-muted">Automated</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Scheduled Transactions -->
        <div class="col-lg-4 mb-4">
            <div class="card fade-in" style="animation-delay: 0.3s;">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fas fa-clock me-2 text-primary"></i> Scheduled Transactions</h5>
                    <a href="scheduledTransfer.jsp" class="btn btn-primary btn-sm">
                        Manage
                    </a>
                </div>
                <div class="card-body">
                    <div class="alert alert-light p-3 mb-3 rounded">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-0">Rent Payment</h6>
                                <small>Next execution: May 20, 2023</small>
                            </div>
                            <div class="text-end">
                                <div class="fw-bold">$1,250.00</div>
                                <small class="text-muted">Monthly</small>
                            </div>
                        </div>
                    </div>
                    <div class="alert alert-light p-3 mb-3 rounded">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-0">Car Loan</h6>
                                <small>Next execution: May 25, 2023</small>
                            </div>
                            <div class="text-end">
                                <div class="fw-bold">$375.50</div>
                                <small class="text-muted">Monthly</small>
                            </div>
                        </div>
                    </div>
                    <div class="alert alert-light p-3 rounded">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-0">Savings Transfer</h6>
                                <small>Next execution: June 1, 2023</small>
                            </div>
                            <div class="text-end">
                                <div class="fw-bold">$500.00</div>
                                <small class="text-muted">Monthly</small>
                            </div>
                        </div>
                    </div>

                    <div class="d-grid mt-3">
                        <a href="scheduledTransfer.jsp" class="btn btn-primary">
                            <i class="fas fa-plus me-1"></i> Schedule New
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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

    // Add animation to account cards
    const accountCards = document.querySelectorAll('.account-card');
    accountCards.forEach((card, index) => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = `all 0.5s ease ${index * 0.1}s`;

        setTimeout(() => {
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
        }, 100);
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
