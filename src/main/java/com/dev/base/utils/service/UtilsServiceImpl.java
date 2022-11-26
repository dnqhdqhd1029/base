package com.dev.base.utils.service;

import java.io.File;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;

import com.dev.base.utils.MediaUtils;

@Service
public class UtilsServiceImpl  implements UtilsService {


	
	@Override
	public void deleteFile(String imgPath, String uploadPath) {
		String fileName = imgPath;
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1); //확장자 검사
		MediaType mType = MediaUtils.getMediaType(formatName);
		if(mType != null) {//이미지 파일의 경우 원본파일 삭제
			String front = fileName.substring(0,12);
			String end = fileName.substring(14);
			new File(uploadPath + (front + end).replace('/', File.separatorChar)).delete();	//파일 삭제
		}
		//	이미지 파일의 경우 썸네일 삭제됨
		new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();	//썸네일 삭제
	}


}
