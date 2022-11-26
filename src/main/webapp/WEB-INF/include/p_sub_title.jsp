<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<p id="sub_title">
	<img alt="icon" src="${path}/resources/images/img_sub_title_seil.png">
	${param.title}
<c:if test="${param.selectBox eq 'Y'}">
	&nbsp;
	<span>
		<select id="row_cnt">
			<option value="10">10건씩 보기</option>
			<option value="15" selected>15건씩 보기</option>
			<option value="20">20건씩 보기</option>
			<option value="50">50건씩 보기</option>
			<option value="100">100건씩 보기</option>
		</select>
	</span>
</c:if>
</p>