<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.paradisiac.csmessages.model.*"%>
<%@ page import="com.paradisiac.csmessages.service.*"%>
<%@ page import="com.paradisiac.csmessages.controller.*"%>
<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, shrink-to-fit=no, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>會員客服訊息</title>

<!-- Bootstrap Core CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.6/lumen/bootstrap.min.css"
	rel="stylesheet">

<style>
@import url(https://fonts.googleapis.com/css?family=Lato:400,700);

body {
	overflow-x: hidden;
	font-family: 'Lato', sans-serif;
	background: #f2f2f2;
}

h1, h2, h3, h4 {
	font-family: 'Lato', sans-serif;
	font-weight: 700;
}

/* Toggle Styles */
#menu-toggle {
	position: absolute;
	top: 10px;
	right: 10px;
}

ul.navigation {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
	background: #8E44AD;
	/*COLOR*/
	width: 100%;
	height: 61px;
}

.navigation li {
	float: right;
}

.navigation li a {
	display: block;
	color: white;
	text-align: center;
	padding: 20px 16px;
	text-decoration: none;
	transition: 0.1s all;
}

.navigation li a:hover {
	background-color: #783993;
	/*COLOR*/
}

.container-fluid {
	max-width: 100%;
	margin-top: 10px;
	padding: 0;
	overflow: hidden;
}

.sidebar-nav>.sidebar-title {
	color: #dddddd;
	text-transform: uppercase;
	margin-bottom: -10px;
	font-size: 14px;
}

.sidebar-nav>.sidebar-brand a, .sidebar-nav>.sidebar-brand a:active,
	.sidebar-nav>.sidebar-brand a:hover, .sidebar-nav>.sidebar-brand a:visited
	{
	background: #783993;
	/*COLOR*/
	color: #ffffff !important;
	font-size: 24px;
	font-family: 'Lato', sans-serif;
	font-weight: 700;
	border: 0px solid #000 !important;
}

.sidebar-nav li a {
	border-left: 0px solid #000;
	transition: 0.1s all;
}

.sidebar-nav li a:hover {
	border-left: 4px solid #783993;
	/*COLOR*/
}

#wrapper {
	padding-left: 0;
	-webkit-transition: all 0.5s ease;
	-moz-transition: all 0.5s ease;
	-o-transition: all 0.5s ease;
	transition: all 0.5s ease;
}

#wrapper.toggled {
	padding-left: 250px;
}

#sidebar-wrapper {
	z-index: 1000;
	position: fixed;
	left: 250px;
	width: 0;
	height: 100%;
	margin-left: -250px;
	overflow-y: auto;
	background: #4d4d4d;
	-webkit-transition: all 0.5s ease;
	-moz-transition: all 0.5s ease;
	-o-transition: all 0.5s ease;
	transition: all 0.5s ease;
}

#wrapper.toggled #sidebar-wrapper {
	width: 250px;
}

#page-content-wrapper {
	width: 100%;
	position: absolute;
	padding: 15px;
}

#wrapper.toggled #page-content-wrapper {
	position: absolute;
	margin-right: -250px;
}

/* Sidebar Styles */
.sidebar-nav {
	position: absolute;
	top: 0;
	width: 250px;
	margin: 0;
	padding: 0;
	list-style: none;
}

.sidebar-nav li {
	text-indent: 20px;
	line-height: 40px;
}

.sidebar-nav li a {
	display: block;
	text-decoration: none;
	color: #999999;
}

.sidebar-nav li a:hover {
	text-decoration: none;
	color: #fff;
	background: rgba(255, 255, 255, 0.2);
}

.sidebar-nav li a:active, .sidebar-nav li a:focus {
	text-decoration: none;
}

.sidebar-nav>.sidebar-brand {
	height: 65px;
	font-size: 18px;
	line-height: 60px;
}

.sidebar-nav>.sidebar-brand a: hover {
	border: 0px solid #000 !important;
}

@media ( min-width :768px) {
	#wrapper {
		padding-left: 250px;
	}
	#wrapper.toggled {
		padding-left: 0;
	}
	#sidebar-wrapper {
		width: 250px;
	}
	#wrapper.toggled #sidebar-wrapper {
		width: 0;
	}
	#page-content-wrapper {
		padding: 20px;
		position: relative;
	}
	#wrapper.toggled #page-content-wrapper {
		position: relative;
		margin-right: 0;
	}
}

/* 表格、查詢部分 */
.table {
	width: 100%;
}

.container {
	max-width: 100%;
	margin: 0;
	padding-left: 15px;
	overflow: visible;
}

.table-data {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
}

.table-data .col-md-2 {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	background-color: #f8f9fa;
	margin-bottom: 10px;
	text-align: left;
	vertical-align: middle;
}

.table-data .col-md-2:nth-child(odd) {
	background-color: #e9ecef;
}

.table-data .col-md-2:nth-child(1) {
	background-color: #007bff;
	color: #fff;
	width: 10%;
}

.table-data .col-md-2:nth-child(2) {
	background-color: #28a745;
	color: #fff;
	width: 20%;
}

.table-data .col-md-2:nth-child(3) {
	background-color: #ffc107;
	width: 30%;
}

.table-data .col-md-2:nth-child(4) {
	background-color: #dc3545;
	color: #fff;
	width: 20%;
}

.table-data .col-md-2:nth-child(5) {
	background-color: #17a2b8;
	color: #fff;
	width: 20%;
}

.table-data .col-md-2 th {
	text-align: left;
	vertical-align: middle;
}

.input-group {
	margin-bottom: 10px;
}

.table thead {
	background-color: #343a40;
	color: #fff;
}

.table tbody tr:nth-child(odd) {
	background-color: #f8f9fa;
}

.table tbody tr:nth-child(even) {
	background-color: #e9ecef;
}

.input-group {
	width: 500px;
}

#resetButton {
	color: #fff;
	background-color: #6c757d;
	border-color: #6c757d;
}

#cscontent, #csreply {
	height: 300px;
}

#cscontentHead{
	font-size: 20px;
	font-weight: bold;
}
</style>
</head>

<body>

	<div id="wrapper" class="">
		<!-- Sidebar -->
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li class="sidebar-brand"><a href="#">ParadisiacBay</a></li>
				<li class="sidebar-title">會員專區</li>
				<li><a
					href="<%=request.getContextPath()%>/front-end/members/MembersUpdate.jsp">會員基本資料</a></li>
				<li class="sidebar-title">訂單專區</li>
				<li><a href="#">訂房訂單查詢</a></li>
				<li><a href="#">購物訂單查詢</a></li>
				<li><a href="#">活動訂單查詢</a></li>
				<li class="sidebar-title">會員服務</li>
				<li><a href="#">會員客服專區</a></li>
				<li><a
					href="<%=request.getContextPath()%>/front-end/csmessages/MessageLPF.jsp">會員客服專區</a></li>
				<li><a href="#">會員紀念相簿</a></li>
			</ul>
		</div>
		<!-- /#sidebar-wrapper -->

		<!-- Top Navigation -->
		<ul class="navigation">
			<li><a href="#home">登出</a></li>

		</ul>
<!-- 		Page Content -->
		<div id="page-content-wrapper">
			<a href="#menu-toggle" class="btn btn-success btn-sm"
				id="menu-toggle">展開畫面</a>


			<h1>請輸入您的問題</h1>
			<div class="container"></div>
			<div class="container mt-3">
				<div class="row">
					<div class="col-12 text-right">
						<a
							href="<%=request.getContextPath()%>/front-end/csmessages/MessageLPF.jsp"
							class="btn btn-secondary">回上一頁</a>
					</div>

					<form id="customerForm" method="post" accept-charset="UTF-8"
						action="csmessages.do">

						<div class="form-group">
							<label for="cscontent" id="cscontentHead">申訴問題</label>
               				<textarea class="form-control" name="cscontent" id="cscontent" rows="3"><c:out value="${CsVO.cscontent}" /></textarea>

						<br>
						<button type="button" class="btn btn-primary" id="submitButton">送出</button>
						<input type="hidden" name="action" value="insert_Front">

						<button type="reset" class="btn btn-secondary" id="resetButton">重設</button>
						</div>

					</form>
					<br>


				</div>

			</div>
		</div>
	</div>
			<!-- Bootstrap JavaScript -->
			<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
			<script
				src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
			<script
				src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
			<!-- Menu Toggle Script -->
			<script>
				$("#menu-toggle").click(function(e) {
 					e.preventDefault();
 					$("#wrapper").toggleClass("toggled");
 				});

 			<!-- 送出訊息確認 -->		
 				// JavaScript代碼以處理點擊"送出"按鈕時的確認對話框
 				document.getElementById('submitButton').addEventListener(
 						'click',
 						function() {
 							if (confirm('送出申訴訊息？')) {
 								// 如果使用者點擊確定，執行送出表單的相關操作
 								document.getElementById('customerForm')
 										.submit();
							}
 						});
		
			</script>
</body>
<link rel="stylesheet" asset="eduser.css"
	href="chrome-extension://mjdbhokoopacimoekfgkcoogikbfgngb/assets/eduser.css">
</html>