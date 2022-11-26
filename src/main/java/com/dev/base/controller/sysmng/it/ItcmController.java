package com.dev.base.controller.sysmng.it;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.dev.base.cloudRest.Rest;
import com.dev.base.service.util.ExcelService;

@RestController
@RequestMapping(value="/itcm")
public class ItcmController { // 품목분류관리

	@Autowired
	Rest rest;
	
	@Autowired
	ExcelService sSvc;
	
	// http://localhost:8180/IT/ITCM/PAGE
	@GetMapping(value="/view")
	public ModelAndView itcmView() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/sysmng-svc/it/itcm");
		
		return mv;
	}
	
	// GET : URL에다가 주소 방식으로
	// POST : 주소에 HEADER, 쿠키정보랑 같이 보냄
	@GetMapping(value="/list")
	public Object getList(@RequestParam Map<String, Object> formData) {
		return rest.service("util-service/itcm/list", formData);
	}
	
	@PostMapping(value="/save")
	public Object save(@RequestBody Map<String, Object> formData) {
		Object result = rest.service("util-service/itcm/save", formData);
		return result;
	}
	
	@PostMapping(value="/delete")
	public Object delete(@RequestBody Map<String, Object> formData) {
		return rest.service("util-service/itcm/delete", formData);
	}
	
	//제품군 가져오기 컨트롤러
	@GetMapping(value = "/SygdGroupCode")
	public Object getSystemCode(@RequestParam Map<String, Object> map) {
		return rest.service("util-service/getSystemCode", map);
	}
	//대분류 가져오기 컨트롤러
	@GetMapping(value = "/selectGr2Code")
	public Object selectGr2Code(@RequestParam Map<String, Object> map) {
		return rest.service("util-service/selectGr2Code", map);
	}
	//중분류 가져오기 컨트롤러
	@GetMapping(value = "/selectGr3Code")
	public Object selectGr3Code(@RequestParam Map<String, Object> map) {
		return rest.service("util-service/selectGr3Code", map);
	}
	//소분류 가져오기 컨트롤러
	@GetMapping(value = "/selectGr4Code")
	public Object selectGr4Code(@RequestParam Map<String, Object> map) {
		return rest.service("util-service/selectGr4Code", map);
	}
	
	/*
	 * 엑셀 다운로드 컨트롤러
	 */
	@PostMapping(value = "/excel")
	public void excel(@RequestParam Map<String, Object> parameterMap) {
//		sSvc.excel(parameterMap);
	}
	
	
	
	
}
