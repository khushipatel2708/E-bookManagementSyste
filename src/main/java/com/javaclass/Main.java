package com.javaclass;

public class Main {
    public static void main(String[] args) {
        String to = "yourreceiver@gmail.com"; // ✅ change this to your email
        String subject = "Test Email";
        String message = "Hello! This is a test email from Java using Jakarta Mail.";

        Thread emailThread = new Thread(new Email(to, subject, message));
        emailThread.start();
    }
}
