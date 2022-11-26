package com.dev.base.controller.sysmng.it;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.dev.base.cloudRest.Rest;

@RestController
@RequestMapping(value = "/itbm")
public class ItbmController {
	
	@Autowired
	Rest rest;

	@GetMapping(value = "/view")
	public ModelAndView stmm(ModelAndView mv) {
		mv.setViewName("/sysmng-svc/it/itbm");
		return mv;
	}
}
