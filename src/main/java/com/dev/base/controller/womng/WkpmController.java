package com.dev.base.controller.womng;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.dev.base.service.womng.WkpmService;

@RestController
public class WkpmController {
	
	@Autowired
	WkpmService wkpmSvc;
	
	@RequestMapping(value = "/wkpm",  method = RequestMethod.GET)
	public ModelAndView wkpm(ModelAndView mv) {
		mv.setViewName("/womng-svc/ms/wkpm");
		return mv;
	}
	
	@GetMapping(value = "/wkpmList")
	public Map<String,Object> wkpmList(){
		return wkpmSvc.wkpmList();
	}
	
	@PostMapping(value ="/wkpmInsert")
	public Map<String, Object> wkpmInsert(@RequestBody Map<String,Object> map){
		wkpmSvc.wkpmInsert(map);
		map.put("result", "성공!");
		return map;
	}
	
	@PostMapping(value ="/wkpmUpdate")
	public Map<String, Object> wkpmUpdate(@RequestBody Map<String,Object> map){
		wkpmSvc.wkpmUpdate(map);
		map.put("result", "성공!");
		return map;
	}
	
	@PostMapping(value="/wkpmDelete")
	public Map<String,Object> wkpmDelete(@RequestBody Map<String,Object> map){
		return wkpmSvc.wkpmDelete(map);
	}
	

}
