package com.dev.base.service.util;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.dev.base.cloudRest.Rest;
import com.dev.base.utils.service.UtilService;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class ExcelService {

	@Autowired
	UtilService uSvc;
	
	@Autowired
	Rest rest;
	
	public ModelAndView excel(Map<String, Object> parameterMap,String userId) {
		ObjectMapper objMapper = new ObjectMapper();
		Object result = rest.service("util-service/stmm/excel", parameterMap);
		Map<String, Object> objMap = objMapper.convertValue(result, Map.class);
		return uSvc.excelDownloadView(objMap, userId);
	}
}
