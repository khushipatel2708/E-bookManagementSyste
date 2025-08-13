/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;
import com.detail.CartDetail;
import com.detail.OrderCartList;
import com.detail.OrderListDetail;
import com.detail.ShippingDetail;
import com.javaclass.Email;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author chetan
 */
public class OrderDAO {
    
    private final Connection conn;

    public OrderDAO(Connection conn) {
        this.conn = conn;
    }
    
    public boolean checkShippingAddress(int userId) {
        try {
            String query = "select * from shipping where userId = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setInt(1, userId);
            ResultSet rs = pt.executeQuery();
            if(rs.next()){
                return true;
            }
        } catch(SQLException e){
            e.printStackTrace();
        }
        return false;
    }
    
   public boolean checkBookAvailable(int bookId) {
       try{
            String query = "select * from book where bookId = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setInt(1, bookId);
            ResultSet rs = pt.executeQuery();
            if(rs.next()){
                if(rs.getInt("available")>0){
                    return true;
                }
            } 
        } catch(SQLException e){
            e.printStackTrace();
        }
       return false;
   }
   
  public synchronized String confirmOrder(String email, int userId, String pMethod) {
    try {
        CartDAO cartDAO = new CartDAO(conn);
        List<CartDetail> cartList = cartDAO.getCart(userId);

        if (cartList.isEmpty()) {
            return "no"; // Nothing in cart
        }

        StringBuilder emailBody = new StringBuilder();
        emailBody.append("\nPayment Method - ").append(pMethod);

        int totalPrice = 0;
        int orderId = 0;

        for (CartDetail cd : cartList) {
            if (checkBookAvailable(cd.getBookId())) {
                totalPrice += cd.getPrice();
                emailBody.append("\n\nBook Name - ").append(cd.getBookName());
                emailBody.append("\nQuantity - ").append(cd.getQuantity());
                emailBody.append("\nPrice - ").append(cd.getPrice());
            }
        }

        if (totalPrice == 0) {
            return "no"; // No valid books to order
        }

        int totalOrderPrice = (totalPrice > 699) ? totalPrice : totalPrice + 70;
        emailBody.append("\n\nBooks Price - ").append(totalPrice);
        emailBody.append("\nDelivery Charge - ").append((totalPrice > 699) ? "0" : "70");
        emailBody.append("\nTotal Order Price - ").append(totalOrderPrice);

        // Fetch shipping address
        ShippingDAO shipDAO = new ShippingDAO(conn);
        ShippingDetail shipping = shipDAO.getAddress(userId);
        if (shipping == null) {
            return "no"; // Missing shipping address
        }

        // Insert into orderlist
        String query1 = "INSERT INTO orderlist (userId, price, paymentMethod, name, phone, address1, address2, landmark, city, pincode) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pt1 = conn.prepareStatement(query1);
        pt1.setInt(1, userId);
        pt1.setInt(2, totalOrderPrice);
        pt1.setString(3, pMethod);
        pt1.setString(4, shipping.getName());
        pt1.setString(5, shipping.getPhone());
        pt1.setString(6, shipping.getAddress1());
        pt1.setString(7, shipping.getAddress2());
        pt1.setString(8, shipping.getLandmark());
        pt1.setString(9, shipping.getCity());
        pt1.setString(10, shipping.getPinCode());

        int i = pt1.executeUpdate();
        if (i != 1) {
            return "error";
        }

        // Get latest orderId
        String query2 = "SELECT orderId FROM orderlist WHERE userId = ? ORDER BY orderId DESC LIMIT 1";
        PreparedStatement pt2 = conn.prepareStatement(query2);
        pt2.setInt(1, userId);
        ResultSet rs2 = pt2.executeQuery();
        if (rs2.next()) {
            orderId = rs2.getInt("orderId");
        } else {
            return "error";
        }

        // Insert into ordercart
        String query3 = "INSERT INTO ordercart (orderId, bookName, authorName, quantity, price) VALUES (?, ?, ?, ?, ?)";
        for (CartDetail cd : cartList) {
            if (checkBookAvailable(cd.getBookId())) {
                PreparedStatement pt3 = conn.prepareStatement(query3);
                pt3.setInt(1, orderId);
                pt3.setString(2, cd.getBookName());
                pt3.setString(3, cd.getAuthorName());
                pt3.setInt(4, cd.getQuantity());
                pt3.setInt(5, cd.getPrice());
                pt3.executeUpdate();

                // Remove from cart
                cartDAO.deleteCart(cd.getBookId(), userId);

                // Decrement book stock
                String query5 = "SELECT available FROM book WHERE bookId = ?";
                PreparedStatement pt5 = conn.prepareStatement(query5);
                pt5.setInt(1, cd.getBookId());
                ResultSet rs5 = pt5.executeQuery();
                if (rs5.next()) {
                    int available = rs5.getInt("available") - 1;
                    String query6 = "UPDATE book SET available = ? WHERE bookId = ?";
                    PreparedStatement pt6 = conn.prepareStatement(query6);
                    pt6.setInt(1, available);
                    pt6.setInt(2, cd.getBookId());
                    pt6.executeUpdate();
                }
            }
        }

        // Send confirmation email
        StringBuilder emailFinal = new StringBuilder("Hi,");
        emailFinal.append("\nOrder number - ").append(orderId);
        emailFinal.append(emailBody);
        emailFinal.append("\n\nThanks for ordering!");
        emailFinal.append("\nIf you have any issues, feel free to contact us.");
        emailFinal.append("\n\nThanks!\nBook Store");

        Thread emailThread = new Thread(new Email(email, "Order Confirm", emailFinal.toString()));
        emailThread.start();

        return "done";

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return "error";
}

    public List<OrderListDetail> getOrderList(int userId) {
       List<OrderListDetail> list = new ArrayList<OrderListDetail>();
       OrderListDetail cd;
        try {
            String query1 = "select * from orderlist where userId = ? ORDER BY orderID DESC";
            PreparedStatement pt1 = conn.prepareStatement(query1);
            pt1.setInt(1, userId);
            ResultSet rs1 = pt1.executeQuery();
            while(rs1.next()){
                cd = new OrderListDetail();
                cd.setOrderID(rs1.getInt("orderId"));
                cd.setPaymentMethod(rs1.getString("paymentMethod"));
                cd.setPrice(rs1.getInt("price"));
                cd.setStatus(rs1.getString("status"));
                cd.setDate(rs1.getTimestamp("time").toString());
                list.add(cd);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
       
       return list;
    }
    
    public OrderListDetail getOrderView(int userId, int orderId) {
        OrderListDetail cd = null;
        try {
            String query1 = "select * from orderlist where orderId = ? and userId = ?";
            PreparedStatement pt1 = conn.prepareStatement(query1);
            pt1.setInt(1, orderId);
            pt1.setInt(2, userId);
            ResultSet rs1 = pt1.executeQuery();
            while(rs1.next()){
                cd = new OrderListDetail();
                cd.setOrderID(rs1.getInt("orderId"));
                cd.setPaymentMethod(rs1.getString("paymentMethod"));
                cd.setPrice(rs1.getInt("price"));
                cd.setStatus(rs1.getString("status"));
                cd.setDate(rs1.getTimestamp("time").toString());
                cd.setName(rs1.getString("name"));
                cd.setPhone(rs1.getString("phone"));
                cd.setAddress1(rs1.getString("address1"));
                cd.setAddress2(rs1.getString("address2"));
                cd.setLandmark(rs1.getString("landmark"));
                cd.setCity(rs1.getString("city"));
                cd.setPinCode(rs1.getString("pincode"));
                String query2 = "select * from ordercart where orderId = ?";
                PreparedStatement pt2 = conn.prepareStatement(query2);
                pt2.setInt(1, orderId);
                ResultSet rs2 = pt2.executeQuery();
                List<OrderCartList> list = new ArrayList<OrderCartList>();
                OrderCartList ocl;
                while(rs2.next()) {
                    ocl = new OrderCartList();
                    ocl.setBookName(rs2.getString("bookName"));
                    ocl.setAuthorName(rs2.getString("authorName"));
                    ocl.setPrice(rs2.getInt("price"));
                    ocl.setQuantity(rs2.getInt("quantity"));
                    list.add(ocl);
                }
                cd.setOcl(list);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
       return cd;
   }
    
    
}
