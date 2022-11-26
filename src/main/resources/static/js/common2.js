/*
 *	fnExcelDown
 *	- 엑셀파일 다운로드
 *	@fileName: 엑셀파일 다운로드시 출력되는 파일명
 *	@title: 엑셀파일 상단에 표기되는 제목
 *	@grid: 엑셀 데이터로 출력할 grid
 *	@params: 조회할 파라미터 object
 *	@formId: #포함 ex) #export-form
 *	@SearchDateName : 조회 기간 명칭
 *  @SDATE : 조회 조건 기간 FROM 
 *	@EDATE : 조회 조건 기간 TO
 *	body에 <form id="export-form"></form> 포함시킬것
 */
function fnExcelDown(url, fileName, title, grid, params, formId, SearchDateName, SDATE, EDATE, flags) {

	let options = {};

	options.fileName = fileName;
	options.title = title;
	options.fieldKeys = fnGetGridNameArray(grid, flags);
	options.labels = fnGetGridLabelArray(grid, flags);
	if (!isEmpty(SearchDateName)) {
		options.SearchDateName = SearchDateName;
		options.SDATE = SDATE;
		options.EDATE = EDATE;
	}

	let data;

	data = grid.getData();

	let f = $(formId);

	let hidden = '<input type="hidden" name="commonData" id="export-form-data">';

	f.html(hidden);

	for (key in params) {
		let hidden2 = '<input type="hidden" name="' + key + '" value="' + params[key] + '">';
		f.append(hidden2);
	}

	let $hidden = $("#export-form-data");
	$hidden.val(JSON.stringify(options));

	f.attr("action", url);
	f.attr("method", "post");
	f.trigger("submit");
}

/**************************************************************************************************************************************************** 
* grid 라벨 배열 얻기
*****************************************************************************************************************************************************/
function fnGetGridLabelArray(grid, flagRs) {
	let columnNames = grid.getColumnNames();
	let columnLabels = [];
	for (let i = 0; i < columnNames.length; i++) {

		let col = grid.getColumnInfo(columnNames[i]);

		if (!flagRs) {
			columnLabels.push(col.label);
		}

		else {
			if (col.visibility != 'hidden') {
				columnLabels.push(col.label);
			}
		}
	}

	return columnLabels;
}
function fnGetGridNameArray(grid, flagRs) {
	let columnNames = grid.getColumnNames();
	let columnLabels = [];
	for (let i = 0; i < columnNames.length; i++) {

		let col = grid.getColumnInfo(columnNames[i]);
		if (!flagRs) {
			columnLabels.push(col.name);
		}
		else {
			if (col.visibility != 'hidden') {
				columnLabels.push(col.name);
			}
		}
	}

	return columnLabels;
}

