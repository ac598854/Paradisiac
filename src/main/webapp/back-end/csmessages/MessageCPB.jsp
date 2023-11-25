<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.csmessages.model.*"%>
<%@ page import="com.paradisiac.csmessages.controller.*"%>
<%@ page import="com.paradisiac.csmessages.service.*"%>


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/sweetalert2.min.css">
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<title>客服訊息管理</title>

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
		padding-left: 150px;
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

.btn-secondary {
	color: #fff;
	background-color: #6c757d;
	border-color: #6c757d;
}

.text-right {
	text-align: right !important;
}

#cscontent, #csreply {
	height: 300px;
}

#cscontentHead, #csreplyHead, #csmsgnoHead {
	font-size: 20px;
	font-weight: bold;
}

#cscontent {
	border-radius: 10px;
	background-color: #c0c0c0;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	padding: 10px;
}

.container mt-3{
	padding-left: 30px;
}


</style>

</head>
<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
	
			<div class="container mt-3">
			<h1>客戶問題</h1>
				<div class="row">
					<div class="col-12 text-right">
						<a
							href="<%=request.getContextPath()%>/back-end/csmessages/MessageLPB.jsp"
							class="btn btn-secondary">回上一頁</a>
					</div>
					<!-- 第一部分表單 -->
					<form id="customerForm" method="post" accept-charset="UTF-8"
						action="csmessages.do">
						<div class="form-group">
							<label for="cscontent" id="cscontentHead">申訴問題</label>
							<p id="cscontent">
								<span>${CsVO.cscontent}</span>
							</p>
						</div>
						<div class="form-group">
							<label for="csaskate">申訴時間</label> <input type="text"
								class="form-control" id="csredate" value="${CsVO.csaskdate}"
								readonly>
						</div>
					</form>
					<br>
					<!-- 第二部分 -->
					<form id="csreplyForm" method="post" accept-charset="UTF-8">
						<div class="form-group">
							<label for="csmsgno" id="csmsgnoHead">客服編號</label> <input
								type="text" name="csmsgno" class="form-control" id="csmsgno"
								value="${CsVO.csmsgno}" readonly>
						</div>
						<div class="form-group">
							<label for="csreply" id="csreplyHead">客服回覆<span class="text-danger">*</span></label>
							<textarea class="form-control" name="csreply" id="csreply"
								rows="3" required><c:out value="${CsVO.csreply}" /></textarea>
						</div>
						<br>
						<button type="submit" class="btn btn-primary" id="submitButton">送出</button>
						<input type="hidden" name="action" value="update_Back">
						<button type="reset" class="btn btn-secondary" id="resetButton">重設</button>
					</form>
				</div>
			</div>

	<script src="../js/sweetalert2.all.min.js"></script>
	<!-- Menu Toggle Script -->
	<script>
		$("#menu-toggle").click(function(e) {
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});
		
		var fieldsValid = false;

		function checkRequiredFields() {
		  var isValid = true;
		  var fieldIds = ["csreply"];
		  for (var i = 0; i < fieldIds.length; i++) {
		    var fieldId = fieldIds[i];
		    var inputElement = $("#" + fieldId);

		    if (inputElement.length > 0) {
		      var fieldValue = inputElement.val().trim();

		      if (inputElement.prop("required") && fieldValue === "") {
		        isValid = false;
		        break;
		      }
		      // 清除首尾空格
		      inputElement.val(fieldValue.trim());
		    }
		  }
		  return isValid;
		}

		$(document).ready(function () {
		  $("#csreplyForm").submit(function (event) {
		    event.preventDefault();
		    var fieldsValid = checkRequiredFields();
		    console.log(fieldsValid)
		    if (fieldsValid) {
		      if (confirm('確認送出回覆？')) {
		        var formData = $(this).serialize();
		        $.ajax({
		          type: "POST",
		          url: "csmessages.do",
		          data: formData,
		          success: async function (response) {
		            if (response.message) {
		              	await Swal.fire({
		              	title: response.message,
		                icon: "success"
		              });
		              window.location.href = "<%=request.getContextPath()%>/back-end/csmessages/MessageLPB.jsp";
		            } else if (response.error) {
		              alert(response.message);
		            }
		          },
		          error: function () {
		            alert("例外错误。");
		          }
		        });
		      }
		    } else {
		      Swal.fire({
		        title: "必填请勿空白!",
		        icon: "error"
		      });
		    }
		  });
		});
		
		
		<!-- 送出訊息確認 -->		
// 		// JavaScript代碼以處理點擊"送出"按鈕時的確認對話框
// 		document.getElementById('submitButton').addEventListener(
// 				'click',
// 				function() {
// 					if (confirm('送出回覆訊息？')) {
// 						// 如果使用者點擊確定，執行送出表單的相關操作
// 						document.getElementById('csreplyForm')
// 								.submit();
// 					}
// 				});

	</script>
</body>
</html>

