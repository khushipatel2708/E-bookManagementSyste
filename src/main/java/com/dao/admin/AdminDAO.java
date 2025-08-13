package com.dao.admin;

import com.database.DBConnect;
import com.detail.AdminDetail;
import com.javaclass.PasswordEncrypt;
import java.sql.*;

public class AdminDAO {

    public boolean registerAdmin(AdminDetail ad) {
        try (Connection conn = DBConnect.getConnection()) {
            String sql = "INSERT INTO admin (userName, email, password, fullName, phone) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, ad.getUserName());
            ps.setString(2, ad.getEmail());
            ps.setString(3, ad.getPassword());
            ps.setString(4, ad.getFullName());
            ps.setString(5, ad.getPhone());
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public String adminLogin(AdminDetail ad) {
        try {
            String ePassword = PasswordEncrypt.hashPassword(ad.getPassword());
            String query = "SELECT * FROM admin WHERE userName = ? AND password = ?";
            Connection conn = DBConnect.getConnection();
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setString(1, ad.getUserName());
            pt.setString(2, ePassword);
            ResultSet rs = pt.executeQuery();
            if (rs.next()) {
                return "done";
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return "no";
    }

    public boolean updateAdminProfile(String userName, String fullName, String email, String phone) {
    try {
        Connection conn = DBConnect.getConnection();
        String sql = "UPDATE admin SET fullName=?, email=?, phone=? WHERE userName=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, fullName);
        ps.setString(2, email);
        ps.setString(3, phone);
        ps.setString(4, userName);
        return ps.executeUpdate() == 1;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

public AdminDetail getAdminByUserName(String userName) {
    try {
        Connection conn = DBConnect.getConnection();
        String sql = "SELECT * FROM admin WHERE userName=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, userName);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            AdminDetail ad = new AdminDetail();
            ad.setUserName(rs.getString("userName"));
            ad.setEmail(rs.getString("email"));
            ad.setPhone(rs.getString("phone"));
            ad.setFullName(rs.getString("fullName"));
            return ad;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}

}
