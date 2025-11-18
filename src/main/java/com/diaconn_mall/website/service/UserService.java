package com.diaconn_mall.website.service;

import com.diaconn_mall.website.dto.*;
import com.diaconn_mall.website.entity.User;
import com.diaconn_mall.website.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import jakarta.servlet.http.HttpSession;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.time.Duration;
import java.nio.charset.StandardCharsets;
import org.springframework.security.crypto.password.PasswordEncoder;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Map;
import java.util.Objects;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.AddressException;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final EmailService emailService;

    private static final String TEMP_PASSWORD_CHARS = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789";
    private static final int TEMP_PASSWORD_LENGTH = 10;
    private static final SecureRandom SECURE_RANDOM = new SecureRandom();
    private static final Duration EMAIL_CODE_TTL = Duration.ofMinutes(3);
    private static final int EMAIL_CODE_MAX_ATTEMPTS = 5;

    private final Map<String, EmailVerificationToken> emailToVerificationToken = new ConcurrentHashMap<>();

    private static class EmailVerificationToken {
        private final String codeHash;
        private final LocalDateTime expiresAt;
        private int attempts;
        private boolean used;

        private EmailVerificationToken(String codeHash, LocalDateTime expiresAt) {
            this.codeHash = codeHash;
            this.expiresAt = expiresAt;
            this.attempts = 0;
            this.used = false;
        }
    }

    // 회원가입 시 이메일 중복검사
    public boolean isEmailDuplicate(String email) {
        if (email == null || email.trim().isEmpty()) return false; // 이메일이 null이거나 비었으면 중복이 아닌 것으로 처리
        return userRepository.existsByEmail(email.trim().toLowerCase());
    }

    // 회원가입 시 이메일 인증
    @Transactional
    public void requestAuthEmail(EmailAuthDto request) {
        String email = normalizeEmail(request.getEmail());
        try {
            InternetAddress internetAddress = new InternetAddress(email);
            internetAddress.validate();
        } catch (AddressException ex) {
            throw new IllegalArgumentException("잘못된 이메일 형식입니다.");
        }
        String code = generateTemporaryPassword();

        // 토큰 저장
        String codeHash = passwordEncoder.encode(code);
        EmailVerificationToken token = new EmailVerificationToken(
                codeHash,
                LocalDateTime.now().plus(EMAIL_CODE_TTL)
        );
        emailToVerificationToken.put(email, token);

        // 이메일로 인증코드 전송
        emailService.sendEmailAuthCode(email, code);
    }

    @Transactional
    public void verifyEmailCode(EmailVerifyDto request) {
        String email = normalizeEmail(request.getEmail());
        String inputCode = Objects.requireNonNull(request.getCode(), "인증번호는 공백일 수 없습니다.");

        EmailVerificationToken token = emailToVerificationToken.get(email);
        if (token == null) {
            throw new IllegalArgumentException("인증번호가 요청되지 않았습니다. 다시 요청해 주세요.");
        }
        if (token.used) {
            throw new IllegalStateException("이미 인증이 완료되었습니다.");
        }
        if (LocalDateTime.now().isAfter(token.expiresAt)) {
            emailToVerificationToken.remove(email);
            throw new IllegalArgumentException("인증번호가 만료되었습니다. 다시 요청해 주세요.");
        }
        if (token.attempts >= EMAIL_CODE_MAX_ATTEMPTS) {
            emailToVerificationToken.remove(email);
            throw new IllegalArgumentException("인증 시도 횟수를 초과했습니다. 다시 요청해 주세요.");
        }

        boolean matches = passwordEncoder.matches(inputCode, token.codeHash);
        if (!matches) {
            token.attempts++;
            throw new IllegalArgumentException("인증번호가 일치하지 않습니다.");
        }

        token.used = true; // 단일 사용 처리
    }

    private String normalizeEmail(String email) {
        return email == null ? null : email.trim().toLowerCase();
    }

    // 임시 비밀번호 생성
    private String generateTemporaryPassword() {
        StringBuilder result = new StringBuilder(TEMP_PASSWORD_LENGTH);
        for (int i = 0; i < TEMP_PASSWORD_LENGTH; i++) {
            int index = SECURE_RANDOM.nextInt(TEMP_PASSWORD_CHARS.length());
            result.append(TEMP_PASSWORD_CHARS.charAt(index));
        }
        return result.toString();
    }

    // 회원가입
    public void registerUser(UserDto userDto) {
        if (userRepository.existsByEmail(userDto.getEmail())) {
            throw new IllegalArgumentException("이미 사용 중인 이메일입니다.");
        }
        // 내부 보안 가드: BCrypt 한계 보호(사용자 메시지는 일반화)
        if (userDto.getPassword().getBytes(StandardCharsets.UTF_8).length > 72) {
            throw new IllegalArgumentException("비밀번호 형식이 올바르지 않습니다. 다른 비밀번호를 사용해 주세요.");
        }
        User user = new User();
        user.setName(userDto.getName());
        user.setEmail(userDto.getEmail());
        user.setPhone(userDto.getPhone());
        user.setPassword(passwordEncoder.encode(userDto.getPassword()));
        user.setAddress(userDto.getAddress());
        userRepository.save(user);
    }

    // 마이페이지 수정
    @Transactional
    public void updateUser(UpdateUserRequest request, HttpSession session) {
        User existingUser = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다."));
        existingUser.setPhone(request.getPhone());
        if (request.getPassword() != null && !request.getPassword().isBlank()) {
            if (request.getPassword().getBytes(StandardCharsets.UTF_8).length > 72) {
                throw new IllegalArgumentException("비밀번호 형식이 올바르지 않습니다. 다른 비밀번호를 사용해 주세요.");
            }
            existingUser.setPassword(passwordEncoder.encode(request.getPassword()));
        }

        // 주소가 빈 문자열이면 null 처리
        if (request.getAddress() == null || request.getAddress().trim().isEmpty()) {
            existingUser.setAddress(null);
            existingUser.setAddressDetail(null);
        } else {
            existingUser.setAddress(request.getAddress());
            existingUser.setAddressDetail(request.getAddressDetail());
        }

        // DB 저장
        existingUser.setUpdatedAt(LocalDateTime.now());
        userRepository.save(existingUser);

        // 세션 유저 정보 업데이트
        LoginUserDto updatedSessionUser = new LoginUserDto(existingUser); // DTO로 변환
        session.setAttribute("user", updatedSessionUser);
    }
}
