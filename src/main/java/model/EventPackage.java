package model;

import java.util.List;

public class EventPackage {
    private String name;
    private int venueId;
    private int createdBy;
    private int attendeeCount;
    private List<Integer> serviceIds;
    private double totalCost;

    // Default constructor
    public EventPackage() {}

    // Parameterized constructor
    public EventPackage(String name, int venueId, int createdBy, int attendeeCount, List<Integer> serviceIds, double totalCost) {
        this.name = name;
        this.venueId = venueId;
        this.createdBy = createdBy;
        this.attendeeCount = attendeeCount;
        this.serviceIds = serviceIds;
        this.totalCost = totalCost;
    }

    // Getters and Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getVenueId() {
        return venueId;
    }

    public void setVenueId(int venueId) {
        this.venueId = venueId;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public int getAttendeeCount() {
        return attendeeCount;
    }

    public void setAttendeeCount(int attendeeCount) {
        this.attendeeCount = attendeeCount;
    }

    public List<Integer> getServiceIds() {
        return serviceIds;
    }

    public void setServiceIds(List<Integer> serviceIds) {
        this.serviceIds = serviceIds;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    @Override
    public String toString() {
        return "EventPackage{" +
                "name='" + name + '\'' +
                ", venueId=" + venueId +
                ", createdBy=" + createdBy +
                ", attendeeCount=" + attendeeCount +
                ", serviceIds=" + serviceIds +
                ", totalCost=" + totalCost +
                '}';
    }
}
