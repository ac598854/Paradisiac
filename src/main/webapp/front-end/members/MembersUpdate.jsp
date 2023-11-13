<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.members.model.*"%>
<%@ page import="com.paradisiac.members.service.*"%>
<%@ page import="com.paradisiac.members.controller.*"%>
<%@ page import="java.util.Base64"%>

<%
MembersService MemsSvc = new MembersService();
Integer memno = (Integer) session.getAttribute("memno");// 取memno
MembersVO membersVO = MemsSvc.getOneBymemno(memno);
pageContext.setAttribute("membersVO", membersVO);
%>
<html>
<head>
<%@ include file="/front-end/index/MembersMeta.jsp"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>會員專區資料修改 - MembersUpdate.jsp</title>

<style>
.round-image-container {
	width: 100px;
	height: 100px;
	border-radius: 50%;
	overflow: hidden;
	margin: 10px auto;
	position: relative;
}

.round-image {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}

table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
}

table, th, td {
	border: 0px solid #CCCCFF;
}

th, td {
	padding: 1px;
}
</style>
</head>
<body>
	<%@ include file="/front-end/index/MembersBody.jsp"%>

	<div id="table-1">
		<!-- Change the table to a div to apply the CSS -->
	</div>
	<h3>資料修改:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post" ACTION="members.do" name="form1"
		enctype="multipart/form-data">
		<div class="round-image-container">
			<!-- Change the table to a div to apply the CSS -->
			<input type="hidden" name="mempicture"
				value="${membersVO.mempicture}" size="45" />
			<c:choose>
				<c:when test="${not empty membersVO.mempicture}">
					<img
						src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(membersVO.mempicture)}"
						class="round-image" id="preview_img_id">
				</c:when>
				<c:otherwise>
					<img
						src="<%=request.getContextPath()%>/images/no-picture-taking.png"
						class="round-image" id="no_img_id">
				</c:otherwise>
			</c:choose>
		</div>
		<table>
			<tr>
				<td>會員編號:<font color=red><b>*</b></font></td>
				<td><input type="hidden" name="memno"
					value="${membersVO.memno}" size="45" />${membersVO.memno}</td>
			</tr>
			<tr>
				<td>上傳會員圖片:</td>
				<td><input name="mempictureup" id="p_file" type="file"></td>
			</tr>
			<tr>
				<td>會員姓名:<font color=red><b>*</b></td>
				<td><input type="TEXT" name="memname"
					value="${membersVO.memname}" size="45" /></td>
			</tr>

			<tr>
				<td>電子信箱:<font color=red><b>*</b></td>
				<td><input type="TEXT" name="memmail"
					value="${membersVO.memmail}" size="45" /></td>
			</tr>
			<tr>
				<td>帳號:<font color=red><b>*</b></td>
				<td><input type="TEXT" name="memaccount"
					value="${membersVO.memaccount}" size="45" /></td>
			</tr>
			<tr>
				<td>密碼:<font color=red><b>*</b></td>
				<td><input type="TEXT" name="mempass"
					value="${membersVO.mempass}" size="45" /></td>
			</tr>
			<tr>
				<td>性別:<font color=red><b>*</b></td>
				<td><input type="radio" name="memgender" value="1" id="male"
					<c:if test="${membersVO.memgender == 1}">checked </c:if> /> <label
					for="male">男</label> <input type="radio" name="memgender" value="2"
					id="female" <c:if test="${membersVO.memgender == 2}">checked</c:if> />
					<label for="female">女</label> <input type="radio" name="memgender"
					value="3" id="other"
					<c:if test="${membersVO.memgender == 3}">checked</c:if> /> <label
					for="other">其他</label></td>
			</tr>

			<tr>
				<td>身分證字號:<font color=red><b>*</b></td>
				<td><input type="TEXT" name="memid" value="${membersVO.memid}"
					size="45" /></td>
			</tr>
			<tr>
				<td>生日:</td>
				<td><input type="TEXT" name="membir"
					value="${membersVO.membir}" size="45" /></td>
			</tr>
			<tr>
				<td>電話:<font color=red><b>*</b></td>
				<td><input type="TEXT" name="memphone"
					value="${membersVO.memphone}" size="45" /></td>
			</tr>
			<tr>
				<td>地址:</td>
				<td><input type="TEXT" name="memaddress"
					value="${membersVO.memaddress}" size="45" /></td>
			</tr>
		</table>
		<br> <input type="hidden" name="action" value="update-Front">
		<input type="submit" value="送出修改">
	</FORM>
</body>
</html>
