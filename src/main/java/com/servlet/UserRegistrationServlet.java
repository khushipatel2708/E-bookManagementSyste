///*
// * To change this license header, choose License Headers in Project Properties.
// * To change this template file, choose Tools | Templates
// * and open the template in the editor.
// */
//package com.servlet;
//
//import com.dao.UserDAO;
//import java.io.IOException;
//import java.io.PrintWriter;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
///**
// *
// * @author chetan
// */
//@WebServlet("/registerForm") 
//public class UserRegistrationServlet extends HttpServlet {
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
//
//        String name = request.getParameter("rName").trim();
//        String email = request.getParameter("rEmail").trim();
//        String password = request.getParameter("rPassword").trim();
//
//        UserDAO dao = new UserDAO();
//        String done = dao.userRegistration(name, email, password);
//
//        if ("done".equals(done)) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
//
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            out.println("Registration failed or already exists.");
//        }
//    }
//
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
//     @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "User Registration Servlet";
//    }
//}



package com.servlet;

import com.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/registerForm")
public class UserRegistrationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String fullName = request.getParameter("rFullName").trim();
    String username = request.getParameter("rName").trim();
    String phone = request.getParameter("rPhone").trim();
    String email = request.getParameter("rEmail").trim();
    String password = request.getParameter("rPassword").trim();
    String confirmPassword = request.getParameter("rConfirmPassword").trim();

    if (!password.equals(confirmPassword)) {
        request.setAttribute("errorMsg", "Passwords do not match.");
        RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
        rd.forward(request, response);
        return;
    }

    UserDAO dao = new UserDAO();
    String result = dao.userRegistration(fullName, username, phone, email, password);

    if ("done".equals(result)) {
        response.sendRedirect("login.jsp");
    } else {
        request.setAttribute("errorMsg", "Registration failed. User already exists or invalid input.");
        RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
        rd.forward(request, response);
    }
}


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "User Registration Servlet";
    }
}
