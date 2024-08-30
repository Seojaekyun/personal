package kr.co.pension.util;

import java.util.Properties;

import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class MailSend 
{
	private static MailSend instance = new MailSend(); // 객체가 instance이름으로 생성

	   private MailSend(){} // 생성자

	   public static MailSend getInstance()
	   {
	     return instance;
	   }
	   
	public int setEmail(String email, String subject, String body, String googlePwd) throws Exception 
	{
	     String host = "smtp.gmail.com"; 
	     final String username = "alclstnp22"; // 송신자 네이버 아이디
	     final String password = "wcwkkrfgmfzmavdq"; // 송신자 네이버 비밀번호 wcwkkrfgmfzmavdq
	     int port=465;
	     int state=0;

	     String recipient = "alclstnp2@naver.com"; // 받는 사람 이메일 주소
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
	     mimeMessage.setFrom(new InternetAddress("alclstnp22@gmail.com")); // 송신자 네이버 주소
	     mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
	     mimeMessage.setSubject(subject);
	     mimeMessage.setText(body);
	     Transport.send(mimeMessage);
	     state=1;
	     }catch(Exception e){
	      state=0;
	     }
	     return state;
	   }
}
