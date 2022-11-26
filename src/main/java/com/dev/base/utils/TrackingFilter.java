package com.dev.base.utils;

import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.json.JSONObject;
import org.keycloak.adapters.springsecurity.client.KeycloakClientRequestFactory;
import org.keycloak.adapters.springsecurity.client.KeycloakRestTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.dev.base.model.urlModel;

@Order(1)
@Component
public class TrackingFilter {


	@Autowired
	FilterUtils filterUtils;

	public String getAuthenticationName(String vToken, String colname){
		String authenticationName = "";
		if (vToken!=null){
			String authToken = vToken.replace("Bearer ","");
	        JSONObject jsonObj = decodeJWT(authToken);
	        authenticationName = jsonObj.getString(colname);
		}
		return authenticationName;
	}

	public JSONObject decodeJWT(String JWTToken) {
		String[] split_string = JWTToken.split("\\.");
		String base64EncodedBody = split_string[1];
		Base64 base64Url = new Base64(true);
		String body = new String(base64Url.decode(base64EncodedBody));
		JSONObject jsonObj = new JSONObject(body);
		
		return jsonObj;
	}
	
	public Map<String, Object> fnUsercontext () throws JsonMappingException, JsonProcessingException {
		
		KeycloakClientRequestFactory fack = new KeycloakClientRequestFactory();
		KeycloakRestTemplate restTemplate = new KeycloakRestTemplate(fack);	    
		//페이지 아이디로 등록된 데이터가 존재하지 않을시 (공통같은 경우) 권한체크 안함.
		ResponseEntity<String> returnChk = restTemplate.exchange(
				urlModel.baseGate + "/util-service/getToken/{main}" , 
				HttpMethod.GET, null, String.class, "main"
		);
		
		@SuppressWarnings("unchecked")
		Map<String, Object> returnMap = new ObjectMapper().readValue(decodeJWT(returnChk.getBody().toString()).toString(), Map.class); 
		
		return returnMap;
	}
}