package model;

import java.util.Date;

public class Complaint {
    private int complaintId;
    private int userId;
    private int bookingId;
    private String complaintText;
    private String status;
    private Date createdAt;

    private String eventName; // Optional - populated via join
    private Date eventDate;   // Optional - populated via join

    public Complaint() {}

    public Complaint(int userId, int bookingId, String complaintText) {
        this.userId = userId;
        this.bookingId = bookingId;
        this.complaintText = complaintText;
        this.status = "Pending";
    }

    // Getters and setters
    public int getComplaintId() { return complaintId; }
    public void setComplaintId(int complaintId) { this.complaintId = complaintId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public String getComplaintText() { return complaintText; }
    public void setComplaintText(String complaintText) { this.complaintText = complaintText; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }

    public Date getEventDate() { return eventDate; }
    public void setEventDate(Date eventDate) { this.eventDate = eventDate; }
}
