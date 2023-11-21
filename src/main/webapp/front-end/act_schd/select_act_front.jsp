<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.photoAlbum.model.*"%>
<!DOCTYPE html>


<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>活動列表</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
.album card mb-3 {
	position: relative;
	width: 800px;
}

.row.g-0 {
	position: relative;
}

.d-flex justify-content-end {
	position: absolute;
	bottom: 0;
	right: 0;
}

/*-------活動tatal-------------------*/
.card-body {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.photo-content d-flex {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

/*-------活動each-------------------*/
.actWholeContent {
    display: flex;
    flex-direction: column;
    align-items: center;
}
.actWholeContent .actImg,
.actWholeContent .tableContent {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}


.photo-content img {
	width: 350px;
	height: 350px;
	background-color: #eee;
	border: 1px solid #ccc;
	margin: 5px;
	object-fit: cover;
}

.tableContent table {
    width: 100%;
    text-align: center; 
    font-size: 20px; 

}
.tableContent table th,.tableContent table td{
	padding: 4px;
    vertical-align: middle;
    
}
.actWholeContent label{
 	display: block;
    text-align: center;
    margin-top: 4px;
    font-size: 25px;
}

/*--------封面-------------------*/
.album.card.mb-3 .row.g-0 .col-md-12 img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.album.card.mb-3 .row.g-0 .col-md-12 {
	height: 100%;
}

.d-flex.justify-content-end {
	position: absolute;
	bottom: 0;
	right: 0;

</style>

</head>

<body>
<%@ include file="/front-end/index/guided.jsp" %>
	<div class="container">
		<h1 class="text-center" style="margin-top: 10px;">顯示所有活動</h1>

		<div class="album card mb-3">
			<div class="row g-0">
				<div class="col-md-12">
					<img src="<%=request.getContextPath()%>/images/act_main_front.png"
						alt="活動封面" class="img-fluid">
				</div>
			</div>
		</div>

		<h2>熱門活動</h2>
			<c:if test="${actPageQty > 0}">
				<b><font color=red>第${currentPage}/${actPageQty}頁</font></b>
			</c:if>
		<div class="album card mb-1">
			<div class="row g-0">
				<div class="col-md-12">
					<div class="card-body">
						<div class="photo-content d-flex">
						<c:forEach var="act" items="${actList}">
							<div class="actWholeContent">
								<div class="actImg">
								<a href='${pageContext.request.contextPath}/act.do?action=getOne_For_Display&actNo=${act.actNo}'>
									<img src="<%=request.getContextPath()%>/dbg.do?act_no=${act.actNo}"
										alt="相片1" class="img-fluid">
								</a>									
								</div>
								<div class="tableContent">
									<table>
										<tr>
											<th>活動名稱:</th>
											<td>${act.actName}</td>
										</tr>
										<tr>
											<th>NTD</th>
											<td>${act.unitPrice}</td>
										</tr>
									</table>
									<label>即將開放報名</label>
								</div>
							</div>
						</c:forEach>
					
						</div>
					</div>
				</div>

			</div>
		</div>
			<c:if test="${currentPage > 1}">
				<a
					href="${pageContext.request.contextPath}/act.do?action=getAll_Front&page=1">至第一頁</a>&nbsp;
			</c:if>
			<c:if test="${currentPage - 1 != 0}">
				<a
					href="${pageContext.request.contextPath}/act.do?action=getAll_Front&page=${currentPage - 1}">上一頁</a>&nbsp;
			</c:if>
			<c:if test="${currentPage + 1 <= actPageQty}">
				<a
					href="${pageContext.request.contextPath}/act.do?action=getAll_Front&page=${currentPage + 1}">下一頁</a>&nbsp;
			</c:if>
			<c:if test="${currentPage != actPageQty}">
				<a
					href="${pageContext.request.contextPath}/act.do?action=getAll_Front&page=${actPageQty}">至最後一頁</a>&nbsp;
			</c:if>
	</div>

	<!-- 引入 Bootstrap JavaScript 文件（如果需要） -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js">
     
    </script>
<%@ include file="/front-end/index/footer.jsp" %>


</body>
</html>
