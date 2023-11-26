<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.photoAlbum.model.*"%>
<!DOCTYPE html>


<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>顯示活動詳情</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
.btn-separator {
	margin-left: auto;
	font-size: 20px;
}

.flex-container {
	display: flex;
	align-items: center;
}

.btn-separator {
	margin-left: 10px;
	font-size: 12px
}

table {
	font-size: 15px;
}


</style>
</head>

<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
	<div class="container">
	<form method="post" action="${pageContext.request.contextPath}/act.do">
		<div style="text-align: center;">
			<h1 class="text-center"
				style="display: inline-block;">顯示一筆活動資訊</h1>
			<input type="hidden" name="action" value="getAll">
			<button class="btn btn-primary mr-2 btn-separator" style="margin-bottom: 15px; font-size: 15px;">活動類別管理首頁</button>
		</div>
	</form>	
	
		

		<div class="album card mb-3">
			<div class="row g-0">
				
				<div class="col-md-5">
					<div class="album-info">
						<table class="table table-bordered">
							<tr>
								<td>活動編號:</td>
								<td>${actVO.actNo}</td>
							</tr>
							<tr>
								<td>活動名稱:</td>
								<td>${actVO.actName}</td>
							</tr>
							<tr>
								<td>活動狀態:</td>
								<td>${actVO.actStatus? '上架':'下架'}</td>
							</tr>
							<tr>
								<td>參加費用:</td>
								<td>${actVO.unitPrice}</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="col-md-7">
					<img id="albPhoto"
						src="<%=request.getContextPath()%>/dbg.do?act_no=${actVO.actNo}"
						style="width: 100%; height: 200px; object-fit: cover;" alt="相簿封面" class="img-fluid">
				</div>
			</div>
		</div>

		<div class="flex-container" >
			<div class="row g-0">
				<div class="col-md-12" style="font-size: 20px;">
				<p class="text-center"><b>活動內容</b></p>
				</div>
				<div class="col-md-12" style="font-size: 15px; border: 1px solid grey;padding: 5px;">
					<p>${actVO.actContent}</p>
				</div>			
			</div>			
		</div>	
		<div class="col-md-12"  style="margin-left: 20px; margin-bottom: 10px; padding: 5px;">
			<form>
				<input type="hidden" name="actNo" value="${actVO.actNo}"> 
				<input type="hidden" name="action" value="getOne_For_Update">							
				<input type="submit" value="修改" class="btn btn-success mr-2 btn-separator" style="margin: 0px; font-size: 15px;">
			</form>				
		</div>
		

    	
		


	</div><%--container --%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js">     
    </script>
	




</body>
</html>
