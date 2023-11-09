<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.members.model.*"%>
<%@ page import="com.paradisiac.members.controller.*"%>
<%@ page import="com.paradisiac.members.service.*"%>
<%-- <%@ include file=<%=request.getContextPath()%>/"back-end.index.header.jsp" %> --%>

<%
List<MembersVO> list = null;
if (request.getAttribute("getOne_For_Memno_SA") != null) {//
    list = (List<MembersVO>) request.getAttribute("getOne_For_Memno_SA");
} else if (request.getAttribute("getAll_For_Status_SA") != null) {//查狀態
    list = (List<MembersVO>) request.getAttribute("getAll_For_Status_SA");
} else if (request.getAttribute("getOne_For_Account_SA") != null) {
    list = (List<MembersVO>) request.getAttribute("getOne_For_Account_SA");
} else {
    // 列出全部
    MembersService memSvc = new MembersService();
    list = memSvc.getAll();
}
pageContext.setAttribute("list", list);
%>

<html>
<head>


  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
<title>MembersLPB.jsp: 會員管理列表</title>

<!-- 引入Bootstrap CSS -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<style>
table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
	border: 3px ridge Gray;
	height: 80px;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}

table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
</style>

<style>
table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
}
</style>

</head>

<%@ include file="/back-end/index/back-left.jsp" %>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td><h3>MembersLPB：會員管理列表</h3>
		</tr>
	</table>

	<h3>資料查詢:</h3>


	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${membersVO.errorMsgs}">
				<li style="color: red">${membersVO.message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<ul>
		<li>
			<FORM METHOD="post" ACTION="members.do">
				<b>輸入會員編號(103):</b> <input type="text" name="memno"> <input
					type="hidden" name="action" value="getOne_For_Memno"> <input
					type="submit" value="送出">
			</FORM>
		</li>

		<li>
			<FORM METHOD="post" ACTION="members.do">
				<b>輸入會員帳號 :</b> <input type="text" name="memaccount"> <input
					type="hidden" name="action" value="getOne_For_Account"> <input
					type="submit" value="送出">
			</FORM>
		</li>

		<jsp:useBean id="MembersService" scope="page"
			class="com.paradisiac.members.service.MembersService" />

		<li>
			<form method="post" action="members.do">
				<label for="memstatus_dropdown"><b>選擇帳號狀態:</b></label> <select
					name="memstatus" id="memstatus_dropdown">
					<option value="3">請選擇</option>
					<option value="true">正常</option>
					<option value="false">凍結</option>
				</select> <input type="hidden" name="action" value="getAll_For_Status">
				<!-- 				value=action名> -->
				<input type="submit" value="送出">
			</form>
		</li>


	</ul>


	<h3>列表</h3>
	<table>
		<tr>
			<th>會員編號</th>
			<th>帳號狀態</th>
			<th>姓名</th>
			<th>帳號</th>
			<th>電子信箱</th>
			<th>手機</th>
			<th>地址</th>
			<th>註冊時間</th>
			<th>修改</th>
		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="MembersVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">

			<tr>
				<td>${MembersVO.memno}</td>
				<td><c:choose>
						<c:when test="${MembersVO.memstatus == true}">
            				正常
        				</c:when>
						<c:when test="${MembersVO.memstatus == false}">
							<span style="color: red;">凍結</span>
						</c:when>
					</c:choose></td>
				<td>${MembersVO.memname}</td>
				<td>${MembersVO.memaccount}</td>
				<td>${MembersVO.memmail}</td>
				<td>${MembersVO.membir}</td>
				<td>${MembersVO.memphone}</td>
				<td>${MembersVO.memdate}</td>

				<td>
					<FORM METHOD="post" ACTION="members.do" style="margin-bottom: 0px;">
						<input type="submit" value="修改"> <input type="hidden"
							name="memno" value="${MembersVO.memno}"> <input
							type="hidden" name="action" value="get_all_back">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>


</body>
</html>