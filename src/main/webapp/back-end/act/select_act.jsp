<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.act.service.*"%>
<%@ page import="com.paradisiac.act.model.*"%>
<%--	ActService actSvc = new ActServiceImpl();
	List<ActVO> actList = actSvc.getAllActs();
	pageContext.setAttribute("actList",actList);

--%>
<!DOCTYPE html>
<html>
<head>
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

#activityTableBlock {
	display: flex;
	flex-wrap: nowrap;
}

.activityCard {
	width: 48%;
	margin-right: 2%;
	margin-bottom: 20px;
	padding: 5px;
	margin: 2px;
}

#activityImageBlock {
	border: 1px solid #ddd;
	padding: 15px;
	width: 40%;
	height: 295px;
	float: right;
	margin-left: 2%;
	margin-top: 5px;
}

#activityTableBlock {
	border: 1px solid #ddd;
}
</style>
</head>
<body>
	<div class="container">
		<div id="searchBlock">
			<h2>查詢活動與檔期</h2>
		<FORM METHOD="post" ACTION="${pageContext.request.contextPath}/act.do">
			<b>輸入活動編號</b> <input type="text" name="actNo">
			<input type="hidden" name="action" value="getOneActAllSchd">
			<input type="submit" value="送出">
		</FORM>		

		</div>
		<div>
			<h2>顯示所有活動</h2>
			<h3>點選活動編號顯示完整活動內容</h3>
			<c:if test="${actPageQty > 0}">
				<b><font color=red>第${currentPage}/${actPageQty}頁</font></b>
			</c:if>
			<c:forEach var="act" items="${actList}">
				<div id="activityTableBlock">
					<!-- 顯示所有活動的區塊 -->

					<div class="activityCard">

						<table class="table table-bordered">
							<tr>
								<th>活動編號</th>
								<td><a href='${pageContext.request.contextPath}/act.do?action=getOne_For_Display&actNo=${act.actNo}'>${act.actNo}</a>
							</td>
									
							</tr>
							<tr>
								<th>活動名稱</th>
								<td>${act.actName}</td>
							</tr>
							<tr>
								<th>最低成團人數</th>
								<td>${act.lowNum}</td>
							</tr>
							<tr>
								<th>最高上限人數</th>
								<td>${act.highNum}</td>
							</tr>
							<tr>
								<th>活動狀態</th>
								<td>${act.actStatus?'上架':'下架'}</td>
							</tr>
							<tr>
								<th>參加費用</th>
								<td>${act.unitPrice}</td>
							</tr>
						</table>

					</div>
					<div id="activityImageBlock">
					<a href='${pageContext.request.contextPath}/act.do?action=getOne_For_Display&actNo=${act.actNo}'>					
						<img
							src="<%=request.getContextPath()%>/dbg.do?act_no=${act.actNo}"
							alt="相簿封面" class="img-fluid">
					</a>
					</div>

				</div>
			</c:forEach>
			<c:if test="${currentPage > 1}">
				<a
					href="${pageContext.request.contextPath}/act.do?action=getAll&page=1">至第一頁</a>&nbsp;
			</c:if>
			<c:if test="${currentPage - 1 != 0}">
				<a
					href="${pageContext.request.contextPath}/act.do?action=getAll&page=${currentPage - 1}">上一頁</a>&nbsp;
			</c:if>
			<c:if test="${currentPage + 1 <= actPageQty}">
				<a
					href="${pageContext.request.contextPath}/act.do?action=getAll&page=${currentPage + 1}">下一頁</a>&nbsp;
			</c:if>
			<c:if test="${currentPage != actPageQty}">
				<a
					href="${pageContext.request.contextPath}/act.do?action=getAll&page=${actPageQty}">至最後一頁</a>&nbsp;
			</c:if>
		</div>
	</div>

</body>
</html>