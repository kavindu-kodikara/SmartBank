<%@ page import="com.kv.app.core.service.user.UserTransactionHistoryService" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="com.kv.app.core.entity.Transaction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction Invoice | Smart Bank</title>
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <style>
        body {
            font-family: 'Rajdhani', sans-serif;
            background-color: #f8f9fa;
            color: #212529;
            padding: 20px;
        }

        #invoice-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            border-radius: 8px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
            border-bottom: 2px solid #4361ee;
            padding-bottom: 20px;
        }

        .bank-logo {
            width: 50px;
        }

        .invoice-title {
            color: #3a0ca3;
            font-size: 28px;
            font-weight: 700;
            margin: 0;
        }

        .invoice-number {
            text-align: right;
        }

        .section {
            margin-bottom: 25px;
        }

        .section-title {
            color: #4361ee;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
            border-bottom: 1px solid #e9ecef;
            padding-bottom: 5px;
        }

        .details-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .detail-item {
            margin-bottom: 8px;
        }

        .detail-label {
            font-weight: 600;
            color: #6c757d;
        }

        .transaction-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .transaction-table th {
            background-color: #4361ee;
            color: white;
            padding: 12px;
            text-align: left;
        }

        .transaction-table td {
            padding: 12px;
            border-bottom: 1px solid #e9ecef;
        }

        .transaction-table tr:last-child td {
            border-bottom: none;
        }

        .amount-credit {
            color: #4cc9a0;
            font-weight: 600;
        }

        .amount-debit {
            color: #ef233c;
            font-weight: 600;
        }

        .summary {
            margin-top: 30px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
        }

        .summary-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .footer {
            margin-top: 40px;
            text-align: center;
            color: #6c757d;
            font-size: 14px;
            border-top: 1px solid #e9ecef;
            padding-top: 20px;
        }

        .download-btn {
            display: block;
            width: 200px;
            margin: 30px auto;
            background: #4361ee;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .download-btn:hover {
            background: #3a0ca3;
            transform: translateY(-2px);
        }
    </style>
</head>
<body id="invoice-container">
<div >
    <div class="header">

        <%
            String id = request.getParameter("id");
            InitialContext ic = new InitialContext();
            UserTransactionHistoryService userTransactionHistoryService = null;
            try {
                userTransactionHistoryService = (UserTransactionHistoryService) ic.lookup("java:global/smart-bank-ear/user-module/TransactionHistorySessionBean!com.kv.app.core.service.user.UserTransactionHistoryService");
            } catch (NamingException e) {
                throw new RuntimeException(e);
            }

            Transaction transaction = userTransactionHistoryService.getTransaction(Long.parseLong(id));
            pageContext.setAttribute("transaction",transaction);
        %>

        <div>
            <img src="${pageContext.request.contextPath}/resources/logo.png" alt="Smart Bank" class="bank-logo">
            <h1 class="invoice-title">Transaction Receipt</h1>
        </div>
        <div class="invoice-number">
            <div class="detail-label">Invoice #</div>
            <div class="detail-value">SB-<fmt:formatDate value="${transaction.timestamp}" pattern="yyyy-MMdd" />${transaction.id}</div>
            <div class="detail-label">Date</div>
            <div class="detail-value"><fmt:formatDate value="${transaction.timestamp}" pattern="MMM dd, yyyy" /></div>
        </div>
    </div>

    <div class="section">
        <h3 class="section-title">Transaction Details</h3>
        <div class="details-grid">
            <div>
                <div class="detail-item">
                    <span class="detail-label">Transaction ID:</span>
                    <span class="detail-value">${transaction.id}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Account:</span>
                    <span class="detail-value">Saving account (••••${transaction.fromAccount.accountNumber.substring(transaction.fromAccount.accountNumber.length() - 4)})</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Status:</span>
                    <span class="detail-value">Completed</span>
                </div>
            </div>
            <div>
                <div class="detail-item">
                    <span class="detail-label">Date & Time:</span>
                    <span class="detail-value"><fmt:formatDate value="${transaction.timestamp}" pattern="MMM dd, yyyy • hh:mm a" /></span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Reference:</span>
                    <span class="detail-value">${transaction.description}</span>
                </div>
            </div>
        </div>
    </div>

    <div class="section">
        <h3 class="section-title">Parties Involved</h3>
        <div class="details-grid">
            <div>
                <div class="detail-label">From:</div>
                <div class="detail-value">${transaction.fromAccount.user.fname} ${transaction.fromAccount.user.lname}</div>
                <div class="detail-value">Saving account (••••${transaction.fromAccount.accountNumber.substring(transaction.fromAccount.accountNumber.length() - 4)})</div>
                <div class="detail-value">Smart Bank</div>
            </div>
            <div>
                <div class="detail-label">To:</div>
                <div class="detail-value">${transaction.toAccount.user.fname} ${transaction.toAccount.user.lname}</div>
                <div class="detail-value">•••• •••• •••• ${transaction.toAccount.accountNumber.substring(transaction.toAccount.accountNumber.length() - 4)}</div>
                <div class="detail-value">Smart Bank</div>
            </div>
        </div>
    </div>

    <div class="section">
        <h3 class="section-title">Transaction Breakdown</h3>
        <table class="transaction-table">
            <thead>
            <tr>
                <th>Description</th>
                <th>Amount</th>

            </tr>
            </thead>
            <tbody>
            <tr>
                <td>${transaction.description} - <fmt:formatDate value="${transaction.timestamp}" pattern="MMM yyyy" /></td>
                <td class="amount-credit">Rs. <fmt:formatNumber value="${transaction.amount}" pattern="#,##0.00" /></td>

            </tr>
            </tbody>
        </table>
    </div>

    <div class="footer">
        <p>This is an automated transaction receipt. Please contact support if you have any questions.</p>
        <p>Smart Bank • 24/7 Customer Support: 1-800-SMART-BANK</p>
        <p>© 2025 Smart Bank. All rights reserved.</p>
    </div>
</div>

<button class="download-btn" id="download-pdf">Download as PDF</button>

<script>
    document.getElementById('download-pdf').addEventListener('click', function() {
        const element = document.getElementById('invoice-container');
        const opt = {
            margin: 10,
            filename: 'SmartBank_Transaction_Receipt.pdf',
            image: { type: 'jpeg', quality: 0.98 },
            html2canvas: { scale: 2 },
            jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' }
        };

        // Generate PDF
        html2pdf().set(opt).from(element).save();
    });
</script>
</body>
</html>
