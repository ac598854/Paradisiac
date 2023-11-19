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
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>會員專區資料修改 - MembersUpdate.jsp</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/sweetalert2.min.css">
<style>
#round-image-container {
	width: 100px;
	height: 100px;
	border-radius: 50%;
	overflow: hidden;
	margin: 10px auto;
	position: relative;
}

.round-image {
	height: 100%;
	object-fit: cover;
}

#preview {
	margin-top: 5px;
	border: 1px dashed #6c757d;
	display: flex;
	min-height: 150px;
	position: relative;
	border-radius: 10px;
	width: 100%;
	justify-content: center;
	align-items: center;
	border: 1px dashed #6c757d;
}

#password-container {
	position: relative;
}

.toggle-mempass {
	position: absolute;
	top: 45px;
	right: 10px;
	transform: translateY(-50%);
	cursor: pointer;
	align-items: center;
}
</style>
<%@ include file="/front-end/index/MembersMeta.jsp"%>
</head>

<body>
	<%@ include file="/front-end/index/MembersBody.jsp"%>
	<div class="container mt-5">
		<form METHOD="post" ACTION="members.do" name="form1" id="form1"
			enctype="multipart/form-data">
			<!-- 讀出的會員圖片 -->
			<div class="row mb-3">
				<div class="col-md-12 text-center" id="round-image-container">
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
			</div>

			<!-- 上傳圖片 -->
			<div class="row mb-3">
				<div class="col-sm-12 ">
					<label for="mempicture">會員頭像</label>
					<div class="custom-file">
						<input type="file" class="custom-file-input" id="mempicture"
							name="mempicture" accept="image/*"> <label
							class="custom-file-label" for="mempicture">選擇檔案</label>
					</div>
					<div id="preview">
						<img id="avatar-preview" class="mt-2"
							style="max-width: 100%; max-height: 200px;" />
					</div>
				</div>
			</div>
			<!-- 會員編號 -->
			<div class="row mb-3">
				<div class="col-md-12">
					<label for="memno">會員編號</label> <input type="text"
						class="form-control" id="memno" name="memno"
						value="${membersVO.memno}" readonly>
				</div>
			</div>
			<!-- 其他欄位以兩欄一列方式呈現 -->
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label for="memname">姓名<span class="text-danger">*</span></label>
						<input type="text" class="form-control" id="memname"
							name="memname" value="${membersVO.memname}" placeholder="請輸入姓名">
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="memmail">Email<span class="text-danger">*</span></label>
						<input type="email" class="form-control" id="email" name="memmail"
							value="${membersVO.memmail}" placeholder="請輸入Email" oninput="checkEmail()">
							<div id="result_Mail" style="color: red;"></div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="memaccount">帳號</label> <input type="text"
							class="form-control" id="memaccount" name="memaccount"
							value="${membersVO.memaccount}" disabled>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group" id="password-container">
						<label for="mempass">修改密碼</label> <input type="password" class="form-control" id="mempass" name="mempass"
							placeholder="修改密碼"> <span class="toggle-mempass"
							onclick="togglePasswordVisibility()">👁️</span>
					</div>

				</div>
				<div class="col-md-6">
					<label for="memgender">性別</label> <select id="memgender"
						class="form-control browser-default custom-select"
						name="memgender">
						<option value="1">男</option>
						<option value="2">女</option>
						<option value="3">其他</option>
					</select>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="memid">身分證字號<span class="text-danger">*</span></label>
						<input type="text" class="form-control" name="memid"
							value="${membersVO.memid}" id="memid"
							placeholder="請輸入身分證字號(首字須為英文大寫)" oninput="checkMemId()" required>
						<div id="result_Id" style="color: red;"></div>
					</div>
				</div>
				<div class="col-sm-6">
					<label for="membir">生日</label> <input type="date" name="membir"
						value="${membersVO.membir}" class="form-control" id="membir"
						placeholder="">
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="memphone">電話<span class="text-danger">*</span></label>
						<input type="text" class="form-control" id="memphone"
							name="memphone" value="${membersVO.memphone}"
							placeholder="輸入電話/手機，例如:09XXXXXXXX、02XXXXXXX"
							oninput="checkPhoneNumber()" required />
						<div id="result" style="color: red;"></div>
					</div>
				</div>
				<div class="col-sm-12">
					<label for="memaddress">地址</label> <input type="text"
						name="memaddress" class="form-control" id="memaddress" value="${membersVO.memaddress}"
						placeholder="請輸入地址"> <br>
				</div>
				<div class="col-sm-12">
				<button type="submit" class="btn btn-primary" id="submitButton">提交更新</button>
				<input type="hidden" name="action" value="update-Front">
				</div>
			</div>
		</form>
	</div>
	<script src="https://use.fontawesome.com/f59bcd8580.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="../js/sweetalert2.all.min.js"></script>
	<script src="./js/Address.js"></script>
	<script>
		var isMemphoneValid = true;
		var isValidEmail = true;
		var isMemIdValid = true;
		var p_file_el = document.getElementById("mempicture");
		document.getElementById('mempicture').addEventListener('change',
				function(event) {
					console.log("讀圖");
					var preview = document.getElementById('avatar-preview');
					var file = event.target.files[0];

					if (file) {
						var reader = new FileReader();
						reader.onload = function(e) {
							preview.src = e.target.result;
						};
						reader.readAsDataURL(file);
					} else {
						preview.src = '';
					}
				});

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
		function checkEmail() {
			var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			var emailValue = $("#email").val().trim();
			if (emailValue === "" || !emailRegex.test(emailValue)) { 
				document.getElementById("result_Mail").innerText = "請輸入有效的Email地址";
				isValidEmail = false; 
				return;
			} else {
				document.getElementById("result_Mail").innerText = "";
				isValidEmail = true;
			}
		}
		function checkPhoneNumber() {
			var phoneInput = document.getElementById("memphone");
			var phoneNumber = phoneInput.value.trim().replace(/\D/g, ''); // 刪除空格並刪除非數字字符
			var mobilePattern = /^09\d{8}$/;
			var landlinePattern = /^0\d{1,2}\d{6,8}$/;
			if (mobilePattern.test(phoneNumber)) {
				document.getElementById("result").innerText = "";
				isMemphoneValid = true;
			} else if (landlinePattern.test(phoneNumber)) {
				document.getElementById("result").innerText = "";
				isMemphoneValid = true;
			} else {
				document.getElementById("result").innerText = "非有效手機、市話號碼格式";
				isMemphoneValid = false;
			}
		}
		function checkMemId() {
			var IdInput = document.getElementById("memid");
			var MemId = IdInput.value.trim();
			var MemIdReg = /^[A-Z][12]\d{8}$/;
			if (MemIdReg.test(MemId)) {
				document.getElementById("result_Id").innerText = "";
				isMemIdValid = true;
			} else {
				document.getElementById("result_Id").innerText = "身分字號不符合規格，首字需大寫";
				isMemIdValid = false;
			}
		}

		//所有欄位濾空白、必填無值提醒
		function checkRequiredFields() {
			var isValid = true;
			var fieldIds = [ "email", "memname", "memphone", "memid" ];

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
				} else {
					console.error("Element with id '" + fieldId
							+ "' not found.");
				}
			}
			return isValid;
		}

		$('#submitButton').click(function(e) {
			e.preventDefault();
			var fieldsValid = checkRequiredFields();//過濾空白檢查
			console.log("fieldsValid:"+fieldsValid);
			console.log("isMemphoneValid:"+isMemphoneValid);
			console.log("isMemIdValid:"+isMemIdValid);
			console.log("isValidEmail:"+isValidEmail);
			
			if (fieldsValid && isMemphoneValid && isMemIdValid && isValidEmail) {
				// 驗證通過
				$("#form1 input[name='action']").val("update-Front");
				// 送出
				$("#form1").submit();
				alert("送出成功");
			} else {
				alert("必填未填");
			}
		});
	</script>
</body>

</html>
