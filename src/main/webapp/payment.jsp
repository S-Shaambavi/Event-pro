<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${empty sessionScope.user_email}">
    <c:redirect url="login.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment Form</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }
        .payment-container {
            max-width: 600px;
            margin: 80px auto;
            background-color: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .payment-container h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #343a40;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #343a40;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            font-size: 16px;
        }
        .form-group input[readonly] {
            background-color: #e9ecef;
        }
        .submit-button {
            background-color: #007bff;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            transition: background-color 0.2s ease;
        }
        .submit-button:hover {
            background-color: #0056b3;
        }
        .submit-button:disabled {
            background-color: #6c757d;
            cursor: not-allowed;
        }
        .error-message {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }
        .error-message.active {
            display: block;
        }
        .server-error {
            color: #dc3545;
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const form = document.querySelector('form');
            const cardNumberInput = document.getElementById('cardNumber');
            const expiryDateInput = document.getElementById('expiryDate');
            const cvvInput = document.getElementById('cvv');
            const submitButton = document.querySelector('.submit-button');

            const cardNumberError = document.getElementById('cardNumberError');
            const expiryDateError = document.getElementById('expiryDateError');
            const cvvError = document.getElementById('cvvError');

            // Validate card number (16 digits, formatted as 4 groups of 4)
            function validateCardNumber() {
                const value = cardNumberInput.value.replace(/\s/g, '');
                const isValid = /^\d{16}$/.test(value);
                cardNumberError.classList.toggle('active', !isValid);
                cardNumberError.textContent = isValid ? '' : 'Card number must be 16 digits.';
                return isValid;
            }

            // Validate expiry date (MM/YY format, future date only)
            function validateExpiryDate() {
                const value = expiryDateInput.value;
                const isFormatValid = /^(0[1-9]|1[0-2])\/\d{2}$/.test(value);
                if (!isFormatValid) {
                    expiryDateError.classList.add('active');
                    expiryDateError.textContent = 'Expiry date must be in MM/YY format.';
                    return false;
                }

                // Check if the date is in the future
                const [month, year] = value.split('/').map(Number);
                const fullYear = 2000 + year;
                const expiryDate = new Date(fullYear, month, 0); // Last day of the month
                const currentDate = new Date();
                const isFuture = expiryDate > currentDate;

                expiryDateError.classList.toggle('active', !isFuture);
                expiryDateError.textContent = isFuture ? '' : 'Expiry date must be in the future.';
                return isFormatValid && isFuture;
            }

            // Validate CVV (3 digits)
            function validateCvv() {
                const value = cvvInput.value;
                const isValid = /^\d{3}$/.test(value); // 3 digits for CVV
                cvvError.classList.toggle('active', !isValid);
                cvvError.textContent = isValid ? '' : 'CVV must be 3 digits.';
                return isValid;
            }

            // Format card number (grouped by 4 digits)
            cardNumberInput.addEventListener('input', function () {
                let value = this.value.replace(/\D/g, '');
                if (value.length > 16) value = value.slice(0, 16);
                this.value = value.replace(/(\d{4})(?=\d)/g, '$1 ');
                validateCardNumber();
                updateSubmitButton();
            });

            // Format expiry date (auto-insert slash)
            expiryDateInput.addEventListener('input', function () {
                let value = this.value.replace(/\D/g, '');
                if (value.length > 4) value = value.slice(0, 4);
                if (value.length >= 3) {
                    this.value = value.slice(0, 2) + '/' + value.slice(2);
                } else {
                    this.value = value;
                }
                validateExpiryDate();
                updateSubmitButton();
            });

            cvvInput.addEventListener('input', function () {
                this.value = this.value.replace(/\D/g, '').slice(0, 3);
                validateCvv();
                updateSubmitButton();
            });

            // Enable/disable submit button based on validation
            function updateSubmitButton() {
                const isValid = validateCardNumber() && validateExpiryDate() && validateCvv();
                submitButton.disabled = !isValid;
            }

            // Validate on form submission
            form.addEventListener('submit', function (event) {
                const isCardValid = validateCardNumber();
                const isExpiryValid = validateExpiryDate();
                const isCvvValid = validateCvv();

                if (!isCardValid || !isExpiryValid || !isCvvValid) {
                    event.preventDefault();
                }
            });

            // Initial validation
            updateSubmitButton();
        });
    </script>
</head>
<body>
<jsp:include page="header.jsp" />

<div class="payment-container">
    <h1>Payment Details</h1>

    <c:if test="${not empty errorMessage}">
        <p class="server-error">${errorMessage}</p>
    </c:if>

    <form action="paymentServlet" method="post">
        <input type="hidden" name="bookingId" value="${transaction.bookingId}">
        <input type="hidden" name="eventName" value="${transaction.packageName}">
        <input type="hidden" name="amount" value="${transaction.packageCost}">
    
        <div class="form-group">
            <label for="eventName">Event Name</label>
            <input type="text" id="eventName" value="${transaction.packageName}" readonly>
        </div>
        
        <div class="form-group">
            <label for="amountDisplay">Amount ($)</label>
            <input type="text" id="amountDisplay" value="${transaction.packageCost}" readonly>
        </div>
    
        <!-- Card fields -->
        <div class="form-group">
            <label for="cardNumber">Card Number</label>
            <input type="text" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" required>
            <div id="cardNumberError" class="error-message"></div>
        </div>
        <div class="form-group">
            <label for="expiryDate">Expiry Date (MM/YY)</label>
            <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" required>
            <div id="expiryDateError" class="error-message"></div>
        </div>
        <div class="form-group">
            <label for="cvv">CVV</label>
            <input type="text" id="cvv" name="cardCvv" placeholder="123" required>
            <div id="cvvError" class="error-message"></div>
        </div>
    
        <button type="submit" class="submit-button" disabled>Submit Payment</button>
    </form>

</div>

<jsp:include page="footer.jsp" />
</body>
</html>