package model;

public class Venue {
	private int venue_id;
	private String venue_name;
	private String venue_status;
	private int venue_capacity;
	private double venue_cost;
	private String venue_image;

	public Venue() {

	}

	public Venue(int venue_id, String venue_name, String venue_status, int venue_capacity, double venue_cost,
			String venue_image) {
		this.venue_id = venue_id;
		this.venue_name = venue_name;
		this.venue_status = venue_status;
		this.venue_capacity = venue_capacity;
		this.venue_cost = venue_cost;
		this.venue_image = venue_image;
	}

	public int getVenue_id() {
		return venue_id;
	}

	public void setVenue_id(int venue_id) {
		this.venue_id = venue_id;
	}

	public String getVenue_name() {
		return venue_name;
	}

	public void setVenue_name(String venue_name) {
		this.venue_name = venue_name;
	}

	public String getVenue_status() {
		return venue_status;
	}

	public void setVenue_status(String venue_status) {
		this.venue_status = venue_status;
	}

	public int getVenue_capacity() {
		return venue_capacity;
	}

	public void setVenue_capacity(int venue_capacity) {
		this.venue_capacity = venue_capacity;
	}

	public double getVenue_cost() {
		return venue_cost;
	}

	public void setVenue_cost(double venue_cost) {
		this.venue_cost = venue_cost;
	}

	public String getVenue_image() {
		return venue_image;
	}

	public void setVenue_image(String venue_image) {
		this.venue_image = venue_image;
	}

}
