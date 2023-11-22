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
<title>修改檔期</title>
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
	background-color: #f2f2f2; <%--f2f2f2--%>
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
	<div class="container">
		<table class="form-section1">
			<tr>
				<th colspan="6" style="text-align: center;">修改檔期內容</th>
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
					
                <th>檔期編號</th>
                <td>${schdVO.schdNo}</td>
                <jsp:useBean id="actSvc" scope="page" class="com.paradisiac.act.service.ActServiceImpl" />
					<th>活動類別</th>
					<td>${schdVO.act.actNo}-${schdVO.act.actName}</td>
					<th>報名狀態</th>
					<%--1:報名中 2:成團 3:未成團 4:因故取消 --%>
					<td><select name="applStatus">
						<option value="1" ${(schdVO.applStatus==1)?'selected':'' }>1-報名中</option>
						<option value="2" ${(schdVO.applStatus==2)?'selected':'' }>2-成團</option>
						<option value="3" ${(schdVO.applStatus==3)?'selected':'' }>3-未成團</option>
						<option value="4" ${(schdVO.applStatus==4)?'selected':'' }>4-因故取消</option>
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
				<tr>
					<th>最低成團人數</th>
					<td><input type="text" name="lowNum" value="${schdVO.lowNum==null? '':schdVO.lowNum}" required></td>
					<th>最高上限人數</th>
					<td><input type="text" name="highNum" value="${schdVO.highNum==null? '':schdVO.highNum}" required></td>
				</tr>
				<%-- 
            <tr>
                <th>未繳費人數</th>
                <td><input type="text" name="" required></td>
                <th>已繳費人數</th>
                <td><input type="text" name="" required></td>
            </tr>--%>

			</table>
			<input type="hidden" name="action" value="update"> 
			<input type="hidden" name="actNo" value="${schdVO.act.actNo}">
			<input type="hidden" name="schdNo" value="${schdVO.schdNo}">
			<input type="submit" value="送出" class="modify-button">
		</form>
	</div>

</body>
</html>