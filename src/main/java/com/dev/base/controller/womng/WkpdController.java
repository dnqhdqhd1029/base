package com.dev.base.controller.womng;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.dev.base.service.womng.WkpdService;

@RestController
public class WkpdController {
	
	@Autowired
	private WkpdService wSvc;
	
	@GetMapping(value="/wkpd")
	public ModelAndView wkpd(ModelAndView mv) {
		mv.setViewName("/womng-svc/ms/wkpd");
		return mv;
	}
	
	@PostMapping(value = "/wkpdList")
	public Map<String,Object> wkpdList(@RequestBody Map<String,Object> map){
		return wSvc.wkpdList(map);
	}
	
	@PostMapping(value="/wkpdUpdate")
	public Map<String,Object> wkpdUpdate(@RequestBody Map<String,Object> map){
		return wSvc.wkpdUpdate(map);
	}
	
	@PostMapping(value = "/wkpdDelete")
	public Map<String,Object> wkpdDelete(@RequestBody Map<String,Object> map){
		return wSvc.wkpdDelete(map);
	}
	
	
  
}
