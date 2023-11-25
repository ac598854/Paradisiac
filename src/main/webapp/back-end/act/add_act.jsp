<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.act.service.*"%>
<%@ page import="com.paradisiac.act.model.*"%>
<% ActVO actVO = (ActVO) request.getAttribute("actVO"); %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>活動管理系統首頁</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>

.container {
	padding-top: 65px;
	padding-left: 255px;
}

#searchBlock {
	margin-bottom: 20px;
}

#actTableBlock {
	display: flex;
	flex-wrap: nowrap;
}

.actCard {
	width: 48%;
	margin-right: 2%;
	margin-bottom: 20px;
	padding: 5px;
	margin: 2px;
}

#actImageBlock {
	border: 1px solid #ddd;
	padding: 15px;
	width: 40%;
	height: 295px;
	float: right;
	margin-left: 2%;
	margin-top: 5px;
}

#actTableBlock {
	border: 1px solid #ddd;
}

#actContent {
	width: 90%;
	margin-right: 2%;
	margin-bottom: 20px;
	padding: 5px;
	margin: 2px;
}

.table-bordered {
    border: none;
}

.table-bordered th,
.table-bordered td {
    border: none;
     text-align: center;
}
</style>
</head>
<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
	<div class="container">
		<div>
			<h2>新增活動</h2>
		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
			<font style="color:red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color:red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>
			<form action="${pageContext.request.contextPath}/act.do" method="post" enctype="multipart/form-data">
				<div id="actTableBlock">
					<div class="actCard">
						<table class="table table-bordered">
							<tr>
								<th>活動名稱</th>
								<td><input type="text" name=actName required value=${actVO.actName==null? '': actVO.actName}></td>
							</tr>
							<tr>
								<th>活動狀態</th>
								<td>
									<input type="radio" name=actStatus value="false" ${actVO.actStatus? '':'checked' }>下架</td>
							</tr>
							<tr>
								<th>參加費用</th>
								<td><input type="text" name=unitPrice required value=${actVO.unitPrice==null? '': actVO.unitPrice}></td>
							</tr>
						</table>
					</div>
					<div id="actImageBlock">
						<input type="file" class="form-control-file" name="actPho1" id="actPho1" accept="image/*">
						<img id="photoPreview" src="#" alt="封面預覽" style="width: 200px; height: 200px; object-fit: cover;">
					</div>
					
				</div>
				<div id="actContent">
					<p><b>活動內容:</b></p>
					<textarea name=actContent rows="10" cols="50" placeholder="請輸入" required >${actVO.actContent==null? '': actVO.actContent}</textarea>
				</div>
                <input type="submit" value="送出">
			    <input type="hidden" name="action"	value="insert">			
			</form>
		</div>
	</div>
	<script>
        // 預覽相片
        document.getElementById('actPho1').addEventListener('change', function(e) {
            const preview = document.getElementById('photoPreview');
            const file = e.target.files[0];
            const reader = new FileReader();

            reader.onload = function(e) {
                preview.src = e.target.result;
            };

            reader.readAsDataURL(file);
        });
    </script>

</body>
</html>