 ///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package com.servlet;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
///**
// *
// * @author 91931
// */
//@WebServlet(name = "PayUServlet", urlPatterns = {"/PayUServlet"})
//public class PayUServlet extends HttpServlet {
//
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet PayUServlet</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet PayUServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}

package com.servlet;

import java.io.*;
import java.math.BigInteger;
import java.security.MessageDigest;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/PayUServlet")
public class PayUServlet extends HttpServlet {

    private static final String MERCHANT_KEY = "BIyoWM";
    private static final String SALT = "dj7zlIsUAs9YjjlJ8HCX3bVF6V4KtS9F";
    private static final String PAYU_BASE_URL = "https://test.payu.in/_payment";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String txnid = "TXN" + System.currentTimeMillis();
        String amount = request.getParameter("amount");
        String firstname = request.getParameter("firstname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String productinfo = "Online Payment";

        String hashString = MERCHANT_KEY + "|" + txnid + "|" + amount + "|" + productinfo + "|" + firstname + "|" + email + "|||||||||||" + SALT;
        String hash = generateHash(hashString);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html><body onload='document.forms[\"payuForm\"].submit()'>");
        out.println("<form action='" + PAYU_BASE_URL + "' method='post' name='payuForm'>");
        out.println("<input type='hidden' name='key' value='" + MERCHANT_KEY + "'>");
        out.println("<input type='hidden' name='txnid' value='" + txnid + "'>");
        out.println("<input type='hidden' name='amount' value='" + amount + "'>");
        out.println("<input type='hidden' name='productinfo' value='" + productinfo + "'>");
        out.println("<input type='hidden' name='firstname' value='" + firstname + "'>");
        out.println("<input type='hidden' name='email' value='" + email + "'>");
        out.println("<input type='hidden' name='phone' value='" + phone + "'>");
        out.println("<input type='hidden' name='surl' value='http://localhost:8080/E-bookManagementSyste/success.jsp'>");
        out.println("<input type='hidden' name='furl' value='http://localhost:8080/E-bookManagementSyste/failure.jsp'>");

        out.println("<input type='hidden' name='hash' value='" + hash + "'>");
        out.println("</form>");
        out.println("</body></html>");
    }

    private String generateHash(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            byte[] messageDigest = md.digest(input.getBytes());
            BigInteger no = new BigInteger(1, messageDigest);
            String hashtext = no.toString(16);
            while (hashtext.length() < 128) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
