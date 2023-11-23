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
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>新增檔期</title>
<style>
.container {
	padding-top: 65px;
	padding-left: 255px;
}

table {
	border-collapse: collapse;
	width: 100%;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

table.form-section1 th {
	background-color: #f2f2f2;
}

table.form-section2 th {
	border-right: none;
}

table.form-section2 td {
	border-left: none;
}

.form-section {
	margin-bottom: 20px;
}

h2 {
	margin-bottom: 10px;
}

.modify-button {
	display: inline-block;
	background-color: #4CAF50;
	color: white;
	padding: 8px 16px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 14px;
	margin: 4px 2px;
	transition-duration: 0.4s;
	cursor: pointer;
	border-radius: 4px;
}

.modify-button:hover {
	background-color: white;
	color: black;
	border: 1px solid #4CAF50;
}
</style>
</head>
<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
	<div class="container">
		<table class="form-section1">
			<tr>
				<th colspan="6" style="text-align: center;">新增檔期內容</th>
			</tr>
			<%-- 錯誤表列 --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color:red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color:red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
		</table>
		<form action="${pageContext.request.contextPath}/schd.do" method="post">
			<table class="form-section2">
				<tr>
					<td colspan="6"></td>
				</tr>
				<tr>
					<%-- 
                <th>檔期編號</th>
                <td><input type="text" name="" required></td>--%>
                <jsp:useBean id="actSvc" scope="page" class="com.paradisiac.act.service.ActServiceImpl" />
					<th>活動類別</th>
					<td><select size="1" name="actNo">
						<c:forEach var="actVO" items="${actSvc.allActs}">
							<option value="${actVO.actNo}" ${(schdVO.act.actNo==null)?'':'selected' }>${actVO.actNo}-${actVO.actName}
						</c:forEach>
					</select></td>
					<th>報名狀態</th>
					<%--1:報名中 2:成團 3:未成團 4:因故取消 --%>
					<td><select name="applStatus">
							<option value="1">報名中</option>
					</select></td>				
				</tr>
				<tr>
					<th>上架日期</th>
					<td><input type="datetime-local" name="ancDate" value="${schdVO.ancDate==null? '':schdVO.ancDate}"></td>
					<th>下架日期</th>
					<td><input type="datetime-local" name="drpoSchdDate" value="${schdVO.drpoSchdDate==null? '':schdVO.drpoSchdDate}"></td>
					<th>活動舉辦時間</th>
					<td><input type="datetime-local" name="holdDate" value="${schdVO.holdDate==null? '':schdVO.holdDate}" required ></td>
				</tr>
				<tr>
					<th>報名開始時間</th>
					<td><input type="datetime-local" name="aplyTime" value="${schdVO.aplyTime==null? '':schdVO.aplyTime}" required></td>
					<th>報名截止時間</th>
					<td><input type="datetime-local" name="cutTime" value="${schdVO.cutTime==null? '':schdVO.cutTime}" required></td>
					<th>參加費用</th>
					<td><input type="text" name="unitPrice" value="${schdVO.unitPrice==null? '':schdVO.unitPrice}" required></td>
				</tr>
		

			</table>
			<input type="hidden" name="action" value="insert"> <input
				type="submit" value="送出" class="modify-button">
		</form>
	</div>

</body>
</html>