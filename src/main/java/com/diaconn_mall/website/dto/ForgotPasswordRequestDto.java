package com.diaconn_mall.website.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class ForgotPasswordRequestDto {
	@NotBlank
	@Email
	private String email;
	private String phone;
}


