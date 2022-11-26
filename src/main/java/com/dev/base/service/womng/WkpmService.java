package com.dev.base.service.womng;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.base.cloudRest.Rest;

@Service
public class WkpmService {

	@Autowired
	Rest rest;

	Map<String, Object> map;

	public Map<String, Object> wkpmList() {
		Map<String, Object> map = new HashMap<>();
		Object result = rest.service("womng-service/wkpm/list", map);
		map.put("result", result);
		return map;
	}

	public Map<String, Object> wkpmInsert(Map<String, Object> map) {
		Object result = rest.service("womng-service/wkpm/insert", map);
		map = new HashMap<>();
		map.put("result", result);
		return map;
	}
	
	public Map<String, Object> wkpmUpdate(Map<String, Object> map) {
		System.out.println(map);
		Object result = rest.service("womng-service/wkpm/update", map);
		map = new HashMap<>();
		map.put("result", result);
		return map;
	}

	public Map<String, Object> wkpmDelete(Map<String, Object> map) {
		Object result = rest.service("womng-service/wkpm/delete", map);
		map = new HashMap<>();
		map.put("result", result);
		return map;
	}

}
