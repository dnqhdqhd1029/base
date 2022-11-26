package com.dev.base.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dev.base.cloudRest.Rest;
import com.dev.base.utils.UploadFileUtils;
import com.dev.base.utils.service.UtilsService;

@Controller
@RequestMapping(value = "/EQMM")
public class EQMMController {
	
	@Autowired
	Rest rest;
	
	@Inject
	UtilsService utils;
	
//	@Resource(name = "uploadPath")
//	String uploadPath;
	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public String login(Model model) {    
		return "EQMNG_SVC/MS/EQMM";
	}	
	@PostMapping(value="/getList")
	@ResponseBody
	public Object getList(@RequestBody Map<String,Object> params)throws Exception {
		
		System.out.println("베이스 컨트롤러");
		System.out.println("조회 값 : "+params);
		Object reVal= rest.service("eqmng-service/comeDate/getList",params);
		System.out.println("값 : "+reVal);
		return reVal;
	}
	
	@PostMapping(value = "/update")
	@ResponseBody
	public Object update(@RequestParam Map<String,Object> params, @RequestParam MultipartFile uploadFile, @RequestParam MultipartFile uploadFile2) throws Exception{
		Map<String,Object> resultMap = new HashMap<String, Object>();	
		
		System.out.println("업데이트");
		System.out.println("업데이트 값 : "+params);	
		
		
		String fileName = uploadFile.getOriginalFilename();
		String fileName2 = uploadFile2.getOriginalFilename();	
			
		try {					
			// exe, js, class, jsp, sh 로 끝나는 파일이 아닌경우에만 업로드 되도록
		    if(!fileName.toLowerCase().endsWith(".exe") ||
		            fileName.toLowerCase().endsWith(".js") ||
		            fileName.toLowerCase().endsWith(".class") ||
		            fileName.toLowerCase().endsWith(".jsp") ||
		            fileName.toLowerCase().endsWith(".sh")) {
				
				if(!uploadFile.isEmpty()) {
					String filePath = "";
					filePath = UploadFileUtils.uploadFile_folder("d:/upload", fileName, uploadFile.getBytes(), "EQMM");
					
//					기존 파일이 있을경우 삭제 
					if(params.get("EqmnimgPath") != null) {
						utils.deleteFile((String) params.get("EqmnimgPath"), "d:/upload");
					}
					params.put("EqmnimgPath", filePath);
				}
				
		    } else {
		    	throw new Exception("업로드 할 수 없는 파일입니다.");
		    }    
		    if(!fileName2.toLowerCase().endsWith(".exe") ||
		            fileName2.toLowerCase().endsWith(".js") ||
		            fileName2.toLowerCase().endsWith(".class") ||
		            fileName2.toLowerCase().endsWith(".jsp") ||
		            fileName2.toLowerCase().endsWith(".sh")) {
				
				if(!uploadFile2.isEmpty()) {
					String filePath2 = "";
					filePath2 = UploadFileUtils.uploadFile_folder("d:/upload", fileName2, uploadFile2.getBytes(), "EQMM");
					
					//기존 파일이 있을경우 삭제	
					if(params.get("EqmnFilePath") != null) {
						utils.deleteFile((String)params.get("EqmnFilePath"), "d:/upload");
					}
					params.put("EqmnFilePath",filePath2);
					params.put("EqmnFileNm",fileName2);
				}
				
		    } else {
		    	throw new Exception("업로드 할 수 없는 파일입니다.");
		    }
		    resultMap.put("list", rest.service("eqmng-service/comeDate/update", params));
			
		}catch (Exception e) {
			e.printStackTrace();
			resultMap.put("message", e.getMessage());
			resultMap.put("code", "ERR");
		}
			
		return resultMap;
	}
	

}
