/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.database.DBConnect;
import com.detail.UserDetail;
import com.javaclass.Email;
import com.javaclass.PasswordEncrypt;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author chetan
 */
public class UserDAO {

public String userRegistration(String fullName, String username, String phone, String email, String password) {
    try {
        String ePassword = PasswordEncrypt.hashPassword(password);
        Connection conn = DBConnect.getConnection();

        // Check for active user
        String query1 = "SELECT * FROM useraccount WHERE email = ? AND active = 'Y'";
        PreparedStatement pt1 = conn.prepareStatement(query1);
        pt1.setString(1, email);
        ResultSet rs1 = pt1.executeQuery();
        if (rs1.next()) {
            return "alreadyUser";
        }

        // Check for any user with same email
        String query2 = "SELECT * FROM useraccount WHERE email = ?";
        PreparedStatement pt2 = conn.prepareStatement(query2);
        pt2.setString(1, email);
        ResultSet rs2 = pt2.executeQuery();
        if (rs2.next()) {
            return "already_exist";
        }

        // Insert new user with full name, username, phone
        String query3 = "INSERT INTO useraccount (fullname, name, phone, email, password, active) VALUES (?, ?, ?, ?, ?, 'N')";
        PreparedStatement pt3 = conn.prepareStatement(query3);
        pt3.setString(1, fullName);
        pt3.setString(2, username);
        pt3.setString(3, phone);
        pt3.setString(4, email);
        pt3.setString(5, ePassword);
        int inserted = pt3.executeUpdate();

        if (inserted == 1) {
            return handleVerification(email, fullName, conn);
        } else {
            return "insert_failed";
        }

    } catch (SQLException ex) {
        Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        return "sql_exception";
    }
}

    private String handleVerification(String email, String name, Connection conn) throws SQLException {
        // Clean up any old verification record
        String deleteQuery = "DELETE FROM userverifications WHERE email = ?";
        PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery);
        deleteStmt.setString(1, email);
        deleteStmt.executeUpdate();

        int otp = getOTP();
        String subject = "Account Verification";
        String body = "Hello " + name + ",\n\n"
                + "Your verification link is:\n"
                + "http://localhost:8080/E-bookManagementSyste/GetVerifiedUserServlet?email=" + email + "&token=" + otp + "\n\n"
                + "If you are having any issues with your account, please contact us.\n\n"
                + "Thanks,\nBook Store";

        // Send email (async)
        Thread emailThread = new Thread(new Email(email, subject, body));
        emailThread.start();

        // Save token
        String insertToken = "INSERT INTO userverifications (email, token) VALUES (?, ?)";
        PreparedStatement insertStmt = conn.prepareStatement(insertToken);
        insertStmt.setString(1, email);
        insertStmt.setInt(2, otp);
        insertStmt.executeUpdate();

        return "done";
    }

    private int getOTP() {
        return (int) (Math.random() * (999999999 - 111111111 + 1) + 111111111);
    }

    public String userLogin(String email, String password) {
        try {
            Connection conn = DBConnect.getConnection();
            String ePassword = PasswordEncrypt.hashPassword(password);
           String query = "select * from useraccount where email = ? and password = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setString(1, email);
            pt.setString(2, ePassword);
            ResultSet rs = pt.executeQuery();
            if (rs.next()) {
                return "done";
            } else {
                return "invalid";
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "no";
    }

    public void verifyUser(String email, int token) {
        try {
            Connection conn = DBConnect.getConnection();
            String query = "select * from userverifications where email = ? and token = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setString(1, email);
            pt.setInt(2, token);
            ResultSet rs = pt.executeQuery();
            if (rs.next()) {
                String query4 = "delete from userverifications where email = ?";
                PreparedStatement pt4 = conn.prepareStatement(query4);
                pt4.setString(1, email);
                pt4.executeUpdate();
                String query5 = "UPDATE useraccount SET active = 'Y' WHERE email = ?";

                PreparedStatement pt5 = conn.prepareStatement(query5);
                pt5.setString(1, email);
                pt5.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public UserDetail userDetail(String email) {
        UserDetail ud = null;
        try {
            Connection conn = DBConnect.getConnection();
            String query = "select * from userAccount where email = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setString(1, email);
            ResultSet rs = pt.executeQuery();
            if (rs.next()) {
                ud = new UserDetail();
                ud.setId(rs.getInt("id"));
                ud.setName(rs.getString("name"));
                ud.setEmail(rs.getString("email"));
                ud.setActive("Y".equalsIgnoreCase(rs.getString("active")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ud;
    }

    public String deleteAccount(int id) {
        try {
            Connection conn = DBConnect.getConnection();
            String query = "delete from useraccount where id = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setInt(1, id);
            pt.executeUpdate();
            return "done";
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "no";
    }

    public String changePassword(int id, String oPassword, String nPassword) {
        try {
            String eoPassword = PasswordEncrypt.hashPassword(oPassword);
            String enPassword = PasswordEncrypt.hashPassword(nPassword);
            Connection conn = DBConnect.getConnection();
            String query = "select * from useraccount where id = ? and password = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setInt(1, id);
            pt.setString(2, eoPassword);
            ResultSet rs = pt.executeQuery();
            if (rs.next()) {
                String query2 = "update useraccount set password = ? where id = ?";
                PreparedStatement pt2 = conn.prepareStatement(query2);
                pt2.setString(1, enPassword);
                pt2.setInt(2, id);
                int i = pt2.executeUpdate();
                if (i == 1) {
                    return "done";
                }
            } else {
                return "notMatched";
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return "no";
    }

}