<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/header.jsp"%>
<meta charset="UTF-8">
<title>품목분류관리</title>
<style type="text/css">
/*input[type="checkbox"] {
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	background: #fff;
	border-radius: 4px;
	cursor: pointer;
	height: 16px;
	outline: 0;
	width: 16px;
}
input[type="checkbox"]:checked {
	background-color: skyblue;
}*/
</style>
</head>
<body>
	<div class="container-fluid">
		<form id="sFrm">
		<!-- <dl
				class="dl-layout four"
				id="searchSet"
				style="margin-bottom: 10px;">
				<dt>제품군1</dt>
				<dd>
					<select
						class="form-control input-sm"
						id="SygdGroupCode"
						name="SygdGroupCode"></select>
				</dd>
				<dt>대분류</dt>
				<dd>
					<select
						class="form-control input-sm"
						id="selectGr2Code"
						name="selectGr2Code"></select>
				</dd>
				<dt>중분류</dt>
				<dd>
					<select
						class="form-control input-sm"
						id="selectGr3Code"
						name="selectGr3Code"></select>
				</dd>
				<dt>소분류</dt>
				<dd>
					<select
						class="form-control input-sm"
						id="selectGr4Code"
						name="selectGr4Code"></select>
				</dd>
			</dl>
			<div
				id="searchBtnSet"
				class="text-right">
				<button
					type="button"
					onclick="search();"
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
			</div> -->
		
		 <div class="content-search " id="searchSet">
	        <div class="row">
	        	 <div class="col">
	        			 <select
						class="form-control input-sm"
						id="SygdGroupCode"
						name="SygdGroupCode"></select>
	        	</div>
	        	<div class="col">
	        			<select
						class="form-control input-sm"
						id="selectGr2Code"
						name="selectGr2Code"></select>
	        	</div>
	        	<div class="col">
	        			 <select
						class="form-control input-sm"
						id="selectGr3Code"
						name="selectGr3Code"></select>
	        	</div>
	        	<div class="col">
	        			 <select
						class="form-control input-sm"
						id="selectGr4Code"
						name="selectGr4Code"></select>
	        	</div>
	        </div>
	        
	        
        	 <div class="search-btn" id="searchBtnSet">
	              <button class="btn mr10"><i class="ic-search"></i>조회</button>
	              <button class="btn mr10"><i class="ic-exle"></i>엑셀</button>
	              <button class="btn"><i class="ic-reset"></i>초기화</button>
            </div>
        
        </div>
			
		</form>
		<div id="gridWrapper">
		
			<div id="sub_title">
				
				<h2 class="title">품목분류 설정내역 &nbsp;</h2>
			
				
				<select id="row_cnt">
					<option value="10">10건씩 보기</option>
					<option
						value="15"
						selected>15건씩 보기</option>
					<option value="20">20건씩 보기</option>
					<option value="50">50건씩 보기</option>
					<option value="100">100건씩 보기</option>
					<option value="500">500건씩 보기</option>
					<option value="1000">1000건씩 보기</option>
				</select>
			</div>
			<form id="gridFrm">
				<table id="grid-table"></table>
			</form>
		
		
		<form id="export-form"></form>
		<script
			id="grid-template"
			type="text/template">
			<table>
				<thead>
					<tr>
						<td name="ItcmIdx" visibility="hidden">NO</td>
						<td name="ItcmL1SysCode" width="280px">제품군</td>
						<td name="ItcmL2GrCode" width="280px">대분류</td>
						<td name="ItcmL3GrCode" width="280px">중분류</td>
						<td name="ItcmL4GrCode" width="280px">소분류</td>
						<td name="ItcmRmks" >비고</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td data-key name="ItcmIdx" bind="ItcmNo"></td>
						<td data-name="ItcmL1SysCode">[ {{ItcmL1SysCode}} ] {{ItcmL1SysCodeName}}</td>
						<td data-name="ItcmL2GrCode">[ {{ItcmL2GrCode}} ] {{ItcmL2GrCodeName}}</td>
						<td data-name="ItcmL3GrCode">[ {{ItcmL3GrCode}} ] {{ItcmL3GrCodeName}}</td>
						<td data-name="ItcmL4GrCode">[ {{ItcmL4GrCode}} ] {{ItcmL4GrCodeName}}</td>
						<td name="ItcmRmks" bind="ItcmRmks"></td>
					</tr>
				</tbody>
			</table>
		</script>
		<div id="gridBtnSet">
			<p class="text-right">
				<button
					type="button"
					id="btnSave"
					class="btn btn-sm btn-success hidden">저장</button>
				<button
					type="button"
					id="btnReg"
					class="btn btn-sm btn-primary">추가</button>
				<button
					type="button"
					id="btnCancel"
					class="btn btn-sm btn-default hidden"
					onclick="init();">취소</button>
				<button
					type="button"
					id="btnDel"
					class="btn btn-sm btn-danger">삭제</button>
			</p>
		</div>
		</div>
	</div>
	<script>
		const checkboxes = document
				.getElementsByTagName('input[type=checkbox]');

		let table = $('#grid-table');
		let template = $('#grid-template');
		let options = {};

		let cnt = $('#row_cnt').val();
		let gridCnt = 0;

		options.rowSelectable = true;
		options.id = table.attr("id");
		options.checkBox = {
			cellType : 'td',
			cellWidth : '50px',
			align : 'center'
		};
		options.paging = {
			countPerPage : cnt
		}

		let grid = webponent.grid.init(table, template, options);

		grid.on("rowRendered", function(e, row, data, index) {
			gridCnt = gridCnt + 1;
		});

		let mode = "READ";
		let updateList = {}; // 업데이트되는 노드 기록용(업데이트,등록 후 초기화되는 변수)
		let selectBox = [];
		selectBox[0] = { //제품군
			"SygdGroupCode" : "PL0001"
		}
		selectBox[1] = { //대분류
			"selectGr2Code" : "selectGr2Code"
		}
		selectBox[2] = { //중분류
			"selectGr3Code" : "selectGr3Code"
		}
		selectBox[3] = { //소분류
			"selectGr4Code" : "selectGr4Code"
		}

		$(document).ready(function() {
			selectBox.forEach(function(selectBox) {
				fnMakeSelectBox(selectBox)
			})
			resize();
		});

		$('#row_cnt').on('change', function() {
			grid.settings.paging.countPerPage = $('#row_cnt').val();
			search();
		})

		// 그리드 사이즈 조정
		function resize() {
			var height = $(window).height();
			var searchSetHeight = $("#searchSet").height();
			var subTitle = $("#sub_title").height();
			var gridBtnSet = $("#gridBtnSet").height();
			var etc = 120;

			var gridHeight = height - searchSetHeight - subTitle - gridBtnSet
					- etc;

			grid.setGridHeight(gridHeight);
		}

		// 조회버튼
		function search() {

			var formData = $("#sFrm").serializeObject(); // 조회 조건의 값들을 오브젝트로 변환해서 넘겨주기

			$.ajax({
				url : "/itcm/list",
				data : formData,
				dataType : "json",
				type : "GET",
				contentType : "application/json; charset=utf-8", // 이게 뭘까--
				success : function(a) {
					// 페이징 안 한거임
					grid.removeRow();
					grid.appendRow(a.list);
					resize();
				}
			})
		}

		// 검색 옵션 초기화, 취소 버튼 및 그리드 새로고침
		function init() {

			$("#sFrm select").each(function() { // 조회 조건에 있는 select 박스 비워주기
				var $input = $(this);
				$input.val("");
				$input.val("").prop("selected", true);
			});

			mode = "READ";

			// 
			if ($("#btnReg").hasClass("hidden"))
				$("#btnReg").removeClass("hidden"); // 추가버튼 hidden -> hidden 지우기 : 추가버튼 보여주기(의미없음)
			if ($("#btnDel").hasClass("hidden"))
				$("#btnDel").removeClass("hidden"); // 삭제버튼 hidden -> hidden 지우기 : 삭제버튼 보여주기
			if (!$("#btnSave").hasClass("hidden"))
				$("#btnSave").addClass("hidden"); // 저장버튼 hidden x -> hidden 추가 : 저장버튼 숨기기
			if (!$("#btnCancel").hasClass("hidden"))
				$("#btnCancel").addClass("hidden"); // 취소버튼 hidden x -> hidden 추가 : 취소버튼 숨기기

			updateList = {};
			search();
		}

		// 추가 버튼
		$(document).on("click", "#btnReg", function() {
			if (mode == "EDIT")
				return false;

			mode = "REG";
			add(); // 그리드에 로우 한 줄씩 추가

		});

		// 그리드에 로우 한 줄씩 추가(단순 추가)
		function add() {

			var newRow = []; // 배열생성
			var newRowData = {}; // 객체생성

			newRowData["ItcmNo"] = gridCnt + 1;
			newRowData["ItcmL1SysCode"] = "";
			newRowData["ItcmL1SysCodeName"] = "";
			newRowData["ItcmL2GrCode"] = "";
			newRowData["ItcmL2GrCodeName"] = "";
			newRowData["ItcmL3GrCode"] = "";
			newRowData["ItcmL3GrCodeName"] = "";
			newRowData["ItcmL4GrCode"] = "";
			newRowData["ItcmL4GrCodeName"] = "";
			newRowData["ItcmRmks"] = "";

			// 만들어준 객체들을 배열에 다 넣어줌
			newRow.push(newRowData);

			// prependRow : 그리드에 로우를 prepend 한다.
			grid.prependRow(newRow);

			// 그리고 그리드에 만들 배열을 한 줄 추가함
			// gridgetRow(start, end); : 그리드에서 로우가 담긴 배열을 가져온다.
			// 아무 인자도 넘겨주지 않으면 모든 로우를
			// 첫번째 인자반 넘기면 해당 인덱스의 로우를
			// 첫번째와 두번째 둘다 넘기면 해당 범위의 로우를 가져온다.
			// 이건 그냥 webponent에서 이렇게 쓰라고 만든거임 외우려고 하지마
			let addedRow = grid.getRow(0)
			let $tr = $(addedRow);

			changeNode(addedRow, $tr);

		}
		//	그리드 로우 수정
		function edit(row) {

			var $tr = $(row);

			changeNode(row, $tr);

			$tr.find("input[name=IcmRmks]").focus();

			//	추가버튼 비활성화
			$("#btnReg").addClass("hidden");
		}

		// 추가해준 로우의 속성 변경 : 데이터, select 박스, 컬러 등
		function changeNode(row, $tr) {

			let rowData = row.data;

			// 추가해준 로우의 데이터들 중 null값을 공백으로 변경
			for ( var key in rowData) {

				if (isEmpty(rowData[key])) {
					rowData[key] = "";
				}
			}

			var newNode = {}; // 객체 생성

			// 추가해준 로우중 제품군, 대분류, 중분류, 소분류들을 select 박스의 형태로 바꿔줌
			if (mode == "REG") {
				newNode.ItcmL1SysCode = '<select name="ItcmL1SysCode" class="selectBack">'
						+ $("#SygdGroupCode").html() + '</select>'; // 제품군
				newNode.ItcmL2GrCode = '<select name="ItcmL2GrCode" class="selectBack">'
						+ $("#selectGr2Code").html() + '</select>'; // 대분류
				newNode.ItcmL3GrCode = '<select name="ItcmL3GrCode" class="selectBack">'
						+ $("#selectGr3Code").html() + '</select>'; // 중분류
				newNode.ItcmL4GrCode = '<select name="ItcmL4GrCode" class="selectBack">'
						+ $("#selectGr4Code").html() + '</select>'; // 소분류
			}

			newNode.ItcmRmks = '<input type="text" name="ItcmRmks" value="'+rowData.ItcmRmks+'"/>'; // 비고

			grid.updateNode(row.rowKey, newNode);

			$tr.css("background", "#e2eff5"); // 로우 배경색 하늘 색으로 바꿔주고

			$("#btnSave").removeClass("hidden"); //	저장버튼 활성화
			$("#btnCancel").removeClass("hidden"); // 취소버튼 활성화
			$("#btnDel").addClass("hidden"); // 삭제버튼 비활성화
		}

		//폼 필수값 검증
		function validRequired($inputs) {
			var boolRs = true;

			$($inputs).each(function() {
				var $this = $(this);
				var isRequired = $this.prop("required");

				$this.parent().removeClass("has-error");

				if (isRequired) {

					if (isEmpty($this.val())) {
						alert("필수 입력항목을 입력하시기 바랍니다.");
						$this.parent().addClass("has-error");
						$this.focus();
						boolRs = false;
						return false;
					}
					/*else if($this.val().length < 2){
						alert("두글자 이상 입력하시기 바랍니다.");
						$this.parent().addClass("has-error");
						$this.focus();
						boolRs = false;
						return false;
					}		*/
				} else if ($this.find("option:checked").text() == "선택") {
					alert("필수 항목을 선택하시기 바랍니다.");
					$this.parent().addClass("has-error");
					$this.focus();
					boolRs = false;
					return false;
				}
			});

			return boolRs;
		}

		//	저장(추가 or 수정)
		function save() {

			var formData = {};

			if (mode == "REG") {
				//	필수값 검증
				if (validRequired("#gridFrm select") == false)
					return false;
			}

			if (Object.keys(updateList).length > 0) {

				var dataList = new Array();

				for ( var key in updateList) {

					dataList.push(updateList[key]);
				}

				formData.list = dataList;
			} else {
				init();
				return false;
			}

			var url = "/itcm/save";
			console.log(formData)

			if (confirm("저장하시겠습니까?"))
				submitJSON(url, formData);
		}

		function submitJSON(_url, formData) {
			$.ajax({
				url : _url,
				type : 'POST',
				data : JSON.stringify(formData),
				dataType : 'json',
				contentType : 'application/json;charset=utf-8',
				success : function(resp) {
					alert(resp.message);
					search();
				},
				error : function(msg) {
					alert("에러발생 관리자에게 문의하세요. 에러메세지 = " + msg);
				}
			})

			updateList = {};
		}

		// 저장 버튼
		$(document).on("click", "#btnSave", function() {

			// 추가사항 저장 시 수정되지 않은 로우는 삭제
			let gridRows = grid.getRow() // 그리드에 담긴 배열을 모두 가져옴
			let removeTargetKey = []; // 배열 생성

			// 가져온 그리드의 갯수 만큼 반복문
			for (var i = 0; i < gridRows.length; i++) {
				var row = gridRows[i];
				let status = "noneEdited";
				for ( var key in row) {
					// 데이터 키를 제외한 나머지 컬럼들 중 하나라도 값이 있으면 상태를 edited로 변경
					// 비고에 문자 넣었으면 여기를 타야하는데 안 타넹... 여기 확인하기
					if (key != "ItcmNo") {
						if (!isEmpty(row[key])) {
							status = "edited";
						}
					}
				}

				// 수정되지 않은 로우의 데이터 키를 배열에 저장 / updateList에서 해당 데이터 삭제
				if (status == "noneEdited") {
					removeTargetKey.push(row.rowKey);
					delete updateList[row.rowKey];
				}
			}

			// 배열 속 데이터 키로 로우의 index를 구해서 해당로우 삭제함
			for (var j = 0; j < removeTargetKey.length; j++) {
				grid.removeRow(fnGetRowIndex(removeTargetKey[j], grid));
			}

			save();
		});
		//data-key 로 그리드 로우의 인덱스 찾기
		function fnGetRowIndex(dataKey, grid) {
			var rows = grid.getRow(), rowIndex = 0;

			for (i = 0; i < rows.length; i++) {
				if (rows[i].rowKey == dataKey) {
					rowIndex = rows[i].index;
				}
			}

			return rowIndex;
		}
		$(document).on(
				"submit",
				"#sFrm",
				function() { // 이거 뭔데..
					if (mode != "READ") {
						alert("수정사항을 저장하시거나 취소해주시기 바랍니다.");
						return false;
					}

					var filter = {};
					$("#sFrm select")
							.each(
									function() {
										var $this = $(this), value = $this
												.val(), name = $this
												.attr("name");

										if (!isEmpty(value))
											filter[name] = value;
									});

					search();

					return false;
				});

		let groupType;

		function fnMakeSelectBox(_Code) {
			let options;
			$
					.ajax({
						url : '/itcm/' + Object.keys(_Code),
						Type : 'GET',
						data : _Code,
						dataType : 'json',
						contentType : 'application/json;charset=utf-8',
						success : function(resp) {
							options += "<option value=''>선택</option>";
							$(resp.list)
									.each(
											function(i) {
												options += "<option value='"+resp.list[i].OPT_CODE+"'>"
														+ resp.list[i].OPT_NAME
														+ "</option>";
											});

							let selectIdkey = "#" + Object.keys(_Code);
							fnMakeSelectBox2(selectIdkey, options)
						},
						error : function(error, status, msg) {
							alert("에러발생 관리자에게 문의하세요. 에러메세지 = " + msg);
						}
					})

		}

		//셀렉트박스 생성 메소드
		function fnMakeSelectBox2(selectId, options) {
			$(selectId).empty();
			$(selectId).append(options);
		}

		//그리드 업데이트이벤트
		grid.event.on("updated", function(e, rowkey, updatedData, rowData) {
			if (updateList[rowData.ItcmNo]) {
				_.extend(updateList[rowData.ItcmNo], updatedData);
			} else {
				var data = {};
				_.extend(data, updatedData);
				updateList[rowData.ItcmNo] = data;
			}

		});

		//		그리드 내용이 수정될때 그리드 데이터 업데이트
		$(grid.markup.main.body.tbody).on("change", "tr", function(e) {
			var row = this, $target = $(e.target);

			var data = {};
			data[$target.attr("name")] = $target.val();

			if (mode == "EDIT") {
				data["ItcmL1SysCode"] = row.data.ItcmL1SysCode;
				data["ItcmL2GrCode"] = row.data.ItcmL2GrCode;
				data["ItcmL3GrCode"] = row.data.ItcmL3GrCode;
				data["ItcmL4GrCode"] = row.data.ItcmL4GrCode;
			}

			grid.updateData(row.rowKey, data);
		});

		//삭제 버튼 클릭시 작동 메소드
		$(document).on("click", "#btnDel", function() {
			let rowData = grid.getCheckedRowData();
			if (rowData.length == 0) {
				alert("삭제 하실항목을 클릭해 주시기 바랍니다.");
				return false;
			}

			if (confirm(rowData.length + "개의 항목을 삭제하시겠습니까?")) {
				let url = "/itcm/delete"
				let formData = {};

				formData.list = rowData;

				submitJSON(url, formData);
			}
		});

		//엑셀 다운로드 기능 추가
		function excelDown() {

			var url = "/itcm/excel";

			var sFrm = $("#sFrm"), formData = sFrm.serializeObject();

			var excelFileName = "시스템코드 리스트";
			var excelTitle = "시스템코드 리스트";

			fnExcelDown(url, excelFileName, excelTitle, grid, formData,
					"#export-form");
		}
	</script>
</body>
</html>