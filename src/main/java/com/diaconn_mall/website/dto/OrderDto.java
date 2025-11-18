package com.diaconn_mall.website.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
public class OrderDto {
    private Long id;

    @NotNull
    @Positive
    private Long totalPrice;

    private LocalDateTime regDate;
    private String address;
    private String addressDetail;
    private String phone;
    private String name;

    private Long userId;
    private String memo;

    @NotEmpty
    @Valid
    private List<OrderDetailDto> orderDetails;
}
