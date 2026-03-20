package com.shop.db;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class SendMail {
    public static void send(String emailID, String subj, String messageText) throws Exception {
        final String host = "smtp.gmail.com";
        final String user = "projectmy220@gmail.com"; 
        final String pass = "ywue skfj hrdo nudi"; //  Google App Password use karein (actual password nahi)

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");  // TLS ke liye 587, SSL ke liye 465
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // TLS enable karein

        // Creating Session
        Session mailSession = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, pass);
            }
        });

        try {
            // Creating Email Message
            Message msg = new MimeMessage(mailSession);
            msg.setFrom(new InternetAddress(user));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailID));
            msg.setSubject(subj);
            msg.setContent(messageText, "text/html");

            // Sending Email
            Transport.send(msg);
            System.out.println("Email Sent Successfully!");
        } catch (MessagingException e) {
            e.printStackTrace(); //  Console pe full error show karega
        }
    }
}
