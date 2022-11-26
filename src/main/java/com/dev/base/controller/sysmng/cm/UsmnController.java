package com.dev.base.controller.sysmng.cm;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.dev.base.cloudRest.Rest;
import com.dev.base.service.util.UsmnService;

@RestController
@RequestMapping(value = "/usmn")
public class UsmnController {
	
	@Autowired
	Rest rest;
	
	@GetMapping(value = "/view")
	public ModelAndView usmn(ModelAndView mv) {
		mv.setViewName("/sysmng-svc/cm/usmn");
		return mv;
	}
	
	@GetMapping(value="/list")
	public Object wkpdList(Map<String,Object> map){		
		map.put("test","123");
		System.out.println( rest.service("util-service/usmn/list", map));
		return rest.service("util-service/usmn/list", map);
	}

}
