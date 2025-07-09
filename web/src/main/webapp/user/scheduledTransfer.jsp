<%--
  Created by IntelliJ IDEA.
  User: kv
  Date: 7/7/2025
  Time: 2:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Bank | Scheduled Transfers</title>
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

        /* Scheduled Transfer Items */
        .scheduled-item {
            padding: 1.25rem;
            margin-bottom: 1rem;
            border-radius: 12px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: var(--glass);
            border-left: 4px solid var(--primary);
            position: relative;
        }

        .scheduled-item:hover {
            transform: translateX(5px);
            background: var(--glass-highlight);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .scheduled-item.recurring {
            border-left-color: var(--secondary);
        }

        .scheduled-item.one-time {
            border-left-color: var(--primary);
        }

        .scheduled-item.cancelled {
            border-left-color: var(--danger);
            opacity: 0.7;
        }

        .scheduled-status {
            position: absolute;
            top: 1rem;
            right: 1rem;
            font-size: 0.75rem;
            font-weight: 600;
            padding: 0.25rem 0.5rem;
            border-radius: 20px;
        }

        .status-active {
            background-color: rgba(76, 201, 160, 0.15);
            color: var(--secondary-dark);
        }

        .status-pending {
            background-color: rgba(255, 193, 7, 0.15);
            color: #ffc107;
        }

        .status-cancelled {
            background-color: rgba(239, 35, 60, 0.15);
            color: var(--danger);
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
            border-color: var(--primary);
            color: var(--primary);
            border-radius: 12px;
            padding: 0.5rem 1rem;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .btn-outline-primary:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.2);
        }

        .btn-danger {
            background: var(--danger);
            border: none;
            border-radius: 12px;
            padding: 0.5rem 1rem;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .btn-danger:hover {
            background: #d90429;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(239, 35, 60, 0.3);
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

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem;
            background: var(--glass);
            border-radius: 16px;
            border: 1px dashed var(--glass-border);
        }

        .empty-state i {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }

        /* Filter Controls */
        .filter-controls {
            background: var(--glass);
            border-radius: 16px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            border: 1px solid var(--glass-border);
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
                <a class="nav-link active" href="scheduledTransfer.jsp">
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

    <!-- Page Header -->
    <div class="dashboard-header fade-in">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 style="font-weight: 700;">Scheduled Transfers</h1>
                <p class="mb-0">View and manage your upcoming and past scheduled transfers</p>
            </div>
            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                <a href="transferFunds.jsp" class="btn btn-primary">
                    <i class="fas fa-plus me-1"></i> Schedule New Transfer
                </a>
            </div>
        </div>
    </div>

    <!-- Filter Controls -->
    <div class="filter-controls fade-in" style="animation-delay: 0.1s;">
        <div class="row align-items-center">
            <div class="col-md-6 mb-2 mb-md-0">
                <div class="input-group">
                    <span class="input-group-text bg-transparent border-end-0"><i class="fas fa-search"></i></span>
                    <input type="text" class="form-control border-start-0" placeholder="Search scheduled transfers...">
                </div>
            </div>
            <div class="col-md-6">
                <div class="d-flex justify-content-md-end">
                    <div class="btn-group" role="group">
                        <button type="button" class="btn btn-outline-primary active">All</button>
                        <button type="button" class="btn btn-outline-primary">Active</button>
                        <button type="button" class="btn btn-outline-primary">Completed</button>
                        <button type="button" class="btn btn-outline-primary">Cancelled</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scheduled Transfers List -->
    <div class="row">
        <div class="col-12">
            <div class="card fade-in" style="animation-delay: 0.2s;">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fas fa-clock me-2 text-primary"></i> Upcoming Scheduled Transfers</h5>
                    <span class="badge bg-primary">5 Scheduled</span>
                </div>
                <div class="card-body">
                    <!-- Recurring Payment -->
                    <div class="scheduled-item recurring mb-3">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h5 class="mb-1">Rent Payment</h5>
                                <p class="mb-2 text-muted">To: FutureHomes Properties • Account: ****3456</p>
                                <div class="d-flex flex-wrap">
                                    <span class="badge bg-light text-dark me-2 mb-1">
                                        <i class="fas fa-wallet me-1"></i> From: Primary Checking
                                    </span>
                                    <span class="badge bg-light text-dark mb-1">
                                        <i class="fas fa-clock me-1"></i> Next: June 20, 2023
                                    </span>
                                </div>
                            </div>
                            <div class="text-end">
                                <div>
                                    <h4 class="mb-2">$1,250.00</h4>
                                </div>
                                <div class="d-flex justify-content-end">
                                    <button class="btn btn-danger btn-sm">
                                        <i class="fas fa-times"></i> Cancel
                                    </button>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="scheduled-item recurring mb-3">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h5 class="mb-1">Rent Payment</h5>
                                <p class="mb-2 text-muted">To: FutureHomes Properties • Account: ****3456</p>
                                <div class="d-flex flex-wrap">
                                    <span class="badge bg-light text-dark me-2 mb-1">
                                        <i class="fas fa-wallet me-1"></i> From: Primary Checking
                                    </span>
                                    <span class="badge bg-light text-dark mb-1">
                                        <i class="fas fa-clock me-1"></i> Next: June 20, 2023
                                    </span>
                                </div>
                            </div>
                            <div class="text-end">
                                <div>
                                    <h4 class="mb-2">$1,250.00</h4>
                                </div>
                                <div class="d-flex justify-content-end">
                                    <button class="btn btn-danger btn-sm">
                                        <i class="fas fa-times"></i> Cancel
                                    </button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Completed/Cancelled Transfers -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="card fade-in" style="animation-delay: 0.3s;">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fas fa-history me-2 text-primary"></i> Past Scheduled Transfers</h5>
                    <div class="dropdown">
                        <button class="btn btn-link text-muted p-0" type="button" id="historyDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-ellipsis-v"></i>
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="historyDropdown">
                            <li><a class="dropdown-item" href="#">Export to CSV</a></li>
                            <li><a class="dropdown-item" href="#">Print</a></li>
                        </ul>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Completed Transfer -->
                    <div class="scheduled-item one-time mb-3">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h5 class="mb-1">Gift to Sarah</h5>
                                <p class="mb-2 text-muted">To: Sarah Johnson • Account: ****4521</p>
                                <div class="d-flex flex-wrap">
                                    <span class="badge bg-light text-dark me-2 mb-1">
                                        <i class="fas fa-wallet me-1"></i> From: Primary Checking
                                    </span>
                                    <span class="badge bg-light text-dark mb-1">
                                        <i class="fas fa-check-circle me-1"></i> Completed: May 10, 2023
                                    </span>
                                </div>
                            </div>
                            <div class="text-end">
                                <h4 class="mb-2">$100.00</h4>

                            </div>
                        </div>
                    </div>

                    <!-- Cancelled Transfer -->
                    <div class="scheduled-item recurring cancelled">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h5 class="mb-1">Gym Membership</h5>
                                <p class="mb-2 text-muted">To: Fitness Center • Account: ****6732</p>
                                <div class="d-flex flex-wrap">
                                    <span class="badge bg-light text-dark me-2 mb-1">
                                        <i class="fas fa-wallet me-1"></i> From: Primary Checking
                                    </span>
                                    <span class="badge bg-light text-dark mb-1">
                                        <i class="fas fa-times-circle me-1"></i> Cancelled: April 15, 2023
                                    </span>
                                </div>
                            </div>
                            <div class="text-end">
                                <h4 class="mb-2">$65.00</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Empty State (Hidden by default) -->
    <div class="row mt-4 d-none">
        <div class="col-12">
            <div class="empty-state">
                <i class="fas fa-clock"></i>
                <h3 class="mt-3">No Scheduled Transfers</h3>
                <p class="text-muted">You don't have any scheduled transfers yet. Schedule your first transfer now!</p>
                <a href="transferFunds.jsp" class="btn btn-primary mt-3">
                    <i class="fas fa-plus me-1"></i> Schedule New Transfer
                </a>
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

    // Add animation to cards
    const cards = document.querySelectorAll('.card');
    cards.forEach((card, index) => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = `all 0.5s ease ${index * 0.1}s`;

        setTimeout(() => {
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
        }, 100);
    });

    // Add hover effect to scheduled items
    const scheduledItems = document.querySelectorAll('.scheduled-item:not(.cancelled)');
    scheduledItems.forEach(item => {
        item.addEventListener('mouseenter', function() {
            this.style.transform = 'translateX(5px)';
            this.style.boxShadow = '0 5px 15px rgba(0, 0, 0, 0.1)';
        });
        item.addEventListener('mouseleave', function() {
            this.style.transform = 'translateX(0)';
            this.style.boxShadow = 'none';
        });
    });

    // Filter functionality
    const filterButtons = document.querySelectorAll('.btn-group .btn');
    filterButtons.forEach(button => {
        button.addEventListener('click', function() {
            filterButtons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');
            // Here you would add logic to filter the scheduled transfers
        });
    });

    // Cancel button functionality
    const cancelButtons = document.querySelectorAll('.btn-danger');
    cancelButtons.forEach(button => {
        button.addEventListener('click', function() {
            const item = this.closest('.scheduled-item');
            if (confirm('Are you sure you want to cancel this scheduled transfer?')) {
                item.classList.add('cancelled');
                const status = item.querySelector('.scheduled-status');
                status.classList.remove('status-active');
                status.classList.add('status-cancelled');
                status.textContent = 'CANCELLED';
                // Here you would add logic to actually cancel the transfer via API
            }
        });
    });
</script>
</body>
</html>
