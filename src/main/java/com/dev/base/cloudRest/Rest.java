package com.dev.base.cloudRest;

import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;
import org.keycloak.adapters.springsecurity.client.KeycloakRestTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import com.dev.base.config.ServiceConfig;
import com.dev.base.exception.ErrorCode;
import com.dev.base.utils.CommonUtils;
import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class Rest {

	@Autowired
	private KeycloakRestTemplate restTemplate;

	@Autowired
	ServiceConfig config;

	// Json-Simple 라이브러리 객체선언
	JSONObject jsonObject = new JSONObject();

	public Object service(String serviceUrl, Map<String, Object> map) {

		ResponseEntity<?> restExchange = null;

		Map<String, Object> sendMap = new HashMap<>();

		if (map != null) {
			sendMap = map;
		}

		// create headers
		HttpHeaders headers = new HttpHeaders();

		// example of custom header
		headers.set("X-Request-Source", "Desktop");
		// 헤더에 콘텐츠타입 추가
		headers.setContentType(MediaType.APPLICATION_JSON);

		// 들어온 데이터 반복문 돌려서 JSON으로 변환
		for (Map.Entry<String, Object> entry : sendMap.entrySet()) {
			String key = entry.getKey();
			Object value = entry.getValue();
			jsonObject.put(key, value);
		}
		restExchange = restTemplate.exchange(config.getGateway() + "/" + serviceUrl, HttpMethod.POST,
				new HttpEntity<>(jsonObject.toString(), headers), Object.class);

		Object returnObj = new Object();

		// code, message 오류코드 메세지 재정의.
		if (restExchange.getBody() instanceof Map) {
			ObjectMapper objMapper = new ObjectMapper();
			@SuppressWarnings("unchecked")
			Map<String, Object> objMap = objMapper.convertValue(restExchange.getBody(), Map.class);
			if (!CommonUtils.isEmpty(objMap.get("message")) && !CommonUtils.isEmpty(objMap.get("code"))
					&& !objMap.get("code").toString().equals("ok")) {
				String vMsg = objMap.get("message").toString();
				objMap.put("message", errMessage(vMsg));
			}
			returnObj = objMap;
		} else {
			returnObj = restExchange.getBody();
		}

		return returnObj;
	}

	public String errMessage(String vMsg) {

		if (vMsg.contains("PRIMARY KEY 제약 조건")) {
			vMsg = "중복된 데이터가 존재합니다.(PK위반) " + vMsg.substring(vMsg.indexOf("중복 키 값은 ("), vMsg.length());
		} else if (vMsg.contains("열에는 NULL을 사용할 수 없습니다. INSERT이(가) 실패했습니다.")) {
			vMsg = "NULL 데이터를 허용하지 않습니다.";
		} else if (vMsg.contains("UNIQUE KEY 제약 조건")) {
			vMsg = "중복된 데이터가 존재합니다.(UNIQUE)\n" + vMsg.substring(vMsg.indexOf("중복 키 값은 ("), vMsg.length());
		} else {
			vMsg = ErrorCode.INTERNAL_SERVER_ERROR.getMessage();
		}

		return vMsg;
	}
}