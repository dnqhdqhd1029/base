<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/header.jsp"%>
<meta charset="UTF-8">
<title>작업장 관리</title>
<script type="text/javascript">

var status;
$(document).ready(function(){

	btnFlag(true,false,false,false,false); //버튼 제어  (신규, 저장, 변경, 취소, 삭제)
	
	draw();
	
	//신규버튼
	$("#btnRegMt").on("click", function(){
		status = 'Insert';
		var result = true;
		
		if(edit==true){
			result = confirm("입력중인 데이터가 있습니다. \n새로 진행 하시겠습니까?");
		}
		
		if(result){
			editMode = "NEW";		
			edit = true;
			inputMode(false);
			
			$("#WkpmWkctrCd").val("");	
            $("#WkpmMchCd").val("");	
            $("#WkpmCorpCd").val("");	
            $("#WkpmBsnsCd").val("");	
            $("#WkpmWkctrNm").val("");	
            $("#WkpmDesc").val("");	
            $("#WkpmDeptCd").val("");
            $("#WkpmWkLoc").val("");
            $("#WkpmMsCode").val("");
		
			btnFlag(false, false, true, false, true);
		}
			
	});
	
	//저장버튼
	$(document).on("click","#btnsendMt",function(){
		var result = confirm('저장 하시겠습니까?');
		
		if(!result) return;
		
		save();
	})
	

	//변경버튼클릭시 이벤트
	$(document).on("click","#btnSaveMt",function(){
		status = 'Update';
		inputMode(false);
		edit=true;
		btnFlag(false, false, true, false, true);
	})
	
	//취소버튼
	$(document).on("click","#btnCanMt", function(){
		var result = confirm('입력 작업을 취소 하시겠습니까?');
		
		if(result){
			inputMode(true);
			edit=false;
			clearData();
			btnFlag(true,false,false,false,false);
		} 
	});
	
	//선택삭제
	$("#btnDelAll").on("click", function(){
		let data = grid.getSelectedRowData();
		if(confirm("선택된 데이터를 삭제하시겠습니까?")){
			let jsonData = JSON.stringify(data[0])
			
			$.ajax({
				cache : false,
				url : '/wkpmDelete',
				data : jsonData,
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				success : function(resp) {
					if(resp.result == 1){
						alert("데이터가 삭게되었습니다.");
					}
					draw();
				},
				error : function(error, status, msg) {
					alert("상태코드 " + status + "에러메시지" + msg);
				}
			});
		}
	});
	
	//로우 클릭시 발생하는 이벤트
	$(grid.markup.main.body.tbody).on("click", "tr", function(e){
    	var input = $(this);
        var $tr = input.closest('tr');
        var tr = $tr[0];
        var rowIndex = tr.index;
        var rowData = tr.data;
		var result;
		
		if(edit==true){
        	result = confirm("변경중인 데이터가 있습니다. \n저장하고 이동하시겠습니까?");
        }
        
        
        edit = false;
        inputMode(true);
        btnFlag(true, true, false, true, false);
        

        $("#WkpmIdx").val(rowData.WkpmIdx)
        $("#WkpmWkctrCd").val(rowData.WkpmWkctrCd)	
      	$("#WkpmMchCd").val(rowData.WkpmMchCd)
        $("#WkpmCorpCd").val(rowData.WkpmCorpCd)
        $("#WkpmBsnsCd").val(rowData.WkpmBsnsCd)
        $("#WkpmWkctrNm").val(rowData.WkpmWkctrNm)
        $("#WkpmDesc").val(rowData.WkpmDesc),	
        $("#WkpmDeptCd").val(rowData.WkpmDeptCd)
        $("#WkpmWkLoc").val(rowData.WkpmWkLoc)
        $("#WkpmMsCode").val(rowData.WkpmMsCode)
        $("#WkpmIsUse").val(rowData.WkpmIsUse)
        $("#WkpmRegUser").val(rowData.WkpmRegUser)
        $("#WkpmAllocMp01").val(rowData.WkpmAllocMp01)
        $("#WkpmAllocMp02").val(rowData.WkpmAllocMp02)
        $("#WkpmAllocMp03").val(rowData.WkpmAllocMp03)
        $("#WkpmAllocMp04").val(rowData.WkpmAllocMp04)
        $("#WkpmAllocMp05").val(rowData.WkpmAllocMp05)
        $("#WkpmRegDate").val(rowData.WkpmRegDate)
        $("#WkpmRegUser").val(rowData.WkpmRegUser)
        $("#WkpmModDate").val(rowData.WkpmModDate)
        $("#WkpmModUser").val(rowData.WkpmModUser)

        
	});
})
	
	
	var totalAmount = 0;
	var selectItem = "";
	var selectItemNm = "";
	var editMode = "";
	var edit = false;


	// 버튼 보여짐유무
	function btnFlag(btnNew, btnUpdate, btnSend, btnDel, btnCan){
		if(btnNew==false){$("#btnRegMt").addClass("hidden");}else{$("#btnRegMt").removeClass("hidden");}
		if(btnCan==false){$("#btnCanMt").addClass("hidden");}else{$("#btnCanMt").removeClass("hidden");}
		if(btnUpdate==false){$("#btnSaveMt").addClass("hidden");}else{$("#btnSaveMt").removeClass("hidden");}
		if(btnSend==false){$("#btnsendMt").addClass("hidden");}else{$("#btnsendMt").removeClass("hidden");}
		if(btnDel==false){$("#btnDelMt").addClass("hidden");}else{$("#btnDelMt").removeClass("hidden");}
	}
	
	
	function inputMode(flag){
		if(flag==false){
			if(editMode=="NEW"){
				$(".txtedit").attr("disabled", flag);
				$(".txtedit2").attr("disabled", flag);	
			}else{
				$(".txtedit").attr("disabled", flag);
			}
		}else{
			$(".txtedit").attr("disabled", flag);
			$(".txtedit2").attr("disabled", flag);
		}
	}
	
	//하단 데이터 초기화
	function clearData(){
	    $(".txtedit").val("");
	    $(".txtedit2").val("");
	    $(".notedit").val("");
	}
	
	
	//저장기능 구현 메소드
	
	function save(){
		
		/* if($("#WkpmWkctrCd").val()==""){alert("작업장코드는 필수입력사항 입니다."); $("#WkpmWkctrCd").focus(); return;}
		if($("#WkpmMchCd").val()==""){alert("기계 설비는 필수입력사항 입니다."); $("#WkpmMchCd").focus(); return;}
		if($("#WkpmCorpCd").val()==""){alert("법인 구분코드는 필수입력사항 입니다."); $("#WkpmCorpCd").focus(); return;}
		if($("#WkpmBsnsCdWkpmBsnsCd").val()==""){alert("사업장 구분코드는 필수입력사항 입니다."); $("#WkpmBsnsCdWkpmBsnsCd").focus(); return;}
		if($("#WkpmWkctrNm").val()==""){alert("작업장 명칭은 필수입력사항 입니다."); $("#WkpmWkctrNm").focus(); return;}
		if($("#WkpmDeptCd").val()==""){alert("작업장 부서코드는 필수입력사항 입니다."); $("#WkpmDeptCd").focus(); return;}
		if($("#WkpmMsCode").val()==""){alert("사내외주 구분코드는 필수입력사항 입니다."); $("#WkpmMsCode").focus(); return;}
		if($("#WkpmDesc").val()==""){alert("작업장 설명은 필수입력사항 입니다."); $("#WkpmDesc").focus(); return;} */

		var formData = $("#editFrm").serializeObject();
		
		$.ajax({
			cache : false,
			url : '/wkpm'+status,
			data : JSON.stringify(formData),
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			success : function(resp) {
				btnFlag(true,false,false,false,false); //버튼 제어  (신규, 저장, 변경, 취소, 삭제)
				draw();
			},
			error : function(error, status, msg) {
				console.log("상태코드 " + status + "에러메시지" + msg);
			}
		});
		
	}
	
	
</script>
</head>
<body>

	<div class="container-fluid">
		<form id="sFrm">

			<input type="hidden" id="popMode">

			<dl class="dl-layout four" id="searchSet"
				style="margin-bottom: 10px;">
				<dt>
					<label for="IBM_ITEM_DESC" class="control-label col-sm-1">작업장명</label>
				</dt>
				<dd>
					<div class="form-inline">
						<input type="text" class="form-control input-sm autoComplete"
							id="WCCM_DESC" name="WCCM_DESC" maxlength="20"
							style="width: 50%;" placeholder="작업장명" data-url="getWkCtrList"
							data-type="name" data-target_value_id="WCCM_WKCTR"
							data-target_label_id="WCCM_DESC"> <input type="text"
							class="form-control input-sm" id="WCCM_WKCTR" name="WCCM_WKCTR"
							maxlength="20" placeholder="작업장코드" style="width: 50%;">
					</div>
				</dd>
				<dt>
					<label for=MNI_PROGS_CD class="control-label col-sm-1">부서</label>
				</dt>
				<dd>
					<select class="form-control input-sm" id="WCCM_DEPT"
						name="WCCM_DEPT"></select>
				</dd>
				<dt>
					<label for=MNI_PROGS_CD class="control-label col-sm-1">외주구분</label>
				</dt>
				<dd>
					<select class="form-control input-sm" id="WCCM_MS_CODE"
						name="WCCM_MS_CODE"></select>
				</dd>
				<dt>
					<label for=MNI_PROGS_CD class="control-label col-sm-1">작업방식</label>
				</dt>
				<dd>
					<select class="form-control input-sm" id="WCCM_USER1"
						name="WCCM_USER1"></select>
				</dd>
			</dl>

			<div id="searchBtnSet" class="text-right">
				<button type="submit" class="btn btn-sm btn-primary">조회</button>
				<button type="button" id="btnExcel" class="btn btn-sm btn-success"
					onclick="excelDown();">Excel Download</button>
				<button type="button" class="btn btn-sm btn-default"
					onclick="init();">초기화</button>
			</div>

		</form>

		<div id="gridWrapper">
			<p id="sub_title">
				<img alt="icon" src="/images/img_sub_title_seil.png"> 작업장 등록현황
			</p>
			<form id="gridFrm">
				<table id="grid-table"></table>
			</form>
			<div id="gridBtnSet"">
				<div class="text-right">
					<button type="button" id="btnDelAll" class="btn btn-sm btn-danger">선택삭제</button>
				</div>
			</div>
		</div>


		<form id="editFrm">
			<div class="panel panel-primary" style="margin-top: 40px;">
				<div class="panel-heading" role="tab" id="headingTwo"
					style="padding: 6px 15px;">
					작업장상세현황 <span class="pull-right"> <a class="collapseBtn"
						data-toggle="collapse" data-parent="#accordion"
						href="#collapseTwo" aria-expanded="true"
						aria-controls="collapseTwo" style="color: #fff"> <i
							class="fas fa-angle-up"></i>
					</a>
					</span>
				</div>

				<div id="collapseTwo"
					class="panel-collapse collapse in collapse_frm" role="tabpanel"
					aria-labelledby="headingTwo">

					<table class="editTable">
						<colgroup>
							<col width="10%">
							<col width="15%">
							<col width="10%">
							<col width="15%">
							<col width="10%">
							<col width="15%">
							<col width="10%">
							<col width="15%">
						</colgroup>
						<tbody>
							<tr>
								<input type="hidden" id="WkpmIdx" name="WkpmIdx" />
								<input type="hidden" id="WkpmAllocMp01" name="WkpmAllocMp01" />
								<input type="hidden" id="WkpmAllocMp02" name="WkpmAllocMp02" />
								<input type="hidden" id="WkpmAllocMp03" name="WkpmAllocMp03" />
								<input type="hidden" id="WkpmAllocMp04" name="WkpmAllocMp04" />
								<input type="hidden" id="WkpmAllocMp05" name="WkpmAllocMp05" />
								<input type="hidden" id="WkpmRegDate" name="WkpmRegDate" />
								<input type="hidden" id="WkpmRegUser" name="WkpmRegUser" />
								<input type="hidden" id="WkpmModDate" name="WkpmModDate" />
								<th class="text-right">작업장 코드</th>
								<td class="data_column" data-name="WkpmWkctrCd"><input
									type="text" class="form-control input-sm txtedit2 required"
									id="WkpmWkctrCd" name="WkpmWkctrCd" style="width: 200px;"></input>
								</td>
								<th class="text-right">기계설비</th>
								<td class="data_column" data-name=WkpmMchCd><input
									type="text" class="form-control input-sm txtedit required"
									id="WkpmMchCd" name="WkpmMchCd" style="width: 250px;"></input>
								</td>
								<th class="text-right">법인 구분코드</th>
								<td class="data_column" data-name="WkpmCorpCd"><input
									class="form-control input-sm txtedit required" id="WkpmCorpCd"
									name="WkpmCorpCd" style="width: 200px;"></input></td>
								<th class="text-right">사업장 구분코드</th>
								<td class="data_column" data-name="WkpmBsnsCd"><input
									class="form-control input-sm txtedit required" id="WkpmBsnsCd"
									name="WkpmBsnsCd" style="width: 200px;"></input></td>
							</tr>
							<tr>
								<th class="text-right">작업장 명칭</th>
								<td class="data_column" data-name="WkpmWkctrNm"><input
									class="form-control input-sm txtedit required" id="WkpmWkctrNm"
									name="WkpmWkctrNm" style="width: 200px;"></input></td>
								<th class="text-right">작업장 부서코드</th>
								<td class="data_column" data-name="WkpmDeptCd"><input
									class="form-control input-sm txtedit required" id="WkpmDeptCd"
									name="WkpmDeptCd" style="width: 250px;"></input></td>
								<th class="text-right">사내외주 구분</th>
								<td class="data_column" data-name="WkpmMsCode"><input
									class="form-control input-sm txtedit required" id="WkpmMsCode"
									name="WkpmMsCode" style="width: 250px;"></input></td>
								<th class="text-right">작업장 설명</th>
								<td class="data_column" data-name="WkpmDesc" colspan="3"><input
									type="text" class="form-control input-sm txtedit" id="WkpmDesc"
									name="WkpmDesc" style="width: 250px;"></input></td>
							</tr>
							<tr>
								<th class="text-right">작업위치(상위)</th>
								<td class="data_column" data-name="WkpmWkLoc"><input
									class="form-control input-sm txtedit required" id="WkpmWkLoc"
									name="WkpmWkLoc" style="width: 200px;"></input></td>
								<th class="text-right">사용여부 구분</th>
								<td class="data_column" data-name="WkpmIsUse"><input
									class="form-control input-sm txtedit required" id="WkpmIsUse"
									name="WkpmIsUse" style="width: 250px;"></input></td>
								<th class="text-right">수정자</th>
								<td class="data_column" data-name="WkpmModUser" colspan="3">
									<input type="text" class="form-control input-sm txtedit"
									id="WkpmModUser" name="WkpmModUser" style="width: 250px;"></input>
								</td>
							</tr>
						</tbody>
					</table>
					<div id="editBtnSet" style="margin-top: 5px; float: right;">
						<button type="button" id="btnRegMt" class="btn btn-sm btn-primary">신규</button>
						<button type="button" id="btnSaveMt"
							class="btn btn-sm btn-primary">변경</button>
						<button type="button" id="btnsendMt"
							class="btn btn-sm btn-success">저장</button>
						<button type="button" id="btnDelMt" class="btn btn-sm btn-danger">삭제</button>
						<button type="button" id="btnCanMt" class="btn btn-sm btn-danger">취소</button>
					</div>
				</div>
			</div>
		</form>


		<script id="grid-template" type="text/template">
    	<table width="100%" height="400px">
        	<thead>
            	<tr>
					<th name="WkpmWkctrCd" align="center" width="8%">작업장코드</th>
					<th name="WkpmMchCd" align="center" width="8%">기계/설비</th>
					<th name="WkpmCorpCd" align="center" width="5%">법인(회사)구분코드</th>
					<th name="WkpmBsnsCd" align="center" width="5%">사업장구분코드</th>
					<th name="WkpmWkctrNm" align="center" width="20%">작업장명칭</th>
					<th name="WkpmDesc" align="center" width="40%">작업장설명</th>
					<th name="WkpmModUser" align="center" width="20%">수정자</th>
            	</tr>
        	</thead>
        	<tbody>
            	<tr>
					<td name="WkpmWkctrCd" bind="WkpmWkctrCd" ></td>
					<td name="WkpmMchCd" bind="WkpmMchCd" ></td>
					<td name="WkpmCorpCd" bind="WkpmCorpCd" ></td>
					<td name="WkpmBsnsCd" bind="WkpmBsnsCd" ></td>
					<td name="WkpmWkctrNm" bind="WkpmWkctrNm" ></td>
					<td name="WkpmDesc" bind="WkpmDesc" ></td>
					<td name="WkpmModUser" bind="WkpmModUser" ></td>
            	</tr>
        	</tbody>
    	</table>
		</script>



		<script type="text/javascript">		

		var table = $('#grid-table');
		var template = $('#grid-template');

		var grid = webponent.grid.init(table, template,{
		    rowSelectable : true
		});

		function draw(){
			$.ajax({
				cache : false,
				url : '/wkpmList',
				type : 'GET',
				contentType : 'application/json;charset=utf-8',
				success : function(resp) {
					console.log(resp.result.result)
					grid.removeRow();
					grid.appendRow(resp.result.result);
					inputMode(true) //그리드그려지고 쓰기모드 잠금

				},
				error : function(error, status, msg) {
					//alert("상태코드 " + status + "에러메시지" + msg);
				}
			});
		}
		
		
		
		</script>

	</div>
</body>
</html>