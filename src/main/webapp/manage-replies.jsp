<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Reply" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>

<head>
    <title>EventPro - Reply Management</title>
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
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
            display: flex;
            align-items: center;
            gap: 10px;
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
        }

        .card-header h2 {
            color: #2c3e50;
            font-size: 18px;
            display: flex;
            align-items: center;
            gap: 8px;
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

        textarea.form-control {
            min-height: 100px;
            resize: vertical;
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

        .reply-list {
            margin-top: 40px;
        }

        .reply-list h2 {
            color: #2c3e50;
            font-size: 22px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        th,
        td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #f8f9fa;
            color: #2c3e50;
            font-weight: 600;
        }

        tr:hover {
            background-color: #f8f9fa;
        }

        .action-btn {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            transition: all 0.2s ease;
        }

        .edit-btn {
            background-color: #3498db;
            color: white;
        }

        .edit-btn:hover {
            background-color: #2980b9;
        }

        .delete-btn {
            background-color: #e74c3c;
            color: white;
        }

        .delete-btn:hover {
            background-color: #c0392b;
        }

        .status-badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-resolved {
            background-color: #d4edda;
            color: #155724;
        }

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
            }

            table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
    <script>
        function populateUpdateForm(replyId, complaintId, replierId, replyText) {
            document.getElementById("update-reply-id").value = replyId;
            document.getElementById("update-complaint-id").value = complaintId;
            document.getElementById("update-replier-id").value = replierId;
            document.getElementById("update-reply-text").value = replyText;
            document.getElementById("update-form").scrollIntoView({ behavior: 'smooth' });
        }

        function populateDeleteForm(replyId) {
            document.getElementById("delete-reply-id").value = replyId;
            document.getElementById("delete-form").scrollIntoView({ behavior: 'smooth' });
        }
    </script>
</head>

<body>
    <div class="container">
        <header>
            <h1><i class="fas fa-comments"></i> Reply Management</h1>
            <a href="${pageContext.request.contextPath}/OrganizerController" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </header>

        <!-- Create Reply -->
        <div class="card">
            <div class="card-header">
                <h2><i class="fas fa-plus-circle"></i> Create New Reply</h2>
            </div>
            <div class="card-body">
                <form action="ReplyController" method="post">
                    <input type="hidden" name="action" value="create">

                    <div class="form-row">
                        <div class="form-group">
                            <label for="complaint-id">Complaint ID</label>
                            <input type="number" class="form-control" name="complaint_id" id="complaint-id"
                                required>
                        </div>

                        <div class="form-group">
                            <label for="replier-id">Your User ID</label>
                            <input type="number" class="form-control" name="replier_id" id="replier-id"
                                required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="reply-text">Reply Message</label>
                        <textarea class="form-control" name="reply_text" id="reply-text"
                            required></textarea>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn">
                            <i class="fas fa-paper-plane"></i> Send Reply
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Update Reply -->
        <div class="card" id="update-form">
            <div class="card-header">
                <h2><i class="fas fa-edit"></i> Update Existing Reply</h2>
            </div>
            <div class="card-body">
                <form action="ReplyController" method="post">
                    <input type="hidden" name="action" value="update">

                    <div class="form-group">
                        <label for="update-reply-id">Reply ID</label>
                        <input type="number" class="form-control" name="reply_id" id="update-reply-id"
                            required>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="update-complaint-id">Complaint ID</label>
                            <input type="number" class="form-control" name="complaint_id"
                                id="update-complaint-id" required>
                        </div>

                        <div class="form-group">
                            <label for="update-replier-id">Your User ID</label>
                            <input type="number" class="form-control" name="replier_id"
                                id="update-replier-id" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="update-reply-text">Updated Reply Message</label>
                        <textarea class="form-control" name="reply_text" id="update-reply-text"
                            required></textarea>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn">
                            <i class="fas fa-save"></i> Update Reply
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Delete Reply -->
        <div class="card" id="delete-form">
            <div class="card-header">
                <h2><i class="fas fa-trash-alt"></i> Delete Reply</h2>
            </div>
            <div class="card-body">
                <form action="ReplyController" method="post"
                    onsubmit="return confirm('Are you sure you want to delete this reply?')">
                    <input type="hidden" name="action" value="delete">

                    <div class="form-group">
                        <label for="delete-reply-id">Reply ID</label>
                        <input type="number" class="form-control" name="reply_id" id="delete-reply-id"
                            required>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn delete-btn">
                            <i class="fas fa-trash"></i> Delete Reply
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Replies List -->
        <div class="reply-list">
            <h2><i class="fas fa-list"></i> Complaint Replies</h2>

            <table>
                <thead>
                    <tr>
                        <th>Reply ID</th>
                        <th>Complaint ID</th>
                        <th>Replier ID</th>
                        <th>Reply Message</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<Reply> replies = (List<Reply>) request.getAttribute("replies");
                            if (replies != null && !replies.isEmpty()) {
                            for (Reply reply : replies) {
                            %>
                            <tr>
                                <td>
                                    <%= reply.getReply_id() %>
                                </td>
                                <td>
                                    <%= reply.getComplaint_id() %>
                                </td>
                                <td>
                                    <%= reply.getReplier_id() %>
                                </td>
                                <td>
                                    <%= reply.getReply_text().length()> 50 ?
                                        reply.getReply_text().substring(0, 50) + "..." :
                                        reply.getReply_text() %>
                                </td>
                                <td>
                                    <form style="display:inline;" method="post" action="ReplyController">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="reply_id"
                                            value="<%= reply.getReply_id() %>">
                                        <input type="hidden" name="complaint_id"
                                            value="<%= reply.getComplaint_id() %>">
                                        <input type="hidden" name="replier_id"
                                            value="<%= reply.getReplier_id() %>">
                                        <input type="hidden" name="reply_text"
                                            value="<%= reply.getReply_text() %>">
                                        <button type="submit" class="action-btn edit-btn">
                                            <i class="fas fa-reply"></i> Reply
                                        </button>
                                    </form>
                                    <form style="display:inline;" method="post" action="ReplyController"
                                        onsubmit="return confirm('Are you sure you want to delete this reply?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="reply_id"
                                            value="<%= reply.getReply_id() %>">
                                        <button type="submit" class="action-btn delete-btn">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <% } } else { %>
                                <tr>
                                    <td colspan="5" style="text-align: center;">No replies found</td>
                                </tr>
                                <% } %>
                </tbody>
            </table>
        </div>

    </div>
</body>

</html>