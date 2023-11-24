<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.actorder.model.*"%>
<%@ page import="com.paradisiac.actorder.controller.*"%>
<%@ page import="com.paradisiac.actorder.service.*"%>
<%@ page import="com.paradisiac.actattendees.model.*"%>
<%@ page import="com.paradisiac.actattendees.controller.*"%>
<%@ page import="com.paradisiac.actattendees.service.*"%>
<%@ page import="java.util.Base64"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, shrink-to-fit=no, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>ParadisiacBay-活動訂單管理</title>

<!-- 引入Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<!-- CSS -->
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
	/* 	max-width: 1100px; */
	/* 	margin-top: 10px; */
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
}

#wrapper.toggled #page-content-wrapper {
	position: relative;
	margin-right: 0;
}

}

/* 原始*/
h1, h2, h3, h4 {
	font-family: 'Lato', sans-serif;
	font-weight: 700;
}

.table {
	width: 100%;
	margin-top: 10px;
	margin-bottom: 1px;
}

.container {
	max-width: 100%;
	margin: 0;
	padding: 0;
	overflow: hidden;
}

.table-data {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
}

.col-md-3 {
	width: 50%;
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

.table td, .table th {
	padding-left: 25px;
	/* vertical-align: top; */
}

.table tbody tr:nth-child(odd) {
	background-color: #f8f9fa;
}

.table tbody tr:nth-child(even) {
	background-color: #e9ecef;
}

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

.btn-primary {
	margin-left: 15px;
}
</style>
<%-- <%@ include file="/back-end/index/back-left_planning.jsp"%> --%>
</head>
<body>
	<div id="wrapper" class="">

<!-- 		Sidebar -->
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li class="sidebar-brand"><a href="#">ParadisiacBay</a></li>
				<li class="sidebar-title">員工權限管理</li>
				<li class="sidebar-title">會員管理</li>
				<li><a
					href="<%=request.getContextPath()%>/back-end/members/MembersLPB.jsp">會員帳號管理</a></li>
				<li><a href="#">會員相簿管理</a></li>
				<li><a
					href="<%=request.getContextPath()%>/back-end/csmessages/MessageLPB.jsp">客服訊息管理</a></li>
				<li class="sidebar-title">最新消息管理</li>
				<li class="sidebar-title">訂房管理</li>
				<li class="sidebar-title">商城管理</li>
				<li class="sidebar-title">活動管理</li>
				<li><a href="#">活動類別管理</a></li>
				<li><a href="#">檔期管理</a></li>
				<li><a href="#">活動訂單管理</a></li>
			</ul>
		</div>
<!-- 		/#sidebar-wrapper Top Navigation -->
		<ul class="navigation">
			<li><a href="#home">登出</a></li>
		</ul>
<!-- 		Page Content -->
		<div id="page-content-wrapper">
			<a href="#menu-toggle" class="btn btn-success btn-sm"
				id="menu-toggle">展開畫面</a>
			<div class="container-fluid">
				<!-- 表格-->
				<div class="container">
					<h1>活動訂單資料</h1>
					<div class="row">
						<div class="col-12 text-right">
							<a
								href="<%=request.getContextPath()%>/back-end/actorder/ActLPB.jsp"
								class="btn btn-secondary">回上一頁</a>
						</div>
					</div>
					<div class="table-responsive">
						<form method="post" action="ActOrder.do" name="form1"
							enctype="multipart/form-data">
							<table class="table">
								<tr>
									<td>檔期編號:<font color="red"><b>*</b></font></td>
									<td><input type="text" name="schdNo" id="schdNo"
										class="form-control" class="custom-file-input"
										value="${actOrder.schdVO.schdNo}" size="45" readonly /></td>
								</tr>
								<tr>
									<td>訂單日期:<font color="red"><b>*</b></font></td>
									<td><input type="datetime-local" name="orderTime" id="orderTime"
										class="form-control" value="${actOrder.orderTime}"
										readonly /></td>
								</tr>
								<tr>
									<td>報名人數:<font color="red"><b>*</b></font></td>
									<td><input type="text" name="aAtnNum" class="form-control"
										value="${actOrder.aAtnNum}" size="45" readonly /></td>
								</tr>
								<tr>
									<td>訂單狀態:</td>
									<td><select name="order_status"
										class="form-control browser-default custom-select" >
											<option value="1"
												<c:if test="${actOrder.orderStatus == 1}">selected</c:if>>成立</option>
											<option value="0"
												<c:if test="${actOrder.orderStatus== 0}">selected</c:if>>取消</option>
									</select></td>
								</tr>
								<tr>
									<td>訂單總金額:<font color="red"><b>*</b></font></td>
									<td><input type="text" name="orderAmount"
										class="form-control" value="${actOrder.orderAmount}" size="45"
										readonly /></td>
								</tr>
							</table>
							<br> <input type="hidden" name="action" value=""> <input
								type="submit" class="btn btn-primary" value="送出修改">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.2/jquery.js"></script>
	<!-- Menu Toggle Script -->
	<script>
		$("#menu-toggle").click(function(e) {
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});
	</script>
</body>
</html>
