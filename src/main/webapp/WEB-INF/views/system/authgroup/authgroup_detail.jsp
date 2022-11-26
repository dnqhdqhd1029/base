<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.checkbox-inline input[type="checkbox"] {position:relative !important;}
.checkbox-inline select{position:relative !important;height:30px;}
</style>
<form id="detailFrm">
	<div class="panel-body">
	
		<%-- 1차메뉴 --%>
		<c:forEach var="depth1" items="${dtoSub.list}">
			<c:if test="${depth1.stmmMenuLvl eq 1}">
				<div class="page-header" style="margin-top:20px;">
					<h5><i class="fas fa-caret-down"></i> &nbsp;<strong>${depth1.stmmPageTitle}</strong></h5>
				</div>
				
				<%-- 2차메뉴 --%>
				<c:forEach var="depth2" items="${dtoSub.list}">
					<c:if test="${depth2.stmmParentId eq depth1.stmmPageId}">
						<ul class="mg10">
							<li><strong>${depth2.stmmPageTitle}</strong>
							
								<%-- 3차메뉴 --%>
								<c:forEach var="depth3" items="${dtoSub.list}">
									<c:if test="${depth3.stmmParentId eq depth2.stmmPageId}">
										<ul>
											<li>${depth3.stmmPageTitle}
												
												<%-- 체크박스 --%>
												<ul class="list-unstyled" style="padding-left:40px;">
													<li class="authMenuList">
														<input type="hidden" id="PmgdPageId" name="PmgdPageId" value="${depth3.stmmPageId}">
														<div class="form-inline">
															<label class="checkbox-inline"> 
																<c:choose>
																	<c:when test="${depth3.PmgdChkRead eq 'Y'}">
																		읽기
																		<select class="form-control" name="PmgdChkRead" style="width:42px;">
																			<option style="background-color:red;" value="Y" selected="selected">Y</option>
																			<option value="N">N</option>
																		</select> 
																	</c:when>
																	<c:otherwise>
																		읽기
																		<select class="form-control" name="PmgdChkRead" style="width:42px; background-color:#FF5675;">
																			<option value="Y">Y</option>
																			<option value="N" selected="selected">N</option>
																		</select> 	
																	</c:otherwise>
																</c:choose>
																<c:choose>
																	<c:when test="${depth3.PmgdChkUpdate eq 'Y'}">
																		쓰기
																		<select class="form-control" name="PmgdChkUpdate" style="width:42px; background-color:#9AB9FF;">
																			<option value="Y" selected="selected">Y</option>
																			<option value="N">N</option>
																		</select>  
																	</c:when>
																	<c:otherwise>
																		쓰기
																		<select class="form-control" name="PmgdChkUpdate" style="width:42px; background-color:#FF5675;">
																			<option value="Y">Y</option>
																			<option value="N" selected="selected">N</option>
																		</select> 	
																	</c:otherwise>
																</c:choose>
															</label>
														</div>
													</li>
												</ul>
												<%-- 체크박스 --%>
											
												
											</li>
										</ul>
									</c:if>
								
								</c:forEach>								
								<%-- 3차메뉴 --%>
							
							</li>
						</ul>
					</c:if>
				</c:forEach>
				<%-- 2차메뉴 --%>
				
			</c:if>
		</c:forEach>
		<%-- 1차메뉴 --%>
		
		
	</div>
		
		
		
		
</form>