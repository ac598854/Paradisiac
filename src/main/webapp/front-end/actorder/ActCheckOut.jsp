<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<!-- 引入Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

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

/* .logo .icon { */
/* 	font-size: 32px; */
/* 	line-height: 32px; */
/* 	margin-right: 5px; */
/* } */
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
	border-radius: 5px; width : 50px;
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

		<div class="container"></div>
		<div class="details shadow">
			<div class="details__item">

				<div class="item__image">
					<img class="image"
						src="https://images.unsplash.com/photo-1539498508910-091b5e859b1d?q=80&w=1925&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
						alt="">
				</div>
				<div class="item__details">
					<div class="item__title" name="actname">${ActOderVO.actname}活動名稱</div>
					<div class="item__price" name="unitprice">${ActOderVO.unitprice}活動單價</div>
					<div class="item__description" id="item__description"
						name="actcontent">${ActOderVO.actcontent}活動介紹</div>
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

							<h6 class="my-0"></h6> <small class="text-muted">活動名稱/數量</small>
						</li>
						<li
							class="list-group-item d-flex justify-content-between lh-condensed">
							<div>
								<h6 class="my-0">${ActOderVO.actname}活動</h6>
								<small class="text-muted">數量</small>
							</div> <span class="text-muted">${ActOderVO.unitprice}活動單價</span>
						</li>
						<li class="list-group-item d-flex justify-content-between"><span>Total
								(TWD)</span> <strong>總金額JS換算回傳</strong></li>
					</ul>
					<hr class="mb-4">
				</div>
				<div class="col-md-8 order-md-1">
					<h4 class="mb-3">訂購人資料</h4>
					<form class="needs-validation" novalidate>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="firstName">會員編號</label> <input type="text"
									class="form-control" id="firstName" name="memno" placeholder=""
									value="${memno}" disabled>
							</div>
							<div class="col-md-6 mb-3">
								<label for="firstName">訂購人姓名</label> <input type="text"
									class="form-control" id="firstName" placeholder=""
									value="${ActOderVO.memname}" required disabled>
							</div>
							<div class="col-md-6 mb-3">
								<label for="firstName">訂購人電話</label> <input type="text"
									class="form-control" id="firstName" placeholder=""
									value="${ActOderVO.memname}" required disabled>
							</div>
						</div>
						<hr class="mb-4">
						<h4 class="mb-3">參加人資料</h4>
						<div class="row" id="participant">
							<div class="col-md-12 mb-6">
								<label for="firstName">參加人姓名</label> <input type="text"
									class="form-control" id="atn_name" name="atn_name"
									placeholder="" value="${memno}" required>
							</div>
							<div class="col-md-12 mb-6">
								<label for="firstName">參加人身分證字號</label> <input type="text"
									class="form-control" id="atn_id_number" name="atn_id_number"
									placeholder="" value="${ActOderVO.memname}" required>
							</div>
							<div class="col-md-12 mb-6">
								<label for="firstName">參加人電話</label> <input type="text"
									class="form-control" id="atn_tel" name="atn_tel" placeholder=""
									value="${ActOderVO.memname}" required>
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
								checked> <i class="icon icon-credit-card"></i>信用卡
							</label> <label class="payment__type payment__type--paypal btn" id="ATM">
								<input type="radio" name="paymentMethod" id="ATMRadio"
								autocomplete="off"> <i class="icon icon-paypal"></i>銀行匯款
							</label>
						</div>
					</form>
					<div class="pay-container" id="pay-container">
						<div class="row participant-container"></div>
						<br> <br>
						<div class="invalid-feedback">卡上的名字是必填的</div>

						<div class="row participant-container">
							<div class="col-md-12 mb-6">
								<label for="cc-number">信用卡姓名</label> <input type="text"
									class="form-control" id="cc-number" placeholder="" required>
								<div class="invalid-feedback">信用卡號碼是必填的</div>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-md-4 mb-2">
								<label for="cc-expiration">到期日</label> <input type="month"
									class="form-control" id="cc-expiration" placeholder="" required>
								<div class="invalid-feedback">Expiration date required</div>
							</div>
							<div class="col-md-8 mb-3">
								<label for="cc-cvv">三碼檢查碼</label> <input type="text"
									class="form-control" id="cc-cvv" placeholder="" required>
								<div class="invalid-feedback">Security code required</div>
							</div>
						</div>
					</div>

					<br>
					<div class="pay-container" id="pay-container_ATM">
						<p style="color: red; font-weight: bold;">訂單有效時間為24小時，請於24小時內轉帳成功後，訂單即成立。</p>
					</div>

					<br>
				</div>
			</div>
			<hr class="mb-4">
			<button class="btn btn-primary btn-lg btn-block" id="btn-submit"
				type="submit">結帳</button>
		</div>
	</section>
	<br>
	<br>

	<%@ include file="/front-end/index/footer.jsp"%>


	<script>
	$(document).ready(function(){
	    $.ajax({
	        type: "POST",
	        url: "<%=request.getContextPath()%>/front-end/members/members.do?action=indexLogin",
	        success: function(data) {
	            const responseMessage = parseInt(data);
	            var  contextPath='<%=request.getContextPath()%>';
	            var guided = contextPath + '/front-end/index/guided.jsp';
				var guidedSignout= contextPath + '/front-end/index/guidedSignout.jsp';
	            if (responseMessage === 1) {
	                $("#dynamicContent").load(guided);
	            } else if (responseMessage === 0) {

	                $("#dynamicContent").load(guidedSignout);
	            }
	        },
	        error: function(error) {
	            console.log("AJAX error:", error);
	        }
	    });
	});

		document
				.addEventListener(
						'DOMContentLoaded',
						function() {

							var creditCardLabel = document
									.getElementById('credit-card');
							var ATMLabel = document.getElementById('ATM');
							var payContainer = document
									.getElementById('pay-container');
							var payContainer_ATM = document
									.getElementById('pay-container_ATM');

							// 信用卡
							creditCardLabel
									.addEventListener(
											'click',
											function() {
												payContainer.style.display = "";
												payContainer_ATM.style.display = "none";
											});

							// 銀行
							ATMLabel.addEventListener('click', function() {
								payContainer.style.display = "none";
								payContainer_ATM.style.display = "";
							});
						});

		document
				.getElementById('addParticipantBtn')
				.addEventListener(
						'click',
						function() {

							var participantName = document
									.getElementById('atn_name').value;
							var participantIdNumber = document
									.getElementById('atn_id_number').value;
							var participantTel = document
									.getElementById('atn_tel').value;

							var newRow = document.createElement('div');
							newRow.className = 'row';
							newRow.id = 'addContent';
							newRow.innerHTML = '<div><br></div>'
									+ '<div class="col-md-12 mb-6">'
									+ '<label for="firstName">參加人姓名</label> <input type="text" class="form-control" value="' + participantName + '" disabled>'
									+ '</div>'
									+ '<div class="col-md-12 mb-6">'
									+ '<label for="firstName">參加人身分證字號</label> <input type="text" class="form-control" value="' + participantIdNumber + '" disabled>'
									+ '</div>'
									+ '<div class="col-md-12 mb-6">'
									+ '<label for="firstName">參加人電話</label> <input type="text" class="form-control" value="' + participantTel + '" disabled>'
									+ '<button type="button" class="btn_delete">移除</button>'
									+ '</div>' + '<hr class="mb-4">';

							// 添加新的 <div class="row"> 到 id="participantList"
							document.getElementById('participantList')
									.appendChild(newRow);

							// 清空輸入框
							document.getElementById('atn_name').value = '';
							document.getElementById('atn_id_number').value = '';
							document.getElementById('atn_tel').value = '';
						});

		//移除參加人
		$("div.row").on("click", "button.btn_delete", function() {
			console.log(1);
			let r = confirm("確認移除？");
			if (r) {
				console.log(this);
				$(this).closest("div.row").animate({
					"opacity" : 0
				}, 100, "swing", function() {
					$(this).remove();
				});
			}
		});
		
	
		
	</script>

</body>

</html>