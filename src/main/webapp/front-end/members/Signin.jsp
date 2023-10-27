<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.members.model.*"%>

<%
MembersVO membersVO = (MembersVO) request.getAttribute("memberVO");
pageContext.setAttribute("membersVO", membersVO);
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>會員資料新增 - Signin.jsp</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	var drop_zone_el = document.getElementById("drop_zone");
	var preview_el = document.getElementById("preview");
	var p_file_el = document.getElementById("p_file");
	$(document).ready(function() {
		$('#memaccount').on('blur', function() {
			var username = $(this).val();
			$.ajax({
				type : "POST",
				url : "UsernameValidationServlet",
				data : {
					username : username
				},
				success : function(response) {
					if (response === 'exists') {
						alert("帳號已存在，請重新輸入帳號。");
						$('#memaccount').val('');
					}
				}
			});
		});

		$('#checkCaptchaButton').on('click', function() {
			var captcha = $('#memcaptcha').val();
			$.ajax({
				type : "POST",
				url : "CaptchaValidationServlet",
				data : {
					captcha : captcha
				},
				success : function(response) {
					if (response === 'invalid') {
						alert("無效驗證碼，請重試。");
					} else {
						alert("驗證成功。");
					}
				}
			});
		});
	});
</script>

<style>
</style>
</head>
<body>

	<h3>會員註冊 - Sign.jsp</h3>

	<a href="login.jsp">回登入</a>

	<h3>資料新增:</h3>

	<c:if test="${not empty errorMsgs}">
		<div class="error-message">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</div>
	</c:if>

	<form method="post" action="members.do" name="form1"
		enctype="multipart/form-data">
		<input type="hidden" name="action" value="insert">

		<div>
			<label for="memname">會員姓名:<font color="red"><b>*</b></font></label> <input
				type="text" name="memname" value="${membersVO.memno}" size="45" />
		</div>

		<div>
			<label for="memmail">電子信箱:<font color="red"><b>*</b></font></label> <input
				type="text" name="memmail" value="${membersVO.memno}" size="45" />
			<input type="button" value="取得驗證碼"> <input type="hidden"
				name="action" value="genAuthCode">
		</div>
		<div>
			<label for="memcaptcha">註冊驗證碼：<font color="red"><b>*</b></font></label>
			<input type="text" name="memcaptcha" id="memcaptcha"
				value="${membersVO.memno}" /> <input type="button" value="驗證"
				id="checkCaptchaButton" />
		</div>
		<div>
			<label for="memaccount">帳號:<font color="red"><b>*</b></font></label>
			<input type="text" name="memaccount" value="${membersVO.memno}"
				size="45" />
		</div>

		<div>
			<label for="mempass">密碼:<font color="red"><b>*</b></font></label> <input
				type="text" name="mempass" value="${membersVO.memno}" size="45" />
		</div>

		<div>
			<label for="mempass">再次確認密碼:<font color="red"><b>*</b></font></label>
			<input type="text" name="mempass" value="${membersVO.memno}"
				size="45" />
		</div>

		<div>
			<label>性別:<font color="red"><b>*</b></font></label> <input
				type="radio" name="memgender" value="1" id="male" checked> <label
				for="male">男</label> <input type="radio" name="memgender" value="2"
				id="female"> <label for="female">女</label> <input
				type="radio" name="memgender" value="3" id="other"> <label
				for="other">其他</label>
		</div>

		<div>
			<label for="memid">身分證字號:<font color="red"><b>*</b></font></label> <input
				type="text" name="memid" value="${membersVO.memno}" size="45" />
		</div>

		<div>
			<label for="membir">生日:</label> <input name="membir" id="f_date1"
				type="date">
		</div>

		<div>
			<label for="memphone">電話:<font color="red"><b>*</b></font></label> <input
				type="text" name="memphone" value="${membersVO.memno}" size="45" />
		</div>

		<div>
			<label for="memaddress">地址:</label> <input type="text"
				name="memaddress" value="${membersVO.memno}" size="45" />
		</div>

		<div>
			<label for="mempicture">上傳會員頭像:</label> <input name="mempicture"
				id="p_file" type="file" value="">
		</div>

		<br> <input type="submit" value="註冊"> <br> <input
			type="hidden" name="action" value="insert">
	</form>

</body>
</html>
