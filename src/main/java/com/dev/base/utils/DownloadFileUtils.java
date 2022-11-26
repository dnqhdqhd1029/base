package com.dev.base.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

@Component
public class DownloadFileUtils extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		setContentType("application/download; charset=utf-8");
		
		File file = (File) model.get("downloadFile");		
		
		response.setContentType(getContentType());
		response.setContentLength((int) file.length());
		
		String header = request.getHeader("User-Agent");
		String fileName = null;	
		
		if(header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1) {
			fileName = URLEncoder.encode(file.getName(), "utf-8").replaceAll("\\+", "%20");
		}
		else {
			fileName = new String(file.getName().getBytes("utf-8"), "iso-8859-1");
		}
		
		fileName = fileName.substring(fileName.indexOf("_")+1);
		
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
		response.setHeader("Content-Transter-Encoding", "binary");
		
		System.out.println("**Download File Name:**"+fileName);
		
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
		
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(fis != null){
				try {
					fis.close();
				} catch(IOException ioe){
					ioe.printStackTrace();
				}
			}
			
			out.flush();
		}
		
	}

}
