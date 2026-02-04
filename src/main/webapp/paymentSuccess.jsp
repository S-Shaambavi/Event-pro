<%@ page session="true" %>
<html>

<head>
    <title>Payment Success</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            text-align: center;
            background-color: #f0fff0;
        }

        .success-box {
            margin-top: 100px;
            display: inline-block;
            padding: 40px;
            border-radius: 15px;
            background-color: #dfffdc;
            border: 2px solid #90ee90;
            box-shadow: 0 0 10px #b5e7b5;
        }

        .success-sticker {
            font-size: 60px;
        }

        h2 {
            color: green;
        }

        p {
            font-size: 18px;
        }
    </style>
</head>

<body>
    <div class="success-box">

        <img src="images/tik.jpeg" alt="Success" style="width:150px; height:auto; margin-top: 20px;" />

        <h2>Payment Successful!</h2>
        <p>Event: <strong>
                <%= session.getAttribute("eventName") %>
            </strong></p>
        <p>Amount Paid: RS <strong>
                <%= session.getAttribute("amount") %>
            </strong></p>
        <p style="font-family: 'Poppins', sans-serif; font-size: 18px; color: #333;">
            Thank you for your payment! Your booking has been confirmed.<br>
            We look forward to making your event unforgettable.
        </p>

        <p> <b> Thank You For Choosing US... </b> </p>
    </div>
</body>

</html>