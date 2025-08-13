package com.javaclass;

import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
//import jakarta.servlet.annotation.WebServlet;

import java.util.Properties;
public class EmailSession {

    private static Session session;
    private final static String fromEmail = "bookingonline40@gmail.com"; // ✅ Gmail sender
    private final static String password = "bcidtabltwqbweup"; // ✅ App Password

    public static Session getSession() {
        if (session == null) {
            System.out.println("TLS Email Start");

            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587"); // ✅ TLS port
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true"); // ✅ Enable TLS

            Authenticator auth = new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            };

            session = Session.getInstance(props, auth); // not getDefaultInstance
            session.setDebug(true); // ✅ Print debug info
            System.out.println("Session created");
        }
        return session;
    }
}
