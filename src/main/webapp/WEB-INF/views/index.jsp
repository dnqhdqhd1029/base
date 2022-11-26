<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/header.jsp" %>
</head>
<body>
	<!-- 헤더 메뉴위치 표시 -->
	<div class="wrapper">
	
	  <!-- Navbar -->
	  <nav class="main-header navbar navbar-expand">
	    <div class="lnb">
	      <button class="nav-link ic-menu" data-widget="pushmenu" href="#" role="button"> </button>
	
	      <button class="ic-home"></button>
	      <div id="ic-home-context"></div>
	    </div>
	    <div class="setting">
	      	${userInfo.family_name}${userInfo.given_name} 님께서 로그인하셨습니다. <button><i class="ic-setting"></i></button>
	    </div>
	  </nav>
	</div>
  
	<!-- /.navbar -->
	
	<!-- Main Sidebar Container -->
	<aside class="main-sidebar elevation-2">
		<!-- Brand Logo -->
		<a href="/main" class="brand-link">
		  <h1>LAKE MATERIALS <b>MES</b></h1>
		</a>
	
		<!-- Sidebar -->
		<div id="sidebar" class="sidebar">
	    <!-- Sidebar Menu -->
	    <nav class="mt-2">
			<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu">
	      		<c:forEach var="depth1" items="${menus.list}">
		    	<c:if test="${depth1.stmmMenuLvl eq 'DEPTH1'}">
		    		<li class="nav-item" id="menu_${depth1.stmmPageId}">
		    			<a href="#" class="nav-link side_depth1">
							<i></i>
		                	<p>${depth1.stmmPageTitle}</p>
		    			</a>
		    		<ul class="nav nav-treeview">
			    		<c:forEach var="depth2" items="${menus.list}">
				    		<c:if test="${depth2.stmmMenuLvl eq 'DEPTH2' and depth1.stmmPageId eq depth2.stmmParentId}">
			    				<li class="nav-item">
				                	<a href="#" class="nav-link side_depth2" data-id="${depth2.stmmPageId}" >
				                		<p>${depth2.stmmPageTitle}</p>
				                	</a>
				                	<ul class="nav nav-treeview">
					                	<c:forEach var="depth3" items="${menus.list}">
					                		<c:if test="${depth3.stmmMenuLvl eq 'DEPTH3' and depth2.stmmPageId eq depth3.stmmParentId}">
								                  <li class="nav-item">
								                    <a href="#" class="nav-link side_depth3" 
								                       data-url="${depth3.stmmPageUrl}" 
								                       data-id="${depth3.stmmPageId}" 
								                       data-title="${depth3.stmmPageTitle}"
								                       data-depth1="${depth1.stmmPageId}"
								                       data-depth2="${depth2.stmmPageId}">
								                      <p>${depth3.stmmPageTitle}</p>
								                    </a>
								                  </li>
					                		</c:if>
					                	</c:forEach>
				                	</ul>
				            	</li>
				    		</c:if>
			    		</c:forEach>
		    		</ul>
		    		</li>
		    	</c:if>
				</c:forEach>
			</ul>
	    </nav>
	  </div>
	</aside>

    <!-- 화면 view -->
	<div id="divWrapper" class="content-wrapper px-4" > <!-- style 삭제 --> 
		<div class="tab-search">
        	<ul class="nav nav-tabs" id="ul_tabs" style="border:0px;">
        	</ul>
		</div>
		<div id="divList">
		</div>
	</div>

</body>
<script type="text/javascript">

	$(".side_depth1").on("click", function(){
		$(".side_depth1").removeClass("active");
		$(this).addClass("active");
	});
	
	$(".side_depth2").on("click", function(){
		$(".side_depth2").removeClass("active");
		$(this).addClass("active");
	});
	
	$(".side_depth3").on("click", function(){
		$(".side_depth3").removeClass("active");
		$(this).addClass("active");
		$("#ic-home-context").text($(".side_depth1.active").text() + " > " + $(".side_depth2.active").text() + ">" +$(this).text());
		
		var selectedFrame = $("#"+$(this).data("id"));
		
		if((selectedFrame).length > 0){
			$(".divTapList").addClass("hidden");	
			$(selectedFrame).removeClass("hidden");
			$(selectedFrame).addClass("show");		
		}else{
			$(".divTapList").addClass("hidden");
			
			var frame = "<iframe class='show cont-wrap divTapList' id='"+$(this).data("id")+"' src='"+$(this).data("url")+"' style='width:100%; height:86vh;'></iframe>";
			$("#divList").append(frame);	
		}
		
		if($(".menuTabs[data-id='"+$(this).data("id")+"']").length == 0){
			$("#ul_tabs>li").each(function (index){
				$(this).removeClass("active");
			});
			var idx = $("#ul_tabs").children().length + 1;
			$("#ul_tabs").append("<li role='presentation' data-idx='"+idx+
					             "'><a title='"+$(this).data("title")+
					             "'style='width:"+($(this).data("title").length * 17)+
					             "px;' class='menuTabs' data-id='"+$(this).data("id")+
					             "' data-depth1='"+$(this).data("depth1")+ 
					             "' data-depth2='"+$(this).data("depth2")+ 
					             "'>"+$(this).data("title")+"</a><span class='btn_close'><i class='fas fa-times' style='font-size: 15px;'></i><span></li>");
			var obj = $("#ul_tabs>li:last");
			obj.addClass("active");
		}
		else {
			$(".menuTabs[data-id='"+$(this).data("id")+"']").click();
		}
	});
	
	$(document).on("click", ".menuTabs", function(){
		
		$("#ul_tabs>li").each(function (index){
			$(this).removeClass("active");	
		});
		
		var obj = $(this);
		var url = obj.data("url");
		var pageId = obj.data("id");
		var depth1 = obj.data("depth1");
		var depth2 = obj.data("depth2");
		
		obj.closest("li").addClass("active");
		
		$(".divTapList").addClass("hidden");	
		$("#"+pageId).removeClass("hidden");
		$("#"+pageId).addClass("show");
	});
	
	$(document).on("click", ".btn_close", function(){
		var obj = $(this).parents("li");		
		var pageId = obj.children("a").data("id");
		obj.remove();
		$("#"+pageId).remove();
		
		var nextPage = $("#ul_tabs>li:last").children("a").data("id");

		$(".menuTabs[data-id='"+ nextPage +"']").click();
	});
	
	$(".ic-setting").on("click", function(){
		if(confirm("로그아웃 하시겠습니까?")){
			location.href = "/logout";
		}
	});
	
</script>
</html>