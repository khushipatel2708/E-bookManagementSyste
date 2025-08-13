package com.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {

    private static Connection conn;

    public static Connection getConnection() {
        try {
            if (conn == null || conn.isClosed()) {
                // Load MySQL JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Connect to MySQL DB
                conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/bookmanagementsystem?useSSL=false&serverTimezone=UTC",
                    "root",            // Your MySQL username
                    "Asdfg@12#"       // Your MySQL password
                );
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return conn;
    }
}

//oracle connections

//package com.database;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.SQLException;
//
//public class DBConnect {
//
//    private static Connection conn;
//
//    public static Connection getConnection() {
//        try {
//            if (conn == null) {
//                Class.forName("oracle.jdbc.driver.OracleDriver");
//                conn = DriverManager.getConnection(
//                    "jdbc:oracle:thin:@//localhost:1521/XE",
//                    "system", // your Oracle DB username
//                    "12345" // your password
//                );
//            }
//        } catch (ClassNotFoundException | SQLException e) {
//            e.printStackTrace();
//        }
//
//        return conn;
//    }
//}
