package com.dev.base.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import lombok.Data;

@Configuration
@ConfigurationProperties(prefix="spring.service")
@Data
public class ServiceConfig {
	private String gateway;
	

}

