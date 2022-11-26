package com.dev.base.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.base.cloudRest.Rest;

@Service
public class mainService {

	@Autowired
	Rest rest;
	
//	@Autowired
//	SimpleSourceBean simpleSourceBean;
	
	public String restApi() {
		
		//rest api 호출시
//		baseModel dd = new baseModel();
		
//		dd.setGUBN("ㅎㅎ");
		
//		rest.service("material-service/workReg/getList", "GET", dd);

		return "";
	}
}
