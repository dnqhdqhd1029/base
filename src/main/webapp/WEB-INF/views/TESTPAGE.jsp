<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/header.jsp" %>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div class="wrapper">
		<h1>Array[Map]부터 로드</h1>
		<h2>Ajax로 Array[Map]데이터 호출</h2>
		
		<div class="wrap">
          <h3>등락율 순위</h3>
			<table id="grid-table-1">

			</table>

			<script id="grid-template-1" type="text/template">
				<table width="100%" height="350px">
					<thead>
						<tr>
							<th name="indx" align="center">순위</th>
							<th name="Isu">종목명</th>
							<th name="NowPrc" align="right">현재가</th>
							<th name="PrdayCmp" align="right">전일비</th>
							<th name="Updn" align="right">등락율(%)</th>
							<th name="TopQty" align="right">거래량</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td name="indx" bind="indx"></td>
							<td name="Isu" bind="Isu"></td>
							<td name="NowPrc" bind="NowPrc"></td>
							<td name="PrdayCmp" bind="PrdayCmp"></td>
							<td name="Updn" bind="Updn"></td>
							<td name="TopQty" bind="TopQty"></td>
						</tr>
					</tbody>
				</table>
			</script>
			
		</div>
		
	</div>
	
    <script type="text/javascript">

		$(document).ready(function(){
	    var table1 = $('#grid-table-1');
		var template1 = $('#grid-template-1');
		var grid1 = webponent.grid.init(table1, template1);
// 			$.ajax({			
// 				dataType : 'json',
// 				type : "GET",
// 				url : '/comDate/getList',
// 				contentType : 'application/json; charset=UTF-8',
// 				success : function (resp) {
		
// 					grid1.appendRow(resp);
// 				}
// 			});
			
		});
		

    </script>

    
    
</body>
</html>