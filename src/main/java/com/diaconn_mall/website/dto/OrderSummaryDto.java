package com.diaconn_mall.website.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * 주문 목록 조회용 DTO (요약 정보)
 */
@Getter
@Setter
public class OrderSummaryDto {
    private Long id;
    private Long totalPrice;
    private LocalDateTime regDate;
    private String address;
    private String addressDetail;
    private String name;

    // 대표 상품 정보
    private String firstProductName;
    private String firstProductImgUrl;
    private Integer totalProductCount; // 전체 상품 개수
}
