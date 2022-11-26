package com.dev.base.utils;

import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CommonUtils {
	
	public static boolean isEmpty(Object obj) {
		
		if(obj == null) return true;

		if ((obj instanceof String) && (((String)obj).trim().length() == 0)) { return true; }

	    if (obj instanceof Map) { return ((Map<?, ?>) obj).isEmpty(); }

	    if (obj instanceof Map) { return ((Map<?, ?>)obj).isEmpty(); } 

	    if (obj instanceof List) { return ((List<?>)obj).isEmpty(); }

	    if (obj instanceof Object[]) { return (((Object[])obj).length == 0); }
	    
	    return false;
	}
	
	//	하이픈(-) 추가 [전화번호]
	public static List<Map<String, String>> addHypenToList(List<Map<String, String>> list, String phoneNumberKey){		
		
		for(int i = 0; i < list.size(); i++){
			Map<String, String> map = list.get(i);				
			map = addHypenToMap(map, phoneNumberKey);
		}
		
		return list;		
	}
	
	public static Map<String, String> addHypenToMap(Map<String, String> map, String phoneNumberKey){
		String phoneNumber = null;
		if(!isEmpty(map.get(phoneNumberKey))) {
			phoneNumber = map.get(phoneNumberKey).toString();					
			phoneNumber = addHypen(phoneNumber);
			map.put(phoneNumberKey, phoneNumber);
		}
		
		return map;
	}
	
	public static String addHypen(String value){				
		if(!isEmpty(value)){
			if(value.indexOf("-") > -1){
				value = value.replace("-", "");
			}		
			
			String num1 = null;
			String num2 = null;
			String num3 = null;
			
			if(value.length() == 9){
				if(value.substring(0,2).equals("02")){
					num1 = value.substring(0,2);
					num2 = value.substring(2,5);
					num3 = value.substring(5,9);
				}
			}			
			else if(value.length() == 10){				
				if(value.substring(0,2).equals("02")){
					num1 = value.substring(0,2);
					num2 = value.substring(2,6);
					num3 = value.substring(6,10);
				}
				else {
					num1 = value.substring(0,3);
					num2 = value.substring(3,6);
					num3 = value.substring(6,10);
				}				
			} 
			else if(value.length() == 11){
				num1 = value.substring(0,3);
				num2 = value.substring(3,7);
				num3 = value.substring(7,11);
			}
			
			if(!value.equals("미등록") && num1 != null && num2 !=null && num3 !=null) {
				value = num1 + "-" + num2 + "-" + num3;
			}
				
		}
		
		return value;
	}
	
	//	하이픈(-) 추가 [사업자등록번호]
	public static List<Map<String, String>> formatRegNo(List<Map<String, String>> list, String regNoKey){
		for(int i = 0; i < list.size(); i++){
			Map<String, String> map = list.get(i);				
			map = formatRegNo(map, regNoKey);
		}
		
		return list;
	}
	
	public static Map<String, String> formatRegNo(Map<String, String> map, String regNoKey){
		String regNo = null;
		if(!isEmpty(map.get(regNoKey))) {
			regNo = map.get(regNoKey).toString();					
			regNo = formatRegNo(regNo);
			map.put(regNoKey, regNo);
		}
		
		return map;
	}
	
	public static String formatRegNo(String regNo) {
		if(!isEmpty(regNo)) {
			if(regNo.indexOf("-") > -1){
				regNo = regNo.replace("-", "");
			}
			
			String num1 = null;
			String num2 = null;
			String num3 = null;
			
			if(regNo.length() == 10) {
				num1 = regNo.substring(0,3);
				num2 = regNo.substring(3,5);
				num3 = regNo.substring(5,10);
				
				if(num1.length() == 3 && num2.length() == 2 && num3.length() == 5) {
					regNo = num1 + "-" + num2 + "-" + num3;
				}
			}
			
		}
		
		return regNo;
	}
	
	/*	
	 *	도로명 주소 괄호 부분 나누기
	 * 	ex) addr = 서울특별시 강남구 도곡로 11-1 (대치동)
	 * 		addr1 = 서울특별시 강남구 도곡로 11-1
	 * 		addr2 = (대치동)
	*/
	public static Map<String, String> divideAddr(String addr){
		
		Map<String, String> rstMap = new HashMap<String, String>(); 
		
		if(!isEmpty(addr)) {
			String addr1 = null;
			String addr2 = null;
			if(addr.indexOf("(") > -1) {
				addr1 = addr.substring(0, addr.indexOf("(")-1).trim();
				addr2 = addr.substring(addr.indexOf("(")).trim();
			}
			else {
				addr1 = addr;
			}
			rstMap.put("addr1", addr1);
			rstMap.put("addr2", addr2);
		}
		
		return rstMap;
	}
	
	public static String getDate() {
		
		Date date = new Date();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		
		String today = fmt.format(date);
		
		return today;
	}
	
	public static String getDate(int y, int m, int d) {
		
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		 
        Calendar cal = Calendar.getInstance();
        Date date = new Date();
        cal.setTime(date);
        cal.add(Calendar.YEAR, y);      //년 더하기
        cal.add(Calendar.MONTH, m);     //월 더하기
        cal.add(Calendar.DATE, d);      //일 더하기
 
        return fmt.format(cal.getTime());
	}
	
	//	값이 숫자인지 아닌지
	public static boolean isNumeric(String input) {
		if(!input.equals("")) {
		
		String firstChar = input.substring(0,1); 
		
			if(String.valueOf(firstChar).equals("0") && input.indexOf(".") == -1) {
				
				return false;
			}
		}
		try {
			
			Double.parseDouble(input);
			return true;
		}
		catch (NumberFormatException e) {
			return false;
		}
	}
	
	public static String toSerialize(Map<String, String> map) {
		
		String str = "";
		
		if(!isEmpty(map)) {
			
			int i = 0;
			for(String key : map.keySet()) {
				
				if(i != 0) str = str + "&";
				
				str = str + key + "=" + map.get(key);
				i++;
			}
		}
		
		return str;
	}
	
	public static void main(String[] args) {
		String x = "12160626.92";
		double d = Double.parseDouble(x);
		
		NumberFormat fmt = NumberFormat.getInstance();
		
		System.out.println(fmt.format(d));
	}
}
