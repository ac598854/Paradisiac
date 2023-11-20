<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.members.model.*"%>
<%@ page import="com.paradisiac.members.controller.*"%>
<%@ page import="com.paradisiac.members.service.*"%>
<%@ page import="java.util.*"%>

<%
MembersVO membersVO = null;
membersVO = (MembersVO) session.getAttribute("membersVO");
%>

<!DOCTYPE html>
<html>

<head>
<!-- 引入Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/sweetalert2.min.css">

<meta charset="UTF-8">
<title>Paradisiac Bay-登入</title>

<style>
body {
	background:
		url('https://images.unsplash.com/photo-1610641818989-c2051b5e2cfd?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')
		center center/cover fixed;
	position: relative;
}

body::before {
	content: "";
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.7);
	z-index: -1;
}

.container {
	width: 65%;
}

.form-style input {
	border: 0;
	height: 50px;
	border-radius: 0;
	border-bottom: 1px solid #ebebeb;
}

.form-style input:focus {
	border-bottom: 1px solid #007bff;
	box-shadow: none;
	outline: 0;
	background-color: #ebebeb;
}

.sideline {
	display: flex;
	width: 100%;
	justify-content: center;
	align-items: center;
	text-align: center;
	color: #ccc;
}

button {
	height: 50px;
}

.sideline:before, .sideline:after {
	content: '';
	border-top: 1px solid #ebebeb;
	margin: 0 20px 0 0;
	flex: 1 0 20px;
}

.sideline:after {
	margin: 0 0 0 20px;
}

.img-fluid {
	min-height: 100%;
	position: relative;
	border-top-left-radius: 20px;
	border-bottom-left-radius: 20px;
}

.img-fluid::after {
	content: "";
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(255, 255, 255, 0.6);
	z-index: 1;
}

.p-5 {
	border-top-right-radius: 20px;
	border-bottom-right-radius: 20px;
}

#password-container {
	position: relative;
}

.toggle-mempass {
	position: absolute;
	top: 50%;
	right: 10px;
	transform: translateY(-50%);
	cursor: pointer;
}
</style>
</head>

<body>
	<%@ include file="/front-end/index/guidedSignout.jsp"%>
	<div class="container">
		<div class="row m-5 no-gutters shadow-lg">
			<div class="col-md-6 d-none d-md-block">
				<img
					src="https://images.unsplash.com/photo-1613425653628-23fd58c3c2b1?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2134&q=80"
					class="img-fluid" />
			</div>

			<div class="col-md-6 bg-white p-5">
				<h3 class="pb-3">會員登入</h3>
				<div class="form-style">
					<form method="post" action="login.do" name="form1" id="form1">
						<div class="form-group pb-3">
							<input type="text" placeholder="帳號" class="form-control"
								id="memaccount" name="memaccount" required>
						</div>
						<div class="form-group pb-3" id="password-container">
							<input type="password" name="mempass" class="form-control"
								id="mempass" placeholder="密碼" required> <span
								class="toggle-mempass" onclick="togglePasswordVisibility()">👁️</span>
						</div>
						<div id="result" style="color: red;"></div>
						<br> <br>

						<div class="d-flex align-items-center justify-content-between">
							<div class="d-flex align-items-center">
								<a
									href="<%=request.getContextPath()%>/front-end/members/ForgetPass.jsp">忘記密碼?</a>
							</div>
						</div>
						<div class="pb-2">
						<input type="hidden" name="action" value="loginCheck">
							<button type="submit"
								class="btn btn-dark w-100 font-weight-bold mt-2"
								id="submitButton">登入</button>							
						</div>
					</form>
					<div class="pt-4 text-center">
						還不是會員? <a
							href="<%=request.getContextPath()%>/front-end/members/Signin.jsp">註冊會員</a>
					</div>
				</div>
			</div>
		</div>
	</div>

<%@ include file="/front-end/index/footer.jsp"%>
<script src="https://use.fontawesome.com/f59bcd8580.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="../js/sweetalert2.all.min.js"></script>
<script>
	var fieldsValid = true;

	function togglePasswordVisibility() {
		var passwordInput = document.getElementById('mempass');
		var toggleButton = document.querySelector('.toggle-mempass');

		if (passwordInput.type === 'password') {
			passwordInput.type = 'text';
			toggleButton.textContent = '👁️';
		} else {
			passwordInput.type = 'password';
			toggleButton.textContent = '👁️';
		}
	}

	function checkRequiredFields() {
		var isValid = true;
		var fieldIds = [ "memaccount", "mempass" ];
		for (var i = 0; i < fieldIds.length; i++) {
			var fieldId = fieldIds[i];
			var inputElement = $("#" + fieldId);
			if (inputElement.length > 0) {
				var fieldValue = inputElement.val().trim();
				if (inputElement.prop("required") && fieldValue === "") {
					isValid = false;
					inputElement.val(fieldValue);
					break;
				}
				// 回寫清除空白的值
				inputElement.val(fieldValue);
				console.log("回寫值" + inputElement.val());
			} else {
				console.error("Element with id '" + fieldId + "' not found.");
			}
		}
		return isValid;
	}

	$(function() {
		$("#memaccount, #mempass").on('blur', function() {
			var fieldsValid = checkRequiredFields();
			if (!fieldsValid) {
				document.getElementById("result").innerText = "帳號、密碼請勿空白";
			} else {
				document.getElementById("result").innerText = "";
			}
		});
	});

	var error = '${param.error}';
	if (error === 'noAccount') {
		console.log("error=" + error);
		Swal.fire({
			title : '登入失敗',
			icon : 'error',
			text : '帳號或密碼錯誤',
			showConfirmButton : false,
			showCloseButton : true,
			timer : 1500
		})
	} else if (error === 'lockAccount') {
		Swal.fire({
			title : '登入失敗',
			icon : 'error',
			text : '會員已停權，請聯絡客服',
		})
	}

	
</script>
</body>
</html>
