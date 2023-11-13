<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 引入Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<meta charset="UTF-8">
<title>活動結帳頁</title>

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

.lead{
color:#89B0AE;
font-weight: bold;
}

</style>
</head>


<%@ include file="/front-end/index/guided.jsp"%>
<body>

	<header>
		<div class="container">
			<div class="navigation">

<!-- 				<div class="logo"> -->
<!-- 					<i class="icon icon-basket"></i>結帳 -->
<!-- 				</div> -->
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
					<div class="item__description" id="item__description" name="actcontent">${ActOderVO.actcontent}活動介紹</div>
				</div>
			</div>

		</div>
		<div class="discount"></div>
		<div class="container">
			<div class="py-5 text-center">

				<h2>結帳明細</h2>
				<p class="lead">Enjoy a relaxing and natural journey.</p>
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
								<h6 class="my-0"></h6>
								<small class="text-muted">活動名稱/數量</small>
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

				</div>
				<div class="col-md-8 order-md-1">
					<h4 class="mb-3">訂購人資料</h4>
					<form class="needs-validation" novalidate>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="firstName">First name</label> <input type="text"
									class="form-control" id="firstName" placeholder="" value=""
									required>
								<div class="invalid-feedback">Valid first name is
									required.</div>
							</div>
							<div class="col-md-6 mb-3">
								<label for="lastName">Last name</label> <input type="text"
									class="form-control" id="lastName" placeholder="" value=""
									required>
								<div class="invalid-feedback">Valid last name is required.
								</div>
							</div>
						</div>

						<div class="mb-3">
							<label for="username">Username</label>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text">@</span>
								</div>
								<input type="text" class="form-control" id="username"
									placeholder="Username" required>
								<div class="invalid-feedback" style="width: 100%;">Your
									username is required.</div>
							</div>
						</div>

						<div class="mb-3">
							<label for="email">Email <span class="text-muted">(Optional)</span></label>
							<input type="email" class="form-control" id="email"
								placeholder="you@example.com">
							<div class="invalid-feedback">Please enter a valid email
								address for shipping updates.</div>
						</div>

						<div class="mb-3">
							<label for="address">Address</label> <input type="text"
								class="form-control" id="address" placeholder="1234 Main St"
								required>
							<div class="invalid-feedback">Please enter your shipping
								address.</div>
						</div>

						<div class="mb-3">
							<label for="address2">Address 2 <span class="text-muted">(Optional)</span></label>
							<input type="text" class="form-control" id="address2"
								placeholder="Apartment or suite">
						</div>

						<div class="row">
							<div class="col-md-5 mb-3">
								<label for="country">Country</label> <select
									class="custom-select d-block w-100" id="country" required>
									<option value="">Choose...</option>
									<option>United States</option>
								</select>
								<div class="invalid-feedback">Please select a valid
									country.</div>
							</div>
							<div class="col-md-4 mb-3">
								<label for="state">State</label> <select
									class="custom-select d-block w-100" id="state" required>
									<option value="">Choose...</option>
									<option>California</option>
								</select>
								<div class="invalid-feedback">Please provide a valid
									state.</div>
							</div>
							<div class="col-md-3 mb-3">
								<label for="zip">Zip</label> <input type="text"
									class="form-control" id="zip" placeholder="" required>
								<div class="invalid-feedback">Zip code required.</div>
							</div>
						</div>
						<hr class="mb-4">
						<div class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input"
								id="same-address"> <label class="custom-control-label"
								for="same-address">Shipping address is the same as my
								billing address</label>
						</div>
						<div class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input"
								id="save-info"> <label class="custom-control-label"
								for="save-info">Save this information for next time</label>
						</div>
						<hr class="mb-4">

						<h4 class="mb-3">Payment</h4>

						<div class="d-block my-3">
							<div class="custom-control custom-radio">
								<input id="credit" name="paymentMethod" type="radio"
									class="custom-control-input" checked required> <label
									class="custom-control-label" for="credit">Credit card</label>
							</div>
							<div class="custom-control custom-radio">
								<input id="debit" name="paymentMethod" type="radio"
									class="custom-control-input" required> <label
									class="custom-control-label" for="debit">Debit card</label>
							</div>
							<div class="custom-control custom-radio">
								<input id="paypal" name="paymentMethod" type="radio"
									class="custom-control-input" required> <label
									class="custom-control-label" for="paypal">PayPal</label>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="cc-name">Name on card</label> <input type="text"
									class="form-control" id="cc-name" placeholder="" required>
								<small class="text-muted">Full name as displayed on card</small>
								<div class="invalid-feedback">Name on card is required</div>
							</div>
							<div class="col-md-6 mb-3">
								<label for="cc-number">Credit card number</label> <input
									type="text" class="form-control" id="cc-number" placeholder=""
									required>
								<div class="invalid-feedback">Credit card number is
									required</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-3 mb-3">
								<label for="cc-expiration">Expiration</label> <input type="text"
									class="form-control" id="cc-expiration" placeholder="" required>
								<div class="invalid-feedback">Expiration date required</div>
							</div>
							<div class="col-md-3 mb-3">
								<label for="cc-cvv">CVV</label> <input type="text"
									class="form-control" id="cc-cvv" placeholder="" required>
								<div class="invalid-feedback">Security code required</div>
							</div>
						</div>
						<hr class="mb-4">
						<button class="btn btn-primary btn-lg btn-block" type="submit">Continue
							to checkout</button>
					</form>
				</div>
			</div>

			<footer class="my-5 pt-5 text-muted text-center text-small">
				<p class="mb-1">&copy; 2017-2019 Company Name</p>
				<ul class="list-inline">
					<li class="list-inline-item"><a href="#">Privacy</a></li>
					<li class="list-inline-item"><a href="#">Terms</a></li>
					<li class="list-inline-item"><a href="#">Support</a></li>
				</ul>
			</footer>
		</div>

	</section>


	<%@ include file="/front-end/index/footer.jsp"%>
</body>
</html>