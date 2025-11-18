package com.diaconn_mall.website.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderDetailDto {
    private Long id;
    private Long orderId;

    @NotNull
    private Long productId;

    @NotNull
    @Positive
    private Long productPrice;

    @NotNull
    @Positive
    private Long productQuantity;

    private Long productTotalPrice;

    //제품 정보
    private String productName;
    private String productImgUrl;
    private String productCategory;
}
