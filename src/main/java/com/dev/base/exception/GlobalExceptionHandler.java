package com.dev.base.exception;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.NoHandlerFoundException;

@RestControllerAdvice
public class GlobalExceptionHandler {
	
    /* Developer Custom Exception */
    @ExceptionHandler(CustomException.class)
    protected ResponseEntity<Map<String, Object>> handleCustomException(final CustomException e) {
    	Map<String, Object> returnMap = new HashMap<>();
    	returnMap.put("code", e.getCode());
    	returnMap.put("message", e.getMessage());
        return ResponseEntity.ok(returnMap);
    }
    
    /* HTTP 400 Exception */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    protected ResponseEntity<Map<String, Object>> MethodArgumentNotValidException(final MethodArgumentNotValidException e) {
    	e.printStackTrace();
    	Map<String, Object> returnMap = new HashMap<>();
    	returnMap.put("code", ErrorCode.BAD_REQUEST.getStatus().value());
    	returnMap.put("message", ErrorCode.BAD_REQUEST.getMessage());
        return ResponseEntity.ok(returnMap);
    }

    /* HTTP 404 Exception */
    @ExceptionHandler(NoHandlerFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    protected ResponseEntity<Map<String, Object>> NoHandlerFoundException(final NoHandlerFoundException e) {
    	e.printStackTrace();
    	Map<String, Object> returnMap = new HashMap<>();
    	returnMap.put("code", ErrorCode.POSTS_NOT_FOUND.getStatus().value());
    	returnMap.put("message", ErrorCode.POSTS_NOT_FOUND.getMessage());
        return ResponseEntity.ok(returnMap);
    }
    
    /* HTTP 405 Exception */
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    protected ResponseEntity<Map<String, Object>> handleHttpRequestMethodNotSupportedException(final HttpRequestMethodNotSupportedException e) {
    	e.printStackTrace();
    	Map<String, Object> returnMap = new HashMap<>();
    	returnMap.put("code", ErrorCode.METHOD_NOT_ALLOWED.getStatus().value());
    	returnMap.put("message", ErrorCode.METHOD_NOT_ALLOWED.getMessage());
        return ResponseEntity.ok(returnMap);
    }

    /* HTTP 500 Exception */
    @ExceptionHandler(Exception.class)
    protected ResponseEntity<Map<String, Object>> handleException(final Exception e) {
    	e.printStackTrace();
    	Map<String, Object> returnMap = new HashMap<>();
    	returnMap.put("code", ErrorCode.INTERNAL_SERVER_ERROR.getStatus().value());
    	returnMap.put("message", ErrorCode.INTERNAL_SERVER_ERROR.getMessage());
        return ResponseEntity.ok(returnMap);
    }
}