package kr.co.jk.util;

import java.util.Properties;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class MailSend {
    private static MailSend instance = new MailSend(); // 객체가 instance이름으로 생성

    private MailSend() {} // 생성자

    public static MailSend getInstance() {
        return instance;
    }
    
    public int setEmail(String email, String subject, String body, String googlePwd) throws Exception {
        String host = "smtp.gmail.com";
        final String username = "your-email@gmail.com"; // 송신자 이메일 주소
        final String password = googlePwd; // 송신자 이메일 비밀번호 (환경변수 또는 안전한 저장소에서 가져와야 함)
        int port = 587; // STARTTLS 포트

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // STARTTLS 사용
        props.put("mail.smtp.ssl.trust", host); // SSL 신뢰 호스트 설정

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        session.setDebug(true); // 디버깅 모드 활성화

        try {
            Message mimeMessage = new MimeMessage(session);
            mimeMessage.setFrom(new InternetAddress(username)); // 송신자 이메일 주소
            mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(email)); // 받는 사람 이메일 주소
            mimeMessage.setSubject(subject);
            mimeMessage.setText(body);
            Transport.send(mimeMessage);
            return 1; // 성공
        } catch (Exception e) {
            e.printStackTrace(); // 예외 로그 출력
            return 0; // 실패
        }
    }
}
