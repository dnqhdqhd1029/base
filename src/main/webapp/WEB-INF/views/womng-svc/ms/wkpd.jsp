<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/header.jsp"%>
<meta charset="UTF-8">
<title>작업장 인원관리</title>
</head>
<body>
	<div
		class="container-fluid">
		
		<form id="sFrm">
					<div id="searchList">
						<dl
							class="dl-layout four"
							style="width: 100%;">
							<dt>직종</dt>
							<dd>
								<select
									class="form-control input-sm"
									id="HRMM_OCPCD"
									name="HRMM_OCPCD">
								</select>
							</dd>
							<dt>부서</dt>
							<dd>
								<div class="form-inline">
									<input
										type="text"
										class="form-control input-sm autoComplete"
										id="HRMM_DPTCD_DESC"
										name="HRMM_DPTCD_DESC"
										maxlength="20"
										style="width: 63%;"
										placeholder="부서명"
										data-url="getDeptList"
										data-type="name"
										data-target_value_id="HRMM_DPTCD"
										data-target_label_id="HRMM_DPTCD_DESC">
									<input
										type="text"
										class="form-control input-sm"
										id="HRMM_DPTCD"
										name="HRMM_DPTCD"
										maxlength="20"
										placeholder="부서코드"
										style="width: 37%;">
								</div>
							</dd>
							<dt>작업장명</dt>
							<dd>
								<div class="form-inline">
									<input
										type="text"
										class="form-control input-sm autoComplete"
										id="WOEMP_WKCTR_DESC"
										name="WOEMP_WKCTR_DESC"
										maxlength="20"
										placeholder="작업장명"
										data-url="getWkCtrList"
										data-type="name"
										data-target_value_id="WOEMP_WKCTR"
										data-target_label_id="WOEMP_WKCTR_DESC"
										style="width: 50%;">
									<input
										type="text"
										class="form-control input-sm"
										id="WOEMP_WKCTR"
										name="WOEMP_WKCTR"
										maxlength="20"
										placeholder="작업장코드"
										style="width: 50%;">
								</div>
							</dd>
							<dt>성명(사번)</dt>
							<dd>
								<div class="form-inline">
									<input
										type="text"
										class="form-control input-sm autoComplete"
										id="HRMM_NAME1"
										name="HRMM_NAME1"
										maxlength="20"
										placeholder="성명"
										data-url="getEmployeeList"
										data-type="name"
										data-target_value_id="HRMM_EMPNO"
										data-target_label_id="HRMM_NAME1"
										style="width: 50%;">
									<input
										type="text"
										class="form-control input-sm"
										id="HRMM_EMPNO"
										name="HRMM_EMPNO"
										maxlength="20"
										placeholder="사번"
										style="width: 50%;">
								</div>
							</dd>
						</dl>
						<dl
							class="dl-layout four"
							style="border-top: none; margin-top: -5px; margin-bottom: 10px;">
							<dt>작업장 지정</dt>
							<dd>
								<select
									class="form-control input-sm"
									id="GUBN"
									name="GUBN">
									<option value="">전체</option>
									<option value="Y">Y</option>
									<option value="N">N</option>
								</select>
							</dd>
						</dl>
					</div>
					<div
						id="searchBtnSet"
						class="text-right">
						<button
							type="submit"
							class="btn btn-sm btn-primary">조회</button>
						<button
							type="button"
							id="btnExcel"
							class="btn btn-sm btn-success"
							onclick="excelDown();">Excel Download</button>
						<button
							type="button"
							class="btn btn-sm btn-default"
							onclick="init();">초기화</button>
					</div>
				</form>
				
		<div
			id="gridWrapper">
			<p id="sub_title">
				<img
					alt="icon"
					src="/images/img_sub_title_seil.png"
					style="float: left;"> 작업장별 사원 현황 <span style="float: right; margin-top: 10px;"> <span style="font-size: 13;">전체 </span><span
					style="font-size: 13;"
					id="totalCount">0 건</span>
				</span>
			</p>
			<div
				id="table"
				style="width: 100%; position: relative;">
				<table id="ci-grid1">
				</table>
			</div>
			<div
				id="gridBtnSet"
				style="margin-top: 10px;">
				<div
					class="text-right">
					<div class="form-inline">
						<label for="WkpdIdx">사원코드</label>
						<input
							type="hidden"
							id="WkpdIdx" />
						<input
							type="text"
							class="form-control input-sm autoComplete"
							id="WkpdEmpno"
							maxlength="20"
							style="width: 150px;"
							placeholder="사원이름"
							readonly="readonly">
						<label for="WkpdIdx">작업장 코드</label>
						<input
							type="text"
							class="form-control input-sm autoComplete"
							id="WkpdWkctr"
							maxlength="20"
							style="width: 150px;"
							placeholder="작업장코드">
						<button
							type="button"
							class="btnChangeStatus btn btn-sm btn-default"
							id="wkpdUpdate">선택변경</button>
						<button
							type="button"
							class="btnChangeStatus btn btn-sm btn-default"
							id="wkpdDelete">선택삭제</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script
		id="ci-grid-template"
		type="text/template">
    <table width="100%" height="300px">
        <thead>
            <tr>
				<th name="WkpdIdx" align="center" width="150px">인덱스(PK)</th>
				<th name="WkpdEmpno" align="center" width="100px">사원코드</th>
				<th name="WkpdWkctr" align="center" width="100px">작업장 코드</th>
				<th name="WkpdRegDate" align="center" width="100px">등록일</th>
				<th name="WkpdRegUser" align="center" width="200px">등록 유저</th>
            </tr>
        </thead>
        <tbody>
            <tr>
				<td data-key name="WkpdIdx" bind="WkpdIdx" ></td>
				<td name="WkpdEmpno" bind="WkpdEmpno" ></td>
				<td name="WkpdWkctr" bind="WkpdWkctr" ></td>
				<td name="WkpdRegDate" bind="WkpdRegDate" ></td>
				<td name="WkpdRegUser" bind="WkpdRegUser" ></td>
            </tr>
        </tbody>
    </table>
	</script>
	<script type="text/javascript">
		var table = $('#ci-grid1');
		var template = $('#ci-grid-template');

		var grid = webponent.grid.init(table, template, {
			rowSelectable : true
		});
		var jsonData = {
			'keyword' : 'test',
		}

		function draw() {
			$.ajax({
				cache : false,
				url : '/wkpdList',
				type : 'POST',
				data : JSON.stringify(jsonData),
				dataType : "json",
				contentType : 'application/json;charset=utf-8',
				success : function(resp) {
					console.log(resp.result.list)
					grid.removeRow();
					grid.appendRow(resp.result.list);
					btnFlag(false)
					/* inputMode(true) //그리드그려지고 쓰기모드 잠금 */

				},
				error : function(error) {
					alert("에러발생 관리자에게 문의하세요. 에러코드 = " + error);
				}
			});
		}

		// 버튼 보여짐유무
		function btnFlag(btnNew) {
			if (btnNew == false) {
				$("#gridBtnSet").addClass("hidden");
			} else {
				$("#gridBtnSet").removeClass("hidden");
			}

		}

		//로우 클릭시 발생하는 이벤트
		$(grid.markup.main.body.tbody).on("click", "tr", function(e) {
			var input = $(this);
			var $tr = input.closest('tr');
			var tr = $tr[0];
			var rowIndex = tr.index;
			var rowData = tr.data;
			var result;
			btnFlag(true);

			$("#WkpdIdx").val(rowData.WkpdIdx)
			$("#WkpdEmpno").val(rowData.WkpdEmpno)
			$("#WkpdWkctr").val(rowData.WkpdWkctr)
		});

		//선택변경 클릭시 업데이트
		$(document).on('click', '#wkpdUpdate', function() {
			let WkpdIdx = $('#WkpdIdx').val(); //PK값
			let WkpdEmpno = $('#WkpdEmpno').val(); //사원코드
			let WkpdWkctr = $('#WkpdWkctr').val(); //작업장코드
			let updateData = {
				'WkpdIdx' : WkpdIdx,
				'WkpdEmpno' : WkpdEmpno,
				'WkpdWkctr' : WkpdWkctr
			}
			$.ajax({
				url : '/wkpdUpdate',
				type : 'POST',
				data : JSON.stringify(updateData),
				dataType : 'json',
				contentType : 'application/json;charset=utf-8',
				success : function() {
					draw();
				},
				error : function(error, status, msg) {
					alert("에러발생 관리자에게 문의하세요. 에러메세지 = " + msg);
				}
			})

		})

		//삭제 클릭시 삭제기능추가
		$(document).on('click', '#wkpdDelete', function() {

			let WkpdIdx = $('#WkpdIdx').val(); //PK값
			let WkpdEmpno = $('#WkpdEmpno').val(); //사원코드
			let deleteData = {
				'WkpdIdx' : WkpdIdx,
				'WkpdEmpno' : WkpdEmpno
			}
			if (confirm("선택한 정보를 삭제하시겠습니까?")) {
				$.ajax({
					url : '/wkpdDelete',
					type : 'POST',
					data : JSON.stringify(deleteData),
					dataType : 'json',
					contentType : 'application/json;charset=utf-8',
					success : function() {
						alert('사원정보 삭제가 완료되었습니다.')
						draw();
					},
					error : function(error, status, msg) {
						alert("에러발생 관리자에게 문의하세요. 에러메세지 = " + msg);
					}
				})
			}

		})

		$(document).ready(function() {
			draw();
		})
	</script>
</body>
</html>