<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            color: #333;
        }

        .contact-section {
            background-color: #2c3e50;
            color: white;
            padding: 5rem 2rem;
            text-align: center;
        }

        .contact-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .contact-form {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-top: 3rem;
        }

        .form-group {
            flex: 0 0 48%;
            margin-bottom: 1.5rem;
            min-width: 250px;
        }

        .form-group.full-width {
            flex: 0 0 100%;
        }

        input,
        textarea {
            width: 100%;
            padding: 12px;
            border-radius: 5px;
            border: none;
            font-family: inherit;
            font-size: 1rem;
        }

        textarea {
            height: 150px;
        }

        .submit-btn {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .submit-btn:hover {
            background-color: #218838;
            transform: translateY(-3px);
        }
    </style>
</head>

<body>
    <jsp:include page="header.jsp" />
    <section id="contact" class="contact-section">
        <h2>Talk to Our Event Experts</h2>
        <p>Have questions about our platform? Want to discuss your specific event needs? Our team is ready to help.</p>

        <div class="contact-container">
            <div class="contact-form">
                <div class="form-group">
                    <input type="text" placeholder="Your Name" required>
                </div>
                <div class="form-group">
                    <input type="email" placeholder="Your Email" required>
                </div>

                <div class="form-group">
                    <input type="tel" placeholder="Phone Number">
                </div>
                <div class="form-group full-width">
                    <textarea placeholder="Tell us about your event needs..." required></textarea>
                </div>
                <div class="form-group full-width">
                    <button type="submit" class="submit-btn">Send Message</button>
                </div>
            </div>
        </div>
    </section>
    <jsp:include page="footer.jsp" />
</body>

</html>