package model;

public class UserData {
    private int bookingId; // <-- Added
    private String email;
    private String username;
    private String bookingDate;
    private String eventDate;
    private String packageName;
    private int attendeeCount;
    private String venueName;
    private String services;
    private String paymentDate;
    private String paymentStatus;
    private double paymentAmount;
    private String replyText;
    private String repliedAt;

    public UserData() {}

    public UserData(int bookingId, String email, String username, String bookingDate, String eventDate,
                              String packageName, int attendeeCount, String venueName, String services,
                              String paymentDate, String paymentStatus, double paymentAmount,
                              String replyText, String repliedAt) {
        this.bookingId = bookingId;
        this.email = email;
        this.username = username;
        this.bookingDate = bookingDate;
        this.eventDate = eventDate;
        this.packageName = packageName;
        this.attendeeCount = attendeeCount;
        this.venueName = venueName;
        this.services = services;
        this.paymentDate = paymentDate;
        this.paymentStatus = paymentStatus;
        this.paymentAmount = paymentAmount;
        this.replyText = replyText;
        this.repliedAt = repliedAt;
    }

    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getEventDate() {
        return eventDate;
    }

    public void setEventDate(String eventDate) {
        this.eventDate = eventDate;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public int getAttendeeCount() {
        return attendeeCount;
    }

    public void setAttendeeCount(int attendeeCount) {
        this.attendeeCount = attendeeCount;
    }

    public String getVenueName() {
        return venueName;
    }

    public void setVenueName(String venueName) {
        this.venueName = venueName;
    }

    public String getServiceName() {
        return services;
    }

    public void setServiceName(String serviceName) {
        this.services = serviceName;
    }

    public String getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(String paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public double getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(double paymentAmount) {
        this.paymentAmount = paymentAmount;
    }

    public String getReplyText() {
        return replyText;
    }

    public void setReplyText(String replyText) {
        this.replyText = replyText;
    }

    public String getRepliedAt() {
        return repliedAt;
    }

    public void setRepliedAt(String repliedAt) {
        this.repliedAt = repliedAt;
    }

    @Override
    public String toString() {
        return "UserDashboardData{" +
                "bookingId=" + bookingId +
                ", email='" + email + '\'' +
                ", username='" + username + '\'' +
                ", bookingDate='" + bookingDate + '\'' +
                ", eventDate='" + eventDate + '\'' +
                ", packageName='" + packageName + '\'' +
                ", attendeeCount=" + attendeeCount +
                ", venueName='" + venueName + '\'' +
                ", serviceName='" + services + '\'' +
                ", paymentDate='" + paymentDate + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", paymentAmount=" + paymentAmount +
                ", replyText='" + replyText + '\'' +
                ", repliedAt='" + repliedAt + '\'' +
                '}';
    }
}