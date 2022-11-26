package com.dev.base.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dev.base.cloudRest.Rest;

@Controller
@RequestMapping(value = "/OPDM")
public class OPDMController {
	
	@Autowired
	Rest rest;
	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public String login(Model model) {    
		return "EQMNG_SVC/MS/OPDM";
	}
	
	@GetMapping(value = "/getList")
	@ResponseBody
	public Object getList(@RequestParam Map<String,Object>params)throws Exception{
		
		System.out.println("베이스 컨트롤러 OPC");
		System.out.println("조회 값 : "+params);
		return rest.service("eqmng-service/opcdata/getList", params);
	}

	@GetMapping(value = "/subList")
	@ResponseBody
	public Object subList(@RequestParam Map<String,Object>params)throws Exception{
		
		System.out.println("베이스 컨트롤러 OPC");
		System.out.println("조회 값 : "+params);
		return rest.service("eqmng-service/opcdata/subList", params);
	}


	
	
	

}
