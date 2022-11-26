<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/include/header.jsp" %>
<title>수집데이터설정관리</title>
</head>
<body>
	<div class="container-fluid" style="height:96%;">
		<div class="row" style="height:10%;">
			<div class="col-sm-12">
				<form id="sFrm">
		            <div id="searchList" style="width:100%;">
		                <dl class="dl-layout four" style="margin-bottom:10px;">
		                    <dt class="dl-1">설비구분</dt>
		                    <dd >
								<select class="form-control" id="GUBN" name="GUBN">
									<option value="">선택</option>
								</select>
		                    </dd>
		                </dl>
		            </div>
					
					<div id="searchBtnSet" class="text-right">
						<button type="button" class="btn btn-sm btn-primary" onclick="search();">조회</button>
						<button type="button" class="btn btn-sm btn-default" onclick="init();">초기화</button>
					</div>
				</form>
			</div>
		</div>
		<div class="row" style="height:85%;">
			<div class="col-sm-3">
				<p id="sub_title">
					<img alt="icon" src="${path}/resources/images/img_sub_title_seil.png">
					설비목록
					<span style="float:right;" id="gridCnt">전체 : 0건</span>
				</p>
				<div class="gridFrm">
					<table id="ci-grid"></table>
				</div>
			</div>
			<div class="col-sm-9">
				<p id="sub_title">
					<img alt="icon" src="${path}/resources/images/img_sub_title_seil.png">
					설비별 수집데이터 목록<span id="subItem" style="font-weight:bold;"></span>
					&nbsp;
					<span class="text-muted" style="color:blue;">
						 &gt;&gt; 해당 로우를 더블클릭하시면 수정 가능합니다.
					</span>
					<span style="float:right;" id="grid2Cnt">전체 : 0건</span>
				</p>
				<div class="gridFrm">
					<table id="ci-grid2"></table>
				</div>
			</div>
		</div>
		
		<div class="row" style="height:5%;">
			<div class="col-sm-12">
				<form id="sFrm">
					<div id="searchBtnSet" class="text-right">
						<button type="button" class="btn btn-sm btn-primary" onclick="fnAdd();">추가</button>
						<button type="button" class="btn btn-sm btn-success" onclick="fnSave();">적용</button>
						<button type="button" class="btn btn-sm btn-danger" onclick="fnDelete();">삭제</button>
						<button type="button" class="btn btn-sm btn-default" onclick="fnInit();">초기화</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script id="ci-grid-template" type="text/template">
    <table>
        <thead>
            <tr>
                <th width="95px" name="SygdSysCode"  	align="center" 	>설비구분코드</th>
				<th width="*" 	 name="SygdSysName" 	align="left" 	>설비구분명</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td name="SygdSysCode" bind="SygdSysCode"></td>
				<td name="SygdSysName" bind="SygdSysName"></td>
            </tr>
        </tbody>
    </table>
	</script>
	<!--dhpark 21.07.20 컬럼 헤더 순서 변경  -->
	<script id="ci-grid-template2" type="text/template">
	<table>
        <thead>
            <tr>
				<th 			  name="OpdmIdx" 		visibility="hidden" ></th>
                <th width="60px"  name="OpdmDispNo"     align="center"		>연번</th>
				<th width="80px"  name="OpdmOpcLvl"     align="left"   	>레벨</th>
				<th width="100px" name="OpdmDataGr"     align="center" 	>그룹</th>
				<th width="120px" name="OpdmGetLt"    	align="center" 	>용도</th>

				<th width="130px" name="OpdmOpcVar"     align="center" 	>수집항목</th>
				<th width="150px" name="OpdmOpcNm"      align="left" 		>수집항목명</th>
				<th width="130px" name="OpdmParVar"     align="center" 	>상위항목</th>

				<th width="80px" name="OpdmKvNm"        align="left" 		>KV</th>
				<th width="80px" name="OpdmSpcGrcd"     align="center" 	>SPC</th>
				
				<th width="80px"  name="OpdmVarUnit"    align="center" 	>단위</th>
				<th width="100px" name="OpdmVarType"    align="center" 	>타입</th>
				<th width="80px"  name="OpdmDecExp"     align="right" 		>소수점</th>

				<th width="150px" name="OpdmChartType"  align="center" 	>그래프</th>
				<th width="100px" name="OpdmXaxIDx"     align="center" 	>X축 IDX</th>

				<th width="120px" name="OpdmAxisPos"    align="center" 	>위치치정</th>
				<th width="80px"  name="OpdmClrType"    align="center" 	>지정색상</th>
				<th width="80px"  name="OpdmYax01Itv"   align="right" 		>Y1 Max</th>
				<th width="80px"  name="OpdmYax01Val"   align="right" 		>Y1 간격</th>
				<th width="80px"  name="OpdmYax02Itv"   align="right" 		>Y2 Max</th>
				<th width="80px"  name="OpdmYax02Val"   align="right" 		>Y2 간격</th>

				<th width="200px" name="OpdmRmks"    	align="left"		>설명</th>
            </tr>
        </thead>
        <tbody>
            <tr>
				<td name="OpdmIdx"       bind="OpdmIdx" 	  					></td>
                <td name="OpdmDispNo"    bind="OpdmDispNo"    class="edit-num not-null"	></td>
				<td name="OpdmOpcLvl"    bind="OpdmOpcLvl"    class="new-select not-null"  	data-mapper="systemCode" data-param="OpdmOpcLvl"		    ></td>
				<td name="OpdmDataGr"    bind="OpdmDataGr"    class="edit-select"    		data-mapper="systemCode" data-param="OpdmDataGr"		    ></td>
				<td name="OpdmGetLt"     bind="OpdmGetLt"     class="edit-select not-null" 	data-mapper="systemCode" data-param="OpdmGetLt"		    ></td>

				<td name="OpdmOpcVar"    bind="OpdmOpcVar"    class="new-text not-null"	></td>
                <td name="OpdmOpcNm"     bind="OpdmOpcNm"     class="edit-text not-null"></td>
				<td name="OpdmParVar"    bind="OpdmParVar"    class="edit-select"         	data-mapper="getTopList" data-param="99" data-gubn="opcv01"></td>

				<td name="OpdmKvNm"      bind="OpdmKvNm"      class="edit-text"			></td>
				<td name="OpdmSpcGrcd"   bind="OpdmSpcGrcd"   class="edit-select"    	    data-mapper="systemCode" data-param="SPC_APL_LT"			></td>

                <td name="OpdmVarUnit"   bind="OpdmVarUnit"   class="edit-select"    	    data-mapper="systemCode" data-param="OPC_VAR_UNIT"			></td>
                <td name="OpdmVarType"   bind="OpdmVarType"   class="edit-select"    		data-mapper="systemCode" data-param="OPC_VAR_TYPE"	        ></td>
				<td name="OpdmDecExp"    bind="OpdmDecExp"    class="edit-num"			></td>

				<td name="OpdmChartType" bind="OpdmChartType" class="edit-select"    		 data-mapper="systemCode" data-param="OPC_CHART_TYPE"	    ></td>

				<td name="OpdmXaxIDx" 	 bind="OpdmXaxIDx"    class="edit-select"    		 data-mapper="getChildList" data-gubn="opcv01"></td>

				<td name="OpdmAxisPos"   bind="OpdmAxisPos"   class="edit-select"        	 data-mapper="systemCode" data-param="OPC_AXIS_POS"			></td>
				<td name="OpdmClrType"   bind="OpdmClrType"   class="edit-color"			></td>
		    	<td name="OpdmYax01Itv"  bind="OpdmYax01Itv"  class="edit-num"			></td>
				<td name="OpdmYax01Val"  bind="OpdmYax01Val"  class="edit-num"			></td>
				<td name="OpdmYax02Itv"  bind="OpdmYax02Itv"  class="edit-num"			></td>
				<td name="OpdmYax02Val"  bind="OpdmYax02Val"  class="edit-num"			></td>
				
				<td name="OpdmRmks"       bind="OpdmRmks"     class="edit-text"			></td>
            </tr>
        </tbody>
    </table>
	</script>
	<script type="text/javascript">

    var tableOne = $('#ci-grid');
	var templateOne = $('#ci-grid-template');
	var gridOne = webponent.grid.init(tableOne, templateOne);

	var tableTwo = $('#ci-grid2');
	var templateTwo = $('#ci-grid-template2');
	var gridTwo = webponent.grid.init(tableTwo, templateTwo);

	$(document).ready(function(){
		
// 		fnSelectBox("systemCode","EQMT_TYPE","전체", "#GUBN");
		
	});

	function search(){

		var formData = $("#sFrm").serializeObject();
		
		$.ajax({
			dataType : 'json',
			type : 'GET',
			data : formData,
			url  : '/OPDM/getList',
			contentType : 'application/json; charset=UTF-8',
			success : function(data){
				gridOne.removeRow();
				gridOne.appendRow(data.list);
			},
			error: function (error){
				 alert("에러");
			}

		
		});
		return false;
	} 

	$(gridOne.markup.main.body.tbody).on("click", "tr", function(e){
    	var input = $(this);
        var $tr = input.closest('tr');
        var tr = $tr[0];
        var rowData = tr.data;
        
        selectItem = rowData.SygdSysCode;
        
        $("#subItem").text(" - "+ rowData.SygdSysCode);
        console.log("얍얍");      
        $.ajax({
			dataType : 'json',
			type : 'GET',
			data : rowData,
			url  : '/OPDM/subList',
			contentType : 'application/json; charset=UTF-8',
			success : function(data){
		        console.log("얍얍얍얍");      
				console.log(data.list);
				gridTwo.removeRow();
				gridTwo.appendRow(data.list);
				var vGridRow = gridTwo.getRow();

				for(var i=0; i<vGridRow.length; i++){
					var vTxt = $(vGridRow[i]).find("[data-name=OpdmOpcLvl]").text()
					if(vTxt=="LVL1"){vTxt = ".." + vTxt;}
					if(vTxt=="LVL2"){vTxt = "...." + vTxt;}
					if(vTxt=="LVL3"){vTxt = "......" + vTxt;}
					$(vGridRow[i]).find("[data-name=OpdmOpcLvl]").text(vTxt)
				}
				
		        $("#grid2Cnt").text("전체 : " + comma(gridTwo.data.length) + "건");
				
			},
			error: function (error){
				 alert("에러");
			}

		
		});
		return false;
		

        
	});

	$(gridTwo.markup.main.body.tbody).on("change", "select", function(e){
    	var input = $(this);
        var $tr = input.closest('tr');
        var tr = $tr[0];
        var rowData = tr.data;
        
		if($(this).attr("name")=="OpdmOpcLvl"){
			$(this).closest("tr").find("[data-name=OpdmParVar]").empty();
			var vStr = "";
			vStr += '<select name="OpdmParVar">';				

		    vStr += fnGetOptions("getTopList", $(this).val(), "선택", "opcv01", rowData);
		    
		    vStr += '</select>';
		    $(this).closest("tr").find("[data-name=OpdmParVar]").append(vStr);
		}
	});

	function fnAdd(){
		
		var newRow = [];
		var newRowData = {}; 

		if(selectItem==""){
			alert("추가할 설비를 선택하여 주십시오.");
			return;
		}
		
		newRowData["ROW_STATUS"] = "N";				//로우 상태 값
		newRowData["OpdmIdx"] = guid();
		newRowData["ODM_EQMT_TYPE"] = selectItem;	//시스템코드 값
        newRowData["OpdmDispNo"] = " ";
        newRowData["OpdmOpcVar"] = " ";
        newRowData["OpdmParVar"] = " ";
		newRowData["OpdmOpcLvl"] = " ";  
        newRowData["OpdmOpcNm"] = " ";
        newRowData["OpdmDataGr"] = " ";
        newRowData["OpdmChartType"] = " ";
        newRowData["OpdmXaxIDx"] = " ";
        newRowData["OpdmVarType"] = " "; 
		newRowData["OpdmDecExp"] = " ";  
        newRowData["OpdmVarUnit"] = " ";
		newRowData["OpdmRmks"] = " ";     
		newRowData["OpdmYax01Val"] = " ";
		newRowData["OpdmYax01Itv"] = " ";
		newRowData["OpdmYax02Val"] = " ";
		newRowData["OpdmYax02Itv"] = " ";
		newRowData["OpdmAxisPos"] = " ";
		newRowData["OpdmClrType"] = " ";
		newRowData["OpdmGetLt"] = " ";
		newRowData["OpdmKvNm"] = " ";
		newRowData["OpdmSpcGrcd"] = " ";
		
		newRow.push(newRowData); 

		gridTwo.prependRow(newRow);
	}
	
	</script>
</body>
</html>