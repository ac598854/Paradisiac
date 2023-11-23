<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.photoAlbum.model.*"%>

<!DOCTYPE html>

<html>
<head>
<%@ include file="/front-end/index/MembersMeta.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>相簿管理</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
.album.card.mb-3 {
	position: relative;
}

.photo-content {
	display: flex;
	justify-content: space-between;
}

.photo-container {
	margin: 5px;
	width: calc(33.33% - 10px);
	box-sizing: border-box;
	padding: 10px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.photo-container img {
	max-width: 100%;
	height: auto;
}

.container {
	padding-top: 65px;
	padding-left: 255px;
}
/*
        .row.g-0 {
        position: relative;
        }
        .d-flex justify-content-end {
            position: absolute;
            bottom: 0;
            right: 0;
        }
        .photo-content d-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
         ====
        .photo-content img {
		    max-width: 50%;  
		    height: 200px; 
            background-color: #eee;
            border: 1px solid #ccc;
            margin: 5px;
        }
        
        .img-fluid img {
	        max-width: 100%;
	        height: auto;
    	}
        
        .album .d-flex.justify-content-end {
        position: absolute;
        bottom: 0;
        right: 0;
        }

        .d-flex.justify-content-end {
        position: absolute;
        bottom: 0;
        right: 0;
        }

        .album-info {
        margin-bottom: 50px; 
        }

        .btn-separator {
        margin-right: 5px; 
        }*/
</style>
</head>
<body>
	<%@ include file="/front-end/index/MembersBody.jsp"%>
	<div id="dynamicContent"></div>
	<%----%>
	<div class="container">
		<h1 class="text-center">會員相簿</h1>
		<div>
			<h2 class="d-flex justify-content-between">
				瀏覽紀念相簿
				<%-- <a
					href="${pageContext.request.contextPath}/back-end/pha/select_phoalb.jsp"
					class="btn btn-secondary">回首頁</a>--%>
			</h2>
		</div>

		<div class="album card mb-3">
			<div class="row g-0">
				<div class="col-md-4">
					<img id="albPhoto"
						src="<%=request.getContextPath()%>/dbg.do?alb_no=${list[0].albNo}"
						alt="相簿封面" class="img-fluid">
				</div>
				<div class="col-md-8">
					<div class="album-info">
						<table class="table table-bordered">
							<tr>
								<td>相簿編號:</td>
								<td>${list[0].albNo}</td>
							</tr>
							<tr>
								<td>相簿名稱:</td>
								<td>${list[0].albName}</td>
							</tr>
							<tr>
								<td>會員編號:</td>
								<td>${list[0].memNo}</td>
							</tr>
							<tr>
								<td>相簿日期:</td>
								<td>${list[0].albDate}</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>

		<h2>相片管理</h2>
		<c:if test="${phoPageQty > 0}">
			<b><font color=red>第${currentPage}/${phoPageQty}頁</font></b>
		</c:if>
		<div class="album card mb-3">
			=====
			<div class="album card mb-3">
				<div class="row g-0">
					<div class="col-md-8">
						<form id="photoForm" method="post"
							action="<%=request.getContextPath()%>/pho.do">
							<div class="photo-content">
								<c:forEach var="pha" items="${list}">
									<%-- <input type="checkbox" name="photoNo" id="${pha.photoNo}"
										value="${pha.photoNo}">--%>
									<div class="photo-container">
										<img
											src="<%=request.getContextPath()%>/dbg.do?photo_no=${pha.photoNo}"
											alt="相片1" class="img-fluid">
										<table>
											<tr>
												<td>相片名稱:</td>
												<td>${pha.photoName}</td>
											</tr>
											<tr>
												<td>相片日期:</td>
												<td>${pha.photoDate}</td>
											</tr>
										</table>
									</div>
								</c:forEach>
							</div>
						</form>

					</div>
				</div>
			</div>


			======
		</div>
		<c:if test="${currentPage > 1}">
			<a
				href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display&albNo=${list[0].albNo}&page=1">至第一頁</a>&nbsp;
		</c:if>
		<c:if test="${currentPage - 1 != 0}">
			<a
				href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display&albNo=${list[0].albNo}&page=${currentPage - 1}">上一頁</a>&nbsp;
		</c:if>
		<c:if test="${currentPage + 1 <= phoPageQty}">
			<a
				href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display&albNo=${list[0].albNo}&page=${currentPage + 1}">下一頁</a>&nbsp;
		</c:if>
		<c:if test="${currentPage != phoPageQty}">
			<a
				href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display&albNo=${albNo}&page=${phoPageQty}">至最後一頁</a>&nbsp;
		</c:if>
	</div>

	<!-- 引入 Bootstrap JavaScript 文件（如果需要） -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js">
     
    </script>



</body>
<footer>
	<%@ include file="/front-end/index/footer.jsp"%>
</footer>
<script>
$(document).ready(function(){
    $.ajax({
        type: "POST",
        url: "<%=request.getContextPath()%>/front-end/members/members.do?action=indexLogin",
        success: function(data) {
            const responseMessage = parseInt(data);
            var  contextPath='<%=request.getContextPath()%>
	';
										var guided = contextPath
												+ '/front-end/index/guided.jsp';
										var guidedSignout = contextPath
												+ '/front-end/index/guidedSignout.jsp';
										if (responseMessage === 1) {
											$("#dynamicContent").load(guided);
										} else if (responseMessage === 0) {

											$("#dynamicContent").load(
													guidedSignout);
										}
									},
									error : function(error) {
										console.log("AJAX error:", error);
									}
								});
					})
</script>
</html>
