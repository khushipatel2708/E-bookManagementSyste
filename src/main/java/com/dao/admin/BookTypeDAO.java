package com.dao.admin;

import com.database.DBConnect;
import com.detail.BookTypeDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookTypeDAO {

    // Add book type
    public boolean addBookType(BookTypeDetail type) {
        try (Connection conn = DBConnect.getConnection()) {
            String sql = "INSERT INTO book_type (typeName, description) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, type.getTypeName());
            ps.setString(2, type.getDescription());
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all book types
    public List<BookTypeDetail> getAllBookTypes() {
        List<BookTypeDetail> list = new ArrayList<>();
        try (Connection conn = DBConnect.getConnection()) {
            String sql = "SELECT * FROM book_type";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookTypeDetail type = new BookTypeDetail();
                type.setId(rs.getInt("id"));
                type.setTypeName(rs.getString("typeName"));
                type.setDescription(rs.getString("description"));
                list.add(type);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get book type by ID
    public BookTypeDetail getBookTypeById(int id) {
        try (Connection conn = DBConnect.getConnection()) {
            String sql = "SELECT * FROM book_type WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                BookTypeDetail type = new BookTypeDetail();
                type.setId(rs.getInt("id"));
                type.setTypeName(rs.getString("typeName"));
                type.setDescription(rs.getString("description"));
                return type;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update book type
    public boolean updateBookType(BookTypeDetail type) {
        try (Connection conn = DBConnect.getConnection()) {
            String sql = "UPDATE book_type SET typeName=?, description=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, type.getTypeName());
            ps.setString(2, type.getDescription());
            ps.setInt(3, type.getId());
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete book type
    public boolean deleteBookType(int id) {
        try (Connection conn = DBConnect.getConnection()) {
            String sql = "DELETE FROM book_type WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
