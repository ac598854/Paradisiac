<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ page import="com.paradisiac.act.model.*"%>
<%@ page import="com.paradisiac.act.controller.*"%>
<%@ page import="com.paradisiac.act.service.*"%>
<%@ page import="com.paradisiac.actorder.service.*"%>
<%@ page import="com.paradisiac.actorder.service.*"%>
<%@ page import="com.paradisiac.actorder.service.*"%>
<!DOCTYPE html>
<html>

<head>
<!-- 引入Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet" href="../css/sweetalert2.min.css">
<meta charset="UTF-8">
<title>Paradisiac Bay-活動結帳頁</title>

<style>
*, *:after, *:before {
	box-sizing: border-box;
}

ul {
	padding-left: 10px;
}

body {
	font-family: "Josefin Sans", sans-serif;
	color: #0a0a0a;
	line-height: 1.4;
}

a {
	color: #000;
}

.content {
	z-index: 9999;
}

.secure, .backBtn {
	display: flex;
}

.secure span, .backBtn span {
	margin-left: 5px;
}

.backBtn {
	margin-top: 20px;
}

.secure {
	color: #afb5c0;
	align-items: flex-end;
}

.secure .icon {
	font-size: 20px;
	line-height: 20px;
}

.previous page {
	font-size: 20px;
	font-weight: bold;
	display: flex;
	justify-content: center;
	align-items: flex-end;
}

img {
	width: 100%;
	border-radius: 8px 0 0 8px;
}

.details {
	max-width: 800px;
	min-height: 300px;
	margin-left: auto;
	margin-right: auto;
	margin-top: -200px;
	background: #fff;
	border-radius: 8px;
	display: flex;
	flex-direction: column;
	position: relative;
}

.details__item {
	display: flex;
}

.details__user {
	background: #f6f9fc;
	padding: 20px;
	border-radius: 8px;
	border: 1px solid #dadada;
}

.item__quantity {
	position: absolute;
	right: 50px;
	top: 30px;
	font-size: 20px;
}

.item__image {
	display: flex;
	align-items: center;
	justify-content: center;
}

.item__image .image {
	margin-top: -50px;
	margin-left: -100px;
	width: 300px;
}

.item__details {
	padding: 30px;
}

.item__title {
	font-size: 28px;
	font-weight: 600;
}

.item__price {
	font-size: 22px;
	color: #bec3cb;
}

.icon {
	font-size: 16px;
	vertical-align: middle;
}

header {
	background-color: #f6f9fc;
	min-height: 500px;
	background-image: url("../images/pattern.png");
}

.navigation {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 50px 0 80px 0;
	color: #246eea;
	font-size: 14px;
	text-transform: uppercase;
	letter-spacing: 1px;
	font-weight: 700;
}

.container {
	width: 960px;
	margin: 0 auto;
}

.shadow {
	box-shadow: 0 15px 35px rgba(50, 50, 93, 0.1), 0 5px 15px
		rgba(0, 0, 0, 0.07);
}

.row {
	display: flex;
}

.txt {
	border-color: #e1e8ee;
	width: 100%;
}

.input {
	border-radius: 5px;
	border-style: solid;
	border-width: 2px;
	height: 48px;
	padding-left: 15px;
	font-weight: 600;
	font-size: 14px;
	color: #5e6977;
}

input[type="text"] {
	display: initial;
	padding: 15px;
}

.text-validated {
	border-color: #7dc855;
	background-image: url("../images/icon-tick.png");
	background-repeat: no-repeat;
	background-position: right 18px center;
}

.ddl {
	border-color: #f0f4f7;
	background-color: #f0f4f7;
	width: 100px;
	margin-right: 10px;
}

.title {
	font-size: 14px;
	padding-bottom: 8px;
}

.field {
	padding-top: 15px;
	padding-right: 30px;
	width: 50%;
}

.field.small {
	width: auto;
}

.notification {
	text-align: center;
	font-size: 28px;
	font-weight: 600;
	display: flex;
	justify-content: center;
}

.notification .icon {
	font-size: 28px;
	color: #7dc855;
	line-height: 28px;
	margin-right: 10px;
}

.actions {
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	padding: 60px 0 40px 0;
}

.btn {
	font-family: "Josefin Sans", sans-serif;
	border-radius: 8px;
	border: 0;
	letter-spacing: 1px;
	color: #fff;
	background: #246eea;
	padding: 20px 60px;
	white-space: nowrap;
	font-size: 16px;
	line-height: 1;
	text-transform: uppercase;
	transition: all 0.15s ease;
	text-decoration: none;
}

.btn:hover {
	-webkit-transform: translateY(-1px);
	transform: translateY(-1px);
	background: #4984ea;
}

.btn.action__back {
	background: transparent;
	color: #a0a0a0;
}

.thankyou {
	display: block;
}

.thankyou .details {
	opacity: 1;
	justify-content: center;
	align-items: center;
}

.thankyou .details h3 {
	font-weight: 600;
}

.thankyou .details__item {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.thankyou .details__item .icon-xl {
	font-size: 32px;
	color: #7dc855;
	line-height: 32px;
}

.loading {
	position: relative;
}

.loading:after {
	-webkit-animation: spinAround .5s infinite linear;
	animation: spinAround .5s infinite linear;
	border: 4px solid #7dc855;
	border-radius: 290486px;
	border-right-color: transparent;
	border-top-color: transparent;
	content: "";
	height: 5em;
	width: 5em;
	position: absolute;
}

.loading .details__item {
	opacity: 0;
}

.payment__title {
	margin: 40px 0 20px 0;
	font-size: 18px;
	display: flex;
	text-align: left;
}

.payment__title .icon {
	margin-right: 10px;
}

.btn {
	font-family: "Josefin Sans", sans-serif;
	border-radius: 8px;
	border: 0;
	letter-spacing: 1px;
	color: #fff;
	background: #246eea;
	padding: 20px 60px;
	white-space: nowrap;
	font-size: 16px;
	line-height: 1;
	text-transform: uppercase;
	transition: all 0.15s ease;
	text-decoration: none;
}

.btn .icon {
	margin-left: 10px;
	font-size: 20px;
}

.btn:hover {
	-webkit-transform: translateY(-1px);
	transform: translateY(-1px);
	background: #4984ea;
}

.btn.action__back {
	background: transparent;
	color: #a0a0a0;
}

.payment__types {
	display: flex;
	justify-content: center;
	align-items: center;
}

.payment__info {
	display: flex;
}

.payment__cc {
	flex: 60%;
}

.payment__shipping {
	flex: 40%;
}

.shipping__info {
	background: #f6f9fc;
	padding: 10px;
	border-radius: 8px;
}

.payment__type {
	display: flex;
	border: 2px solid #d9d9d9;
	border-radius: 8px;
	padding: 20px 40px;
	width: 100%;
	justify-content: center;
	align-items: center;
	cursor: pointer;
	color: #d9d9d9;
	transition: all 0.15s ease;
}

.payment__type:hover {
	-webkit-transform: translateY(-1px);
	transform: translateY(-1px);
}

.payment__type.active {
	color: #0a0a0a;
	background: #f6fcf7;
	border-color: #7dc855;
}

.payment__type .icon {
	font-size: 32px;
	margin-right: 10px;
}

.payment__type+.payment__type {
	margin-left: 10px;
}

#btn-submit {
	display: block;
}

.btn_update, .btn_delete {
	text-align: center;
	border-radius: 5px;
	width: 50px;
	height: 30px;
	font-size: 16px;
	vertical-align: middle;
	line-height: 30px;
	padding-top: 0px;
	padding-bottom: 0px;
	margin-top: 15px;
	margin-right: 20px;
	color: #0a0a0a;
	background: #f6fcf7;
	border-color: #7dc855;
	width: 50px;
}

#row1 {
	flex-wrap: wrap;
	margin-right: -15px;
	margin-left: -15px;
}

.col-md-12 {
	padding-bottom: 10px;
}
</style>

</head>

<body>
	<div id="dynamicContent"></div>
	<header>
		<div class="container">
			<div class="navigation">

				<div class="secure">
					<i class="previous page"><a href="#" class="btn-shop">回上一頁</a></i>

				</div>
			</div>
			<div class="notification">完成您的訂單</div>
		</div>
	</header>
	<section class="content">
		<form class="needs-validation" id="form1"
			action="${pageContext.request.contextPath}/front-end/actorder/ActOrder.do"
			method="POST">
			<div class="container"></div>
			<div class="details shadow">
				<div class="details__item">

					<div class="item__image">
<%-- 					<img src="<%=request.getContextPath()%>/dbg.do?act_no=${schdVO.act.actNo}" alt="活動封面" class="img-fluid"> --%>
						<img class="image"
							src="<%=request.getContextPath()%>/dbg.do?act_no=${schdVO.act.actNo}"
							alt="活動封面" class="img-fluid">
					</div>
					<div class="item__details">
						<div class="item__title">${schdVO.schdNo}檔期編號</div>
						<div class="item__title">${schdVO.act.actNo}-${schdVO.act.actName}活動名稱</div>
						<div class="item__price">${schdVO.unitPrice}活動單價</div>
					</div>
				</div>
			</div>
			<div class="discount"></div>
			<div class="container">
				<div class="py-5 text-center">
					<hr class="mb-4">
					<h2>結帳明細</h2>
				</div>
				<div class="row">
					<div class="col-md-4 order-md-2 mb-4">
						<h4 class="d-flex justify-content-between align-items-center mb-3">
							<span class="text-muted">訂單總金額</span>
						</h4>
						<ul class="list-group mb-3">
							<li
								class="list-group-item d-flex justify-content-between lh-condensed">
								<div>
									<h6 class="my-0">${SchdVO.schdNo}檔期編號</h6>
									<input type="hidden" class="form-control" id="schdNo"
										name="schdNo" value="${SchdVO.schdNo}">
								</div>
							</li>
							<li class="list-group-item d-flex justify-content-between">單價
								<input type="text" class="form-control" id="unitPrice"
								name="unitPrice" value="1000" readonly>
							<li class="list-group-item d-flex justify-content-between">數量
								<input type="text" class="form-control" id="countNumDisplay"
								name="countNumDisplay" readonly>
							<li class="list-group-item d-flex justify-content-between">總計
								<input type="text" class="form-control" id="orderAmount"
								name="orderAmount" value="${ActOrder.orderAmount}" readonly>
						</ul>
						<hr class="mb-4">
					</div>
					<div class="col-md-8 order-md-1">
						<!-- 					<form class="needs-validation" -->
						<!-- <%-- action="${pageContext.request.contextPath}/front-end/actorder/ActOrder.do" --%> -->
						<!-- 						method="POST"> -->
						<div class=row>
							<div class="col-md-12 mb-6">
								<h4 class="mb-3">參加人數</h4>
								<input type="text" class="form-control" id="aAtnNum"
									name="aAtnNum" value="" readonly onchange="check()">
							</div>
						</div>
						<br>
						<h4 class="mb-3">個人資料</h4>
						<div class="row" id="participant">
							<div class="col-md-12 mb-6">
								<label for="atnName">參加人姓名<span class="text-danger">*</span></label>
								<input type="text" class="form-control" id="atnName"
									placeholder="報名人若為參加人也須填寫參加人資料" value="${ActOrder.atnName}">
							</div>
							<div class="col-md-12 mb-6">
								<label for="atnIdNumber">參加人身分證字號<span
									class="text-danger">*</span></label> <input type="text"
									class="form-control" id="atnIdNumber" placeholder="請填寫身分證字號"
									value="${ActOrder.atnIdNumber}" oninput="checkId()">
								<p>A151938787</p>
								<div id="result_Id" style="color: red;"></div>

							</div>
							<div class="col-md-12 mb-6">
								<label for="atnTel">參加人電話<span class="text-danger">*</span></label>
								<input type="text" class="form-control" id="atnTel"
									placeholder="請填寫聯絡手機或電話" value="${ActOrder.atnTel}"
									oninput="checkPhoneNumber()">
								<p>0987654321</p>
								<div id="result" style="color: red;"></div>
							</div>
							<div class="col-md-12 mb-6">
								<br>
								<button type="button" id="addParticipantBtn"
									class="btn btn-secondary">增加參加人</button>
								<br>
							</div>
							<br>
						</div>
						<br>
						<div class="row1" id="participantList"></div>
						<hr class="mb-4">
						<h4 class="mb-3">付款方式</h4>
						<div class="payment btn-group btn-group-toggle"
							data-toggle="buttons">
							<label class="payment__type payment__type--cc btn active"
								id="credit-card"> <input type="radio"
								name="paymentMethod" id="creditCardRadio" autocomplete="off"
								checked> <i>信用卡</i>
							</label>
						</div>

						<div class="pay-container" id="pay-container">
							<div class="row participant-container"></div>
							<br> <br>
							<div class="row participant-container">
								<div class="col-md-12 mb-6">
									<label for="cc-number">信用卡姓名<span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="cc-number"
										placeholder="請填寫信用卡姓名" required>
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col-md-4 mb-2">
									<label for="cc-expiration">到期日<span class="text-danger">*</span></label>
									<input type="month" class="form-control" id="cc-expiration"
										required>
									<div class="invalid-feedback">Expiration date required</div>
								</div>
								<div class="col-md-8 mb-3">
									<label for="cc-cvv">三碼檢查碼<span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="cc-cvv"
										placeholder="請填寫信用卡三碼檢查碼" required>
								</div>
							</div>
						</div>
						<br> <br>
						<button class="btn btn-primary btn-lg btn-block" id="btn-submit"
							type="submit">結帳</button>
						<input type="hidden" name="action" value="insert" />
		</form>
	</section>
	<br>
	<br>

	<%@ include file="/front-end/index/footer.jsp"%>
	<script
		src="${pageContext.request.contextPath}/front-end/actorder/js/ActCheckOut.js"></script>
	<script src="../js/sweetalert2.all.min.js"></script>
	<script>
		var isMemphoneValid = false;
		var isMemIdValid = false;
		var fieldsValid =false;
		//號碼檢查
		function checkPhoneNumber() {
			var phoneInput = document.getElementById("atnTel");
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

		function checkId() {
			var IdInput = document.getElementById("atnIdNumber");
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

		function checkRequiredFields() {
			var isValid = true;
			var fieldIds = [ "cc-number", "cc-cvv", "cc-expiration" ];

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
				} 
			}
			return isValid;
		}
		$('#btn-submit').click(function(e) {
			e.preventDefault();
			var fieldsValid = checkRequiredFields();//過濾空白檢查
			if (isMemphoneValid && isMemIdValid) {
				// 驗證通過
				$("#form1 input[name='action']").val("insert");
				// 送出
				$("#form1").submit();
				Swal.fire({
					title : "訂單送出成功!",
					icon : "success"
				})
			} else {
				Swal.fire({
					title : "必填請勿空白!",
					icon : "error"
				})
			}
		});

	
		
	</script>

</body>

</html>