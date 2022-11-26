<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<!DOCType html>
<html>
<head>
<%@ include file="/WEB-INF/include/header.jsp"%>
<c:set var="sysCodePath" value="${path}/web/base/system/sysCode"></c:set>
<meta charset="UTF-8">
<script Type="text/javascript">
	
</script>
<title>시스템 코드 관리</title>
</head>
<body>
	<div class="container-fluid">
		<form id="sFrm">
			<dl class="dl-layout four" id="searchSet"
				style="margin-bottom: 10px;"
			>
				<dt>
					<label for="Code" class="control-label col-sm-1 ">시스템코드</label>
				</dt>
				<dd>
					<input Type="text" class="form-control input-sm" id="Code"
						Name="Code" maxlength="40" autofocus="autofocus"
					>
				</dd>
				<dt>
					<label for="Code_Name" class="control-label col-sm-1">코드명</label>
				</dt>
				<dd>
					<input Type="text" class="form-control input-sm" id="Code_Name"
						Name="Code_Name" maxlength="40"
					>
				</dd>
				<dt>
					<label for="Code_Type" class="control-label col-sm-1">구분</label>
				</dt>
				<dd>
					<select class="form-control input-sm" id="Code_Type"
						name="Code_Type"
					></select>
				</dd>
				<dt>
					<label for="IsUse" class="control-label col-sm-1">사용여부</label>
				</dt>
				<dd>
					<select class="form-control input-sm" id="IsUse" Name="IsUse">
						<option value="">선택</option>
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select>
				</dd>
			</dl>
			<div id="searchBtnSet" class="text-right">
				<button Type="submit" class="btn btn-sm btn-primary">조회</button>
				<button type="button" id="btnExcel" class="btn btn-sm btn-success"
					onclick="excelDown();"
				>Excel Download</button>
				<button type="reset" id="btn_init" class="btn btn-sm btn-default">초기화</button>
			</div>
		</form>
		<div class="row">

			<div class="col-sm-6">
				<p id="sub_title">
					<img alt="icon" src="/images/img_sub_title_seil.png"> 시스템 코드
					그룹
				</p>
				<div>
					<form id="mtFrm">
						<input Type="hidden" id="modeMt" Name="modeMt">
						<input Type="hidden" id="groupCode" Name="groupCode">
						<input Type="hidden" id="regCnt" value="0">
						<input Type="hidden" id="jsonParams" Name="jsonParams">
						<table id="grid-table-mt"></table>
					</form>
				</div>
				<div class="reg_div">
					<form id="addGroupFrm">
						<input Type="hidden" Name="mode">
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="heading1"
								style="padding: 6px 15px;"
							>
								그룹코드 등록 상세항목 <span class="pull-right"> <a
										class="collapseBtn" data-toggle="collapse"
										data-parent="#accordion" href="#collapse1"
										aria-expanded="false" aria-controls="collapse1"
										style="color: #fff"
									>
										<i class="fas fa-angle-up"></i>
									</a>
								</span>
							</div>
							<div id="collapse1" class="panel-collapse collapse collapse_frm"
								role="tabpanel" aria-labelledby="heading1"
							>
								<table class="table">
									<colgroup>
										<col width="15%">
										<col width="35%">
										<col width="15%">
										<col width="35%">
									</colgroup>
									<thead>
									</thead>
									<tbody>
										<tr>
											<th class="text-right">* 그룹코드</th>
											<td class="data_column" data-Name="SygmGroupCode">
												<input Type="text" class="form-control input-sm required"
													id="SygmGroupCode" Name="SygmGroupCode" maxlength="20"
													placeholder="" required="required" value=""
													class="needUnique" data-Type="MT"
												>
											</td>
											<th class="text-right">* 그룹명</th>
											<td class="data_column" data-Name="SygmGroupName">
												<input Type="text" class="form-control input-sm required"
													id="SygmGroupName" Name="SygmGroupName" maxlength="40"
													placeholder="" required="required" value=""
												>
											</td>
										</tr>
										<tr>
											<th class="text-right">* 구분</th>
											<td class="data_column" data-Name="SygmGroupType">
												<select class="form-control input-sm required"
													id="SygmGroupType" style="width: 100px;"
													required="required"
												></select>
											</td>
											<th class="text-right">* 분류</th>
											<td class="data_column" data-Name="SygmGroupDepth">
												<input Type="number" class="form-control input-sm required"
													id="SygmGroupDepth" Name="SygmGroupDepth" maxlength="1"
													placeholder="" required="required" value="0"
													style="width: 100px;"
												>
											</td>
										</tr>
										<tr>
											<th class="text-right">사용여부</th>
											<td class="data_column" data-Name="IPM_AMT_Type">
												<label class="radio-inline">
													<input type="radio" name="SygmIsUse" id="SygmIsUse1"
														class="form-check-input" value="Y" checked="checked"
													/>
													사용
												</label>
												<label class="radio-inline">
													<input type="radio" name="SygmIsUse" id="SygmIsUse2"
														class="form-check-input" value="N"
													/>
													미사용
												</label>
											</td>
											<th class="text-right">삭제가능</th>
											<td class="data_column" data-Name="SOD_QTY_ORD">
												<label class="radio-inline">
													<input Type="radio" Name="SygmIsDel" id="SygmIsDel1"
														class="form-check-input" value="Y" checked="checked"
													>
													가능
												</label>
												<label class="radio-inline">
													<input Type="radio" Name="SygmIsDel" id="SygmIsDel2"
														class="form-check-input" value="N"
													>
													불가능
												</label>
											</td>
										</tr>
										<tr>
											<th class="text-right">세부사항</th>
											<td class="data_column" data-Name="SygmGroupDesc" colspan="3">
												<input Type="text" class="form-control input-sm"
													id="SygmGroupDesc" Name="SygmGroupDesc" placeholder=""
													maxlength="80"
												>
											</td>
											<input type="hidden" id="regUser" value="${user_name }">
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<p class="text-right">
							<span class="top_buttons">
								<button Type="button" class="btn btn-sm btn-primary btn_add">신규</button>
								<button Type="button" class="btn btn-sm btn-primary btn_change">변경</button>
								<button Type="button" class="btn btn-sm btn-danger btn_delete">삭제</button>
							</span> <span class="bottom_buttons" style="display: none;">
								<button Type="button" class="btn btn-sm btn-success btn_save">저장</button>
								<button Type="button" class="btn btn-sm btn-default btn_cancel">취소</button>
							</span>
						</p>
					</form>
				</div>
				<form id="export-form"></form>
				<script id="grid-template-mt" Type="text/template">
				<table width="100%">
					<thead>
						<tr>
							<td Name="SygmNO" visibility="hidden"></td>
							<td Name="SygmIdx" visibility="SygmIdx"></td>
							<td Name="SygmGroupCode" align="center" width="120px">그룹코드</td>
							<td Name="SygmGroupName" align="" width="120px">그룹코드명</td>
							<td Name="SygmIsUse" align="center" width="80px">사용여부</td>
							<td Name="SygmIsDel" align="center" width="80px">삭제가능</td>
							<td Name="SygmGroupType" align="center" width="80px">구분</td>
							<td Name="SygmGroupDepth" align="center" width="60px">분류</td>
							<td Name="SygmGroupDesc" align="" width="*">상세</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td Name="SygmNO" bind="SygmNO"></td>
							<td Name="SygmIdx" bind="SygmIdx"></td>
							<td data-key Name="SygmGroupCode" bind="SygmGroupCode"></td>
							<td data-key Name="SygmGroupName" bind="SygmGroupName"></td>
							<td data-key Name="SygmIsUse" bind="SygmIsUse"></td>
							<td data-key Name="SygmIsDel" bind="SygmIsDel"></td>
							<td data-key Name="SygmGroupType" bind="SygmGroupTypeName"></td>
							<td data-key Name="SygmGroupDepth" bind="SygmGroupDepth"></td>
							<td data-key Name="SygmGroupDesc" bind="SygmGroupDesc"></td>
						</tr>
					</tbody>
				</table>
				</script>
			</div>

			<div class="col-sm-6">
				<p id="sub_title">
					<img alt="icon" src="/images/img_sub_title_seil.png"> 그룹별 시스템
					코드
				</p>
				<div>
					<input Type="hidden" id="sysCode">
					<input Type="hidden" id="modeDt">
					<input Type="hidden" id="sgdGroupCode">
					<input type="hidden" id="SygmIdx">
					<form id="dtFrm">
						<table id="grid-table-dt"></table>
					</form>
					<!-- 버튼자리 -->
				</div>
				<div class="reg_div">
					<form id="addCodeFrm">
						<input Type="hidden" Name="mode">
						<input Type="hidden" Name="SygdGroupCode">
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="heading2"
								style="padding: 6px 15px;"
							>
								그룹별 시스템코드 등록 상세항목 <span class="pull-right"> <a
										class="collapseBtn" data-toggle="collapse"
										data-parent="#accordion" href="#collapse2"
										aria-expanded="false" aria-controls="collapse2"
										style="color: #fff"
									>
										<i class="fas fa-angle-up"></i>
									</a>
								</span>
							</div>
							<div id="collapse2" class="panel-collapse collapse collapse_frm2"
								role="tabpanel" aria-labelledby="heading2"
							>
								<table class="table">
									<colgroup>
										<col width="15%">
										<col width="35%">
										<col width="15%">
										<col width="35%">
									</colgroup>
									<tbody>
										<tr>
											<th class="text-right">시스템코드</th>
											<td class="data_column" data-Name="SygdSysCode">
												<input Type="text" class="form-control input-sm required"
													id="SygdSysCode" Name="SygdSysCode" maxlength="20"
													placeholder="" required="required" value=""
													class="needUnique" data-Type="DT"
												>
											</td>
											<th class="text-right">코드명</th>
											<td class="data_column" data-Name="SygdSysName">
												<input Type="text" class="form-control input-sm required"
													id="SygdSysName" Name="SygdSysName" maxlength="80"
													placeholder="" required="required" value=""
												>
											</td>
										</tr>
										<tr>
											<th class="text-right">사용여부</th>
											<td class="data_column" data-Name="SygdIsUse">
												<label class="radio-inline">
													<input Type="radio" Name="SygdIsUse" id="SygdIsUse1"
														value="Y" checked="checked" class="form-check-input"
													>
													사용
												</label>
												<label class="radio-inline">
													<input Type="radio" Name="SygdIsUse" id="SygdIsUse2"
														value="N" class="form-check-input"
													>
													미사용
												</label>
											</td>
											<th class="text-right">표시순서</th>
											<td class="data_column" data-Name="SygdDispOrd">
												<input Type="number" class="form-control input-sm required"
													id="SygdDispOrd" Name="SygdDispOrd" maxlength="3"
													placeholder="" required="required" value="0"
													style="width: 100px;"
												>
											</td>
										</tr>
										<tr>
											<th class="text-right">세부사항</th>
											<td class="data_column" data-Name="SygdSysDesc">
												<input Type="text" class="form-control input-sm"
													id="SygdSysDesc" Name="SygdSysDesc" placeholder=""
													maxlength="80"
												>
											</td>
											<th class="text-right">서브코드</th>
											<td class="data_column" data-Name="SygdSubCode">
												<input Type="text" class="form-control input-sm"
													id="SygdSubCode" Name="SygdSubCode" placeholder=""
													maxlength="80"
												>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<p class="text-right">
							<span class="top_buttons2">
								<button Type="button" class="btn btn-sm btn-primary btn_add2">신규</button>
								<button Type="button" class="btn btn-sm btn-primary btn_change2">변경</button>
								<button Type="button" class="btn btn-sm btn-danger btn_delete2">삭제</button>
							</span> <span class="bottom_buttons2" style="display: none;">
								<button Type="button" class="btn btn-sm btn-success btn_save2">저장</button>
								<button Type="button" class="btn btn-sm btn-default btn_cancel2">취소</button>
							</span>
						</p>
					</form>
				</div>
				<script id="grid-template-dt" Type="text/template">
				<table width="100%">
					<thead>
						<tr>
							<td Name="SygdNO" visibility="hidden"></td>
							<td Name="SygdGroupCode" visibility="hidden"></td>
							<td Name="SygdSysCode" align="center" width="100px">시스템코드</td>
							<td Name="SygdSysName" align="" width="150px">코드명</td>
							<td Name="SygdIsUse" align="center" width="80px">사용여부</td>
							<td Name="SygdIsDel" align="center" visibility="hidden">삭제가능여부</td>
							<td Name="SygdDispOrd" align="center" width="60px">순서</td>
							<td Name="SygdSysDesc" align="" width="*">상세</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td data-key Name="SygdNO" bind=""></td>
							<td Name="SygdGroupCode" bind="SygdGroupCode"></td>
							<td Name="SygdSysCode" bind="SygdSysCode"></td>
							<td Name="SygdSysName" bind="SygdSysName"></td>
							<td Name="SygdIsUse" bind="SygdIsUse"></td>
							<td Name="SygdIsDel" bind="SygdIsDel"></td>
							<td Name="SygdDispOrd" bind="SygdDispOrd"></td>
							<td Name="SygdSysDesc" bind="SygdSysDesc"></td>							
						</tr>
					</tbody>
				</table>
				</script>
			</div>
		</div>
	</div>
</body>
<script Type="text/javascript">
	let groupType;

	var tableMt = $('#grid-table-mt');
	var templateMt = $('#grid-template-mt');
	var tableDt = $('#grid-table-dt');
	var templateDt = $('#grid-template-dt');

	var gridMt = webponent.grid.init(tableMt, templateMt, {
		rowSelectable : true
	});

	var gridDt = webponent.grid.init(tableDt, templateDt, {
		rowSelectable : true
	});

	let selectBoxCode = {
		"SygdGroupCode" : "S02"
	}

	$(function() {
		fnMakeSelectBox(selectBoxCode);
		resize();
		resize_de();
		$(window).resize(function() {
			resize();
			resize_de();
		});
	});

	function resize() {
		var height = $(window).height();
		var searchSet = $("#sFrm").height();
		var subTitle = $("#sub_title").height();
		var etc = 120;

		var gridHeight = height - searchSet - subTitle - etc;
		gridMt.setGridHeight(gridHeight);
	}
	function resize2() {
		var height = $(window).height();
		var searchSet = $("#sFrm").height();
		var subTitle = $("#sub_title").height();
		var etc = 282;

		var gridHeight = height - searchSet - subTitle - etc;
		gridMt.setGridHeight(gridHeight);
	}

	function resize_de() {
		var height = $(window).height();
		var searchSet = $("#sFrm").height();
		var subTitle = $("#sub_title").height();
		var etc = 110;

		var gridHeight = height - searchSet - subTitle - etc;
		gridDt.setGridHeight(gridHeight);
	}
	function resize2_de() {
		var height = $(window).height();
		var searchSet = $("#sFrm").height();
		var subTitle = $("#sub_title").height();
		var etc = 282;

		var gridHeight = height - searchSet - subTitle - etc;
		gridDt.setGridHeight(gridHeight);
	}

	//	입력 값 중복 검사
	function hasDuplicateInput($obj) {
		var boolRs = true
		uniqueInputs = [];

		$obj.each(function(index) {

			uniqueInputs[index] = $(this).val();
		});

		var inputCnt = uniqueInputs.length, removeDuplicatedCnt = $
				.unique(uniqueInputs).length;

		if (inputCnt == removeDuplicatedCnt) {
			boolRs = false;
		}

		return boolRs;
	}

	//조회버튼 클릭시 작동하는 이벤트
	$(document).on("submit", "#sFrm", function() {
		return search();

	});
	//마스터 테이블 로우 클릭시 인풋박스 값입력
	function selectData(rowData) {
		if (rowData != null) {
			$("#SygmGroupCode").val(rowData.SygmGroupCode);
			$("#SygmGroupName").val(rowData.SygmGroupName);
			$('input:radio[Name="SygmIsUse"][value=' + rowData.SygmIsUse + ']')
					.attr('checked', 'checked');
			$('input:radio[Name="SygmIsDel"][value=' + rowData.SygmIsDel + ']')
					.attr('checked', 'checked');
			var GroupType = rowData.SygmGroupType;

			$("#SygmGroupType").val(GroupType.trim()).attr("selected", true);
			$("#SygmGroupDepth").val(rowData.SygmGroupDepth);
			$("#SygmGroupDesc").val(rowData.SygmGroupDesc);
		} else {
			$("#SygmGroupCode").val("");
			$("#SygmGroupName").val("");
			$("#SygmGroupType").val("");
			$("#SygmGroupDepth").val("");
			$("#SygmGroupDesc").val("");
		}

	}

	//상세 테이블 로우 클릭시 인풋박스 값입력
	function selectData2(rowData) {
		if (rowData != null) {
			$("#")
			$("#SygdSysCode").val(rowData.SygdSysCode);
			$("#SygdSysName").val(rowData.SygdSysName);
			$('input:radio[Name="SygdIsUse"][value=' + rowData.SygdIsUse + ']')
					.attr('checked', 'checked');
			$("#SygdDispOrd").val(rowData.SygdDispOrd);
			$("#SygdSysDesc").val(rowData.SygdSysDesc);
			$("#SygdSubCode").val(rowData.SygdSubCode);
		} else {
			$("#SygdSysCode").val("");
			$("#SygdSysName").val("");
			$("#SygdDispOrd").val("");
			$("#SygdSysDesc").val("");
			$("#SygdSubCode").val("");
		}

	}

	// 그룹 신규,수정 저장 버튼
	$(document)
			.on(
					"click",
					".btn_save",
					function() {
						if ($("#modeMt").val() != "EDIT") {
							$("#modeMt").val("REG");
						}
						var regCnt = parseInt($("#regCnt").val());
						regCnt += 1;
						$("#regCnt").val(regCnt);

						var newRow = [];
						newRow[0] = {
							SgmNO : gridMt.getRow().length + 1,
							SygmGroupCode : $("#SygmGroupCode").val(),
							SygmGroupDepth : $("#SygmGroupDepth").val(),
							SygmGroupDesc : $("#SygmGroupDesc").val(),
							SygmGroupName : $("#SygmGroupName").val(),
							SygmGroupType : "",
							SygmGroupTypeName : "",
							SgmIsDel : $('input[Name="SgmIsDel"]:checked')
									.val(),
							SgmIsUse : $('input[Name="SgmIsUse"]:checked')
									.val(),
							SgmMOD_DATE : "",
							SgmMOD_UseR : "",
							SgmREG_DATE : "",
							SgmREG_UseR : ""
						};

						var _this = newRow;
						var _tr = $(_this);
						if ($("#modeMt").val() == "EDIT") {
							changeRow(gridMt, _this, "EDIT");
						} else {
							changeRow(gridMt, _this, "REG");
						}

						var _tbody = $(gridMt.markup.main.body.tbody);
						_tbody.off("dblclick");

						//	상세정보 그리드 새로그리기
						let url = "/stmt/detail/list"
						let detailData = 'groupCode= '
						getDraw(url, gridDt, detailData);

						var frm = $("#mtFrm"), boolRs = "Y", mode = $("#modeMt")
								.val(), regCnt = parseInt($("#regCnt").val());
						;
						//	필수 입력값 검증
						$("#addGroupFrm input, #addGroupFrm select")
								.each(
										function(index) {

											var input = $(this), isRequired = input
													.prop("required");

											if (isRequired) {
												if (isEmpty(input.val())) {
													alert("필수 입력항목을 입력하시기 바랍니다.");
													input.focus();
													boolRs = "N";
													return false;
												} else if (input.attr("class") == "needUnique") {
													if (!isUnique(input.val(),
															"MT")) {

														alert("중복된 코드 입니다.");
														input.val("").focus();
														boolRs = "N";
														return false;
													}
												}
											} else if (input.find(
													"option:checked").text() == "선택") {
												alert("필수 항목을 선택하시기 바랍니다.");
												input.focus();
												boolRs = "N";
												return false;
											}
										});

						if (boolRs == "N")
							return false;

						// 		등록시 그룹코드 중복여부 확인
						if (hasDuplicateInput($("input[name=SygmGroupCode]"))) {
							alert("입력하신 코드 중 중복된 값이 있습니다.\n입력 내용을 확인해 주세요");
							return false;
						}

						if (confirm("저장하시겠습니까?")) {
							let url;
							;

							if (mode == "REG") {
								url = "/stmt/regist";
							} else {
								url = "/stmt/update";
							}

							var jsonParams = {};
							var paramsList = new Array();
							var formData;
							var params = {};

							params.SygmGroupCode = $("#SygmGroupCode").val();
							params.SygmGroupDepth = $("#SygmGroupDepth").val();
							params.SygmGroupDesc = $("#SygmGroupDesc").val();
							params.SygmGroupName = $("#SygmGroupName").val();
							params.SygmGroupType = $(
									"#SygmGroupType option:selected").val();
							params.SygmIsDel = $(
									'input[Name="SygmIsDel"]:checked').val();
							params.SygmIsUse = $(
									'input[Name="SygmIsUse"]:checked').val();

							$.ajax({
								url : url,
								dataType : "JSON",
								contentType : "application/json",
								type : "POST",
								data : JSON.stringify(params),
								success : function(data) {
									$("#modeMt").val("");
									if (data.msg == 'ok') {
										alert('처리가 완료되었습니다.')
									}
									search();
									$(".top_buttons").show();
									$(".bottom_buttons").hide();
								},
								error : function(msg) {
									alert("등록에 실패하였습니다. 에러코드 - " + msg);
								}
							});
						} else {
							return false;
						}
					});

	// 삭제기능구현 메소드
	function deleteCode(code, type) {
		let inputCode = {
			'code' : code
		}
		var url = "";

		if (type == "master") {
			url = "/stmt/delete";
		} else if (type == "detail") {
			url = "/stmt/detail/delete";
		}
		$.ajax({
			url : url,
			type : "post",
			data : JSON.stringify(inputCode),
			contentType : "application/json",
			dataType : "JSON",
			success : function(data) {
				if (data.msg == 'ok') {
					alert('삭제가 완료되었습니다.')
				} else {
					alert('에러발생' + data.msg)
				}
				search();
			}
		});
	}
	/*******************
	MT테이블 버튼클릭 스크립트
	 *******************/
	//Mt테이블(좌측그리드) 신규 버튼클릭
	// 그룹 추가
	$(document).on(
			'click',
			'.btn_add',
			function() {
				$("#modeMt").val("REG");
				var $frm = $("#addGroupFrm").closest('form');
				var $formDiv = $frm.find('.collapse_frm');
				$(".top_buttons").hide();
				$(".bottom_buttons").show();
				if ($formDiv.is(':visible') == false) { //Form이 숨겨져 있을때 보여줌
					$formDiv.collapse('show');
					resize2();
				}
				$('input[Name=SygmGroupCode]').attr('disabled', false);
				$("#SygmGroupCode").val("");
				$("input:radio[Name='SygdIsUse'][value='Y']").attr('checked',
						'checked');
				$("#SygmGroupName").val("");
				$("#SygmGroupTypeName").val("");
				$("#SygmGroupDepth").val("");
				$("#SygmGroupDesc").val("");
				$("#SygmGroupType").val("");
			});

	// 그룹 변경(Mt)
	$(document).on('click', '.btn_change', function() {
		$("#modeMt").val("EDIT");
		var $frm = $("#addGroupFrm").closest('form');
		var $formDiv = $frm.find('.collapse_frm');
		$(".top_buttons").hide();
		$(".bottom_buttons").show();
		if ($formDiv.is(':visible') == false) { //Form이 숨겨져 있을때 보여줌
			$formDiv.collapse('show');
			resize2();
		}
	});

	// 그룹 취소 버튼
	$(document).on(
			'click',
			'.btn_cancel',
			function() {
				$("#modeMt").val("");
				$('#addGroupFrm').find('input[Name=SygmGroupCode]').attr(
						'disabled', true);
				$(".top_buttons").show();
				$(".bottom_buttons").hide();
			});

	// MT 삭제
	$(document).on("click", ".btn_delete", function() {
		let groupCode = $("#SygmGroupCode").val();
		if (confirm(groupCode + '를 삭제하시겠습니까?')) {
			deleteCode(groupCode, "master");
		}
	});

	/*******************
	MT테이블 버튼클릭 스크립트
	 *******************/

	/*******************
	DT테이블 버튼클릭 스크립트
	 *******************/
	// 시스템 코드 신규버튼 클릭이벤트
	$(document).on(
			'click',
			'.btn_add2',
			function() {
				$("#modeMt").val("REG");
				var $frm = $("#addCodeFrm").closest('form');
				var $formDiv = $frm.find('.collapse_frm2');
				$(".top_buttons2").hide();
				$(".bottom_buttons2").show();
				if ($formDiv.is(':visible') == false) { //Form이 숨겨져 있을때 보여줌
					$formDiv.collapse('show');
					resize2_de();
				}
				$('input[name=SygdSysCode]').attr('disabled', false);
				$("#SygdSysName").val("");
				$("input:radio[name='SygdIsUse'][value='Y']").attr('checked',
						'checked');
				$("#SygdDispOrd").val("");
				$("#SygdSysDesc").val("");
				$("#SygdSubCode").val("");
				$("#SygdSysCode").val("");
			});

	// 시스템 코드 변경버튼 클릭 이벤트
	$(document).on('click', '.btn_change2', function() {
		$("#modeMt").val("EDIT");
		var $frm = $("#addCodeFrm").closest('form');
		var $formDiv = $frm.find('.collapse_frm');
		$(".top_buttons2").hide();
		$(".bottom_buttons2").show();
		if ($formDiv.is(':visible') == false) { //Form이 숨겨져 있을때 보여줌
			$formDiv.collapse('show');
			resize2();
		}
	});

	// 코드 신규,수정 저장 버튼
	$(document)
			.on(
					"click",
					".btn_save2",
					function() {
						if ($("#modeMt").val() != "EDIT") {
							$("#modeMt").val("REG");
						}
						var regCnt = parseInt($("#regCnt").val());
						regCnt += 1;
						$("#regCnt").val(regCnt);

						let mtSygmIdx = $("#SygmIdx").val(); //MT테이블 인덱스값
						let mtSygdSysCode = $("#sgdGroupCode").val(); //MT테이블 값
						if (mtSygmIdx == "" || mtSygdSysCode == "") {
							alert("시스템 코드그룹을 선택 후 실행해주세요.")
							return false;
						}

						var newRow = [];
						newRow[0] = {
							SygdNO : gridDt.getRow().length + 1,
							SygdSysCode : $("#SygdSysCode").val(),
							SygdGroupCode : $("#sgdGroupCode").val(), //마스터테이블 그룹코드값 가져오기
							SygdSysNAME : $("#SygdSysCode").val(),
							SygdSysDesc : $("#SygdSysDesc").val(),
							SygdIsUse : "Y",
							SygdIsDel : "Y",
							SygdDispOrd : $("#SygdDispOrd").val(),
							SygdREG_DATE : "",
							SygdREG_USER : "",
							SygdMOD_DATE : "",
							SygdMOD_USER : "",
							SygdSubCode : $("#SygdSubCode").val()
						};

						var _this = newRow;
						var _tr = $(_this);
						if ($("#modeMt").val() == "EDIT") {
							changeRowDt(gridDt, _this, "EDIT");
						} else {
							changeRowDt(gridDt, _this, "REG");
						}

						var $tbody = $(gridDt.markup.main.body.tbody);
						$tbody.off("dblclick");

						//	코드 조회 초기화
						//	 		drawGrid("${syscodePath}/detail/list", {groupCode: ""}, "post", "json", gridDt);
						var frm = $("#mtFrm"), boolRs = "Y", mode = $("#modeMt")
								.val(), regCnt = parseInt($("#regCnt").val());
						;

						if (confirm("저장하시겠습니까?")) {
							var url;
							;

							if (mode == "REG") {
								url = "/stmt/detail/regist";
							} else {
								url = "/stmt/detail/update";
							}

							var jsonParams = {};
							var paramsList = new Array();
							var formData;
							var params = {};

							params.SygdGroupCode = $("#sgdGroupCode").val();
							params.SygdSysCode = $("#SygdSysCode").val();
							params.SygdSysName = $("#SygdSysName").val();
							params.SygdIsUse = $(
									'input[name="SygdIsUse"]:checked').val();
							params.SygdDispOrd = $("#SygdDispOrd").val();
							params.SygdSysDesc = $("#SygdSysDesc").val();
							params.SygdSubCode = $("#SygdSubCode").val();
							params.SygdSygmIdx = mtSygmIdx;


							$.ajax({
								url : url,
								datatype : "json",
								contentType : "application/json",
								type : "POST",
								data : JSON.stringify(params),
								success : function(data) {
									$("#modeMt").val("");
									if (data.msg == 'ok') {
										if (url == '/stmt/detail/regist') {
											alert('신규 등록이 완료되었습니다.')
										} else {
											alert('변경이 완료되었습니다.')
										}
									} else {
										alert('에러발생' + data.msg)
									}
									let _detailData = 'groupCode='
											+ params.SygdGroupCode
									getDraw("/stmt/detail/list", gridDt, _detailData);
									$(".top_buttons2").show();
									$(".bottom_buttons2").hide();
								}
							});
							return false;
						} else {
							return false;
						}
					});

	// 시스템 코드 삭제
	$(document).on("click", ".btn_delete2", function() {
		var params = {};
		params.SygdGroupCode = $("#sgdGroupCode").val();
		params.SygdSysCode = $("#SygdSysCode").val();
		url = "/stmt/detail/delete";
		$.ajax({
			url : url,
			datatype : "json",
			contentType : "application/json",
			type : "POST",
			data : JSON.stringify(params),
			success : function(data) {
				if(data.msg == 'ok'){
					alert('데이터가 정상적으로 삭제되었습니다.')
					let _detailData = 'groupCode=' + params.SygdGroupCode
					getDraw("/stmt/detail/list", gridDt, _detailData);
				}else{
					alert('에러발생' + data.msg)
				}
			}
		});
	});
	/*******************
	DT테이블 버튼클릭 스크립트
	 *******************/

	// 그룹 코드조회(조회버튼 눌렀을때)
	function search() {

		var mode = $("#modeMt").val();

		if (!isEmpty(mode)) {
			alert("기존 작업을 저장하시거나 취소버튼을 클릭하시기 바랍니다.");
			return false;
		}

		var frm = $("#sFrm")
		let url = "/stmt/list"
		let searchData = frm.serializeObject();

		getDraw(url, gridMt, searchData);

		$("#regCnt").val("0");
		return false;
	}

	//Mt그리드(왼쪽) 컬럼 로우 클릭시 값가져오기
	//	시스템 코드 조회
	function searchDetail(_groupCode) {
		let url = "/stmt/detail/list"
		let detailData = 'groupCode=' + _groupCode

		getDraw(url, gridDt, detailData);
	}

	//함수생성 (선택한값에 데이터를 넣어주면 값을 변경시켜주는 함수)
	function selectData(rowData) {
		if (rowData != null) {
			$("#SygmGroupCode").val(rowData.SygmGroupCode);
			$("#SygmGroupName").val(rowData.SygmGroupName);
			$('input:radio[Name="SygmIsUse"][value=' + rowData.SygmIsUse + ']')
					.attr('checked', 'checked');
			$('input:radio[Name="SygmIsDel"][value=' + rowData.SygmIsDel + ']')
					.attr('checked', 'checked');
			var GroupType = rowData.SygmGroupType;
			$("#SygmGroupType").val($.trim(GroupType)).attr("selected", true);
			$("#SygmGroupDepth").val(rowData.SygmGroupDepth);
			$("#SygmGroupDesc").val(rowData.SygmGroupDesc);
		} else {
			$("#SygmGroupCode").val("");
			$("#SygmGroupName").val("");
			$("#SygmGroupType").val("");
			$("#SygmGroupDepth").val("");
			$("#SygmGroupDesc").val("");
		}

	}

	//	코드 목록 조회
	$(gridMt.markup.main.body.tbody)
			.on(
					"click",
					"tr",
					function(e) {
						var row = this, rowData = row.data, $target = $(e.target), mode = $(
								"#modeMt").val();
						var $frm = $("#addGroupFrm").closest('form');
						var $formDiv = $frm.find('.collapse_frm');
						if ($formDiv.is(':visible') == false) { //Form이 숨겨져 있을때 보여줌
							$formDiv.collapse('show');
							resize2();
						}
						if (mode != "REG"
								&& mode != "EDIT"
								&& $target.attr("data-Name") == "SygmGroupCode"
								|| $target.attr("data-Name") == "SygmGroupName"
								|| $target.attr("data-Name") == "SygmIsUse"
								|| $target.attr("data-Name") == "SygmIsDel"
								|| $target.attr("data-Name") == "SygmGroupType"
								|| $target.attr("data-Name") == "SygmGroupDepth"
								|| $target.attr("data-Name") == "SygmGroupDesc") {

							searchDetail(rowData.SygmGroupCode);
							$("#dtBtnSet").removeClass("hidden");
						}

						selectData(rowData);

						$("#sgdGroupCode").val(rowData.SygmGroupCode);
						$("#SygmIdx").val(rowData.SygmIdx);

					});

	$(gridDt.markup.main.body.tbody)
			.on(
					"click",
					"tr",
					function(e) {
						var row = this, rowData = row.data, $target = $(e.target), mode = $(
								"#modeMt").val();
						selectData2(rowData);
						var $frm = $("#addCodeFrm").closest('form');
						var $formDiv = $frm.find('.collapse_frm2');
						if ($formDiv.is(':visible') == false) { //Form이 숨겨져 있을때 보여줌
							$formDiv.collapse('show');
						}

					});

	function draw(url, grid, inputData) {
		$.ajax({
			cache : false,
			url : url,
			Type : 'POST',
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

	//셀렉트박스 생성 메소드
	function fnMakeSelectBox2(selectId, options) {
		$(selectId).empty();
		$(selectId).append(options);
	}

	function fnMakeSelectBox(_Code) {
		let options;
		$
				.ajax({
					url : '/stmt/getSystemCode',
					Type : 'GET',
					data : _Code,
					dataType : 'json',
					contentType : 'application/json;charset=utf-8',
					success : function(resp) {
						options += `<option value=''>전체</option>`
						$(resp.list)
								.each(
										function(i) {
											options += `<option value='\${resp.list[i].sygdSysCode}'>\${resp.list[i].sygdSysName}</option>`;
										});

						groupType = options
						fnMakeSelectBox2("#Code_Type", options)
						fnMakeSelectBox2("#SygmGroupType", options)
					},
					error : function(error, status, msg) {
						alert("에러발생 관리자에게 문의하세요. 에러메세지 = " + msg);
					}
				})

	}

	//로우 변경함수
	function changeRow(grid, row, mode) {
		var rowData = row;
		for ( var key in rowData) {
			if (isEmpty(rowData[key])) {
				rowData[key] = "";
			}
		}
		var newNode = {};
		if (mode == "REG") {
			newNode.SygmGroupCode = '<input Type="text" class="needUnique required" data-Type="MT" Name="SygmGroupCode" maxlength="20" required="required" value="'+rowData[0].SygmGroupCode+'"/>';

			newNode.SygmGroupName = '<input Type="text" Name="SygmGroupName" required="required" value="'+rowData[0].SygmGroupName+'"/>';
			newNode.SygmIsUse = '<select id="GRID_SygmIsUse" Name="SygmIsUse">'
					+ '	<option value="Y">Y</option>'
					+ '	<option value="N">N</option>' + '</select>';
			newNode.SygmIsDel = '<select id="GRID_SygmIsDel" Name="SygmIsDel">'
					+ '	<option value="Y">Y</option>'
					+ '	<option value="N">N</option>' + '</select>';
			newNode.SygmGroupTypeName = '<select id="GRID_SygmGroupType" Name="SygmGroupType">'
					+ groupType + '</select>';
			newNode.SygmGroupDepth = '<input Type="text" Name="SygmGroupDepth" value="'+rowData[0].SygmGroupDepth+'" />';
			newNode.SygmGroupDesc = '<input Type="text" Name="SygmGroupDesc" value="'+rowData[0].SygmGroupDesc+'" />';
		}
		grid.updateNode(row.rowKey, newNode);
	}

	//DT 로우 변경함수
	function changeRowDt(grid, row, mode) {

		var rowData = row;

		for ( var key in rowData) {

			if (isEmpty(rowData[key])) {
				rowData[key] = "";
			}
		}

		var newNode = {};

		if (mode == "REG") {
			newNode.SgdSysCode = '<input type="text" class="needUnique required" data-type="DT" name="SgdSysCode" maxlength="20" required="required" value="'+rowData[0].SgdSysCode+'"/>';
		}

		newNode.SgdGroupCode = '<input type="text" name="SgdGroupCode" required="required" value="'+rowData[0].SgdGroupCode+'"/>';
		newNode.SgdSysName = '<input type="text" name="SgdSysName" required="required" value="'+rowData[0].SgdSysName+'"/>';
		newNode.SgdIsUse = '<select id="GRID_SgdIsUse" name="SgdIsUse">'
				+ '	<option value="Y">Y</option>'
				+ '	<option value="N">N</option>' + '</select>';
		newNode.SgdIsDel = '<select id="GRID_SgdIsDel" name="SgdIsDel">'
				+ '	<option value="Y">Y</option>'
				+ '	<option value="N">N</option>' + '</select>';
		newNode.SgdDispOrd = '<input type="text" name="SgdDispOrd" value="'+rowData[0].SgdDispOrd+'" />';
		newNode.SgdSysDesc = '<input type="text" name="SgdSysDesc" value="'+rowData[0].SgdSysDesc+'" />';
		newNode.SgdType = rowData[0].SgdType;
		grid.updateNode(row.rowKey, newNode);

	}
	


	//엑셀 다운로드 기능 추가
	function excelDown() {

		var url = "/stmt/excel";

		var sFrm = $("#sFrm"), formData = sFrm.serializeObject();

		var excelFileName = "품목분류관리";
		var excelTitle = "품목 분류관리 리스트";

		fnExcelDown(url, excelFileName, excelTitle, gridMt, formData,
				"#export-form");
	}
</script>
</html>