<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
<%@ include file="/WEB-INF/include/header.jsp" %>
<title>예제페이지</title>
</head>
<body>
<!-- 조회헤더  -->
<div class="row" style="height:20%; width:100%;">
	<div class="col-sm-12">
		<form id="sFrm">
				<dl class="dl-layout two" id="searchSet">
					<dt>
						<label for="EMM_EQMT_TYPE" class="control-label col-sm-1 ">설비구분</label>
					</dt>
					<dd>
						<select class="form-control input-sm required" title="설비구분" id="EMM_EQMT_TYPE" name="EMM_EQMT_TYPE">
							<option value="">선택</option>
						</select>
					</dd>
					<dt>
						<input type="text" class="form-control input-sm required" title="생산일자-from" id="SEARCH_PREWEEK_DATE" name="SEARCH_PREWEEK_DATE" maxlength="20" placeholder="YYYY-MM-DD" style="width:50%">
					</dt>
					<dd>
						<input type="text">
					</dd>
				</dl>
		<div id="searchBtnSet" class="text-right">
			<button type="button" class="btn btn-sm btn-primary" onclick="search();">조회</button>
			<button type="button" id="btnExcel" class="btn btn-sm btn-success" onclick="fnReport();">리포트</button>
			<button type="button" class="btn btn-sm btn-default" onclick="init();">초기화</button>
		</div>
	</form>
	</div>
</div>

<!-- 몸통  -->
<div class="row" style="height:80%; width:100%;">
	<div class="col-sm-12">
	    <!-- 그리드 -->
		<div id="gridFrm">
			<table id="ci-grid"></table>
		</div>
	</div>
	<script id="ci-grid-template" type="text/template">
       <table width="100%" align="center">
           <thead>
               <tr>
	   			  <th name="stmmPageId" align="center" width="150px">페이지ID</th>
	   			  <th name="stmmPageTitle" align="center" width="100px">페이지 타이틀</th>
               </tr>
           </thead>
           <tbody>
               <tr>
	   			  <td name="stmmPageId" bind="stmmPageId" ></td>
	   			  <td name="stmmPageTitle" bind="stmmPageTitle" ></td>
               </tr>
           </tbody>
       </table>
	</script>
</div>
<script type="text/javascript">

    //setGrid(_table, _template, _pagingYN, _checkBoxYn, _rowCnt) {
	var grid = setGrid($("#ci-grid"),$("#ci-grid-template"), true, false, 50);	

	$(document).ready(function(){ 
		init()
	});
	
	//조회
	function search(){
		
		var sData = $("#sFrm").serializeObject();
		
		//get방식 ajax
		getAjax("${path}/TEST101/page", sData, true).done(function(data){
			grid.removeRow();
			grid.appendRow(data.list);
			gridResize();
		});
	}
	
	//초기화
	function init(){
		fnFormClear("#sFrm");
		search();
	} 
	
	//리포트
	function fnReport(){
		var option = "width = 700, height = 900, top = 100, left = 200, location = no";
		var sData = $("#sFrm").serializeObject();
		var vData = {};
		var vArray = new Array();
		
		vArray.push(sData);
		vData.list = vArray;
		
		window.open("${path}/TEST101/report?paramMap="+encodeURI(JSON.stringify(vData)), "어떤리포트", option);
	}
	
</script>
</body>
</html>