<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.members.model.*"%>
<%@ page import="java.util.Base64;"%>


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>會員專區資料修改 - MembersUpdate.jsp</title>

<style>
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
<body bgcolor='white'>

	<table id="table-1">
	</table>
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
	
	<FORM METHOD="post" ACTION="login.do" name="form1">
		<table>
			<tr>
				<td>會員頭像:</td>
				<td><input type="HIDDEN" name="mempicture"
					value="${membersVO.mempicture}" size="45" />${membersVO.mempicture}</td>

				<c:choose>
					<c:when test="${not empty membersVO.mempicture}">
						<img
							src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(membersVO.mempicture)}"
							class="preview_img" id="preview_img_id">
					</c:when>
					<c:otherwise>
						<span class="text">預覽圖</span>
					</c:otherwise>
				</c:choose>
			</tr>
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
