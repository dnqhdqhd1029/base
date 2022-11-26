<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/header.jsp" %>
<meta charset="UTF-8">
<title>권한관리</title>
<style type="text/css">
table#e_table > tbody > tr > td {vertical-align: middle;}
table#e_table > tbody > tr:last-child > td  {border-bottom: 1px solid #ddd;}
ul.mg10 li{margin:10px;}
</style>

<script>
$(document).on("click", "#btnEdit", function(){
	var _this = $(this),
		editId = _this.data("id");
	
	location.href = "${path}/authGroup/edit/"+editId;
});

//	권한그룹 입력폼 추가
function addRegFrm(){
	location.href = "regist";
}

//	취소[새로고침]
$(document).on("click", "#btnCancel", function(){
	location.href = "${path}/authGroup/list";
});

//	권한그룹 추가 or 수정
$(document).on("click", "#btnSave", function(){
	var frm = $("#regFrm"), 
		mode = $("#mode").val(),
		boolRs = "Y";
	//필수 입력값 검증
	$("#regFrm input").each(function(index){
		
		var input = $(this);
		var isRequired = input.prop("required");
		
		input.parent().removeClass("has-error");
		
		if(isRequired){
			if(isEmpty(input.val())){
				alert("필수 입력항목을 입력하시기 바랍니다.");
				input.parent().addClass("has-error");
				input.focus();
				boolRs = "N";
				return false;
			}
		} 
	});
	
	if(boolRs == "N") return false;
	
	if(confirm("저장하시겠습니까?")){		

		var url = "${path}/authGroup/regist";
		if(mode == "EDIT") { url = "${path}/authGroup/edit"; }
		
		var vData = frm.serializeObject();
		
		postAjax(url, vData, true).done(function(data){
			alert(data.message);
			if(data.code=="ok"){
				location.href = "${path}/authGroup/list";
			}
		});
		
		postAjax(url, vData, true).done(function(data){
			alert(data.message);
			if(data.code=="ok"){
				location.href = "${path}/authGroup/list";
			}
		});
	}
	else{
		return false;
	}
});

//	권한그룹 삭제
$(document).on("click", "#btnDelete", function(){
	var _this = $(this),
		groupId = _this.data("id");
	if(confirm("삭제하시겠습니까?")){
		deleteAuthGroup(groupId)
	}
});

function deleteAuthGroup(_groupId){
	
	postAjax("${path}/authGroup/delete", {PmgmGroupId: _groupId}, true).done(function(data){
		alert(data.message);
		if(data.code=="ok"){
			location.reload();
		}
	});
}

//	권한그룹 리스트 불러오기
$(document).on("click", "#btnSetting", function(){
	var _this = $(this),
		groupId = _this.data("id"),
		btnSet = $("#btnSet");
	
	pasteDetail(groupId);
	btnSet.removeClass("hidden");	
});

function pasteDetail(groupId){
	var url = "${path}/authGroup/detail";
	$("#loadedForm").empty();	
	$("#loadedForm").load(url, {"groupId": groupId});
}

</script>

<%-- 권한 목록 스크립트 --%>

<script>
$(document).on("click", "#btnDetailSave", function(){
    var vData = {};
    var vList = new Array();
    
    $(".authMenuList").each(function(){
    	var param = {};
    	param.PmgdPageId    = $(this).find("[name=PmgdPageId]").val();
    	param.PmgdChkRead   = $(this).find("[name=PmgdChkRead]").val();
    	param.PmgdChkUpdate = $(this).find("[name=PmgdChkUpdate]").val();
    	vList.push(param);
    });
    
    vData.list = vList;
    
	if(confirm("저장하시겠습니까?")){
		postAjax("${path}/authGroup/detail/regist", vData, true).done(function(data){
			alert(data.message);
			if(data.code=="ok"){
				location.reload();
			}
		});
	}
});
</script>

</head>
<body>
	<div class="container-fluid h100">
		<div class="row h100">
			<div class="col-sm-7 h100">
				<h5>
					<i class="fas fa-users"></i>
					권한그룹 목록
					&nbsp;
					<small><a class="" href="javascript:addRegFrm()"><i class="fas fa-plus"></i>&nbsp;추가</a></small>
				</h5>
				
				<div class="panel panel-default h100" style="height:calc(100% - 85px);">
					<form id="regFrm">
						<input type="hidden" name="mode" id="mode" value="${mode}">
						<table id="e_table" class="table table-hover">
							<colgroup>
								<col width="50px"/><col width="160px"><col width="160px"><col width="*"><col width="60px"><col width="100px">
							</colgroup>
							<thead>
								<tr>
									<th class="text-center">No</th>
									<th class="">권한그룹 ID</th>
									<th class="">권한그룹명</th>
									<th class="">설명</th>
									<th class="text-center">LEVEL</th>
									<th class="text-center">편집</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${mode eq 'REG'}">
									<tr>
										<td></td>
										<td class="">
											<input type="text" class="form-control input-sm required" id="PmgmGroupId" name="PmgmGroupId" required="required" autofocus="autofocus">
										</td>
										<td class="">
											<input type="text" class="form-control input-sm required" id="PmgmGroupName" name="PmgmGroupName" required="required">
										</td>
										<td class="">
											<input type="text" class="form-control input-sm" id="PmgmGroupDesc" name="PmgmGroupDesc">
										</td>
										<td class="">
											<input type=text class="form-control input-sm number_only required" id="PmgmGroupLvl" name="PmgmGroupLvl" maxlength="2" required="required">
										</td>
										<td class="text-center">
											<button type="button" id="btnSave" class="btn btn-xs btn-success" data-toggle="tooltip" data-placement="bottom" title="저장">
												<i class="fas fa-check"></i>
											</button>
											<button type="button" id="btnCancel" class="btn btn-xs btn-default" data-toggle="tooltip" data-placement="bottom" title="취소">
												<i class="fas fa-ban"></i>
											</button>										
										</td>
									</tr>
								</c:if>
								
								<c:forEach var="dto" items="${dto.list}" varStatus="status">
									
									<c:choose>
										<c:when test="${mode eq 'EDIT' and editId eq dto.PmgmGroupId}">
											<tr>
												<td class="text-center">${status.index + 1}</td>											
												<td class="">													
													<input type="text" class="form-control input-sm required" id="PmgmGroupIdNew" name="PmgmGroupIdNew" required="required" autofocus="autofocus" value="${dto.PmgmGroupId}">
												</td>
												<td class="">
													<input type="text" class="form-control input-sm required" id="PmgmGroupName" name="PmgmGroupName" required="required" value="${dto.PmgmGroupName}">
												</td>
												<td class="">
													<input type="text" class="form-control input-sm" id="PmgmGroupDesc" name="PmgmGroupDesc" value="${dto.PmgmGroupDesc}">
												</td>
												<td class="">
													<input type="text" class="form-control input-sm number_only required" id="PmgmGroupLvl" name="PmgmGroupLvl" maxlength="2" required="required" value="${dto.PmgmGroupLvl}">
												</td>
												<td class="text-center">
													<button type="button" id="btnSave" class="btn btn-xs btn-success" data-toggle="tooltip" data-placement="bottom" title="저장">
														<i class="fas fa-check"></i>
													</button>
													<button type="button" id="btnCancel" class="btn btn-xs btn-default" data-toggle="tooltip" data-placement="bottom" title="취소">
														<i class="fas fa-ban"></i>
													</button>
												</td>
											</tr>
										</c:when>
										
										<c:otherwise>
											<tr id="clickableTr">
												<td class="text-center">${status.index + 1}</td>
												<td class="">${dto.PmgmGroupId}</td>
												<td class="">${dto.PmgmGroupName}</td>
												<td class="">${dto.PmgmGroupDesc}</td>
												<td class="text-center">${dto.PmgmGroupLvl}</td>
												<td class="text-center">
													<button type="button" id="btnEdit" data-id="${dto.PmgmGroupId}" class="btn btn-xs btn-default" data-toggle="tooltip" data-placement="bottom" title="권한그룹 수정">
														<i class="fas fa-edit"></i>
													</button>
													<button type="button" id="btnDelete" data-id="${dto.PmgmGroupId}" class="btn btn-xs btn-default" data-toggle="tooltip" data-placement="bottom" title="권한그룹 삭제">
														<i class="far fa-trash-alt"></i>
													</button>
													<button type="button" id="btnSetting" class="btn btn-xs btn-default" data-toggle="tooltip" data-placement="bottom" title="권한 설정" data-id="${dto.PmgmGroupId}">
														<i class="fas fa-cog"></i>
													</button>
												</td>
											</tr>
										</c:otherwise>
									</c:choose>
									
								</c:forEach>
								
							</tbody>
						</table>
					</form>
										
				</div>
			</div>
			
			<div class="col-sm-5 h100">
				<h5>
					<i class="fas fa-cog"></i>
					권한그룹별 권한 설정										
				</h5>
				
				<div id="loadedForm" class="panel panel-default h100" style="height:calc(100% - 85px); overflow-y: auto;">
				
				</div>
				
				<p id="btnSet" class="text-right hidden" style="margin-top:-10px;">
					<button type="button" id="btnDetailSave" class="btn btn-sm btn-primary">저장</button>
					<button type="button" id="btnCancel" class="btn btn-sm btn-default">취소</button>
				</p>
			</div>
			
		</div>
	</div>	
</body>
</html>