<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Modal -->
<div class="modal fade myModal" id="modal_pop" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog <c:out value="${param.size}" default="modal-lg" />">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h5 class="modal-title" id="myModalLabel"><strong>${param.title}</strong></h5>
			</div>
			<div class="modal-body" id="modal_pop_body">
			<!-- load on this area! -->
			</div>
		</div>
	</div>
</div>