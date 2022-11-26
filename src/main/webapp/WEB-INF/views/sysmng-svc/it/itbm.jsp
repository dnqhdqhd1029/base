<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/header.jsp"%>
<c:set var="infoPath" value="${path}/web/base/product/info"></c:set>
<style type="text/css">
.modal-dialog.modal-fullsize {width: 100%;height: 100%;margin: 0;padding: 0; }
</style>
<meta charset="UTF-8">
<title>품목 정보 관리</title>
</head>
<body>
<%-- 모달 팝업 import --%>
<c:import url="/WEB-INF/views/web/base/product/info/info_pop.jsp" charEncoding="UTF-8"></c:import>

	<div class="container-fluid">
		<form id="sFrm">
			<input type="hidden" id="popMode">			
			
			<dl class="dl-layout four" id="searchSet">
				<dt>품목번호</dt>
				<dd>
					<div class="form-inline">
						<!-- 품명 id랑 name 뒤에 2붙였습니다  모달쪽에서 name이 같은게 있어서 오류가 발생해서 수정했습니다. -->
						<input type="text" class="form-control input-sm autoComplete" id="IBM_ITEM_DESC2" name="IBM_ITEM_DESC2" style="width:49%;" placeholder="품목명"
								data-url="getItemList"
								data-type="name"
								data-target_value_id="IBM_ITEM_NO"
								data-target_label_id="IBM_ITEM_DESC2"
								autofocus="autofocus">
						<input type="text" class="form-control input-sm autoComplete" id="IBM_ITEM_NO" name="IBM_ITEM_NO" maxlength="20" style="width:49%;" placeholder="품목번호"
								data-url="getItemList"
								data-type="code"
								data-target_value_id="IBM_ITEM_NO"
								data-target_label_id="IBM_ITEM_DESC2">
					</div>
				</dd>
				<dt>이전 품명</dt>
				<dd>
					<input type="text" class="form-control input-sm" id="IBM_ITEM_BACK" name="IBM_ITEM_BACK" maxlength="20">
				</dd>
				<dt>구분</dt>
				<dd>
					<select class="form-control input-sm " id="IBM_ITEM_TYPE" name="IBM_ITEM_TYPE"></select>
				</dd>
				<dt>상태</dt>
				<dd>
					<select class="form-control input-sm" id="IBM_ITEM_STATUS" name="IBM_ITEM_STATUS"></select>
				</dd>
			</dl>
			
			<dl class="dl-layout four" id="searchSet" style="border-top:none;margin-top:-5px;margin-bottom:10px;">
				<dt>제품군</dt>
				<dd>
					<select class="form-control input-sm " id="IBM_GROUP1_VAL" name="IBM_GROUP1_VAL"></select>
				</dd>
				<dt>분류</dt>
				<dd>
					<div class="form-inline">
						<select class="form-control input-sm clsfGroup" id="IBM_GROUP2_VAL" name="IBM_GROUP2_VAL" style="width:32%;">
							<option value="">선택</option>
						</select>
						<select class="form-control input-sm clsfGroup" id="IBM_GROUP3_VAL" name="IBM_GROUP3_VAL" style="width:32%;">
							<option value="">선택</option>
						</select>
						<select class="form-control input-sm clsfGroup" id="IBM_GROUP4_VAL" name="IBM_GROUP4_VAL" style="width:32%;">
							<option value="">선택</option>
						</select>
					</div>
				</dd>
			</dl>
			
			<div id="searchBtnSet" class="text-right">
				<button type="submit" class="btn btn-sm btn-primary">조회</button>
				<button type="button" id="btnExcel" class="btn btn-sm btn-success">Excel Download</button>
				<button type="button" class="btn btn-sm btn-default" onclick="init();">초기화</button>
			</div>
			
		</form>
		
		<p id="sub_title">
			<img alt="icon" src="${path}/resources/images/img_sub_title_seil.png">
			품목정보 내역
			&nbsp;
			<span>
				<select id="row_cnt">
					<option value="10">10건씩 보기</option>
					<option value="15" selected>15건씩 보기</option>
					<option value="20">20건씩 보기</option>
					<option value="50">50건씩 보기</option>
					<option value="100">100건씩 보기</option>
					<option value="500">500건씩 보기</option>
					<option value="1000">1000건씩 보기</option>
				</select>
			</span>
			&nbsp;
			<span class="text-muted">
				&lt;&lt; 항목을 더블클릭 하시면 품목정보를 수정할 수 있습니다. &gt;&gt;
			</span>
		</p>
		
		<div id="gridWrapper">
			<form id="gridFrm">
				<table id="grid-table"></table>
			</form>
		</div>
		
		<script id="grid-template" type="text/template">
		<table>
			<thead>
				<tr>
					<td name="IBM_ITEM_NO" width="110px" align="center">품목번호</td>
					<td name="IBM_ITEM_DESC" width="170px">품명</td>
					<td name="IBM_STANDARD_DESC" width="200px">기타규격</td>
					<td name="IBM_ITEM_BACK" width="*" visibility="hidden">이전 품명</td>
					<td name="IBM_GROUP1_VAL_NAME" width="120px" align="center">제품군</td>
					<td name="IBM_GROUP2_VAL_NAME" width="120px" align="center">대분류</td>
					<td name="IBM_GROUP3_VAL_NAME" width="120px" align="center">중분류</td>
					<td name="IBM_GROUP4_VAL_NAME" width="120px" align="center">소분류</td>
					<td name="IBM_ITEM_UNIT_NAME" width="80px" align="center">단위</td>
					<td name="IBM_PACKING_CD" width="100px" visibility="hidden">포장단위</td>
					<td name="IBM_PM_CODE_DESC" width="100px" align="center">MPS구분</td>
					<td name="IBM_ITEM_TYPE_NAME" width="100px" align="center">품목구분</td>
					<td name="IBM_SFTY_STK" width="100px" align="right">안전재고</td>
					<td name="IBM_INSP_RQD" width="90px" align="center">검사품</td>
					<td name="IBM_QRCODE_DOC" width="80px" align="center">명판</td>
					<td name="IBM_APP_DATE" width="100px" visibility="hidden">적용일</td>
					<td name="IBM_DUE_DATE" width="100px" visibility="hidden">유효일</td>
					<td name="IBM_ITEM_STATUS_NAME" width="100px" align="center">상태</td>
					<td name="CNT" width="100px" align="right">품목수량</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td data-key name="IBM_ITEM_NO" bind="IBM_ITEM_NO"></td>
					<td name="IBM_ITEM_DESC" bind="IBM_ITEM_DESC"></td>
					<td name="IBM_STANDARD_DESC" bind="IBM_STANDARD_DESC"></td>
					<td name="IBM_ITEM_BACK" bind="IBM_ITEM_BACK"></td>
					<td name="IBM_GROUP1_VAL_NAME" bind="IBM_GROUP1_VAL_NAME"></td>
					<td name="IBM_GROUP2_VAL_NAME" bind="IBM_GROUP2_VAL_NAME"></td>
					<td name="IBM_GROUP3_VAL_NAME" bind="IBM_GROUP3_VAL_NAME"></td>
					<td name="IBM_GROUP4_VAL_NAME" bind="IBM_GROUP4_VAL_NAME"></td>
					<td name="IBM_ITEM_UNIT_NAME" bind="IBM_ITEM_UNIT_NAME"></td>
					<td name="IBM_PACKING_CD" bind="IBM_PACKING_CD"></td>
					<td name="IBM_PM_CODE_DESC" bind="IBM_PM_CODE_DESC"></td>
					<td name="IBM_ITEM_TYPE_NAME" bind="IBM_ITEM_TYPE_NAME"></td>
					<td name="IBM_SFTY_STK" bind="IBM_SFTY_STK"></td>
					<td name="IBM_INSP_RQD" bind="IBM_INSP_RQD"></td>
					<td name="IBM_QRCODE_DOC" bind="IBM_QRCODE_DOC"></td>
					<td name="IBM_APP_DATE" bind="IBM_APP_DATE"></td>
					<td name="IBM_DUE_DATE" bind="IBM_DUE_DATE"></td>
					<td name="IBM_ITEM_STATUS_NAME" bind="IBM_ITEM_STATUS_NAME"></td>
					<td name="CNT">
						<input type="text" id="CNT" name="CNT" bind="CNT" class="number_only editQty" style="text-align:right; width:99%; height:29px;" />
					</td>
				</tr>
			</tbody>
		</table>
		</script>
		
		<div id="gridBtnSet">
			<p class="text-right">
				<button type="button" id="btnReg" class="btn btn-sm btn-primary">등록</button>
				<button type="button" id="btnQr" class="btn btn-sm btn-primary">바코드 발행</button>
<!-- 				<button type="button" id="btnDel" class="btn btn-sm btn-danger">삭제</button>				 -->
			</p>
		</div>
		
		<form id="export-form"></form>
		
		<script>
		
			$(document).ready(function(){ 
				fnSelectBox("systemCode","PRODST","선택", "#IBM_ITEM_STATUS");
				fnSelectBox("systemCode","PL0001","선택", "#IBM_GROUP1_VAL");
				fnSelectBox("systemCode","PRODTY","선택", "#IBM_ITEM_TYPE");
				init();
			});
			
			$(document).on("submit", "#sFrm", function(){
				
				if(mode != "READ"){
					alert("수정사항을 저장하시거나 취소해주시기 바랍니다.");
					return false;
				}
				
				search();

				return false;
			});

			//검색 옵션 초기화 및 그리드 새로고침
			function init(){
				$("#sFrm select, #sFrm input").each(function(){
					var $input = $(this);
					$input.val("");
					$input.val("").prop("selected",true);
				});
				
				mode = "READ";
			}
			
			var mode = "READ";	
			var table = $('#grid-table');
			var template = $('#grid-template');
			
			var grid = setGrid(table, template, false, true, true);
			var uiPlugIn = setPage(grid, $("#row_cnt").val());
		
			//서버 사이드 페이징 그리드 생성
			function search(flag) {
				var cnt = 0;
				var sFrm = $("#sFrm");
				var formData = sFrm.serializeObject();
				
				drawGrid("${infoPath}/list", formData, "post", "json", grid, true, flag).done(function(){
					resize();	
				});
			}
			
			$("#row_cnt").on("change", function(){
				
				grid.settings.paging.countPerPage = $("#row_cnt").val();
				search();
			});
						
			$(function(){
				resize();
				$(window).resize(function() {
					resize();
				});
			});
			
			function resize(){
			    var height = $(window).height();
			    var searchSetHeight = $("#searchSet").height();
			    var editFrmHeight = $("#editFrm").height();
			    var subTitle = $("#sub_title").height();
			    var gridBtnSet = $("#gridBtnSet").height();
			    var editBtnSet = $("#editBtnSet").height();
			    var etc = 140;
			    
			    var gridHeight = height - searchSetHeight - editFrmHeight - subTitle - gridBtnSet - editBtnSet - etc;
			    		    
			    grid.setGridHeight(gridHeight);				    
			}
			
			$(document).on("click", "#btnReg", function(){
				
				regist();
			});
			
			$(grid.markup.main.body.tbody).on("dblclick", "tr", function(){
				var row = this;
				makeSelectBox(row.data.IBM_GROUP1_VAL, $("#popFrm"));	//수정 모드일때 대분류, 중분류, 소분류 selectBox 미리 생성
				
				edit(row);
			});
			
			$(document).on("click", "#btnDel", function(){
				
				deleteAll();
			});
			
			$(document).on("click", "#btnExcel", function(){
				
				excelDown();				
			});
			
			$(document).on("click", "#btnQr", function(){
				var chkData = grid.getCheckedRowData();
				
				if(chkData.length < 1){alert("진행할 대상을 체크하여 주십시오."); return;}
				
				var result = confirm('선택된 항목들을 발행 하시겠습니까?');
				if(!result) return;
				
				print(chkData);
			});
			
			function print(chkData){
				
				var itemList = "";
				
				for(var m=0; m<chkData.length; m++){
					itemList = itemList + chkData[m].IBM_ITEM_NO + "-" + chkData[m].CNT + ","	
				}

			   //서브코드를 하나 조회해서 가져온
			   var chkData = fnGetSystemCode("systemCode", "ReportCode:RPT_INFO");   
			               
			   var vReportName = "info_list";		//이전에 사용하던 리포트 파일명
			         
			    if(!isEmpty(chkData) && !isEmpty(chkData[0].SGD_SUB_CODE)){	//chkData와 chakData의 서브코드의 값이 있을경우 
			       vReportName = chkData[0].SGD_SUB_CODE;
			    }

			        				
				var vData = {
						"item" : itemList,    /*조건1*/
						"reportName" : vReportName /*리포트 파일명(요것만 지키면 됨)*/
					};
	 			fnReport(vData); 
			}
			
			$(grid.markup.main.body.tbody).on("change blur", ".editQty", function(e){
				var input = $(this);
	            var $tr = input.closest('tr');
	            var tr = $tr[0];
	            var rowIndex = tr.index;
	            var rowData = tr.data;
				var num = $tr.find("input[id='CNT']").val();
				grid.updateData(rowData.IBM_ITEM_NO ,{
	        		CNT     : parseInt(num)
	        	});
			});
			
//			검색창 selectBox 값 변경시 자동 검색
			$(document).on("change", "#sFrm select", function(){
				$("#sFrm").submit();
			});

			//대분류, 중분류, 소분류 selectBox
			$(document).on("change", "#IBM_GROUP1_VAL", function(){
				var $this = $(this),
					$sFrm = $("#sFrm");
				makeSelectBox($this.val(), $sFrm);
			});

			function makeSelectBox(group1Val, $frm){
				customAjax("${path}/utils/getClsfOptions", "get", {parameter: group1Val}, "json", false).done(function(data){
							
// 					$(".clsfGroup").each(function(){
// 						$(this).empty();
// 						$(this).append("<option value=''>선택</option>");
// 					})
					
					if(data.length > 1) {
						alert("품목 분류에 중복된 값이 있습니다.\n품목분류관리에서 중복된 분류를 삭제하세요.");
						return false;
					}
					else if(data.length == 1){
						$frm.find("[name=IBM_GROUP2_CD]").val(data[0].GROUP_CODE2);
						fnSelectBox("systemCode",data[0].GROUP_CODE2,"선택", "#"+$frm.find("[name=IBM_GROUP2_VAL]").attr("id"));
						$frm.find("[name=IBM_GROUP3_CD]").val(data[0].GROUP_CODE3);
						fnSelectBox("systemCode",data[0].GROUP_CODE3,"선택", "#"+$frm.find("[name=IBM_GROUP3_VAL]").attr("id"));
						
						$frm.find("[name=IBM_GROUP4_CD]").val(data[0].GROUP_CODE4);
						fnSelectBox("systemCode",data[0].GROUP_CODE4,"선택", "#"+$frm.find("[name=IBM_GROUP4_VAL]").attr("id"));
					}
					else {
						return false;
					}
				});
			}

//				등록
			function regist(){
				$("#popBtnDelete").addClass("hidden");	//	삭제버튼 숨기기
				$("#imgThumbnail").html("");
				$("#imgThumbnail").html('<span class="text-muted">없음</span>');
				
				
				openPop("품목 정보 등록", "REG");
			}

//				수정
			function edit(row){
				$("#popBtnDelete").removeClass("hidden");	//	삭제버튼 보이기
				
				//	첨부 이미지 미리보기
				if(!isEmpty(row.data.IBM_IMG_PATH)){
					var imgPath = "${path}/utils/displayFile?fileName="+getImageLink(row.data.IBM_IMG_PATH);
					var str = makeImgTag(imgPath, imgPath);
					$("#imgThumbnail").html("");
					$("#imgThumbnail").html(str);
				}
				else {
					$("#imgThumbnail").html("");
					$("#imgThumbnail").html('<span class="text-muted">없음</span>');
				}
				$('input[name=IBM_ITEM_CHECK]').prop('checked', false);
//			 	$("#ITEM_CHECK").show();
				openPop("품목 정보 수정", "EDIT", row);
			}

//				모달 팝업 오픈
			function openPop(modal_title, mode, row){
				$("#modalTitle").html("<strong>"+modal_title+"</strong>");	
				$("#popMode").val(mode);
				
				showModal("#modal_pop");

				if(mode=="EDIT"){
					makeNameBox(row.data["IBM_QRCODE_DOC"]);
				}else{
					makeNameBox("none");
				}
				
				check = true;
				
				$("#modal_pop").on("shown.bs.modal", function (e) {	//모달이 호출되고 나서 실행되는 함수
					var i=0;
					$("#popFrm input, #popFrm select").each(function(){
						var $this = $(this),
							thisName = $this.attr("name");
						if(isEmpty(row)){
							$this.val("");			
							if(thisName == "IBM_ITEM_STATUS") $this.val("AC");
							if(thisName == "IBM_IS_SET") $this.val("N");
							if($this.data("type") == "noneEditable") $this.attr("disabled", false);
							if(thisName == "IBM_ITEM_NO") $this.attr("disabled", false);
							if(thisName == "IBM_ITEM_NO") $this.attr("readonly", false);
							if(thisName == "IBM_UNIT_SIZE") $this.val(0);
							if(thisName == "IBM_QTY_UNIT") $this.val(0);
							$("#POP_CPRODGR").val("11").prop("selected", true);
							if(thisName == "CPRODGR") $this.val("1");
							if(thisName == "IBM_ITEM_ABC") $this.val("C");
							if(thisName == "IBM_INSP_RQD") $this.val("N");
							if(thisName == "IBM_SFTY_STK") $this.val(0);
							if(thisName == "IBM_ITEM_STATUS") $this.val("A");
							$("#ITEM_CHECK").hide();
							 var date = new Date();
							    var year = date.getFullYear();
							    var month = date.getMonth()+1
							    var day = date.getDate();
							    if(month < 10){
							        month = "0"+month;
							    }
							    if(day < 10){
							        day = "0"+day;
							    }
							    var today = year+"-"+month+"-"+day;
			 
							if(thisName == "IBM_APP_DATE") $this.val(today);
							if(thisName == "IBM_DUE_DATE") $this.val("2050-12-31");
							$("input:checkbox[id='POP_IBM_ASSY_CHECK']").prop("checked", false); 
						}
						else {
							$this.val("");
							
							if($this.hasClass("numberFormat")){
								$this.val(comma(row.data[thisName]));
							}
							else {
								$this.val(row.data[thisName]);	
							}
							if(thisName == "IBM_ASSY_CODE"){
								if($this.val()=="V"){
									$("input:checkbox[id='POP_IBM_ASSY_CHECK']").prop("checked", true);
								}
								else{
									$("input:checkbox[id='POP_IBM_ASSY_CHECK']").prop("checked", false);
								}
							}
							if($this.data("type") == "noneEditable") $this.attr("disabled", true);
							if(thisName == "IBM_ITEM_NO") $this.attr("readonly", false);
							if(thisName == "IBM_ITEM_NO") $this.attr("disabled", false);
							$("#ITEM_CHECK").show();
							if(thisName == "IBM_ITEM_ABC"){
								if($this.val()==null || $this.val()==""){
									$this.val("C");
								}
							}
							if(thisName == "IBM_INSP_RQD"){
								if($this.val()==null || $this.val()==""){
									$this.val("N");
								}
							}
							if(thisName == "IBM_UNIT_SIZE"){
								if($this.val()==null || $this.val()==""){
									$this.val(0);
								}
							}
							if(thisName == "IBM_LEAD_TM"){
								if($this.val()==null || $this.val()==""){
									$this.val(0);
								}
							}
							if(thisName == "IBM_SFTY_STK"){
								if($this.val()==null || $this.val()==""){
									$this.val(0);
								}
							}
							if(thisName == "IBM_MIN_QTY"){
								if($this.val()==null || $this.val()==""){
									$this.val(0);
								}
							}
							if(thisName == "IBM_MAX_QTY"){
								if($this.val()==null || $this.val()==""){
									$this.val(0);
								}
							}
							if(thisName == "IBM_ITEM_STATUS"){
								if($this.val()==null || $this.val()==""){
									$this.val("A");
								}
							}
						}
						
					});
				});
				
			}

//				선택 삭제
			function deleteAll(){
				
				var rowData = grid.getCheckedRowData();
				if(rowData.length == 0){
					alert("삭제 하실 항목을 1개 이상 체크해 주시기 바랍니다.");
					return false;
				}
				
				if(confirm("선택하신 항목을 삭제하시겠습니까?")){
					var url = "${infoPath}/deleteAll", 
						formData = {};
					
					formData.list = rowData;
					
					customAjaxJSON(url, "post", JSON.stringify(formData), "text", true).done(function(data){
						if(data == "OK"){
							alert("삭제되었습니다");
							//	새로고침
							var iframeWrapper = $("#iframe_wrapper", parent.document);
							reloadActiveIframe(iframeWrapper);
						}
					})
					.fail(function (xhr, status, err) {
						
						if(xhr.status == 400){
							var error = JSON.parse(xhr.responseText);
							
							var msg = error.message + "\n[ 품목번호: "+error.parameter.IBM_ITEM_NO + "]",
								row = grid.getRow(fnGetRowIndex(error.parameter.IBM_ITEM_NO, grid)),
								$tr = $(row); 
															
							alert(msg);
							
							$tr.css("background","#f2dede");
						}
					});
				}
			}

			function excelDown() {
				
				var url = "${infoPath}/excel";
				
				var sFrm = $("#sFrm"),
					formData = sFrm.serializeObject();
				
				var excelFileName = "품목정보 내역";
				var excelTitle = "품목정보 내역";	
					
				fnExcelDown(url, excelFileName, excelTitle, grid, formData, "#export-form");
			}
		</script>
		
	</div>

</body>
</html>