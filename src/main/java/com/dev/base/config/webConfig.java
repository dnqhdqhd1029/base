package com.dev.base.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import com.dev.base.interceptor.LoggerInterceptor;
import com.dev.base.model.urlModel;
import com.dev.base.utils.ExcelDownloadView;

@Configuration
public class webConfig implements WebMvcConfigurer {

	@Autowired 
	ServiceConfig config;
	
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
    	
    	urlModel.baseGate = config.getGateway();
    	
        registry.addInterceptor(new LoggerInterceptor());
    }
}