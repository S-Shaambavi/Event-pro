package model;

import java.sql.Date;

public class Booking {
	private int customerId;
	private int packageId;
	private Date eventDate;
	private String eventType;
	private String services;

	public Booking(int customerId, int packageId, Date eventDate) {
		this.customerId = customerId;
		this.packageId = packageId;
		this.eventDate = eventDate;
	}

	public Booking(int customerId, int packageId, Date eventDate, String eventType, String services) {
		this.customerId = customerId;
		this.packageId = packageId;
		this.eventDate = eventDate;
		this.eventType = eventType;
		this.services = services;
	}

	public int getCustomerId() {
		return customerId;
	}

	public int getPackageId() {
		return packageId;
	}

	public Date getEventDate() {
		return eventDate;
	}

	public String getEventType() {
		return eventType;
	}

	public String getServices() {
		return services;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public void setPackageId(int packageId) {
		this.packageId = packageId;
	}

	public void setEventDate(Date eventDate) {
		this.eventDate = eventDate;
	}

	public void setEventType(String eventType) {
		this.eventType = eventType;
	}

	public void setServices(String services) {
		this.services = services;
	}
}
