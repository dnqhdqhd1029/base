package com.dev.base.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dev.base.cloudRest.Rest;


@Controller
@RequestMapping(value="/authGroup")
public class authGroupController {
	
	@Autowired
	Rest rest;
	
	@GetMapping(value="/list")
	public String login(Model model) {   
		model.addAttribute("mode", "READ");
		model.addAttribute("dto", rest.service("util-service/selectAuth", null));
		return "system/authgroup/authgroup_list";
	}
	
	@PostMapping(value = "/detail")
	public String detail(@RequestParam String groupId, HttpSession session, Model model) {		
		Map<String, Object> sendMap = new HashMap<>();
		sendMap.put("PmgdGroupId", groupId);
		session.setAttribute("DETAIL_AUTH_GROUP_ID", groupId);
		model.addAttribute("dtoSub", rest.service("util-service/selectAuthDetail", sendMap));
		return "system/authgroup/authgroup_detail";
	}
	
	
	@RequestMapping(value = "/regist", method = RequestMethod.GET)
	public String regist(Model model) {
		model.addAttribute("mode", "REG");
		model.addAttribute("dto", rest.service("util-service/selectAuth", null));
		return "system/authgroup/authgroup_list";
	}
	
	@RequestMapping(value = "/regist", method = RequestMethod.POST)
	@ResponseBody
	public Object regist(@RequestBody Map<String, Object> paramMap, HttpSession session, Model model) {
		model.addAttribute("mode", "READ");
		return rest.service("util-service/insertAuth", paramMap);
	}
	
	@RequestMapping(value = "/edit/{editId}", method = RequestMethod.GET)
	public String edit(@PathVariable("editId") String editId, HttpSession session, Model model) {
		model.addAttribute("mode", "EDIT");
		model.addAttribute("editId", editId);
		model.addAttribute("dto", rest.service("util-service/selectAuth", null));
		
		//	세션에 원래 아이디 저장
		session.setAttribute("ORIGIN_AUTH_GROUP_ID", editId);
		return "system/authgroup/authgroup_list";
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	@ResponseBody
	public Object edit(@RequestBody Map<String, Object> paramMap, HttpSession session) {
		String originAuthGroupId = (String) session.getAttribute("ORIGIN_AUTH_GROUP_ID");
		paramMap.put("PmgmGroupId", originAuthGroupId);
		//	세션에 담긴 원래 아이디 삭제
		session.removeAttribute("ORIGIN_AUTH_GROUP_ID");
		return rest.service("util-service/updateAuth", paramMap);
	}
	
	@RequestMapping(value = "/detail/regist", method = RequestMethod.POST)
	@ResponseBody
	public Object detailRegist(@RequestBody Map<String, Object> paramMap, HttpSession session) {
		String originAuthGroupId = (String) session.getAttribute("DETAIL_AUTH_GROUP_ID");
		paramMap.put("PmgmGroupId", originAuthGroupId);
		//	세션에 담긴 원래 아이디 삭제
		session.removeAttribute("ORIGIN_AUTH_GROUP_ID");
		
		System.out.println(paramMap);
		
		return rest.service("util-service/insertDetailAuth", paramMap);
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public Object delete(@RequestBody Map<String, Object> paramMap) {
		return rest.service("util-service/deleteAuth", paramMap);
	}
}
