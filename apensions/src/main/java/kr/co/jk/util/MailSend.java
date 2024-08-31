package kr.co.jk.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.internet.MimeMessage;

@Service
public class MailSend {

    private final JavaMailSender mailSender;

    @Autowired
    public MailSend(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public int sendEmail(String recipient, String subject, String body) {
        int state = 0;

        try {
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            helper.setFrom("your-email@gmail.com"); // 자신의 이메일로 변경
            helper.setTo(recipient);
            helper.setSubject(subject);
            helper.setText(body, true); // true로 설정하면 HTML 콘텐츠를 사용할 수 있음

            mailSender.send(mimeMessage);
            state = 1; // 이메일 발송 성공 시 상태를 1로 설정
        } catch (Exception e) {
            e.printStackTrace(); // 실제 환경에서는 적절한 로깅으로 대체
            state = 0; // 이메일 발송 실패 시 상태를 0으로 설정
        }
        return state;
    }
}
