<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/header.jsp" %>
<style type="text/css">
td.has-error {background: #f2dede;}R
.selectBack > option {background: #e6eeff;}

select.selectBack{
    -webkit-appearance: none;
    appearance: none;
    background: url(/resources/images/selectbox2.png) 100% 50% no-repeat !important;
    background-size: 25px !important;
    background-color: #e6eeff !important;
}
.editTable > thead > tr > th, .editTable > tbody > tr > th, .editTable > tfoot > tr > th, .editTable > thead > tr > td, .editTable > tbody > tr > td, .table > tfoot > tr > td{
	padding-top: 3px;
	padding-bottom: 3px;
	padding-right: 10px;
	padding-left: 10px;
	vertical-align: middle;
    line-height: 1.42857143;
    border-top: 1px solid #ddd;
}

div.no_image{
	margin: 0 auto;
	width:140px;
	height:140px;
}
</style>
<meta charset="UTF-8">
<title>설비현황관리</title>
</head>
<body>
	<div class="container-fluid">  <!-- 상단 <조건부 검색> -->
		<form id="aFrm">
			<dl class="dl-layout" id="searchSet" style="margin-bottom:10px;">
				<dt>
					<label class="control-label col-sm-1">설비명</label>
				</dt>
				<dd style="width:22%;">
					<div class="form-inline">
						<input type="text" class="form-control input-sm autoComplete" id="Search_Mch_Name" name="Search_Mch_Name" placeholder="설비명" style="width:50%">
						<input type="text"  class="form-control input-sm" id="Search_Mch_Code" name="Search_Mch_Code"placeholder="설비코드" style="width:50%">
					</div>
				</dd>
								
				<dt>
					<label class="control-label col-sm-1">형식규격</label>
				</dt>
				<dd style="width:17%;">
					<input type="text" id="Search_Type_Desc" name="Search_Type_Desc" placeholder="형식규격">
				</dd>
				<dt>
					<label class="control-label col-sm-1">설치장소</label>
				</dt>
				<dd style="width:17%;">
					<input type="text" id="Search_Inst_Wkctr" name="Search_Inst_Wkctr" placeholder="설치장소">
				</dd>
				<dt>
					<label class="control-label col-sm-1">구입일자</label>
				</dt>
				<dd style="width:20%;">
					<div class="form-inline">
						<input type="text" class="form-control input-sm datePicker searchDate" id="Search_Purc_Date_From" name="Search_Purc_Date_From" placeholder="FROM : YYYY-MM-DD" style="width:48%;">
						~
						<input type="text" class="form-control input-sm datePicker searchDate" id="Search_Purc_Date_To" name="Search_Purc_Date_To" placeholder="TO : YYYY-MM-DD" style="width:48%;">
					</div>
				</dd>
			</dl>
			<div class="text-right">
				<button type="submit" class="btn btn-sm btn-primary">조회</button>
				<button type="button" class="btn btn-sm btn-success">엑셀</button>
				<button type="button" class="btn btn-sm btn-default" onclick="init();">초기화</button>
			</div>
		</form>
		  <!-- 중단 <현황판>-->
		<div>
			<p id="sub_title">
				설비등록 현황
			</p>
				<table id="grid-table-1"></table>

			<script id="grid-template-1" type="text/template">
				<table width="100%" height="350px">
					<thead>
						<tr>
							<th name="EqmnMchCode" 	align="center" width="100px">설비번호</th>
							<th name="EqmnWkflGrcdDesc" align="center" width="150px">설비 Work 그룹</th>
							<th name="EqmnWkflOdr" 	align="center" width="150px">설비 공정 순서</th>
							<th name="EqmnMchName" 	align="center" width="150px">설비명</th>
							<th name="EqmnTypeDesc" align="center" width="150px">형식/규격</th>
							<th name="EqmnMafaNbr" 	align="center" width="150px">제조번호</th>
							<th name="EqmnMafaName" align="center" width="150px">제조자명</th>
							<th name="EqmnPurcDate" align="center" width="150px">구입일자</th>
							<th name="EqmnInstWkctr"align="center" width="150px">설치장소</th>
							<th name="EqmnMchMngr" 	align="center" width="150px">관리자</th>
							<th name="EqmnMchPrc" 	align="right"  width="150px">구입가격</th>
							<th name="EqmnMchStsDesc" 	align="center" width="170px">상태</th>
							<th name="EqmnSpecDesc" align="center" width="150px">설비사양</th>
							<th name="EqmnPartDesc" align="center" width="150px">부속품</th>
							<th name="EqmnFileNm" 	align="center" width="150px" >파일명</th>		
						</tr>
					</thead>
					<tbody>
						<tr>
							<td name="EqmnMchCode" bind="EqmnMchCode" ></td>
							<td name="EqmnWkflGrcdDesc" bind="EqmnWkflGrcdDesc" ></th>
							<th name="EqmnWkflOdr" bind="EqmnWkflOdr"></th>
							<td name="EqmnMchName" bind="EqmnMchName" ></td>
							<td name="EqmnTypeDesc" bind="EqmnTypeDesc" ></td>
							<td name="EqmnMafaNbr" bind="EqmnMafaNbr" ></td>
							<td name="EqmnMafaName" bind="EqmnMafaName" ></td>
							<td name="EqmnPurcDate" bind="EqmnPurcDate" ></td>
							<td name="EqmnInstWkctr" bind="EqmnInstWkctr" ></td>
							<td name="EqmnMchMngr" bind="EqmnMchMngr" ></td>
							<td name="EqmnMchPrc" bind="EqmnMchPrc" ></td>
							<td name="EqmnMchStsDesc" bind="EqmnMchStsDesc" ></td>
							<td name="EqmnSpecDesc" bind="EqmnSpecDesc"></td>
							<td name="EqmnPartDesc" bind="EqmnPartDesc"></td>
							<td name="EqmnFileNm" bind="EqmnFileNm"></td>					
						</tr>
					</tbody>
				</table>
			</script>
			<div id="gridBtnSet">
				<button type="button" class="btn btn-sm btn-default">선택출력</button>
				<button type="button" class="btn btn-sm btn-danger">선택삭제</button>
			</div>
		</div>
		<form id="editFrm">
			<input type="hidden" id="GUBN" name="GUBN">
				<div class="panel panel-primary"  style="margin-top:45px; width:100%;">
					<div class="panel-heading" role="tab" id="headingTwo"  style="padding: 6px 15px;">
						설비등록사항
						<span class="pull-right">
							<a class="collapseBtn" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo" style="color:#fff">
								<i class="fas fa-angle-up"></i>
							</a>
						</span>
					</div>
					<div id="collapseTwo" class="panel-collapse collapse in collapse_frm" role="tabpanel" aria-labelledby="headingTwo">
						<table class="editTable" style="width: 100%;">
							<colgroup>
								<col width="8%"><col width="17%"><col width="8%"><col width="17%"><col width="8%"><col width="17%"><col width="8%"><col width="25%">
							</colgroup>
							<tbody>
								<tr>
									<th class="text-right">설비번호</th>
									<td class="data_column" >
										<input type="text" class="form-control input-sm txtedit2 required" required="required" id="EqmnMchCode" name="EqmnMchCode" style="width:250px;"></input>	
									</td>
									<th class="text-right">설비명</th>
									<td class="data_column" >
										<input type="text" class="form-control input-sm txtedit required" required="required" id="EqmnMchName" name="EqmnMchName" style="width:250px;"></input>
									</td>
									<th class="text-right">형식/규격</th>
									<td class="data_column">
										<input type="text" class="form-control input-sm txtedit required" required="required" id="EqmnTypeDesc" name="EqmnTypeDesc" style="width:250px;"></input>	
									</td>
									<th class="text-right">첨부파일</th>
									<td class="data_column">
										<div id="down">없음</div>
									</td>
								</tr>
								<tr>
									<th class="text-right">제조자명</th>
									<td class="data_column">
										<input type="text" class="form-control input-sm txtedit" id="EqmnMafaName" name="EqmnMafaName" style="width:250px; "></input>	
									</td>
									<th class="text-right">제조번호</th>
									<td class="data_column" >
										<input type="text" class="form-control input-sm txtedit" id="EqmnMafaNbr" name="EqmnMafaNbr" style="width:250px; "></input>	
									</td>
									<th class="text-right">구입일자</th>
									<td class="data_column" >
										<input type="text" class="form-control input-sm datePicker searchDate txtedit" id="EqmnPurcDate" name="EqmnPurcDate" maxlength="20" placeholder="YYYY-MM-DD" style="width:250px;">	
									</td>
									<th class="text-center" colspan="2">첨부된 이미지</th>
								</tr>
								<tr>
									<th class="text-right">설치장소</th>
									<td class="data_column">
										<div class="form-inline">
										<input type="text" class="form-control input-sm autoComplete txtedit" id="EqmnInstWkctr" name="EqmnInstWkctr" maxlength="20" style="width:250px;" placeholder="설치장소">
<!-- 										<input type="hidden" id="EMM_WKCTR_CODE" name="EMM_WKCTR_CODE"> -->
									</div>
									</td>
									<th class="text-right">관리자</th>
									<td class="data_column">
										<div class="form-inline">
											<input type="text" class="form-control input-sm autoComplete txtedit" id="EqmnMchMngr" name="EqmnMchMngr" maxlength="20" style="width:250px;" placeholder="성명">
										</div>
									</td>
									<th class="text-right">구입가격</th>
									<td class="data_column">
										<div class="form-inline">
											<input type="text" class="form-control input-sm numberFormat txtedit" id="EqmnMchPrc" name="EqmnMchPrc" style="width:225px; text-align: right;"></input><span style="font-weight: bold; margin-left: 7px;">원</span>
										</div>
									</td>
									<td rowspan="4" colspan="2" style="text-align: center;">
										<div id="imgThumbnail">
											<div class="no_image"></div>
										</div>
										<input type="hidden" id="EqmnimgPath" name="EqmnimgPath">
									</td>
								</tr>
								<tr>
									<th class="text-right">OPC서버</th>
									<td class="data_column">
										<input type="text" class="form-control input-sm txtedit" id="EqmnOpcSrv" name="EqmnOpcSrv" style="width:250px; "></input>	
									</td>
									<th class="text-right">OPC 폴더</th>
									<td class="data_column">
										<input type="text" class="form-control input-sm txtedit" id="EqmnOpcFld" name="EqmnOpcFld" style="width:250px; "></input>	
									</td>
									<th class="text-right">설비종류(구분)</th>
									<td class="data_column">
										<select class="form-control input-sm txtedit" id="EqmnEqmtType" name="EqmnEqmtType" style="width:250px;"><option value="">선택</option></select>	
									</td>
								</tr>
								<tr>
									<th class="text-right">설비 Work 그룹</th>
									<td class="data_column">
										<select class="form-control input-sm txtedit selectBack" id="EqmnWkflGrcd" name="EqmnWkflGrcd" style="width:250px;"><option value="">선택</option></select>	
									</td>
									<th class="text-right">설비 공정 순서</th>
									<td class="data_column">
										<input type="text" class="form-control input-sm txtedit" id="EqmnWkflOdr" name="EqmnWkflOdr" style="width:250px; "></input>	
									</td>
									<th class="text-right">UPH(UPEH)</th>
									<td class="data_column">
										<input type="text" class="form-control input-sm txtedit" id="EqmnMchUph" name="EqmnMchUph" style="width:250px; "></input>	
									</td>
								</tr>
								<tr>
									<th class="text-right">상태</th>
									<td class="data_column">
										<select class="form-control input-sm txtedit selectBack" id="EqmnMchSts" name="EqmnMchSts" style="width:250px;"><option value="">선택</option></select>		
									</td>
									<th class="text-right" >이미지 파일선택</th>
									<td class="data_column">
										<input type="file" class="txtedit" id="uploadFile" name="uploadFile" />
									</td>
									<th class="text-right">첨부파일선택</th>
									<td class="data_column">
										<input type="file" class="txtedit" id="uploadFile2" name="uploadFile2" />
										<input type="hidden" id="EqmnFilePath" name="EqmnFilePath">
									</td>
								</tr>
								<tr>
									<th class="text-right" >설비사양</th>
									<td class="data_column" >
										<textarea class="form-control input-sm txtedit" rows="2" style="overflow-y:none; width:250px;" id="EqmnSpecDesc" name="EqmnSpecDesc" maxlength="500"></textarea>		
									</td>
									<th class="text-right">부속품</th>
									<td class="data_column" colspan="3">
										<textarea class="form-control input-sm txtedit" rows="2" style="overflow-y:none; width:650px;" id="EqmnPartDesc" name="EqmnPartDesc" maxlength="500"></textarea>		
									</td>
								</tr>
							</tbody>
						</table>
						<div id="editBtnSet" style="margin-top:5px;  float:right;">
								<button type="button" id="btnRegMt" class="btn btn-sm btn-primary">신규</button>
								<button type="button" id="btnSaveMt" class="btn btn-sm btn-primary">변경</button>
								<button type="button" id="btnsendMt" class="btn btn-sm btn-success">저장</button>
								<button type="button" id="btnDelMt" class="btn btn-sm btn-danger">삭제</button>
								<button type="button" id="btnCanMt" class="btn btn-sm btn-danger">취소</button>
						</div>	
					</div>
				</div>
			</form>		
		</div>
<script type="text/javascript">
	var totalAmount = 0;
	var selectItem = "";
	var selectItemNm = "";
	var editMode = "";
	var edit = false;

    var tableOne = $('#grid-table-1');
	var templateOne = $('#grid-template-1');
	var gridOne = webponent.grid.init(tableOne, templateOne);

	$(document).ready(function(){
		
		init();
// 		resize();
	});
	
	//설비현황 조회
	$(document).on("submit","#aFrm",function(){
		var afrmData = $("#aFrm").serializeObject();

		$.ajax({
			dataType : 'json',
			type :	'POST',
			data : JSON.stringify(afrmData),
			url :	'/EQMM/getList',
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
	});

	//초기화 버튼 기능
	function init(){

		fnSelectBox("systemCode","EQMT_STS","#EqmnMchSts","선택");			//상태
		fnSelectBox("systemCode","EQMT_TYPE","#EqmnEqmtType","선택");			//설비종류(종류)
		fnSelectBox("systemCode","EMM_WKFL_GRCD","#EqmnWkflGrcd","선택");		// 설비 work 그룹
		
		inputMode(true);//쓰기모드 잠금
		clearData();	//하단 쓰기 초기화
		btnFlag(true,false,false,false,false);//버튼 제어  (신규, 저장, 변경, 취소, 삭제)
		
	}
	
	function clearData(){
        $(".txtedit").val("");
        $(".txtedit2").val("");
        $(".notedit").val("");
        $("#imgThumbnail").html('<div class="no_image"></div>');
	}
	
	function inputMode(flag){
		console.log("인풋모드 : "+flag);
		if(flag==false){ // 1. 플래그가 false일 때 
			if(editMode=="NEW"){ // 1-1. editMode가 NEW라면(신규)
				$(".txtedit").attr("disabled", flag); //
				$(".txtedit2").attr("disabled", flag);	
			}else{ // 1-2. editMode가 NEW가 아니라면(변경)
// 				$(".txtedit").attr("disabled", flag);		잠시만 고정
			}
		}else{ // 2. 플래그가 false가 아닐 때(true)
			$(".txtedit").attr("disabled", flag); 
			$(".txtedit2").attr("disabled", flag);
		}
	}
		
	//윈도우 사이즈 조절 
	function resize(){
	    var height = $(window).height();
	    var searchSetHeight = $("#searchSet").height();
	    var editFrmHeight = $("#editFrm").height();
	    var subTitle = $("#sub_title").height();
	    var gridBtnSet = $("#gridBtnSet").height();
	    var editBtnSet = $("#editBtnSet").height();
	    var etc = 90;
	    
	    var gridHeight = height - searchSetHeight - editFrmHeight - subTitle - gridBtnSet - editBtnSet - etc;
	    		    
	    gridOne.setGridHeight(gridHeight);				    
	}

	$("#btnsendMt").on("click",function(){

		var result = confirm('저장 하시겠습니까?');
		if(!result)return;
		save();
	});
	//설비 등록
	function save(){
		$("#GUBN").val(editMode);

		var frm = $("#editFrm")[0];
		var formData = new FormData(frm);
		formData.EqmnMchCode = $("#EqmnMchCode").val();
		
		var afrmData = $("#editFrm").serializeObject();

		
		$.ajax({
			url : '/EQMM/update',
			cache: false,		
			data: formData,
			type: "post",
			dataType: "json",
			processData: false,
			contentType: false,
			success: function(data) {
				if(data.code!="ERR"){
					alert("오류가 아닐경우");
					alert(data.list.message);
					if(editMode == "DEL"){
						editMode = ""; 
						edit = false;
						inputMode(true);	
						clearData();
						btnFlag(true, false, false, false, false);
						search(false);					
					}else{
						editMode = ""; 
						edit = false;
						inputMode(true);	
						btnFlag(true, true, false, true, false);
						search(false);
					}
				}
				if(data.code == "ERR"){
					alert("오류 일경우");
					alert(data.message);
				}
			}
		})		
	}

	function btnFlag(btnNew, btnUpdate, btnSend, btnDel, btnCan){
		if(btnNew==false){$("#btnRegMt").addClass("hidden");}else{$("#btnRegMt").removeClass("hidden");}
		if(btnCan==false){$("#btnCanMt").addClass("hidden");}else{$("#btnCanMt").removeClass("hidden");}
		if(btnUpdate==false){$("#btnSaveMt").addClass("hidden");}else{$("#btnSaveMt").removeClass("hidden");}
		if(btnSend==false){$("#btnsendMt").addClass("hidden");}else{$("#btnsendMt").removeClass("hidden");}
		if(btnDel==false){$("#btnDelMt").addClass("hidden");}else{$("#btnDelMt").removeClass("hidden");}
	}




	//데이터 변경 
	$(gridOne.markup.main.body.tbody).on("click", "tr", function(e){
    	var input = $(this);
        var $tr = input.closest('tr');
        var tr = $tr[0];
        var rowIndex = tr.index;
        var rowData = tr.data;
		var result;
        editMode="SAVE";

        if(edit==true){
        	result = confirm("변경중인 데이터가 있습니다. \n저장하고 이동하시겠습니까?");
        }
        
        if(result){save();}
        
        edit = false;
        inputMode(true);
        btnFlag(true, true, false, true, false);

    	$("#EqmnMchCode").val(rowData.EqmnMchCode);		//설비번호
    	$("#EqmnMchName").val(rowData.EqmnMchName);		//설비명
    	$("#EqmnTypeDesc").val(rowData.EqmnTypeDesc);	//형식/규격
    	$("#EqmnMafaName").val(rowData.EqmnMafaName);	//제조자명
    	$("#EqmnMafaNbr").val(rowData.EqmnMafaNbr);		//제조번호
    	$("#EqmnPurcDate").val(rowData.EqmnPurcDate);	//구입일자
    	$("#EqmnInstWkctr").val(rowData.EqmnInstWkctr);	//설치장소
    	$("#EqmnMchMngr").val(rowData.EqmnMchMngr);		//관리자
    	$("#EqmnMchPrc").val(rowData.EqmnMchPrc);		//구입가격
    	$("#EqmnOpcSrv").val(rowData.EqmnOpcSrv);		//opc서버
    	$("#EqmnOpcFld").val(rowData.EqmnOpcFld);		//opc폴더
    	$("#EqmnimgPath").val(rowData.EqmnimgPath);  	//이미지 경로
    	$("#EqmnFilePath").val(rowData.EqmnFilePath);	//파일 경로  	
    	$("#EqmnEqmtType").val(rowData.EqmnEqmtType).prop("selected", true);	//설비종류
    	$("#EqmnWkflGrcd").val(rowData.EqmnWkflGrcd).prop("selected", true);	//설비 work 그룹
    	$("#EqmnWkflOdr").val(rowData.EqmnWkflOdr);		//설비 공정순서
    	$("#EqmnMchUph").val(rowData.EqmnMchUph);		//UPH
    	$("#EqmnMchSts").val(rowData.EqmnMchSts).prop("selected", true); 		//상태
    	$("#EqmnSpecDesc").val(rowData.EqmnSpecDesc);	//설비사양
    	$("#EqmnPartDesc").val(rowData.EqmnPartDesc);	//부속품
    	$("#down").html(rowData.EqmnFileNm);
    	$("#uploadFile").val("");
    	$("#uploadFile2").val("");
    	
    	var imgTag = "";
    	
    	if(!isEmpty(rowData.EqmnimgPath)) {
    		
    		imgTag = '<img src="${path}/utils/displayFile?fileName='+rowData.EqmnimgPath+'"style="margin:0px; width: 300px; height:155px;" alt="이미지">';
    	} 
    	else {
    		
    		imgTag = '<div class="no_image"></div>';
    	}
    	var fileTag = "";
    	if(!isEmpty(rowData.EqmnFileNm)){
    		$("#down").html(rowData.EqmnFileNm + " <a class='btn btn-xs btn-primary' href='${path}/utils/download?fileName="+rowData.EqmnFilePath +"' title='"+rowData.EqmnFileNm+"' role='button'>다운로드</a>");
        }
    	else{
    		$("#down").html("없음");
        }
    	$("#imgThumbnail").html(imgTag);
	});


	//버튼 기능 구현
	
	//신규버튼
			$("#btnRegMt").on("click", function(){
				var result = true;
				
				if(edit==true){
					result = confirm("입력중인 데이터가 있습니다. \n새로 진행 하시겠습니까?");
				}
				
				if(result){
					editMode = "NEW";		
					edit = true;
					inputMode(false);
					
					$("#EqmnMchCode").val("");
					$("#EqmnMchName").val("");
					$("#EqmnTypeDesc").val("");
					$("#EqmnMafaName").val("");
					$("#EqmnMafaNbr").val("");
					$("#EqmnPurcDate").val("");
					$("#EqmnMchMngr").val("");
					$("#EqmnMchPrc").val(0);
			    	$("#EqmnWkflOdr").val("");
			    	$("#EqmnOpcSrv").val("");
			    	$("#EqmnOpcFld").val("");
					$("#EqmnSpecDesc").val("");
					$("#EqmnPartDesc").val("");
					$("#EqmnMchSts").val("OP");
					$("#EqmnimgPath").val("");
					$("#EqmnFilePath").val("");
					$("#uploadFile").val("");
					$("#uploadFile2").val("");
					$("#imgThumbnail").html('<div class="no_image"></div>');
					$("#down").html("없음");
					
					//21-12-16 kmy
					//설비 WORK-GROUP 추가항목
					$("#EMM_WKFL_GRCD").val("NA");
					$("#EMM_WKFL_ODR").val(0); 	
					btnFlag(false, false, true, false, true);
				}
			});

			//취소 버튼
			$("#btnCanMt").on("click", function(){
				var result = confirm('입력 작업을 취소 하시겠습니까?');
				
				if(result){
					inputMode(true);
					edit=false;
					clearData();
					$("#imgThumbnail").html('<div class="no_image"></div>');
					btnFlag(true,false,false,false,false);
				}
			});	

			//삭제
			$("#btnDelMt").on("click", function(){
				editMode = "DEL";		
				
				var result = confirm('삭제 하시겠습니까?');
				if(!result) return;
				inputMode(false);
				save();
				
			});

			//변경 버튼
			$("#btnSaveMt").on("click",function(){ 
				inputMode(false);
				edit=true;
				btnFlag(false, false, true, false, true);
			});

			//파일 경로 이벤트
			 $("#uploadFile").change(function() {
			    	$("#imgThumbnail").html("");
			        readURL(this);
			    });
				
				function readURL(input) {
			        if (input.files && input.files[0]) {
			            var reader = new FileReader();
			            reader.onload = function(e) {
			            	$("#imgThumbnail").parent().css('padding', '0');
			            	$("#imgThumbnail").append("	<img id ='view' style='width:390px; height:190px;' src='"+ e.target.result +"'>");
			            }
			            reader.readAsDataURL(input.files[0]);
			     }
		     }
</script>
</body>
</html>