package model;

import java.util.Date;

public abstract class UserProfile {
	protected int userId;
	protected String email;
	protected String firstName;
	protected String lastName;
	protected String phone;
	protected String address;
	protected String password;
	protected Date dob;
	protected String profile;
	protected String gender;

	public UserProfile(int userId,String email, String firstName, String lastName, String phone, String address, String password,
			Date dob, String profile, String gender) {
		this.userId=userId;
		this.email = email;
		this.firstName = firstName;
		this.lastName = lastName;
		this.phone = phone;
		this.address = address;
		this.password = password;
		this.dob = dob;
		this.profile = profile;
		this.gender = gender;
	}
	public int getUserId() {
	    return userId;
	}
	public void setUserId(int userId) {
	    this.userId = userId;
	}
	public abstract String getRole();

	public String getEmail() {
		return email;
	}

	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public String getPhone() {
		return phone;
	}

	public String getAddress() {
		return address;
	}

	public String getPassword() {
		return password;
	}

	public Date getDob() {
		return dob;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}
	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
}
