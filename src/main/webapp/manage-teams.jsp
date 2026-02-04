<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>EventPro - Team Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e0e0e0;
        }

        h1 {
            color: #2c3e50;
            font-size: 28px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            padding: 10px 15px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .btn i {
            margin-right: 8px;
        }

        .btn:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background-color: #95a5a6;
        }

        .btn-secondary:hover {
            background-color: #7f8c8d;
        }

        .alert {
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-success i {
            margin-right: 10px;
        }

        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
            overflow: hidden;
        }

        .card-header {
            padding: 15px 20px;
            background-color: #f8f9fa;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header h2 {
            color: #2c3e50;
            font-size: 18px;
        }

        .card-body {
            padding: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #2c3e50;
        }

        .form-control {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .team-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 20px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .team-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .team-info {
            margin-bottom: 15px;
        }

        .team-info p {
            margin-bottom: 8px;
            display: flex;
        }

        .info-label {
            font-weight: 500;
            color: #7f8c8d;
            min-width: 120px;
        }

        .team-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }

        .delete-form {
            display: inline;
        }

        .delete-btn {
            background-color: #e74c3c;
            color: white;
        }

        .delete-btn:hover {
            background-color: #c0392b;
        }

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }

            .team-grid {
                grid-template-columns: 1fr;
            }

            .form-actions,
            .team-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>

    <script>
        function populateForm(teamId, teamName, noOfWorkers, bookingId, assignedBy) {
            document.getElementById("form-title").textContent = "Update Team";
            document.getElementById("team_id").value = teamId;
            document.getElementById("team_name").value = teamName;
            document.getElementById("no_of_workers").value = noOfWorkers;
            document.getElementById("booking_id").value = bookingId;
            document.getElementById("assigned_by").value = assignedBy;
            document.getElementById("action").value = "update";
            document.getElementById("form-card").scrollIntoView({ behavior: 'smooth' });
        }

        function resetForm() {
            document.getElementById("form-title").textContent = "Create New Team";
            document.getElementById("teamForm").reset();
            document.getElementById("action").value = "create";
            document.getElementById("team_id").value = "";
        }

        function validateForm() {
            const teamName = document.getElementById("team_name").value.trim();
            const noOfWorkers = document.getElementById("no_of_workers").value.trim();
            const bookingId = document.getElementById("booking_id").value.trim();
            const assignedBy = document.getElementById("assigned_by").value.trim();

            const nameRegex = /^[A-Za-z\s]+$/;
            const numberRegex = /^[1-9]\d*$/;

            if (!nameRegex.test(teamName)) {
                alert("Team name should contain only letters and spaces.");
                return false;
            }
            if (!numberRegex.test(noOfWorkers)) {
                alert("Number of workers must be a positive integer.");
                return false;
            }
            if (!numberRegex.test(bookingId)) {
                alert("Booking ID must be a positive integer.");
                return false;
            }
            if (!numberRegex.test(assignedBy)) {
                alert("Assigned By (User ID) must be a positive integer.");
                return false;
            }

            return true;
        }

        window.onload = function () {
            document.getElementById("teamForm").onsubmit = validateForm;
        };
    </script>
</head>

<body>
    <div class="container">
        <header>
            <h1><i class="fas fa-users-cog"></i> Team Management</h1>
            <a href="OrganizerController" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </header>

        <c:if test="${not empty message}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${message}
            </div>
        </c:if>

        <div class="card" id="form-card">
            <div class="card-header">
                <h2 id="form-title">Create New Team</h2>
            </div>
            <div class="card-body">
                <form action="TeamController" method="post" id="teamForm">
                    <input type="hidden" name="action" id="action" value="create">
                    <input type="hidden" name="team_id" id="team_id"> <!-- ✅ Fix -->

                    <div class="form-row">
                        <div class="form-group">
                            <label for="team_name">Team Name</label>
                            <input type="text" class="form-control" name="team_name" id="team_name" required>
                        </div>
                        <div class="form-group">
                            <label for="no_of_workers">Number of Workers</label>
                            <input type="text" class="form-control" name="no_of_workers" id="no_of_workers" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="booking_id">Booking ID</label>
                            <input type="text" class="form-control" name="booking_id" id="booking_id" required>
                        </div>
                        <div class="form-group">
                            <label for="assigned_by">Assigned By (User ID)</label>
                            <input type="text" class="form-control" name="assigned_by" id="assigned_by" required>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn">
                            <i class="fas fa-save"></i> Save Team
                        </button>
                        <button type="button" class="btn btn-secondary" onclick="resetForm()">
                            <i class="fas fa-undo"></i> Reset Form
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <h2><i class="fas fa-list"></i> Existing Teams</h2>
        <div class="team-grid">
            <c:forEach var="team" items="${teamList}">
                <div class="team-card">
                    <div class="team-info">
                        <p><span class="info-label">Team ID:</span> <c:out value="${team.teamId}" /></p>
                        <p><span class="info-label">Team Name:</span> <c:out value="${team.teamName}" /></p>
                        <p><span class="info-label">Workers:</span> <c:out value="${team.noOfWorkers}" /></p>
                        <p><span class="info-label">Booking ID:</span> <c:out value="${team.booking_id}" /></p>
                        <p><span class="info-label">Assigned By:</span> <c:out value="${team.assigned_by}" /></p>
                    </div>
                    <div class="team-actions">
                        <button class="btn" onclick="populateForm(
                            '${team.teamId}', 
                            '${team.teamName}', 
                            '${team.noOfWorkers}', 
                            '${team.booking_id}', 
                            '${team.assigned_by}')">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                        <form class="delete-form" action="TeamController" method="post"
                            onsubmit="return confirm('Are you sure you want to delete this team?')">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="team_id" value="${team.teamId}">
                            <button type="submit" class="btn delete-btn">
                                <i class="fas fa-trash-alt"></i> Delete
                            </button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
