<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/header.jsp"%>
<meta charset="UTF-8">
<title>사용자 목록</title>
<script type="text/javascript">
$(document).ready(function(){
	
})
</script>

</head>

<body>
<c:import url="/WEB-INF/include/modal_frame.jsp" charEncoding="UTF-8">
	<c:param name="title" value="사용자 정보 등록/수정"></c:param>
</c:import>

	<div class="container-fluid">
		
		<form id="sFrm" onsubmit="return search();">
			<dl class="dl-layout four" id="searchSet">
				<dt>
					<label for="UMM_USER_ID" class="control-label col-sm-1 ">사용자ID</label>
				</dt>
				<dd>
					<input type="text" class="form-control input-sm" name="UMM_USER_ID" id="UMM_USER_ID" autofocus="autofocus" onKeyUp="this.value=this.value.toUpperCase();" style="text-transform: uppercase;">
				</dd>
				<dt>
					<label for="UMM_USER_NAME" class="control-label col-sm-1 ">사용자명</label>
				</dt>
				<dd>
					<input type="text" class="form-control input-sm" name="UMM_USER_NAME" id="UMM_USER_NAME" onKeyUp="this.value=this.value.toUpperCase();" style="text-transform: uppercase;">
				</dd>
				<dt>
					<label for="UMM_COMPANY_CD" class="control-label col-sm-1 ">소속회사</label>
				</dt>
				<dd>
					<select class="form-control imput-sm" name="UMM_COMPANY_CD" id="UMM_COMPANY_CD"></select>
				</dd>
				<dt>
					<label for="UMM_DEPA_CD" class="control-label col-sm-1 ">소속부서</label>
				</dt>
				<dd>
					<select class="form-control imput-sm" name="UMM_DEPA_CD" id="UMM_DEPA_CD"></select>
				</dd>
			</dl>
			<dl class="dl-layout four first-line" id="searchSet" style="border-top:none;margin-top:-5px;margin-bottom:10px;">
				<dt class="first-line">
					<label for="UMM_GROUP_ID" class="control-label col-sm-1 ">권한그룹</label>
				</dt>
				<dd class="first-line">
					<select class="form-control imput-sm" name="UMM_GROUP_ID" id="UMM_GROUP_ID">
						<option value="">선택</option>
						<option value="READUSERGR">조회 사용자 그룹</option>
						<option value="NORMALUSERGR">일반 사용자 그룹</option>
						<option value="MNGUSERGR">업무 관리자 그룹</option>
						<option value="ADMINFIRST">시스템 최고 관리자</option>
					</select>
				</dd>
				<dt class="first-line">
					<label for="" class="control-label col-sm-1 ">사용여부</label>
				</dt>
				<dd class="first-line">
					<div class="form-inline" style="text-align:center;">
						<label class="radio-inline">
							<input type="radio" name="UMM_IS_YN" id="UMM_IS_YN1" value="" checked="checked"> 전체
						</label>
						<label class="radio-inline">
							<input type="radio" name="UMM_IS_YN" id="UMM_IS_YN2" value="Y"> 사용
						</label>
						<label class="radio-inline">
							<input type="radio" name="UMM_IS_YN" id="UMM_IS_YN3" value="N"> 불가
						</label>
					</div>
				</dd>
				<dt class="first-line" style="background:white;"></dt>
				<dd class="first-line"></dd>
				<dt class="first-line" style="background:white;"></dt>
				<dd class="first-line"></dd>
			</dl>
			<div id="searchBtnSet" class="text-right">
				<button type="submit" class="btn btn-sm btn-primary">조회</button>
				<button type="button" id="btnExcel" class="btn btn-sm btn-success" onclick="excelDown();">Excel Download</button>
				<button type="button" class="btn btn-sm btn-default" onclick="init();">초기화</button>
			</div>
		</form>
		
		<div  id="gridWrapper">
		
			<div>
				<p id="sub_title">
					<img alt="icon" src="${path}/images/img_sub_title_seil.png">
					사용자 정보 조회내역
					&nbsp;
					<span>
						<select id="row_cnt">
						</select>
					</span>	
				</p>
			</div>
			
			<div>
				<table id="grid-table"></table>
			</div>
		
			<div id="btn_set">
				<p class="text-right">
					<button type="button" class="btn btn-sm btn-primary" id="btn_regist">사용자등록</button>
					<!-- <button type="button" class="btn btn-sm btn-default" id="btn_update">사용자수정</button> -->
					<button type="button" class="btn btn-sm btn-danger" id="btn_delete">사용자삭제</button>
					<!-- <button type="button" class="btn btn-sm btn-success" id="btn_excel">엑셀다운로드</button> -->
				</p>
			</div>
		</div>
			
		
		
		<form id="export-form"></form>
		<script id="grid-template" type="text/template">
		<table width="100%" height:"430px">
			<thead>
				<tr>
					<th name="USERNAME" align="center">유저ID</th>
					<th name="USER_NAME" align="center">유저이름</th>
					<th name="EMAIL" align="center">유저 Email</th>
					<th name="GROUP_ID" align="center">그룹ID</th>
					<th name="CREATED_TIMESTAMP" align="center">CREATED_TIMESTAMP</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td name="USERNAME" bind="USERNAME"></td>
					<td name="USER_NAME" bind="USER_NAME"></td>
					<td name="EMAIL" bind="EMAIL"></td>
					<td name="GROUP_ID" bind="GROUP_ID"></td>
					<td name="CREATED_TIMESTAMP" bind="CREATED_TIMESTAMP"></td>
				</tr>
			</tbody>
		</table>
		</script>
		
		<script type="text/javascript">
			let table = $('#grid-table');
			let template = $('#grid-template');
			
			const grid = webponent.grid.init(table, template, {
				rowSelectable : true
			});
			
		 
			// 그룹 코드조회(조회버튼 눌렀을때)
			function search() {
				let frm = $("#sFrm")
				let url = "/usmn/list"
				let searchData = frm.serializeObject();
				getDraw(url, grid, searchData);

				return false;
			}
			
			function getDraw(url, grid, inputData) {
				$.ajax({
					cache : false,
					url : url,
					Type : 'GET',
					data : inputData,
					dataType : "json",
					contentType : 'application/json;charset=utf-8',
					success : function(resp) {
						grid.removeRow();
						grid.appendRow(resp);

					},
					error : function(error) {
						alert("에러발생 관리자에게 문의하세요. 에러코드 = " + error);
					}
				});
			}
			
		</script>
		
	</div>
		
</body>
</html>