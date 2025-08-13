/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.detail.BookDetail;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.LinkedHashMap;

/**
 *
 * @author chetan
 */
public class UserBookDAO {

    private final Connection conn;

    public UserBookDAO(Connection conn) {
        this.conn = conn;
    }

    public List<BookDetail> newBook() {
        List<BookDetail> list = new ArrayList<BookDetail>();
        BookDetail bd;
        try {
            String query = "SELECT * FROM book WHERE bookCategory = 'new' ORDER BY bookId DESC LIMIT 8";
            PreparedStatement pt = conn.prepareStatement(query);
            ResultSet rs = pt.executeQuery();
            while (rs.next()) {
                bd = new BookDetail();
                bd.setId(rs.getInt("bookId"));
                bd.setAuthorName(rs.getString("authorName"));
                bd.setAvailable(rs.getInt("available"));
                bd.setBookCategory(rs.getString("bookCategory"));
                bd.setBookName(rs.getString("bookName"));
                bd.setPhoto(rs.getString("photo"));
                bd.setPrice(rs.getInt("price"));
                list.add(bd);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<BookDetail> oldBook() {
        List<BookDetail> list = new ArrayList<BookDetail>();
        BookDetail bd;
        try {
            String query = "SELECT * FROM book WHERE bookCategory = 'old' ORDER BY bookId DESC LIMIT 4";
            PreparedStatement pt = conn.prepareStatement(query);
            ResultSet rs = pt.executeQuery();
            while (rs.next()) {
                bd = new BookDetail();
                bd.setId(rs.getInt("bookId"));
                bd.setAuthorName(rs.getString("authorName"));
                bd.setAvailable(rs.getInt("available"));
                bd.setBookCategory(rs.getString("bookCategory"));
                bd.setBookName(rs.getString("bookName"));
                bd.setPhoto(rs.getString("photo"));
                bd.setPrice(rs.getInt("price"));
                list.add(bd);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countNewBook() {
        int pageNo = 1;
        try {
            String query = "SELECT count(*) AS total FROM book WHERE bookCategory = 'new'";
            PreparedStatement pt = conn.prepareStatement(query);
            ResultSet rs = pt.executeQuery();
            if (rs.next()) {
                pageNo = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pageNo;
    }

    public int countOldBook() {
        int pageNo = 1;
        try {
            String query = "SELECT count(*) AS total FROM book WHERE bookCategory = 'old'";
            PreparedStatement pt = conn.prepareStatement(query);
            ResultSet rs = pt.executeQuery();
            if (rs.next()) {
                pageNo = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pageNo;
    }

    public List<BookDetail> newBookByPageNo(int pageNo) {
        List<BookDetail> list = new ArrayList<BookDetail>();
        BookDetail bd;
        try {
            String query = "SELECT * FROM book WHERE bookCategory = 'new' LIMIT 20 OFFSET " + ((pageNo - 1) * 20);
            PreparedStatement pt = conn.prepareStatement(query);
            ResultSet rs = pt.executeQuery();
            while (rs.next()) {
                bd = new BookDetail();
                bd.setId(rs.getInt("bookId"));
                bd.setAuthorName(rs.getString("authorName"));
                bd.setAvailable(rs.getInt("available"));
                bd.setBookCategory(rs.getString("bookCategory"));
                bd.setBookName(rs.getString("bookName"));
                bd.setPhoto(rs.getString("photo"));
                bd.setPrice(rs.getInt("price"));
                list.add(bd);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<BookDetail> oldBookByPageNo(int pageNo) {
        List<BookDetail> list = new ArrayList<BookDetail>();
        BookDetail bd;
        try {
            String query = "SELECT * FROM book WHERE bookCategory = 'old' LIMIT 20 OFFSET " + ((pageNo - 1) * 20);
            PreparedStatement pt = conn.prepareStatement(query);
            ResultSet rs = pt.executeQuery();
            while (rs.next()) {
                bd = new BookDetail();
                bd.setId(rs.getInt("bookId"));
                bd.setAuthorName(rs.getString("authorName"));
                bd.setAvailable(rs.getInt("available"));
                bd.setBookCategory(rs.getString("bookCategory"));
                bd.setBookName(rs.getString("bookName"));
                bd.setPhoto(rs.getString("photo"));
                bd.setPrice(rs.getInt("price"));
                list.add(bd);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<BookDetail> getAllBooks() {
        List<BookDetail> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM book";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookDetail b = new BookDetail();
                b.setId(rs.getInt("bookId"));
                b.setBookName(rs.getString("bookName"));    
                b.setAuthorName(rs.getString("authorName"));
                b.setPrice(rs.getInt("price"));
                b.setBookCategory(rs.getString("bookCategory"));
                b.setAvailable(rs.getInt("available"));
                b.setPhoto(rs.getString("photo"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
// In UserBookDAO.java

  public Map<String, List<BookDetail>> getBooksGroupedByCategory() throws SQLException {
    Map<String, List<BookDetail>> map = new LinkedHashMap<>();

    String sql = "SELECT b.bookId, b.bookName, b.authorName, b.price, b.photo, " +
                 "b.available, bt.typeName " +
                 "FROM book b " +
                 "JOIN book_type bt ON b.bookCategory = bt.id " +
                 "ORDER BY bt.typeName, b.bookName";

    try (PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            String categoryName = rs.getString("typeName"); // typeName instead of ID

            BookDetail book = new BookDetail();
            book.setId(rs.getInt("bookId"));
            book.setBookName(rs.getString("bookName"));
            book.setAuthorName(rs.getString("authorName"));
            book.setPrice(rs.getInt("price"));
            book.setPhoto(rs.getString("photo"));
            book.setBookCategory(categoryName); // store category name here
            book.setAvailable(rs.getInt("available"));

            map.computeIfAbsent(categoryName, k -> new ArrayList<>()).add(book);
        }
    }
    return map;
}

}
