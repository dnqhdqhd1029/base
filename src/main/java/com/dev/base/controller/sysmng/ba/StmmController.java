package com.dev.base.controller.sysmng.ba;

import java.util.Map;

import javax.servlet.http.HttpSession;

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
@RequestMapping(value = "/stmt")
public class StmmController {

	@Autowired
	Rest rest;
	
	@Autowired
	ExcelService sSvc;
	

	@GetMapping(value = "/view")
	public ModelAndView stmm(ModelAndView mv) {
		mv.setViewName("/sysmng-svc/ba/stmm");
		return mv;
	}

	@GetMapping(value = "/getSystemCode")
	public Object getSystemCode(@RequestParam Map<String, Object> map) {
		return rest.service("util-service/getSystemCode", map);
	}
	/*
	 * 마스터테이블 컨트롤러
	 */

	@GetMapping(value = "/list")
	public Object stmmList(@RequestParam Map<String, Object> map) {
		return rest.service("util-service/stmm/list", map);
	}

	@PostMapping(value = "/regist")
	public Object stmtMtRegist(@RequestBody Map<String, Object> map) {
		return rest.service("util-service/stmm/regist", map);
	}

	@PostMapping(value = "/update")
	public Object stmtMtUpdate(@RequestBody Map<String, Object> map) {
		return rest.service("util-service/stmm/update", map);

	}

	@PostMapping(value = "/delete")
	public Object stmtMtDelete(@RequestBody Map<String, Object> map) {
		return rest.service("util-service/stmm/delete", map);

	}

	/*
	 * 상세테이블 컨트롤러
	 */

	@GetMapping(value = "/detail/list")
	public Object stmmDetailList(@RequestParam Map<String, Object> map) {
		return rest.service("util-service/stmm/detail/list", map);
	}

	@PostMapping(value = "/detail/regist")
	public Object stmtDtRegist(@RequestBody Map<String, Object> map) {
		return rest.service("util-service/stmm/detail/regist", map);
	}

	@PostMapping(value = "/detail/update")
	public Object stmtDtUpdate(@RequestBody Map<String, Object> map) {
		return rest.service("util-service/stmm/detail/update", map);

	}

	@PostMapping(value = "/detail/delete")
	public Object stmtMtDetailDelete(@RequestBody Map<String, Object> map) {
		return rest.service("util-service/stmm/detail/delete", map);
	}

	/*
	 * 엑셀 다운로드 컨트롤러
	 */
	@PostMapping(value = "/excel")
	public void excel(@RequestParam Map<String, Object> parameterMap,HttpSession session) {
		String userId = (String) session.getAttribute("userId");
		
		sSvc.excel(parameterMap,userId);
	}

}
