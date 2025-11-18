package com.diaconn_mall.website.service;

import lombok.RequiredArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Value;

@Service
@RequiredArgsConstructor
public class EmailService {

	private final JavaMailSender mailSender;

	@Value("${spring.mail.username}")
	private String fromAddress;

	public void sendTemporaryPassword(String toEmail, String temporaryPassword) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(toEmail);
		message.setFrom(fromAddress);
		message.setSubject("[Diaconn Mall] 임시 비밀번호 안내");
		message.setText("안녕하세요.\n요청하신 임시 비밀번호는 다음과 같습니다.\n\n" + temporaryPassword + "\n\n보안을 위해 로그인 후 비밀번호를 즉시 변경해 주세요.");
		mailSender.send(message);
	}

	public void sendEmailAuthCode(String toEmail, String temporaryPassword) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(toEmail);
		message.setFrom(fromAddress);
		message.setSubject("[Diaconn Mall] 회원가입 이메일 인증번호 안내");
		message.setText("안녕하세요.\n회원가입을 위한 인증번호는 다음과 같습니다.\n\n" + temporaryPassword + "\n\n인증번호를 입력하여 인증을 완료 해주세요.");
		mailSender.send(message);
	}
}


