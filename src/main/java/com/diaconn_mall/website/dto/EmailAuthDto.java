package com.diaconn_mall.website.dto;

import jakarta.validation.constraints.Email;
import lombok.Data;

@Data
public class EmailAuthDto {
    @Email
    private String email;
}


