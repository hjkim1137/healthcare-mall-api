package com.diaconn_mall.website.controller;

import com.diaconn_mall.website.dto.LoginUserDto;
import com.diaconn_mall.website.dto.OrderDto;
import com.diaconn_mall.website.dto.OrderSummaryDto;
import com.diaconn_mall.website.service.OrderService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/mypage")
@RequiredArgsConstructor
public class MyPageController {

    private final OrderService orderService;

    /*
     * 마이페이지 홈 - 사용자 요약 정보
     */
    @GetMapping
    public ResponseEntity<?> getMyPageHome(HttpSession session) {
        // 로그인 여부 확인
        LoginUserDto loginUser = (LoginUserDto) session.getAttribute("user");
        if (loginUser == null) {
            return ResponseEntity.status(401).body("로그인이 필요합니다.");
        }

        // 마이페이지 홈에 표시할 요약 정보 반환
        return ResponseEntity.ok(loginUser);
    }

    /*
     * 주문 목록 조회 (요약 정보)
     */
    @GetMapping("/orders")
    public ResponseEntity<?> getMyOrders(HttpSession session) {
        System.out.println("@@@ 마이페이지 주문 목록 조회 요청 도착");

        // 로그인 여부 확인
        LoginUserDto loginUser = (LoginUserDto) session.getAttribute("user");
        if (loginUser == null) {
            return ResponseEntity.status(401).body("로그인이 필요합니다.");
        }

        // 사용자별 주문 목록 조회 (요약 정보)
        List<OrderSummaryDto> orderHistory = orderService.getOrderHistory(loginUser.getId());
        return ResponseEntity.ok(orderHistory);
    }

    /*
     * 주문 상세 조회
     */
    @GetMapping("/orders/{orderId}")
    public ResponseEntity<?> getOrderDetail(@PathVariable Long orderId, HttpSession session) {
        System.out.println("@@@ 마이페이지 주문 상세 조회 요청 도착: orderId=" + orderId);

        // 로그인 여부 확인
        LoginUserDto loginUser = (LoginUserDto) session.getAttribute("user");
        if (loginUser == null) {
            return ResponseEntity.status(401).body("로그인이 필요합니다.");
        }

        try {
            // 주문 상세 조회 (본인 주문만 조회 가능)
            OrderDto orderDetail = orderService.getOrderDetail(orderId, loginUser.getId());
            return ResponseEntity.ok(orderDetail);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(e.getMessage());
        }
    }

    /*
     * 회원 정보 조회
     */
    @GetMapping("/profile")
    public ResponseEntity<?> getProfile(HttpSession session) {
        // 로그인 여부 확인
        LoginUserDto loginUser = (LoginUserDto) session.getAttribute("user");
        if (loginUser == null) {
            return ResponseEntity.status(401).body("로그인이 필요합니다.");
        }

        return ResponseEntity.ok(loginUser);
    }
}
