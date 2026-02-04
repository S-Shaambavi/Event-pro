<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${empty sessionScope.user_email}">
    <c:redirect url="login.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Transaction Summarys</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }

        .transaction-container {
            max-width: 900px;
            margin: 80px auto;
            background-color: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .transaction-container h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #343a40;
        }

        .transaction-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 16px;
        }

        .transaction-table thead {
            background-color: #343a40;
            color: #fff;
        }

        .transaction-table th,
        .transaction-table td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #dee2e6;
        }

        .transaction-table tbody tr:hover {
            background-color: #f1f1f1;
        }

        .status-pending {
            color: #d39e00;
            font-weight: bold;
        }

        .status-complete {
            color: #28a745;
            font-weight: bold;
        }

        .pay-button {
            background-color: #007bff;
            color: white;
            padding: 8px 14px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.2s ease;
        }

        .pay-button:hover {
            background-color: #0056b3;
        }

        .paid-text {
            color: #28a745;
            font-weight: bold;
        }

        .no-transactions {
            text-align: center;
            color: #6c757d;
            font-size: 18px;
            margin-top: 30px;
        }

        .pay-button {
            background-color: #28a745;
            color: white;
            padding: 6px 12px;
            text-decoration: none;
            border-radius: 4px;
        }

        .completed-label {
            color: #888;
            font-weight: bold;
        }
    </style>
</head>

<body>
    <jsp:include page="header.jsp" />

    <div class="transaction-container">
        <h1>Your Transactions</h1>

        <c:if test="${not empty transactionList}">
            <table class="transaction-table">
                <thead>
                    <tr>
                        <th>Event Name</th>
                        <th>Booked Date</th>
                        <th>Amount</th>
                        <th>Payment Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="transaction" items="${transactionList}">
                        <tr>
                            <td>${transaction.packageName}</td>
                            <td>
                                <fmt:formatDate value="${transaction.bookingDate}" pattern="yyyy-MM-dd" />
                            </td>
                            <td>Rs. ${transaction.packageCost}</td>
                            <td>${transaction.paymentStatus}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${transaction.paymentStatus == 'Pending'}">
                                        <a href="paymentServlet?bookingId=${transaction.bookingId}"
                                            class="pay-button">Pay Now</a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="completed-label">Completed</span>
                                        <!-- Optional: use a disabled button instead
                                <button class="completed-button" disabled>Completed</button>
                                -->
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>


        <c:if test="${empty transactionList}">
            <p class="no-transactions">No transactions found.</p>
        </c:if>
    </div>

    <jsp:include page="footer.jsp" />
</body>

</html>