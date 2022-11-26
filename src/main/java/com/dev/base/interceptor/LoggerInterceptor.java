package com.dev.base.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.keycloak.adapters.springsecurity.client.KeycloakClientRequestFactory;
import org.keycloak.adapters.springsecurity.client.KeycloakRestTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.dev.base.config.ServiceConfig;
import com.dev.base.exception.CustomException;
import com.dev.base.model.urlModel;

public class LoggerInterceptor implements HandlerInterceptor {
	
	@Autowired
	ServiceConfig config;
	
	//컨트롤러 가기전에 오는곳입니다~
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

    	/*호출 대상이 존재하는 컨트롤러 오브젝트가 존재할시에 권한 체크실행*/
    	HandlerMethod vMethod = null;
    	
    	try {vMethod = (HandlerMethod)handler;}catch (Exception e) {vMethod = null;}
    	
    	if(vMethod !=null){
    		String menuId = vMethod.getMethod().getDeclaringClass().getSimpleName().replace("Controller", "");
    		String vType = request.getMethod();
    		if(vType.toString().contains("GET")){vType="read";}else{vType="update";}

    		KeycloakClientRequestFactory fack = new KeycloakClientRequestFactory();
    		KeycloakRestTemplate restTemplate = new KeycloakRestTemplate(fack);

    		//페이지 아이디로 등록된 데이터가 존재하지 않을시 (공통같은 경우) 권한체크 안함.
    		ResponseEntity<String> returnChk = restTemplate.exchange(
    				urlModel.baseGate + "/util-service/authGroupChk/{menuId}/{type}" , 
    				HttpMethod.GET, null, String.class, menuId, vType
    		);
    		
    		if(!returnChk.getBody().equals("true")){
    			throw new CustomException("err", "실행권한이 없습니다.");
    		}
    	}

        return HandlerInterceptor.super.preHandle(request, response, handler);
    }

    //컨트롤러 서비스 다 처리하고 view 가기전에 오는 곳입니다.
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }
}