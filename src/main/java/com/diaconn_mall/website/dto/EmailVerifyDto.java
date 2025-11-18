package com.diaconn_mall.website.dto;

import jakarta.validation.constraints.Email;
import lombok.Data;

@Data
public class EmailVerifyDto {
    @Email
    private String email;
    private String code;
}


