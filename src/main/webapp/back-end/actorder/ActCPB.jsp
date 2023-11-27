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
<%@ include file="/back-end/index/ManagerMeta.jsp"%>

<link rel="stylesheet" href="../css/sweetalert2.min.css">
<title>ParadisiacBay-活動訂單資料</title>

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

.tableDetail {
	width: 100%;
	margin-top: 10px;
	margin-bottom: 1px;
	padding: 0.75rem;
	vertical-align: top;
	border-top: 1px solid #dee2e6;
	background-color: #e9ecef;
}

.detailTd {
	padding: 0.75rem;
	vertical-align: top;
	border-top: 1px solid #dee2e6;
}

.detailTl {
	padding: 0.75rem;
	vertical-align: top;
	border-top: 1px solid #dee2e6;
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

.btn-secondary {
	color: #fff;
	background-color: #6c757d;
}
</style>

</head>
<body>
	<%@ include file="/back-end/index/ManagerBody.jsp"%>
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
				<form method="post" name="form1" id="form1">
					<table class="table">
						<tr>
							<td>活動訂單編號:</td>
							<td><input type="text" class="form-control" id="actOrderNo"
								name="actOrderNo" value="${actOrder.actOrderNo}" readonly></td>
						</tr>
						<tr>
							<td>檔期編號:</td>
							<td><input type="text" name="schdNo" id="schdNo"
								class="form-control" class="custom-file-input"
								value="${actOrder.schdVO.schdNo}" size="45" readonly /></td>
						</tr>
						<tr>
							<td>會員編號:</td>
							<td><input type="text" name="memNo" id="memNo"
								class="form-control" class="custom-file-input"
								value="${actOrder.memNo}" size="45" readonly /></td>
						</tr>
						<tr>
							<td>訂單日期:</td>
							<td><input type="datetime-local" name="orderTime"
								id="orderTime" class="form-control"
								value="${actOrder.orderTime}" readonly /></td>
						</tr>
						<tr>
							<td>報名人數:</td>
							<td><input type="text" name="aAtnNum" id="aAtnNum"
								class="form-control" value="${actOrder.aAtnNum}" size="45"
								readonly /></td>
						</tr>
						<tr>
							<td>訂單狀態:</td>
							<td><select name="orderStatus" id="orderStatus"
								class="form-control browser-default custom-select"
								<c:if test="${actOrder.orderStatus == 0}">disabled="disabled"
            					</c:if>>
									<option value="1"
										<c:if test="${actOrder.orderStatus == 1}">selected</c:if>>成立</option>
									<option value="0"
										<c:if test="${actOrder.orderStatus == 0}">selected style="color: red;"</c:if>>取消</option>
							</select></td>
						</tr>
						<tr>
							<td>訂單總金額:</td>
							<td><input type="text" name="orderAmount" id="orderAmount"
								class="form-control" value="${actOrder.orderAmount}" size="45"
								readonly /></td>
						</tr>
					</table>
					<br>

					<h5 style="font-weight: bold;">活動參加人明細</h5>
					<table class="tableDetail">
						<c:forEach var="actorder2" items="${list}">
							<tr>
								<td class="detailTd">參加人編號:</td>
								<td class="detailTl">${actorder2.atnNo}</td>
								<td class="detailTd">參加人姓名:</td>
								<td class="detailTl">${actorder2.atnName}</td>
								<td class="detailTd">參加人身分證字號:</td>
								<td class="detailTl">${actorder2.atnIdNumber}</td>
								<td class="detailTd">參加人電話:</td>
								<td class="detailTl">${actorder2.atnTel}</td>
							</tr>
						</c:forEach>
					</table>
					<br>
					<div class="col-sm-12" style="padding-left: 0;">
						<button type="submit" class="btn btn-primary" id="submitButton"
							<c:if test="${actOrder.orderStatus == 0}">style="display:none;"
        					</c:if>>送出</button>
						<input type="hidden" name="action" value="updateStatusBack" />
					</div>
				</form>
			</div>
		</div>
	</div>

	<script src="../js/sweetalert2.all.min.js"></script>

	<!-- Menu Toggle Script -->
	<script>
		
		$(document).ready(function () {
		    $("#form1").submit(async function (event) {
		        event.preventDefault();

		        var orderStatus = $("#orderStatus").val();

		        if (orderStatus === "1") {
		            await Swal.fire({
		                title: "訂單已成立，請再次確認選擇",
		                icon: "error"
		            });
		        } else {
		            if (confirm('確認取消訂單？')) {
		                var formData = $(this).serialize();
		                $.ajax({
		                    type: "POST",
		                    url: "ActOrder.do",
		                    data: formData,
		                    success: async function (response) {
		                        if (response.message) {
		                            await Swal.fire({
		                          	  title: response.message,
				            		  text: "訂單取消成功!",
				            		  icon: "success"
		                            });
		                            window.location.href = "<%=request.getContextPath()%>/back-end/actorder/ActLPB.jsp";
		                        } else if (response.error) {
		                            alert(response.message);
		                        }
		                    },
		                    error: function () {
		                        alert("例外错误。");
		                    }
		                });
		            }
		        }
		    });
		});

	</script>
</body>
</html>

