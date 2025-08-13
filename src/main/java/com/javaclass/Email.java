package com.javaclass;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.io.UnsupportedEncodingException;
import java.util.Date;

public class Email implements Runnable {

    private final String toEmail;
    private final String body;
    private final String subject;

    public Email(String toEmail, String subject, String body) {
        this.toEmail = toEmail;
        this.subject = subject;
        this.body = body;
    }

    @Override
    public void run() {
        Session session = EmailSession.getSession();
        try {
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress("bookingonline40@gmail.com", "Book Store"));
            msg.setReplyTo(InternetAddress.parse("bookingonline40@gmail.com", false));
            msg.setSubject(subject, "UTF-8");
            msg.setText(body, "UTF-8");
            msg.setSentDate(new Date());
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));

            Transport.send(msg);
            System.out.println("Email Sent Successfully!");
        } catch (UnsupportedEncodingException | MessagingException e) {
            System.out.println("Failed to send email:");
            e.printStackTrace();
        }
    }
}
