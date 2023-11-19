package com.paradisiac.members.service;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;

import org.json.HTTP;

public class MailService {
	public void sendMail(String to, String subject, String messageText,HttpServletResponse res) throws IOException {
		final String myGmail = "cha103g2@gmail.com"; 
		final String myGmailPassword = "nwrovcqusngjdcru"; 

		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

		javax.mail.Session session = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(myGmail, myGmailPassword);
			}
		});
		try {
			res.setContentType("application/json;charset=UTF-8");
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(myGmail));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
			message.setSubject(subject);
			message.setText(messageText);

			// 設定信中的主旨
			message.setSubject(subject);
			// 設定信中的內容
			message.setText(messageText);
			Transport.send(message);
			System.out.println("Email sent successfully!");		
			res.getWriter().write("{\"message\":\"寄信成功\"}");
			
		} catch (MessagingException e) {
			System.out.println("Email sending failed!");
			res.getWriter().write("{\"error\":\"寄信失敗\"}");
			e.printStackTrace();
		
		
		}
		
		
	}
}
