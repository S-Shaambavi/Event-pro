package model;

import java.sql.Date;

public class Admin extends UserProfile {
	public Admin(int userId,String email, String firstName, String lastName, String phone, String address, String password,
			Date dob, String profile, String gender) {
		super(userId,email, firstName, lastName, phone, address, password, dob, profile, gender);
	}

	@Override
	public String getRole() {
		return "Admin";
	}
}
