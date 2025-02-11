package com.example.demo;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSend {
	private static MailSend instance = new MailSend(); // 객체가 instance이름으로 생성
	
	private MailSend(){} // 생성자
	
	public static MailSend getInstance() {
		return instance;
	}
	
	public int setEmail(String email, String subject, String body, String naverPwd) throws Exception {
		String host = "smtp.naver.com";
		
		final String username = "goalki"; // 송신자 네이버 아이디
		final String password = naverPwd; // 송신자 네이버 비밀번호
		int port=465;
		int state=0;
		
		String recipient = email; // 받는 사람 이메일 주소
		//String subject = "안녕하세요"; // 이메일 제목
		//String body = "테스트입니다"; // 이메일 내용
		
		Properties props = System.getProperties();
		
		try {
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.port", port);
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.ssl.enable", "true");
			props.put("mail.smtp.ssl.trust", host);
			
			Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
				String un=username;
				String pw=password;
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(un, pw);
				}
			});
			session.setDebug(true); //for debug
			
			Message mimeMessage = new MimeMessage(session);
			mimeMessage.setFrom(new InternetAddress("goalki@naver.com")); // 송신자 네이버 주소
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
			mimeMessage.setSubject(subject);
			mimeMessage.setText(body);
			Transport.send(mimeMessage);
			state=1;
		}
		catch(Exception e) {
			state=0;
		}
		return state;
	}
}