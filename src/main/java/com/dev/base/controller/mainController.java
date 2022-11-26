package com.dev.base.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dev.base.cloudRest.Rest;
import com.dev.base.utils.TrackingFilter;

@Controller
public class mainController {
	
	@Autowired
	Rest rest;
	  
    @Autowired
    TrackingFilter trackingFilter;

	//메뉴 메인페이지
	@GetMapping(value= {"/main", "/index", "/home", "/"})
	public String login(Model model, HttpSession session) throws ServletException, IOException {
		Map<String, Object> userInfo = trackingFilter.fnUsercontext();
		model.addAttribute("menus", rest.service("util-service/selectAllMenu", null));
		model.addAttribute("userInfo", userInfo);
		session.setAttribute("userInfo", userInfo);
		session.setAttribute("userId", userInfo.get("preferred_username"));
		return "index";
	}
	
	@GetMapping(value="/main1")
	public String login1(Model model) {    
		return "/EQMNG_SVC/MS/EQMM";
	}
	

	//시스템코드 조회
	@GetMapping(value="/systemCode")
	@ResponseBody
	public Object getSytemCode(@RequestParam Map<String, Object> paramMap) {
		return rest.service("util-service/getSystemCode", paramMap);
	}
	
	//로그아웃
	@GetMapping(value="/reMain")
	public String deleteCookie(HttpSession session){
		session.invalidate();
	    return "redirect:/main";
	}
	
	
    private String getHttpConnection(String uri, String param) throws ServletException, IOException {
    	URL url = new URL(uri);
	    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	    conn.setRequestMethod("POST");
	    conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
	    conn.setDoOutput(true);
	      
	    try (OutputStream stream = conn.getOutputStream()) {
		    try (BufferedWriter wd = new BufferedWriter(new OutputStreamWriter(stream))) {
		    	wd.write(param);
		    }
	    }
	    
	    int responseCode = conn.getResponseCode();
	    
	    System.out.println(responseCode);
	    String line;
	    StringBuffer buffer = new StringBuffer();
	    try (InputStream stream = conn.getInputStream()) {
		    try (BufferedReader rd = new BufferedReader(new InputStreamReader(stream))) {
			    while ((line = rd.readLine()) != null) {
				    buffer.append(line);
				    buffer.append('\r');
			    }
		    }
	    }catch (Throwable e) {
	    	e.printStackTrace();
	    }
	    
	    return buffer.toString();
    }
}
