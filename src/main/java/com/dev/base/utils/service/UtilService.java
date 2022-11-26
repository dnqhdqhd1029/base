package com.dev.base.utils.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.keycloak.adapters.springsecurity.client.KeycloakClientRequestFactory;
import org.keycloak.adapters.springsecurity.client.KeycloakRestTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dev.base.exception.CustomException;
import com.dev.base.utils.CommonUtils;
import com.dev.base.utils.MediaUtils;
import com.dev.base.utils.UploadFileUtils;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;


@Service
@Transactional
public class UtilService {

	@Value("${file.upload.path}")
	private String filePath;
	
	
	@SuppressWarnings("unchecked")
	public SXSSFWorkbook getExcelWorkbook(Map<String, Object> parameterMap) {
		List<Map<String, Object>> list = (List<Map<String, Object>>) parameterMap.get("excelData");
		List<String> labels = (List<String>) parameterMap.get("labels");
		List<String> keys = (List<String>) parameterMap.get("fieldKeys");
		String title = String.valueOf(parameterMap.get("title"));
		//작성자
		String userName = (String) parameterMap.get("USER_NAME");
		
		SXSSFWorkbook workbook = new SXSSFWorkbook(10000);
		
		//	시트 생성
		SXSSFSheet sheet = workbook.createSheet(title);	
		
		//	제목 행 생성
		Row titleRow = sheet.createRow(0);
		
		//	제목 행 스타일 세팅
		CellStyle titleRowStyle = workbook.createCellStyle();
						
		titleRowStyle.setAlignment(HorizontalAlignment.CENTER);
		titleRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		titleRowStyle.setBorderTop(BorderStyle.THIN);
		titleRowStyle.setBorderLeft(BorderStyle.THIN);
		titleRowStyle.setBorderRight(BorderStyle.THIN);
		titleRowStyle.setBorderBottom(BorderStyle.THIN);
		titleRowStyle.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.getIndex());
		titleRowStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		
		
		//	폰트 스타일
		Font titleFont = workbook.createFont();
		titleFont.setBold(true);
		titleFont.setFontHeight((short) (12*20));
		titleFont.setFontName("맑은 고딕");
		
		titleRowStyle.setFont(titleFont);
		for(int t = 0; t < labels.size(); t++) {
			Cell titleCell = titleRow.createCell(t);
			titleCell.setCellStyle(titleRowStyle);
			titleCell.setCellValue(title);
		}
		
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, (labels.size() - 1) ));
		titleRow.setHeight((short) 600);
        // 	헤더 행 스타일 세팅
		CellStyle headerRowStyle = workbook.createCellStyle();
		headerRowStyle.setAlignment(HorizontalAlignment.CENTER);
		headerRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		headerRowStyle.setBorderTop(BorderStyle.THIN);
		headerRowStyle.setBorderLeft(BorderStyle.THIN);
		headerRowStyle.setBorderRight(BorderStyle.THIN);
		headerRowStyle.setBorderBottom(BorderStyle.THIN);
		headerRowStyle.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.getIndex());
		headerRowStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		
		//	폰트 스타일
		Font headerFont = workbook.createFont();
		headerFont.setBold(true);
		headerFont.setFontHeight((short) (10*20));
		headerFont.setFontName("맑은 고딕");
		
		headerRowStyle.setFont(headerFont);
		
		// 헤더 행 생성
        Row headerRow;
        int j;
        
    	//셀 스타일
		CellStyle headerRowStyle1 = workbook.createCellStyle();
		headerRowStyle1.setAlignment(HorizontalAlignment.RIGHT);
		headerRowStyle1.setVerticalAlignment(VerticalAlignment.CENTER);
		headerRowStyle1.setBorderTop(BorderStyle.THIN);
		headerRowStyle1.setBorderLeft(BorderStyle.THIN);
		headerRowStyle1.setBorderBottom(BorderStyle.THIN);
		headerRowStyle1.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.getIndex());
		headerRowStyle1.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		headerRowStyle1.setFont(headerFont);
		
		// 조회조건 중 날짜 관련 SearchDateName 액셀에서 보여줄 명칭 ex) 생산 일자
		String ResultDate = null;
		if(!CommonUtils.isEmpty(parameterMap.get("SearchDateName"))) {
			ResultDate = parameterMap.get("SearchDateName") + " : " + parameterMap.get("SDATE");
			if(!CommonUtils.isEmpty(parameterMap.get("EDATE"))) {
				ResultDate += " ~ " + parameterMap.get("EDATE");
			}
		}
		
		// 출력일
    	SimpleDateFormat date = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm");
    	Calendar cal = Calendar.getInstance();
		
    	headerRow = sheet.createRow(2);
    	Row row2 = sheet.createRow(1);
    	j = 3;
    	
    	Cell cell = row2.createCell(0);
    	cell.setCellValue(ResultDate);
    	cell.setCellStyle(headerRowStyle1);
    	
    	//작성자 : 로그인사용자명  출력일 : 출력일시
    	Cell cell2 = row2.createCell(labels.size()-1);
    	cell2.setCellValue("작성자 : "+userName + "     출력일 : "+date.format(cal.getTime()));
    	headerRowStyle1.setAlignment(HorizontalAlignment.LEFT);
    	headerRowStyle1.setBorderLeft(BorderStyle.NONE);
    	headerRowStyle1.setBorderRight(BorderStyle.THIN);
    	cell2.setCellStyle(headerRowStyle1);
    	
    	sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, labels.size()-2));
        
        int i = 0;
        for (String label : labels) {
			
        	Cell headerCell = headerRow.createCell(i);
        	headerCell.setCellStyle(headerRowStyle);
        	headerCell.setCellValue(label == "null" ? "" : label);
        	        	
        	i++;
		}
        
        // 	바디 행 스타일 세팅 (텍스트)
		CellStyle bodyRowStyleText = workbook.createCellStyle();
		bodyRowStyleText.setAlignment(HorizontalAlignment.CENTER);
		bodyRowStyleText.setVerticalAlignment(VerticalAlignment.CENTER);
		bodyRowStyleText.setBorderTop(BorderStyle.THIN);
		bodyRowStyleText.setBorderLeft(BorderStyle.THIN);
		bodyRowStyleText.setBorderRight(BorderStyle.THIN);
		bodyRowStyleText.setBorderBottom(BorderStyle.THIN);
		
		//	폰트 스타일
		Font bodyFont = workbook.createFont();
		bodyFont.setFontHeight((short) (10*20));
		bodyFont.setFontName("맑은 고딕");
		
		bodyRowStyleText.setFont(bodyFont);
		
		//	바디 행 스타일 세팅 (숫자)
		CellStyle bodyRowStyleNumber = workbook.createCellStyle();
		bodyRowStyleNumber.setAlignment(HorizontalAlignment.RIGHT);
		bodyRowStyleNumber.setVerticalAlignment(VerticalAlignment.CENTER);
		bodyRowStyleNumber.setBorderTop(BorderStyle.THIN);
		bodyRowStyleNumber.setBorderLeft(BorderStyle.THIN);
		bodyRowStyleNumber.setBorderRight(BorderStyle.THIN);
		bodyRowStyleNumber.setBorderBottom(BorderStyle.THIN);
		bodyRowStyleNumber.setFont(bodyFont);
		bodyRowStyleNumber.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
        
		
		//	데이터 생성		
        for(Map<String, Object> data : list) {
        	Row bodyRow = sheet.createRow(j);
        	
        	int z = 0;
        	for (String key : keys) {
        		
        		Cell bodyCell = bodyRow.createCell(z);
        		String cellValue = String.valueOf(data.get(key));
        		
        		if(CommonUtils.isNumeric(cellValue) && key.indexOf("_ZIP") == -1 && key.indexOf("PART_NO") == -1 && key.indexOf("ITEM_NO") == -1 && key.indexOf("SUB_PART") == -1 && 
        				key.indexOf("SOLD_PART") == -1 && key.indexOf("CONST_CD") == -1 && key.indexOf("PSCM_COMP") == -1 && key.indexOf("PSCM_PAR") == -1 && key.indexOf("POPAR_CODE") == -1 && key.indexOf("POWOD_CODE") == -1) {
        			
        			bodyCell.setCellStyle(bodyRowStyleNumber);
        			
        			double cellValueNumber = 0;
        			
        			try {
						
        				cellValueNumber = Double.parseDouble(cellValue);
        				
        				NumberFormat fmt = NumberFormat.getInstance();
        				String num = fmt.format(cellValueNumber);
        				bodyCell.setCellValue(num.equals("0") ? "-" : num);
					} 
        			catch (NumberFormatException e) {
        				bodyCell.setCellStyle(bodyRowStyleText);
            			bodyCell.setCellValue(cellValue == "null" ? "" : cellValue);
					}
        			
        		}
        		else {
        			bodyCell.setCellStyle(bodyRowStyleText);
        			if(cellValue == "null") {
        				bodyCell.setCellValue("");
        			}
        			// 값이 0일 경우 값을 - 으로 변경 하고 우측 정렬
        			else if(cellValue.equals("0")) {
        				bodyCell.setCellStyle(bodyRowStyleNumber);
        				bodyCell.setCellValue("-");
        			}
        			else {
        				bodyCell.setCellValue(cellValue);
        			}
        			
        		}
        		
        		z++;
			}
        	
        	j++;
        }
        
        sheet.trackAllColumnsForAutoSizing();
        for(int index = 0; index < labels.size(); index++ ) {
        	sheet.autoSizeColumn(index);
        	int vWidth = (sheet.getColumnWidth(index)) + (short)1024;
        	
        	if(vWidth > 26240){
        		vWidth = 26000;
        	}
        	
//        	System.out.println("숫자 : "+ vWidth);
        	sheet.setColumnWidth(index, vWidth);
        }

        
		return workbook;
	}
	@SuppressWarnings("unchecked")
	public ModelAndView excelDownloadView(Map<String, Object> parameterMap,String user_id) {
		ModelAndView mv = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			
			JSONObject jsonObj = (JSONObject) new JSONParser().parse(String.valueOf(parameterMap.get("commonData")));
			
			try {
				
				map = new ObjectMapper().readValue(jsonObj.toJSONString(), Map.class);
				
				Set set = parameterMap.keySet();
				Iterator iterator = set.iterator();
				while(iterator.hasNext()){
					  String key = (String)iterator.next();
					  if(!key.equals("commonData")) {
						  map.put(key, parameterMap.get(key));
					  }
				}
				map.put("USER_NAME", user_id);
				mv.addObject("locale", Locale.KOREA);
				
				mv.addObject("workbookName", map.get("fileName"));
				mv.addObject("workbook", getExcelWorkbook(map));
				mv.setViewName("ExcelDownloadView");
			} 
			catch (JsonParseException e) {
				
				e.printStackTrace();
			} 
			catch (JsonMappingException e) {
				
				e.printStackTrace();
			} 
			catch (IOException e) {
				
				e.printStackTrace();
			}
		} 
		catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(mv);
		return mv;
	}
	
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		try {
			//파일 확장자 검사
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
			MediaType mType = MediaUtils.getMediaType(formatName);
			//헤더 생성
			HttpHeaders headers = new HttpHeaders();
			in = new FileInputStream(filePath + fileName);

			if(mType != null) {	//이미지 파일인 경우
				headers.setContentType(mType);
			} else {	//이미지 파일이 아닌경우
				fileName = fileName.substring(fileName.indexOf("_") + 1);	//uuid 를 제외한 파일이름
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);	//컨텐트 타입 
				
				//파일 이름에 한글이 들어간 경우
				//스트링.getBytes("언어셋") 스트링을 바이트 배열로 변환
				//new String(바이트 배열, "언어셋") 문자열의 인코딩 변경
				fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
				headers.add("Contents-Disposition", "attachment;filename=\""+fileName+"\"");	//첨부파일 정보
				headers.set("Content-Transfer-Encoding", "binary");

			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			if(in != null) in.close();
		}
		return entity;
	}
	
	public ResponseEntity<byte[]> displayTest(String fileName) throws Exception {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		try {
			//파일 확장자 검사
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
			MediaType mType = MediaUtils.getMediaType(formatName);
			//헤더 생성
			HttpHeaders headers = new HttpHeaders();
			in = new FileInputStream(filePath + "\\" + fileName);

			if(mType != null) {	//이미지 파일인 경우
				headers.setContentType(mType);
			} else {	//이미지 파일이 아닌경우
				fileName = fileName.substring(fileName.indexOf("_") + 1);	//uuid 를 제외한 파일이름
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);	//컨텐트 타입 
				
				//파일 이름에 한글이 들어간 경우
				//스트링.getBytes("언어셋") 스트링을 바이트 배열로 변환
				//new String(바이트 배열, "언어셋") 문자열의 인코딩 변경
				fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
				headers.add("Contents-Disposition", "attachment;filename=\""+fileName+"\"");	//첨부파일 정보
				headers.set("Content-Transfer-Encoding", "binary");

			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			if(in != null) in.close();
		}
		return entity;
	}
	
	public ModelAndView fileDownload(@RequestParam String fileName){		
		String realFileUrl = filePath + fileName;		
		File downFile = new File(realFileUrl);
		return new ModelAndView("downloadView", "downloadFile", downFile);
	}
	
	public Map<String, String> fileUpload(MultipartFile uploadFile) throws IOException, Exception{
		Map<String, String> returnMap = new HashMap<String, String>();
		
		String fileName = uploadFile.getOriginalFilename();
		String code = "";
		String filePath = "";
		String msg = "";
		
		if(!uploadFile.isEmpty()) {
			if(!fileName.toLowerCase().endsWith(".exe") ||
		            fileName.toLowerCase().endsWith(".js") ||
		            fileName.toLowerCase().endsWith(".class") ||
		            fileName.toLowerCase().endsWith(".jsp") ||
		            fileName.toLowerCase().endsWith(".sh")) {
				
				filePath = UploadFileUtils.uploadFile(filePath, fileName, uploadFile.getBytes());
				
				code = "OK";
				msg = "등록완료";
			}else {
				code = "ERR";
				msg = "지원하지 않는 형식입니다.";
			}
		}else {
			code = "NONE";
			msg = "자료없음.";			
		}

		returnMap.put("code", code);
		returnMap.put("fileName", fileName);
		returnMap.put("filePath", filePath);
		returnMap.put("msg", msg);
		
		return returnMap;
	}
	
	@SuppressWarnings("unchecked")
	public void ArrayReport(String serviceUrl, Map<String, Object> listMap, HttpServletResponse response, HttpServletRequest request) throws JRException, IOException, SQLException  {
		InputStream inputStream = null;
		try {
			
			SimpleDriverDataSource dataSource = new SimpleDriverDataSource();
			KeycloakClientRequestFactory fack = new KeycloakClientRequestFactory();
			KeycloakRestTemplate restTemplate = new KeycloakRestTemplate(fack);
			
			//페이지 아이디로 등록된 데이터가 존재하지 않을시 (공통같은 경우) 권한체크 안함.
			ResponseEntity<Object> returnChk = restTemplate.exchange(
					"http://localhost:8071/util-service/default" , 
					HttpMethod.GET, null, Object.class, "default"
			);
			
			ObjectMapper objMapper = new ObjectMapper();
			
			Map<String, List<Map<String, Map<String, String>>>> fulldataMap = objMapper.convertValue(returnChk.getBody(), Map.class);
			Map<String, String> dataMap = fulldataMap.get("propertySources").get(0).get("source");
			
			dataSource.setDriverClass(net.sf.log4jdbc.sql.jdbcapi.DriverSpy.class);
			dataSource.setUrl(dataMap.get("spring.datasource.url"));
			dataSource.setUsername(dataMap.get("spring.datasource.username"));
			dataSource.setPassword(dataMap.get("spring.datasource.password"));
//			System.out.println(listMap.get("paramMap"));
//			Map<String, Object> paramMap = objMapper.convertValue(listMap.get("paramMap"), Map.class);
//			System.out.println(paramMap);
			
			
			
			System.out.println("D://report/TEMP.jasper"); 
	        File file = ResourceUtils.getFile( "/report/TEMP.jrxml");

	        JasperReport jasperReport = JasperCompileManager.compileReport(file.getAbsolutePath());

	        JasperPrint jasperPrint = new JasperPrint();
	        JasperPrint jasperPrint2 = new JasperPrint();
	        
	        jasperPrint = JasperFillManager.fillReport(jasperReport, listMap, dataSource.getConnection());
	        
//	        for(int vCnt=1; vCnt<reportPamram.size(); vCnt++) {
//        		jasperPrint2 = JasperFillManager.fillReport(jasperReport, reportPamram.get(vCnt), dataSource.getConnection());
//        		List<JRPrintPage > pages = jasperPrint2.getPages();
//                for(JRPrintPage  page : pages)
//                {
//                	jasperPrint.addPage(page);
//                }
//	        }
	        
	        response.setCharacterEncoding("UTF-8");
	        response.setContentType("application/pdf");
	        final OutputStream outStream = response.getOutputStream();
	        
	        JasperExportManager.exportReportToPdfStream(jasperPrint, outStream);	
	        
		}catch(Exception e) {
			e.printStackTrace();
			throw new CustomException("오류 메세지", "리포트 출력오류");
		}
	}
}
