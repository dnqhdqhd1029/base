package com.dev.base.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.keycloak.adapters.springsecurity.client.KeycloakClientRequestFactory;
import org.keycloak.adapters.springsecurity.client.KeycloakRestTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dev.base.cloudRest.Rest;
import com.dev.base.model.urlModel;
import com.dev.base.utils.service.UtilService;
import com.fasterxml.jackson.databind.ObjectMapper;

import net.sf.jasperreports.engine.JRException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

@Controller
@RequestMapping(value="/TEST101")
public class TEST101Controller {
	
	@Autowired
	Rest rest;
	
	@Autowired
	UtilService utilservice; 
	
	@Autowired
	DataSource dataSource;
	
	
	@GetMapping(value="/page")
	public String page(Model model) {    
		return "temp/temp_list";
	}
	
	//조회
	@GetMapping(value="/list")
	@ResponseBody
	public Object list(@RequestParam Map<String, Object> paramMap) {
		System.out.println("조회조건");
		System.out.println(paramMap);
		return rest.service("util-service/selectAllMenu", paramMap);
	}
	
	@GetMapping(value="/report")
	@ResponseBody
	public void report(@RequestParam Map<String, Object> paramMap, HttpServletResponse response, HttpServletRequest request) throws JRException, IOException, SQLException{
		
		System.out.println(paramMap);
		
		utilservice.ArrayReport("util-service", paramMap, response, request);
	}
}
