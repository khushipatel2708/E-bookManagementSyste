package authDAO;

import com.database.DBConnect;
import auth.User;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {

    // Register new user with status passed in User object
    public String register(User u) {
        String sql = "INSERT INTO users(fullname, username, email, password, phone, status, role_id) VALUES(?,?,?,?,?,?,?)";
        try (Connection con = DBConnect.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, u.getFullname());
            ps.setString(2, u.getUsername());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPassword());  // already hashed
            ps.setString(5, u.getPhone());
            ps.setString(6, u.getStatus());    // ✅ use status from RegisterServlet
            ps.setInt(7, u.getRoleId());

            ps.executeUpdate();
            return "ok";

        } catch (SQLIntegrityConstraintViolationException ex) {
            if (ex.getMessage().contains("username")) {
                return "duplicate-username";
            }
            if (ex.getMessage().contains("email")) {
                return "duplicate-email";
            }
            return "error";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    // Login (any status)
    public User loginAnyStatus(String username, String passwordHash) {
        String sql = "SELECT * FROM users WHERE username=? AND password=?";
        try (Connection con = DBConnect.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, passwordHash);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setFullname(rs.getString("fullname"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setStatus(rs.getString("status"));
                u.setRoleId(rs.getInt("role_id"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Check token exists
    public boolean isTokenExists(String email) {
        String sql = "SELECT token FROM userverifications WHERE email=?";
        try (Connection con = DBConnect.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Save verification token
    public void saveVerificationToken(String email, int token) {
        try (Connection con = DBConnect.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO userverifications(email, token) VALUES(?, ?) ON DUPLICATE KEY UPDATE token=?"
            );
            ps.setString(1, email);
            ps.setInt(2, token);
            ps.setInt(3, token);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Verify user
    public boolean verifyUser(String email, int token) {
        try (Connection con = DBConnect.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM userverifications WHERE email=? AND token=?"
            );
            ps.setString(1, email);
            ps.setInt(2, token);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // mark ACTIVE
                PreparedStatement ps2 = con.prepareStatement(
                        "UPDATE users SET status='ACTIVE' WHERE email=?"
                );
                ps2.setString(1, email);
                ps2.executeUpdate();

                // delete token
                PreparedStatement ps3 = con.prepareStatement(
                        "DELETE FROM userverifications WHERE email=?"
                );
                ps3.setString(1, email);
                ps3.executeUpdate();

                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get user by email
    public User getUserByEmail(String email) {
        User user = null;
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection con = DBConnect.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setFullname(rs.getString("fullname"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setRoleId(rs.getInt("role_id"));
                user.setStatus(rs.getString("status"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public String deleteAccount(int id) {
        String getEmailSQL = "SELECT email FROM users WHERE id=?";
        String deleteTokenSQL = "DELETE FROM userverifications WHERE email=?";
        String deleteUserSQL = "DELETE FROM users WHERE id=?";

        try (Connection conn = DBConnect.getConnection()) {
            conn.setAutoCommit(false); // start transaction
            String email = null;

            // 1️⃣ Get email
            try (PreparedStatement psEmail = conn.prepareStatement(getEmailSQL)) {
                psEmail.setInt(1, id);
                ResultSet rs = psEmail.executeQuery();
                if (rs.next()) {
                    email = rs.getString("email");
                } else {
                    return "no"; // user not found
                }
            }

            // 2️⃣ Delete from userverifications
            try (PreparedStatement psToken = conn.prepareStatement(deleteTokenSQL)) {
                psToken.setString(1, email);
                psToken.executeUpdate();
            }

            // 3️⃣ Delete from users
            try (PreparedStatement psUser = conn.prepareStatement(deleteUserSQL)) {
                psUser.setInt(1, id);
                int rows = psUser.executeUpdate();
                if (rows > 0) {
                    conn.commit();
                    return "done";
                } else {
                    conn.rollback();
                    return "no";
                }
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            return "error";
        }
    }

}
