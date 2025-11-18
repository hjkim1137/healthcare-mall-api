package com.diaconn_mall.website.controller;

import com.diaconn_mall.website.dto.EmailAuthDto;
import com.diaconn_mall.website.dto.EmailVerifyDto;
import com.diaconn_mall.website.dto.UserDto;
import com.diaconn_mall.website.dto.UpdateUserRequest;
import com.diaconn_mall.website.service.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @GetMapping("/checkemail")
    public ResponseEntity<Map<String, Object>> checkEmail(@RequestParam String email) {
        System.out.println("@@@이메일 중복검사 요청 도착: "+  email);
        boolean isDuplicate = userService.isEmailDuplicate(email);
        return ResponseEntity.ok(Map.of(
                "isDuplicate", isDuplicate,
                "message", isDuplicate ? "이미 사용중인 이메일입니다." : "사용 가능한 이메일입니다."
        ));
    }

    // 회원가입 이메일 인증코드 발송
    @PostMapping(value = "/auth-email/request", produces = "application/json")
    public ResponseEntity<Map<String, String>> requestEmailCode(@Valid @RequestBody EmailAuthDto email) {
        try {
            userService.requestAuthEmail(email);
            System.out.println("@@@@회원가입 이메일 인증코드 발송 요청 도착: " + email);
            return ResponseEntity.ok(Map.of("message", "인증번호가 이메일로 전송되었습니다."));
        } catch (IllegalArgumentException | IllegalStateException ex) {
            return ResponseEntity.badRequest().body(Map.of("message", ex.getMessage()));
        } catch (Exception e) {
            log.error("회원가입 이메일 인증 중 오류 발생", e);
            return ResponseEntity.status(500).body(Map.of("message", "회원가입 이메일 인증 중 오류가 발생했습니다."));
        }
    }

    // 회원가입 이메일 인증코드 검증
    @PostMapping(value = "/auth-email/verify", produces = "application/json")
    public ResponseEntity<Map<String, String>> verifyEmailCode(@Valid @RequestBody EmailVerifyDto request) {
        try {
            userService.verifyEmailCode(request);
            return ResponseEntity.ok(Map.of("message", "이메일 인증이 완료되었습니다."));
        } catch (IllegalArgumentException ex) {
            return ResponseEntity.badRequest().body(Map.of("message", ex.getMessage()));
        } catch (Exception e) {
            log.error("회원가입 이메일 인증 검증 중 오류 발생", e);
            return ResponseEntity.status(500).body(Map.of("message", "이메일 인증 검증 중 오류가 발생했습니다. 다시 시도해주세요."));
        }
    }

    @PostMapping(value = "/register", produces = "application/json")
    public ResponseEntity<Map<String, String>> registerUser(@Valid @RequestBody UserDto userDto) {
        try {
            System.out.println("@@@@회원가입 요청 도착: " + userDto);
            userService.registerUser(userDto);
            return ResponseEntity.ok(Map.of("message", "회원가입이 완료되었습니다."));
        } catch (Exception e) {
            log.error("회원가입 중 오류 발생", e);
            return ResponseEntity.status(500).body(Map.of("message", "회원가입 중 오류가 발생했습니다."));
        }
    }

    @PutMapping(value = "/update", produces = "application/json")
    public ResponseEntity<Map<String, String>> updateUser(@Valid @RequestBody UpdateUserRequest request, HttpSession session) {
        try {
            System.out.println("@@@@마이페이지 수정 요청 도착: " + request);
            userService.updateUser(request, session); // 세션도 함께 업데이트
            return ResponseEntity.ok(Map.of("message", "회원정보 수정이 완료되었습니다."));
        } catch (Exception e) {
            log.error("마이페이지 수정중 오류 발생", e);
            return ResponseEntity.status(500).body(Map.of("message", "회원정보 수정중 오류가 발생했습니다."));
        }
    }
}