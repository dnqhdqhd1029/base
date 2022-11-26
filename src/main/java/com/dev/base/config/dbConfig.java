package com.dev.base.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import lombok.Data;

@Configuration
@ConfigurationProperties(prefix="spring.datasource")
@Data
public class dbConfig {
	private String url;
	private String driverClassName;
	private String username;
	private String password;
}
