package com.dev.base.exception;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CustomException extends RuntimeException {
	private static final long serialVersionUID = -7760381976584086238L;
	private final String code;
	private final String message;
}