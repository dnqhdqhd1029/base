<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${mode eq 'EDIT'}">
	<c:set var="isReadonly" value="readonly"/>
</c:if>

<form id="regFrm" class="form-horizontal">
	<div class="panel panel-default" style="height:570px;">
		<div class="panel-body" >					
		
			<input type="hidden" id="mode" value="${mode}">
		
			<div class="form-group">
				<label for="stmmMenuLvl" class="control-label col-sm-1">구분</label>
				<div class="col-sm-2">
					<select class="form-control input-sm" id="stmmMenuLvl" name="stmmMenuLvl">
						<option value="1" selected>1차</option>
						<option value="2">2차</option>
						<option value="3">3차</option>
					</select>
				</div>		
				
				<label for="stmmParentId" class="control-label col-sm-2">상위그룹</label>
				<div class="col-sm-2">
					<select class="form-control input-sm" id="stmmParentId" name="stmmParentId"></select>
				</div>
			</div>
			
			<div class="form-group">
				<label for="stmmPageId" class="control-label col-sm-1">페이지 ID</label>
				<div class="col-sm-2">
					<input type="text" class="form-control input-sm required" id="stmmPageId" name="stmmPageId" required="required" value="${map.list[0].stmmPageId}" ${isReadonly} >
				</div>
				
				<label for="stmmPageTitle" class="control-label col-sm-2">명칭</label>
				<div class="col-sm-2">
					<input type="text" class="form-control input-sm required" id="stmmPageTitle" name="stmmPageTitle" required="required"  value="${map.list[0].stmmPageTitle}">
				</div>
			</div>
			
			<div class="form-group">
				<label for="stmmPageDesc" class="control-label col-sm-1">설명</label>
				<div class="col-sm-9">
					<input type="text" class="form-control input-sm" id="stmmPageDesc" name="stmmPageDesc" value="${map.list[0].stmmPageDesc}">
				</div>
			</div>
			
			<div class="form-group">
				<label for="stmmPageUrl" class="control-label col-sm-1">URL</label>
				<div class="col-sm-9">
					<input type="text" class="form-control input-sm" id="stmmPageUrl" name="stmmPageUrl" value="${map.list[0].stmmPageUrl}">
				</div>
			</div>
			
			<div class="form-group">
				<label for="stmmIsUse" class="control-label col-sm-1">사용여부</label>
				<div class="col-sm-2">
					<select class="form-control input-sm" id="stmmIsUse" name="stmmIsUse">
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="stmmPageApp" class="control-label col-sm-1">건수보기</label>
				<div class="col-sm-2">
					<select class="form-control input-sm" id="stmmPageApp" name="stmmPageApp">
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select>
				</div>
				<label for="stmmRowCnt" class="control-label col-sm-2">기본값</label>
				<div class="col-sm-2">
					<select class="form-control input-sm" id="stmmRowCnt" name="stmmRowCnt"></select>
				</div>
				<label for="stmmReadMth" class="control-label col-sm-2">조회방식</label>
				<div class="col-sm-2">
					<select class="form-control input-sm" id="stmmReadMth" name="stmmReadMth"></select>
				</div>
			</div>
		</div>
	</div>
	
	<p class="text-right">
		<button type="button" id="btnSave" class="btn btn-sm btn-primary">저장</button>
		<c:if test="${mode eq 'EDIT'}">
			<button type="button" id="btnDelete" class="btn btn-sm btn-danger">삭제</button>
		</c:if>		
		<button type="button" id="btnInit" class="btn btn-sm btn-default">초기화</button>
	</p>
</form>

<c:if test="${mode eq 'EDIT'}">
	<script>
	$(function(){
		
		fnSelectBox("systemCode", "PAGE_ROWS", "#stmmRowCnt",  "선택", "${map.list[0].stmmRowCnt}"); 
		fnSelectBox("systemCode", "PAGE_ATTR", "#stmmReadMth", "선택", "${map.list[0].stmmReadMth}");
		 
		$("#stmmMenuLvl").val("${map.list[0].stmmMenuLvlNum}").prop("selected", true);
		$("#stmmIsUse").val("${map.list[0].stmmIsUse}").prop("selected", true);
		$("#stmmPageApp").val("${map.list[0].stmmPageApp}").prop("selected", true);
	});
	</script>
</c:if>

<script>

$(function(){
	
	fnSelectBox("systemCode", "PAGE_ROWS", "#stmmRowCnt",  "선택", "${map.list[0].stmmRowCnt}"); 
	fnSelectBox("systemCode", "PAGE_ATTR", "#stmmReadMth", "선택", "${map.list[0].stmmReadMth}"); 
	
	$("#stmmParentId").val("C").prop("selected", true);
	
	var menuLevel = $("#stmmMenuLvl").val();
	if(isEmpty(menuLevel)){
		menuLevel = 1;
	}
	getParentMenuList(menuLevel);
});

$(document).on("change", "#stmmMenuLvl", function(){
	var _this = $(this),
		_menuLevel = _this.val();
	getParentMenuList(_menuLevel);
});

function getParentMenuList(_menuLevel) {
	
	var selectBox = $("#stmmParentId");
	
	if(_menuLevel == 1){
		selectBox.empty();
		selectBox.attr("readonly", true);
	}
	else{
		selectBox.attr("readonly", false);
		
		$.ajax({
			url: "/menu/parentMenu",
			type: "get",
			data: {
				stmmMenuLvl: _menuLevel
			},
			dataType: "json",
			success: function(data){
				$("#stmmParentId").empty();
				$(data.list).each(function(i){
										
					if($("#mode").val() == "EDIT" && data.list[i].stmmPageId == "${map.list[0].stmmParentId}"){		
						$("#stmmParentId").append('<option value="'+data.list[i].stmmPageId+'" selected>'+data.list[i].stmmPageTitle+'</option>');
					}
					else{
						$("#stmmParentId").append('<option value="'+data.list[i].stmmPageId+'">'+data.list[i].stmmPageTitle+'</option>');	
					}
				});
				
			}
		});	
	}
	
}

</script>
