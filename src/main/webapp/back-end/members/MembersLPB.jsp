<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.members.model.*"%>
<%@ page import="com.paradisiac.members.controller.*"%>
<%@ page import="com.paradisiac.members.service.*"%>


<%
List<MembersVO> list = null;
if (request.getAttribute("getOne_For_Memno_SA") != null) {//
	list = (List<MembersVO>) request.getAttribute("getOne_For_Memno_SA");
} else if (request.getAttribute("getAll_For_Status_SA") != null) {//查狀態
	list = (List<MembersVO>) request.getAttribute("getAll_For_Status_SA");
} else if (request.getAttribute("getOne_For_Account_SA") != null) {
	list = (List<MembersVO>) request.getAttribute("getOne_For_Account_SA");
} else {
	// 列出全部
	MembersService memSvc = new MembersService();
	list = memSvc.getAll();
}
pageContext.setAttribute("list", list);

MembersVO membersVO = new MembersVO();
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<title>會員帳號管理</title>


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

/*調整h1 */
.col-lg-12 {
	/* 	padding: 0 0 0 10%; */
	
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

/* 原始*/
h1, h2, h3, h4 {
	font-family: 'Lato', sans-serif;
	font-weight: 700;
}

.table {
	width: 100%;
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

#keyword, #resStatus {
	width: 420px;
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
</style>

</head>
<body>
	<%@ include file="/back-end/index/ManagerBody.jsp"%>
	<!-- 	Page Content -->
	<div class="container-fluid">

		<div class="col-lg-12">
			<h1>會員帳號管理</h1>
			<%-- 錯誤表列 --%>
			<div>
				<c:if test="${not empty errorMsgs}">
					<font style="color: red">請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color: red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>
			</div>

			<div class="col-sm-3 form-group">
				<form method="post" action="members.do">
					<label for="keyword">會員編號查詢</label> <input type="text"
						class="form-control" name="memno" id="memno"> <input
						type="hidden" name="action" value="getOne_For_Memno"> <input
						type="submit" value="送出" class="btn btn-primary">
				</form>
			</div>

			<div class="col-sm-3 form-group">
				<form method="post" action="members.do">
					<label for="resStatus">會員帳號查詢</label>
						<input type="text" name="memaccount" class="form-control">
						<input type="hidden" name="action" value="getOne_For_Account">
						<input type="submit" value="送出" class="btn btn-primary">
				</form>
			</div>
			<div class="col-sm-3 form-group">
				<form method="post" ACTION="members.do">
					<label for="resStatus">會員帳號狀態查詢</label>
					<div class="input-group" style="width: 100%;">
						<select name="memstatus" id="memstatus_dropdown"
							class="form-control">
							<option value="3">請選擇</option>
							<option value="true">正常</option>
							<option value="false">凍結</option>
						</select>
						<div class="input-group-append"></div>
						<input type="hidden" name="action" value="getAll_For_Status">
						<input type="submit" value="送出" class="btn btn-primary">
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 表格-->
	<div class="container">
		<div class="row mb-4">
			<div class="col-md-12">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th>會員編號</th>
								<th>帳號狀態</th>
								<th>姓名</th>
								<th>帳號</th>
								<th>電子信箱</th>
								<th>生日</th>
								<th>電話</th>
								<th>註冊時間</th>
								<th>動作</th>
							</tr>
						</thead>

						<tbody>
							<%@ include file="page1.file"%>
							<c:forEach var="MembersVO" items="${list}" begin="<%=pageIndex%>"
								end="<%=pageIndex+rowsPerPage-1%>">
								<tr>
									<td>${MembersVO.memno}</td>
									<td><c:choose>
											<c:when test="${MembersVO.memstatus == true}">正常</c:when>
											<c:when test="${MembersVO.memstatus == false}">
												<span style="color: red;">凍結</span>
											</c:when>
										</c:choose></td>
									<td>${MembersVO.memname}</td>
									<td>${MembersVO.memaccount}</td>
									<td>${MembersVO.memmail}</td>
									<td>${MembersVO.membir}</td>
									<td>${MembersVO.memphone}</td>
									<td>${MembersVO.memdate}</td>
									<td>
										<form method="post" action="members.do"
											style="margin-bottom: 0px;">
											<input type="submit" value="修改" class="btn btn-primary">
											<input type="hidden" name="memno" value="${MembersVO.memno}">
											<input type="hidden" name="action" value="get_all_back">
										</form>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<%@ include file="page2.file"%>
				</div>
			</div>
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
		
		
		var error = '${param.error}';
		if (error === 'Empty') {
			console.log("error=" + error);
			Swal.fire({
				title : '請勿空白',
				icon : 'error',
				showConfirmButton : false,
				showCloseButton : true,
				timer : 1500
			})
		if (error === 'Nodata') {
			console.log("error=" + error);
			Swal.fire({
				title : '查無資料',
				icon : 'error',
				showConfirmButton : false,
				showCloseButton : true,
				timer : 1500
			})
			
		} 
		
		
		
		
	</script>
</body>
</html>

