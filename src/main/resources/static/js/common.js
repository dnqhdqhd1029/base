/*****************************************************************************************************************************************************
 *   F5키 눌렀을때 아이프레임만 새로고침 하기     
 ****************************************************************************************************************************************************/
document.onkeydown = fkey;
/*document.onkeypress = fkey
document.onkeyup = fkey;*/

var wasPressed = false;

function fkey(e){
   e = e || window.event;
   if( wasPressed ) return; 
      
   if (e.keyCode == 116) {
       
       var iframeWrapper;
       
      if(self == top){
         var iframeWrapper = $("#iframe_wrapper");
         reloadActiveIframe(iframeWrapper);
      }
      else {
         var iframeWrapper = $("#iframe_wrapper", parent.document);
         reloadActiveIframe(iframeWrapper);
      }
      wasPressed = true;
      return false;
    }   
}

/*****************************************************************************************************************************************************
 *    reloadActiveIframe 개체 화면로드시 src 호출용
 *****************************************************************************************************************************************************/
function reloadActiveIframe(iframeWrapper){
   var activeIframe = iframeWrapper.find("iframe.show");
   if(activeIframe.length > 0){
      var _url = activeIframe.attr("src");
      activeIframe.attr("src", _url);
   }
}

/*****************************************************************************************************************************************************
 *   화면 준비 공통 이벤트
*****************************************************************************************************************************************************/
$(document).ready(function () {
   //그리드내 선택 영역 표시 후 영역 안에 내용 담기
   $(".CI-GRID-BODY-TABLE").selectable({
      create: function (event, ui) { },
      filter: "td",
      distance: 2
   })

   //클래스 datePicker 를 가지고 있는 input 박스 달력 버튼 추가
   $(".datePicker").datepicker();

   //그리드 개체를 찾아서 사이즈를 공간에 맞춰서 조정
   gridResize();

   //인터넷 사이즈 조정시 마다 이벤트
   $(window).resize(function () {
      gridResize();
   });
});

/****************************************************************************************************************************************************
 * 페이지 서버 처리
 ****************************************************************************************************************************************************/
var pagingInfo = {
   countPerPage: 15,
   paginationCount: 10,
   freezeScrollerY: ""
};

var PageListIndex = 0;
var vStartPageIndex = 0;
var vCurrentPageIndex = 0;
var uiPlugIn;

function setPage(gridObj, rowCnt) {

   if (rowCnt != null) { pagingInfo.countPerPage = rowCnt; }

   uiPlugIn = webponent.grid.UIplugin.init(gridObj, {
      paging: {
         type: "server",
         countPerPage: pagingInfo.countPerPage,
         paginationCount: pagingInfo.paginationCount,
         freezeScrollerY: pagingInfo.freezeScrollerY,
         pageSelected: function (pagingInfo) {

            if (pagingInfo.startPageListIndex != PageListIndex) {
               vStartPageIndex = pagingInfo.startPageListIndex;
               vCurrentPageIndex = pagingInfo.currentPageIndex;
               PageListIndex = pagingInfo.startPageListIndex;
               search("LIST");
            } else {
               if (PageListIndex == 0) {
                  gridObj.renderingPage(pagingInfo.currentPageIndex);
               } else {
                  gridObj.renderingPage(pagingInfo.currentPageIndex - PageListIndex);
               }
            }
         }
      }
   });

   return uiPlugIn;
}


/*****************************************************************************************************************************************************
 *    gridResize 인터넷 사이즈 조정시 마다 이벤트
 *****************************************************************************************************************************************************/
function gridResize() {
   $(".gridFrm").closest(".row").each(function () {
      var vHeight = $(this).height() - 40;
      $(this).find(".CI-GRID-AREA").each(function () {
         $(this)[0].grid.setGridHeight(vHeight);
      });
   });
}

/*****************************************************************************************************************************************************
<<<<<<< HEAD
=======
 *    reloadActiveIframe 개체 화면로드시 src 호출용
 *****************************************************************************************************************************************************/
function reloadActiveIframe(iframeWrapper) {
   var activeIframe = iframeWrapper.find("iframe.show");
   if (activeIframe.length > 0) {
      var _url = activeIframe.attr("src");
      activeIframe.attr("src", _url);
   }
}

/*****************************************************************************************************************************************************
>>>>>>> ab6734634779d8a552fd13dec4c52138bd7060b1
 *    postAjax 입력용 
 *    @ _url: 컨트롤러 주소
 *  @ _data : 보낼 JSON 데이터
 *  @ _async : 비동기(false), 동기(true)
 *****************************************************************************************************************************************************/
function postAjax(_url, _data, _async) {

   var returnAjax = $.ajax({
      url: _url,
      type: "post",
      contentType: "application/json",
      data: JSON.stringify(_data),
      dataType: "json",
      async: _async
   }).done(function (data) {
      // preconfigured logic for success
   })
      .fail(function (xhr, status, err) {
         //predetermined logic for unsuccessful request
      });
   return returnAjax;
}

/*****************************************************************************************************************************************************
 *    getAjax 조회용 
 *    @ _url: 컨트롤러 주소
 *  @ _data : 보낼 JSON 데이터
 *  @ _async : 비동기(false), 동기(true)
 *****************************************************************************************************************************************************/
function getAjax(_url, _data, _async) {
   var returnAjax = $.ajax({
      url: _url,
      type: "get",
      data: _data,
      dataType: "json",
      async: _async
   }).done(function (data) {
      // preconfigured logic for success
   })
      .fail(function (xhr, status, err) {
         //predetermined logic for unsuccessful request
      });
   return returnAjax;
}

/*****************************************************************************************************************************************************
 *    form 데이터를 Object 형태로 변환
 *****************************************************************************************************************************************************/
jQuery.fn.serializeObject = function() { 
   var obj = null; 
   try { 
      if(this[0].tagName && this[0].tagName.toUpperCase() == "FORM" ) { 
         var arr = this.serializeArray(); 
           if(arr){ obj = {}; 
              jQuery.each(arr, function() {
               obj[this.name] = this.value;   
              }); 
           } 
       } 
   }catch(e) { 
       alert(e.message); 
   }finally {} 
   return obj; 
}

/*****************************************************************************************************************************************************
 *    fnSelectBox(alias, parent, defaultName, selectId, defaultValue, gubn, vData) <select> 안에 옵션 append
 *    @selectId: 반드시 #을 붙일것 ex> #selectBox
 *  @defaultValue: 셀렉트 박스 생성시 선택될 값
 *****************************************************************************************************************************************************/
function fnSelectBox(_url, _code, _selectId, _defaultName, _defaultValue) {
   var options = "";
   var sendData = {
      SygdGroupCode: _code
   };

   if (!isEmpty(_defaultName)) {
      options += "<option value=''>" + _defaultName + "</option>";
   }

   $.ajax({
      url: "/" + _url,
      type: "get",
      data: sendData,
      dataType: "json",
      async: false,
      success: function (_data) {
         $(_data.list).each(function (i) {
            options += "<option value='" + _data.list[i].sygdSysCode + "'>" + _data.list[i].sygdSysName + "</option>";
         });
         $(_selectId).empty();
         $(_selectId).append(options);

         if (!isEmpty(_defaultValue)) {
            $(_selectId).val(_defaultValue).prop("selected", true);
         }
      }
   });
}

/*****************************************************************************************************************************************************
 *    NULL 값 체크 함수
 *****************************************************************************************************************************************************/
function isEmpty(value) {
   if (value == "" || value == null || value == undefined || (value != null && typeof value == "object" && !Object.keys(value).length)) {
      return true;
   } else {
      return false;
   }
}

/*****************************************************************************************************************************************************
 *   Datepicker
 *   클래스 명에 datePicker 추가
*****************************************************************************************************************************************************/
$.datepicker.setDefaults({
   dateFormat: 'yy-mm-dd',
   prevText: '이전 달',
   nextText: '다음 달',
   monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
   monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
   dayNames: ['일', '월', '화', '수', '목', '금', '토'],
   dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
   dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
   showMonthAfterYear: true,
   yearSuffix: '년',
   onSelect: function (dateText, inst) {
   }
});

/*****************************************************************************************************************************************************
 *   Datepicker
 *   날짜 유효성 검사
*****************************************************************************************************************************************************/
$(document).on("change", ".datePicker", function (e) {

   $('#' + e.target.id).attr("maxlength", 10); // 최대길이 설정

   var RegNotNum = /[^0-9]/g;

   var date = this.value;

   date = date.replace(RegNotNum, ''); // 숫자만 남기기

   if (date == "" || date == null || date.length < 5) {
      this.value = date;
      return;
   }

   var DataFormat;
   var RegPhonNum;

   // 날짜 포맷(yyyy-mm-dd) 만들기 
   if (date.length <= 6) {
      DataFormat = "$1-$2"; // 포맷을 바꾸려면 이곳을 변경
      RegPhonNum = /([0-9]{4})([0-9]+)/;
   } else if (date.length <= 8) {
      DataFormat = "$1-$2-$3"; // 포맷을 바꾸려면 이곳을 변경
      RegPhonNum = /([0-9]{4})([0-9]{2})([0-9]+)/;
   }

   date = date.replace(RegPhonNum, DataFormat);

   this.value = date;

   // 모두 입력됐을 경우 날짜 유효성 확인
   if (date.length == 10) {

      var isVaild = true;

      if (isNaN(Date.parse(date))) {
         // 유효 날짜 확인 여부
         isVaild = false;
      } else {

         // 년, 월, 일 0 이상 여부 확인
         var date_sp = date.split("-");
         date_sp.forEach(function (sp) {
            if (parseInt(sp) == 0) {
               isVaild = false;
            }
         });

         // 마지막 일 확인
         var last = new Date(new Date(date).getFullYear(), new Date(date).getMonth() + 1, 0);
         // 일이 달의 마지막날을 초과했을 경우 다음달로 자동 전환되는 현상이 있음 (예-2월 30일 -> 3월 1일)
         if (parseInt(date_sp[1]) != last.getMonth() + 1) {
            var date_sp2 = date_sp.slice(0);
            date_sp2[2] = '01';
            var date2 = date_sp2.join("-");
            last = new Date(new Date(date2).getFullYear(), new Date(date2).getMonth() + 1, 0);
         }
         if (last.getDate() < parseInt(date_sp[2])) {
            isVaild = false;
         }
      }

      if (!isVaild) {
         alert("잘못된 날짜입니다. \n다시 입력하세요.");
         this.value = "";
         this.focus();
         return;
      }
   }

   var inputDate = new Date(this.value);

   $('#' + e.target.id).datepicker("setDate", inputDate);
});

/*****************************************************************************************************************************************************
 *   classRequired : 필수값 검증
 *   @ form : 오브젝트 아이디
*****************************************************************************************************************************************************/
function classRequired(form) {

   $(form + " .required").each(function () {
      if ($(this).val() == "" || $(this).val() == null) {
         $(this).focus();
         alert($(this).prop("title") + "는(은) 필수입력 입니다.");
         flag = false;
         return flag;
      }
   });

   return flag;
}

/*****************************************************************************************************************************************************
 *    fnSystemCode(_code) 시스템 코드 데이터 가져오기
 *    @ _code : SGD_GROUP_CODE
 *****************************************************************************************************************************************************/
function fnSystemCode(_code) {
   var returnData;
   var sendData = {
      SGD_GROUP_CODE: _code
   };
   $.ajax({
      url: "/systemCode",
      type: "get",
      data: sendData,
      dataType: "json",
      async: false,
      success: function (_data) {
         returnData = _data;
      }
   });
   return returnData;
}

/*****************************************************************************************************************************************************
 *    특정 Mapper 데이터 가져오기 
 *  @ _mapperId : 찾아갈 맵퍼 아이디
 *    @ _json : {} 조건값 
 *****************************************************************************************************************************************************/
function fnMapperData(_mapperId, _json) {
   var returnData;
   $.ajax({
      url: "/mapperData",
      type: "get",
      data: _json,
      dataType: "json",
      async: false,
      success: function (_data) {
         returnData = _data;
      }
   });
   return returnData;
}

/*****************************************************************************************************************************************************
 *    그리드 컨트롤 + C 복사 기능 추가 
 *****************************************************************************************************************************************************/
var ctrlDown = false; var ctrlKey = 17, vKey = 86, cKey = 67;
$(document).keydown(function (e) { if (e.keyCode == ctrlKey) ctrlDown = true; }).keyup(function (e) { if (e.keyCode == ctrlKey) ctrlDown = false; });//컨트롤만 눌러도 복사되는 사항 막음    
$(document).keydown(function (event) {
   //컨트롤  + C (복사)
   if (ctrlDown && (event.keyCode == cKey)) {

      if ($(".ui-selected").text() != "" && $(".ui-selected").text() != null) {
         var ttxt = "";
         var thisText = "";

         var $box = $("<input>");

         var vCopyGubn = "";
         $(".ui-selected:not(.hiddenTd):not([name=CI_GRID_CHECKBOX_CONTAINER])", this).each(function () {

            if ($(this).parents("div").hasClass('modal-body')) {
               vCopyGubn = "popup";
            };

            if ($(this).find("input").length > 0) {
               thisText = $(this).find("input").val();
            } else if ($(this).find("select").length > 0) {
               thisText = $(this).find("select option:selected").html();
            } else {
               thisText = $(this).html();
            }
            if (thisText == "") thisText = "   ";

            if (ttxt == "") { ttxt = ttxt + thisText; } else {
               ttxt = ttxt + "   " + thisText;
            }

         });

         if (vCopyGubn == "popup") {
            $("#modal_pop_body").append($box);
         } else {
            $("body").append($box);
         }

         $box.val(ttxt).select();
         document.execCommand("copy");
         $box.remove();

         $('.ui-selected').removeClass('ui-selected');
      }
   }

   if (event.keyCode == 27) {
      $('.ui-selected').removeClass('ui-selected');
   }

   if (event.keyCode == 116) {
      event.keyCode = 0;
      event.cancelBubble = true;
      event.returnValue = false;
      document.location.reload();
      return;
   }
});

/****************************************************************************************************************************************************
 * 그리드 세팅
 * @ _table : 테이블 아이디
 * @ _template : 테이블 스크립트 아이디
 * @ _pagingYN : 페이징 사용여부
 * @ _serverPage : 서버 페이징 사용여부
 ****************************************************************************************************************************************************/
function setGrid(_table, _template, _pagingYN, _checkBoxYn, _rowCnt) {
   var _options = {};
   var rowCnt = 15;
   var checkBox = null;

   var _paging = {
      countPerPage: rowCnt,
      paginationCount: 10,
      freezeScrollerY: 'hide',
      usingMarkUp: true,
      animate: 'basic'
   }

   _options.rowSelectable = true;
   _options.paging = _paging;

   if (_checkBoxYn) {
      checkBox = {
         cellType: 'td',
         cellWidth: '50px',
         align: 'center'
      }
      options.checkBox = checkBox;
   }

   var _grid = webponent.grid.init(_table, _template, options);

   if (_pagingYN) {
      _grid.makePageList();
   }

   return _grid;
}

/****************************************************************************************************************************************************
 * 페이지 정보
 ****************************************************************************************************************************************************/
function getGridPage(gridObj, flag) {
   var paging = {};
   paging.pageNo = (vStartPageIndex * gridObj.settings.paging.countPerPage) + 1;
   paging.countPerPage = paging.pageNo + (pagingInfo.paginationCount * gridObj.settings.paging.countPerPage) - 1;
   return paging;
}

/****************************************************************************************************************************************************
 * 그리드 그리기
 ****************************************************************************************************************************************************/
function drawGrid(url, formData, requestType, returnType, grid, vPaging, vPage) {

   var vData;

   formData.paging = getGridPage(grid);

   if (!vPage) {
      PageListIndex = 0;
      vStartPageIndex = 0;
      vCurrentPageIndex = 0;
   }

   //비동기 
   var vAjax = $.ajax({
      url: url,
      type: requestType,
      data: formData,
      dataType: returnType,
      async: true
   })
      .done(function (data) {

         //ROW_STATUS ( S:조회상태,  N:신규로우,  U:업데이트 )
         for (var i = 0; i < data.length; i++) {
            data[i]["ROW_STATUS"] = "S";
         }

         grid.removeRow();
         grid.appendRow(data);

         if (vPaging) {
            setPageInit(grid, uiPlugIn, vPage);
         }

         vData = data;

         gridResize();

      });

   return vAjax;
}


/****************************************************************************************************************************************************
 * 그리드 리사이즈
 ****************************************************************************************************************************************************/
function gridResize() {
   $(".gridFrm").closest(".row").each(function () {
      var vHeight = $(this).height() - 40;
      $(this).find(".CI-GRID-AREA").each(function () {
         $(this)[0].grid.setGridHeight(vHeight);
      });
   });

   //그리드내 선택 영역 표시 후 영역 안에 내용 담기{
   $(".CI-GRID-BODY-TABLE").selectable({
      create: function (event, ui) { },
      filter: "td",
      distance: 2
   })
}

/**
 * uuid 생성
 * @return {String} 랜덤 uuid 반환
 */
function guid() {
	
	function s4() {
      return ((1 + Math.random()) * 0x10000 | 0).toString(16).substring(1);
    }
    return s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();

}

/****************************************************************************************************************************************************
 * 페이지 정보
 ****************************************************************************************************************************************************/
function getGridPage(gridObj, flag) {
	var paging = {};
	paging.pageNo = (vStartPageIndex * gridObj.settings.paging.countPerPage) + 1;
	paging.countPerPage = paging.pageNo + (pagingInfo.paginationCount * gridObj.settings.paging.countPerPage) - 1;
	return paging;
}

/****************************************************************************************************************************************************
 * 그리드 그리기
 ****************************************************************************************************************************************************/
function drawGrid(url, formData, requestType, returnType, grid, vPaging, vPage) {

	var vData;

	formData.paging = getGridPage(grid);

	if (!vPage) {
		PageListIndex = 0;
		vStartPageIndex = 0;
		vCurrentPageIndex = 0;
	}

	//비동기 
	var vAjax = $.ajax({
		url: url,
		type: requestType,
		data: formData,
		dataType: returnType,
		async: true
	})
		.done(function (data) {

			//ROW_STATUS ( S:조회상태,  N:신규로우,  U:업데이트 )
			for (var i = 0; i < data.length; i++) {
				data[i]["ROW_STATUS"] = "S";
			}

			grid.removeRow();
			grid.appendRow(data);

			if (vPaging) {
				setPageInit(grid, uiPlugIn, vPage);
			}

			vData = data;

			gridResize();

		});

	return vAjax;
}


/*****************************************************************************************************************************************************
 *	fnFormClear
 *	폼 초기화 용
 *  fromContetn : #sFrm select, #sFrm input[type=text], #sFrm
*****************************************************************************************************************************************************/
function fnFormClear(formContent){
	//셀렉트 박스 인풋박스 모두 초기화
	$(formContent).each(function(){
		var $input = $(this);
		$input.val("");
		$input.val("").prop("selected",true);
	});
}

/****************************************************************************************************************************************************
 * 그리드 리사이즈
 ****************************************************************************************************************************************************/
function gridResize() {
	$(".gridFrm").closest(".row").each(function () {
		var vHeight = $(this).height() - 40;
		$(this).find(".CI-GRID-AREA").each(function () {
			$(this)[0].grid.setGridHeight(vHeight);
		});
	});

}


