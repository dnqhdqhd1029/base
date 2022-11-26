package com.dev.base.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dev.base.cloudRest.Rest;
import com.dev.base.utils.CommonUtils;
import com.dev.base.utils.UserContext;


@Controller
@RequestMapping(value="/menu")
public class menuController {
	
	@Autowired
	Rest rest;
	
	@GetMapping(value="/list")
	public String list(Model model) {    
		model.addAttribute("menus", rest.service("util-service/selectAllMenu", null));
		return "system/menu/menu_list";
	}
	
	@PostMapping(value = "/detail")
	public String detail(@RequestParam(required = false) String pageId, Model model) {
		
		System.out.println( UserContext.getUserName());
		System.out.println( UserContext.getUserName());
		
		Map<String, Object> sendMap = new HashMap<>();
		sendMap.put("stmmPageId", pageId);
		String mode = "REG";
		if(!CommonUtils.isEmpty(pageId)) {
			model.addAttribute("map", rest.service("util-service/selectMenuDetail", sendMap));
			mode = "EDIT";
		}
		model.addAttribute("mode", mode);
		return "system/menu/menu_detail";
	}

	@GetMapping(value = "/parentMenu")
	@ResponseBody
	public Object parendMenu(@RequestParam Map<String, Object> paramMap){
		return rest.service("util-service/parentMenu", paramMap);
	}
	
	@GetMapping(value = "/regist")
	@ResponseBody
	public Object regist(@RequestParam Map<String, Object> params) {
		return rest.service("util-service/insertMenu", params);
	}

	@GetMapping(value = "/update")
	@ResponseBody
	public Object update(@RequestParam Map<String, Object> params) {
		return rest.service("util-service/updateMenu", params);
	}
	
	@PostMapping(value = "/delete")
	@ResponseBody
	public Object delete(@RequestBody Map<String, Object> params) {
		return rest.service("util-service/deleteMenu", params);
	}

	@GetMapping(value = "/updateOrder")
	@ResponseBody
	public Object saveOrder(@RequestParam Map<String, Object> params) {
		return rest.service("util-service/updateOrder", params);
	}
}
