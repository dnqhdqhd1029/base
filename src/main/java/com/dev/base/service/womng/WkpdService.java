package com.dev.base.service.womng;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import com.dev.base.cloudRest.Rest;

@Service
public class WkpdService {
	
	@Autowired
	Rest rest;
	
	public Map<String,Object> wkpdList(@RequestBody Map<String,Object> map){
		Object result = rest.service("womng-service/wkpd/list", map);
		Map<String,Object> resultMap = new HashMap<>();
		resultMap.put("result",result);
		return resultMap;
	}
	
	public Map<String,Object> wkpdUpdate(@RequestBody Map<String,Object> map){
		Object result = rest.service("womng-service/wkpd/update",map);
		Map<String,Object> resultMap = new HashMap<>();
		resultMap.put("result",result);
		return resultMap;
	}
	
	public Map<String,Object> wkpdDelete(@RequestBody Map<String,Object> map){
		Object result = rest.service("womng-service/wkpd/delete",map);
		Map<String,Object> resultMap = new HashMap<>();
		resultMap.put("result",result);
		return resultMap;
		
	}
	
	
}
