package dao;

import model.User;
import util.DatabaseConnection;
import java.sql.*;
import java.text.SimpleDateFormat;

public class UserProfileDAO {

    // Insert user for signup
    public static int insertUser(User user) {
        int userId = -1;
        try {
            Connection con = DatabaseConnection.getConnection();
            String query = "INSERT INTO users (user_fname, user_lname, user_dob, user_email, user_phone, user_address, user_gender, password) " +
                           "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, user.getUser_fName());
            ps.setString(2, user.getUser_lName());
            ps.setString(3, new SimpleDateFormat("yyyy-MM-dd").format(user.getUser_dob()));
            ps.setString(4, user.getUser_email());
            ps.setString(5, user.getUser_phone());
            ps.setString(6, user.getUser_address());
            ps.setString(7, user.getUser_gender());
            ps.setString(8, user.getPassword());

            

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    userId = rs.getInt(1);
                }
                rs.close();
            }

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userId;
    }

    // Update user
    public static boolean updateUser(User user) {
        boolean updated = false;
        try {
            Connection con = DatabaseConnection.getConnection();
            String query = "UPDATE users SET user_fname=?, user_lname=?, user_phone=?, user_address=?, password=? WHERE user_email=?";
            
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, user.getUser_fName());
            ps.setString(2, user.getUser_lName());
            ps.setString(3, user.getUser_phone());
            ps.setString(4, user.getUser_address());
            ps.setString(5, user.getPassword());
            ps.setString(6, user.getUser_email());

            updated = ps.executeUpdate() > 0;

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return updated;
    }
    // Get user by email (used for login or profile)
    public static User getUserByEmail(String email) {
        User user = null;
        try {
            Connection con = DatabaseConnection.getConnection();
            String query = "SELECT * FROM users WHERE user_email = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUser_id(rs.getInt("user_id"));
                user.setUser_fName(rs.getString("user_fname"));
                user.setUser_lName(rs.getString("user_lname"));
                user.setUser_dob(rs.getDate("user_dob"));
                user.setUser_phone(rs.getString("user_phone"));
                user.setUser_address(rs.getString("user_address"));
                user.setUser_email(rs.getString("user_email"));
                user.setPassword(rs.getString("password"));
                user.setUser_gender(rs.getString("user_gender"));
                user.setUser_role(rs.getString("user_role"));
                user.setUser_profile(rs.getString("user_profile"));
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Delete user
    public static boolean deleteUser(String email) {
        boolean deleted = false;
        try {
            Connection con = DatabaseConnection.getConnection();
            String query = "DELETE FROM users WHERE user_email = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            deleted = ps.executeUpdate() > 0;
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return deleted;
    }

    }

