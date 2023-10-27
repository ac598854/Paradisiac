<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.paradisiac.members.model.*"%>
<%@ page import="com.paradisiac.members.service.*"%>
<%
Integer memno = (Integer) session.getAttribute("memno");
MembersService MembersSvc = new MembersService();
MembersVO membersVO = null;
// membersVO = MembersSvc.getOneBymemno(memno);
pageContext.setAttribute("membersVO", membersVO);
%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Login</title>
</head>
<body>

	<style>

/************ Start Main Rules **************/
* {
	margin: 0;
	padding: 0;
	outline: none;
	box-sizing: border-box;
	/*   font-family: 'Roboto', sans-serif; */
	font-family: 'Raleway', sans-serif;
}

body {
	/* 	background: #191919 */
	background: white
}

.main-box {
	position: relative;
	display: block;
	width: 90%;
	height: 700px;
	margin: 50px auto;
	border-radius: 8px;
	overflow: hidden;
	background: linear-gradient(to right, #232f41, #374a62);
}

.lined-link {
	position: relative;
	text-decoration: none;
	transition: all 0.2s linear
}

.lined-link:hover {
	opacity: 0.5
}

.lined-link:after {
	position: absolute;
	content: "";
	width: 100%;
	left: 0;
	bottom: -2px;
	border: none;
	border-bottom: 1px solid #63d5c4;
}

/************ Start Slider Container **************/
.slider-cont, .form-cont {
	width: 50%;
	height: 100%;
	float: left;
}

.slick-slide, .slick-slider {
	width: 100%;
	height: 100%
}

.clear-fix {
	clear: both;
}

.slick-dots {
	position: absolute;
	bottom: 10px;
	display: block;
	width: 100%;
	padding: 0;
	list-style: none;
	text-align: center;
}

.slick-dots li {
	position: relative;
	display: inline-block;
	width: 20px;
	height: 20px;
	margin: 0 3px;
	padding: 0;
	cursor: pointer;
}

.slick-dots li button {
	font-size: 0;
	display: block;
	width: 10px;
	height: 10px;
	padding: 5px;
	cursor: pointer;
	border: 0;
	outline: none;
	background: #8dffea;
	border-radius: 50%;
	transition: all 0.3s ease;
}

.slick-dots li.slick-active button {
	background-color: #53C5B9;
	transform: scale(1.6);
	box-shadow: 0 0 10px #1b1b1b
}

.img-txt {
	position: relative;
}

.img-layer {
	position: absolute;
	width: 100%;
	height: 100%;
	background: rgba(47, 63, 85, 0.53);
}

.img-txt h1 {
	position: absolute;
	display: block;
	top: 50%;
	color: #fff;
	width: 100%;
	padding: 50px 0;
	font-size: 45px;
	font-weight: 100;
	text-align: center;
	transform: translateY(-50%);
	background-color: transparent;
}

/************ Start Form Container **************/
.top-buttons {
	position: relative;
	display: block;
	width: 100%;
	height: 15%;
	padding: 25px;
	text-align: right;
}

.top-buttons button {
	color: #cacaca;
	border: none;
	width: 90px;
	margin: -2px;
	padding: 10px;
	font-size: 16px;
	font-weight: 300;
	background: #4c5c72;
	cursor: pointer;
}

.top-buttons button:nth-child(1) {
	border-radius: 50px 0 0 50px;
}

.top-buttons button:nth-child(2) {
	border-radius: 0 50px 50px 0;
}

.top-active-button {
	color: #fff !important;
	box-shadow: 0 0 20px #2a2a2a;
	background: linear-gradient(#68dac7, #54c7ba) !important;
	transition: all 0.3s ease;
}

.form {
	width: 100%;
	height: 85%;
	padding: 10px 40px;
}

.form form {
	width: 100%;
	height: 100%;
}

.form form lable, input[type="text"], input[type="email"], input[type="password"]
	{
	display: block;
	color: #000; /* 将颜色更改为黑色 */
	font-size: 16px;
	font-weight: 300;
	margin: 6px 0;
}

.form form lable {
	color: #fff;
	font-size: 16px;
	font-weight: 300;
	margin: 6px 0;
}

p.terms {
	color: #9E9E9E;
	margin-bottom: 60px;
}

.form form 
input[type="text"], input[type="email"], input[type="password"] {
	color: #fff;
	width: 100%;
	border: none;
	font-size: 16px;
	font-weight: 200;
	margin-bottom: 45px;
	padding: 5px 0 10px 0;
	background: transparent;
	border-bottom: 1px solid #4c5c72;
}

.form form input::placeholder {
	color: #cecece;
}

.form form a {
	color: #fff;
}

input.form-btn {
	color: #fff;
	font-size: 18px;
	font-weight: 300;
	padding: 12px 55px;
	margin-right: 20px;
	border: none;
	cursor: pointer;
	border-radius: 35px;
	transition: all 0.3s linear;
	box-shadow: 0 0 40px rgba(0, 0, 0, 0.55);
	background: linear-gradient(to right, #5bcdbe, #41ab9e);
}

input.form-btn:hover {
	box-shadow: none
}

.form-signin {
	display: none;
	padding-top: 120px;
}
</style>
	<!-- //// -->

	<!-- 加载 jQuery -->
	<!-- 		<script -->
	<!-- 			src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
	<script src="<%=request.getContextPath()%>/front-end/js/jquery.min.js"></script>
	<!-- 加载 Slick Carousel -->
	<!-- 		<script src="https://cdn.jsdelivr.net/jquery.slick/1.6.0/slick.min.js"></script> -->
	<script src="<%=request.getContextPath()%>/front-end/js/slick.min.js"></script>

	<!-- 在这里可以编写你的 JavaScript 代码，利用已加载的库 -->
	<script type="text/javascript">
		$(document).ready(function(){
				// 这里可以使用 jQuery 和 Slick Carousel 来编写你的 JavaScript 代码
				// 例如：初始化 Slick Carousel
				$('.your-carousel-element').slick({
					slidesToShow : 3,
					slidesToScroll : 1,
					$(document).ready(function(){
						  $('.signup-slider').slick({
						    dots: true,
						    arrows: false,
						    autoplay: true,
						    autoplaySpeed: 2000
						  });

						  $("img").height($(".main-box").height());

						  $(".to-signin").on("click", function () {
						    $(this)
						      .addClass("top-active-button")
						      .siblings()
						      .removeClass("top-active-button");
						    $(".form-signup").slideUp(500);
						    $(".form-signin").slideDown(500);
						  });

						  $(".to-signup").on("click", function () {
						    $(this)
						      .addClass("top-active-button")
						      .siblings()
						      .removeClass("top-active-button");
						    $(".form-signin").slideUp(500);
						    $(".form-signup").slideDown(500);
						  });

						  $(".to-signin-link").on("click", function () {
						    $(".to-signin")
						      .addClass("top-active-button")
						      .siblings()
						      .removeClass("top-active-button");
						    $(".form-signup").slideUp(200);
						    $(".form-signin").slideDown(200);
						  });

						  $(".to-signup-link").on("click", function () {
						    $(".to-signup")
						      .addClass("top-active-button")
						      .siblings()
						      .removeClass("top-active-button");
						    $(".form-signin").slideUp(200);
						    $(".form-signup").slideDown(200);
						  });
						});


				});
			});
		</script>


	<!-- /// -->
	<div class="main-box">
		<div class="slider-cont">
			<div class="signup-slider">
				<div class="img-txt">
					<div class="img-layer"></div>
					<h1>Welcome to Paradise Bay</h1>
					<img src="https://static.pexels.com/photos/33972/pexels-photo.jpg" />
				</div>
				<div class="img-txt">
					<div class="img-layer"></div>
					<h1>Enjoy a relaxing and natural journey</h1>
					<img
						src="https://static.pexels.com/photos/257897/pexels-photo-257897.jpeg" />
				</div>
				<div class="img-txt">
					<div class="img-layer"></div>
					<h1>Experience Pure Bliss</h1>
					<img
						src="https://static.pexels.com/photos/317383/pexels-photo-317383.jpeg" />
				</div>
			</div>
		</div>
		<!-- /* 頁籤 */ -->
		<div class="form-cont">
			<div class="top-buttons">
				<button class="to-signup top-active-button">Sign Up</button>
				<button class="to-signin">Sign In</button>
			</div>
			<!-- /* 登入 */ -->
			<div class="form form-signup">
				<form action="#">
					<label for="singaccount">帳號</label> <input type="text"
						id="singaccount" placeholder="請輸入帳號"> <label
						for="signpass">密碼</label> <input type="password" id="signpass"
						placeholder="請輸入密碼">
					<p class="rember">
						<input type="checkbox"> 記住我的帳號
					</p>
					<input type="submit" class="form-btn" value="登入" /> <br> <br>
					<a href="#" class="lined-link to-signup-link">忘記密碼</a> <br> <br>
				</form>
			</div>
			<!-- /* 註冊 */ -->
			<div class="form form-signin">
				<form action="#">
					<label for="memname">姓名</label> <input type="text" id="memname"
						placeholder="姓名" required> <label for="memmail">E-mail</label>
					<input type="email" id="memname" placeholder="Email" required>
					<a id="sendCode" class="returnPass" type="button"
						href="javascript:sendCode();">獲取認證碼</a> <span id="receiverHp2_msg"
						class=""></span> <label for="memaccount">帳號</label> <input
						type="text" id="memaccount" placeholder="帳號" required> <label
						for="mempass">密碼</label> <input type="password" id="mempass"
						placeholder="密碼" required> <label for="comfirepass">確認密碼</label>
					<input type="password" id="comfirepass" placeholder="請再次輸入密碼"
						required> <label for="memgender">性別</label> <input
						type="radio" name="memgender" id="memgender" class="memgender"
						value="1" id="male" checked> <input type="radio"
						name="male" value="1" id="male" checked> <label for="male">男</label>
					<input type="radio" name="female" value="2" id="female"> <label
						for="female">女</label> <input type="radio" name="other" value="3"
						id="other"> <label for="other">其他</label> <label
						for="memid">身分證字號</label> <input type="text" id="memid"
						placeholder="身分證字號"> <label for="Date">生日</label> <input
						type="date" name="dob" class="form-control" id="Date"
						placeholder="">

					<div class="phone-form-group">
						<label for="cod">Country code</label> <select
							class="form-control browser-default custom-select">
							<option data-countryCode="TW" value="886" selected>TW
								(+886)</option>
							<option data-countryCode="GB" value="44">UK (+44)</option>
							<option disabled="disabled">其他國家</option>
							<option data-countryCode="DZ" value="213">Algeria (+213)</option>
							<option data-countryCode="AD" value="376">Andorra (+376)</option>
							<option data-countryCode="AO" value="244">Angola (+244)</option>
							<option data-countryCode="AI" value="1264">Anguilla
								(+1264)</option>
						</select> <label for="tel">電話</label> <input type="tel" name="phone"
							class="form-control" id="tel" placeholder="電話" required>
					</div>

					<label for="memaddress">地址</label> <input type="text"
						id="memaddress" placeholder="地址"> <label for="p_file">會員頭像</label>
					<input name="mempicture" id="p_file" type="file"
						value="${membersVO.memno}"> <input type="submit"
						class="form-btn" value="註冊"> <br> <br>
</body>
</html>