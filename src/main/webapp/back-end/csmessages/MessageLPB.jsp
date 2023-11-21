<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.csmessages.model.*"%>
<%@ page import="com.paradisiac.csmessages.controller.*"%>
<%@ page import="com.paradisiac.csmessages.service.*"%>
<%
request.setCharacterEncoding("utf-8");

String resStatus = request.getParameter("resStatus") != null ? request.getParameter("resStatus") : "0";
String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";

StringBuffer whereCondition = new StringBuffer("");
if (keyword.trim().length() > 0) {//有輸入關鍵字
	whereCondition.append("  cs_content LIKE ?  ");
}
//下拉式選單resStatus 有 0 , 1, 2三種狀態
if (!resStatus.equals("0") && whereCondition.length() > 0) {//全部+有輸入關鍵字
	whereCondition.append(" and ");
}
if (resStatus.equals("1")) {//有處理(員編)
	whereCondition.append(" emp_no is not NULL ");
} else if (resStatus.equals("2")) {//未處理(員編)
	whereCondition.append(" emp_no is NULL ");
}

if (whereCondition.length() > 0) {//判斷是否有無處理+輸入關鍵字
	whereCondition = new StringBuffer(" Where " + whereCondition);
}

System.out.println("29=" + whereCondition);
CsMessagesService csMessagesService = new CsMessagesService();
List<CsMessagesVO> list = csMessagesService.getAllBystatus(whereCondition, keyword);
pageContext.setAttribute("list", list);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, shrink-to-fit=no, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
<title>客服訊息管理</title>

<!-- Bootstrap -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.6/lumen/bootstrap.min.css"
	rel="stylesheet">
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
<%@ include file="/back-end/index/back-left_planning.jsp"%>
</head>
<body>
	<div id="wrapper" class="">

		<!-- Sidebar -->
<!-- 		<div id="sidebar-wrapper"> -->
<!-- 			<ul class="sidebar-nav"> -->
<!-- 				<li class="sidebar-brand"><a href="#">ParadisiacBay</a></li> -->
<!-- 				<li class="sidebar-title">員工權限管理</li> -->
<!-- 				<li class="sidebar-title">會員管理</li> -->
<%-- 				<li><a href="<%=request.getContextPath()%>/back-end/members/MembersLPB.jsp">會員帳號管理</a></li> --%>
<!-- 				<li><a href="#">會員相簿管理</a></li> -->
<%-- 				<li><a href="<%=request.getContextPath()%>/back-end/csmessages/MessageLPB.jsp">客服訊息管理</a></li> --%>
<!-- 				<li class="sidebar-title">最新消息管理</li> -->
<!-- 				<li class="sidebar-title">訂房管理</li> -->
<!-- 				<li class="sidebar-title">商城管理</li> -->
<!-- 				<li class="sidebar-title">活動管理</li> -->
<!-- 				<li><a href="#">活動類別管理</a></li> -->
<!-- 				<li><a href="#">檔期管理</a></li> -->
<!-- 				<li><a href="#">活動訂單管理</a></li> -->
<!-- 			</ul> -->
<!-- 		</div> -->
		<!-- /#sidebar-wrapper -->

		<!-- Top Navigation -->
<!-- 		<ul class="navigation"> -->
<!-- 			<li><a href="#home">登出</a></li> -->
<!-- 		</ul> -->
		<!--Page Content -->
		<div id="page-content-wrapper">
			<a href="#menu-toggle" class="btn btn-success btn-sm"
				id="menu-toggle">展開畫面</a>
			<div class="container-fluid">

				<form action="MessageLPB.jsp" method="get">
					<div class="col-lg-12">
						<h1>客服訊息管理列表</h1>

						<!-- 查詢 -->

						<div class="row mb-4">
							<div class="col-md-3">
								<label for="keyword">申訴內容關鍵字</label>
								<div class="input-group">
									<input type="text" class="form-control" name="keyword"
										id="keyword" value="<%=keyword%>">
									<div class="input-group-append"></div>
								</div>
							</div>

							<div class="col-md-3">
								<label for="resStatus">處理狀態</label>
								<div class="input-group">
									<select class="form-control" id="resStatus" name="resStatus">
										<option <%=resStatus.equals("0") ? "selected" : ""%> value="0">全部</option>
										<option <%=resStatus.equals("1") ? "selected" : ""%> value="1">(有員工編號)有處理</option>
										<option <%=resStatus.equals("2") ? "selected" : ""%> value="2">(無員工編號)未處理</option>
									</select>
									<div class="input-group-append"></div>
								</div>
							</div>
						</div>
						<button class="btn btn-primary" id="btn submit" type="submit">送出</button>
						<br> <br>
					</div>
				</form>
				<!-- 表格-->
				<div class="container">
					<div class="row mb-4">
						<div class="col-md-12">
							<div class="table-responsive">
								<table class="table">
									<thead>
										<tr>
											<th>客服編號</th>
											<th>會員編號</th>
											<th>申訴內容</th>
											<th>處理員工</th>
											<th>申訴時間</th>
											<th>客服狀態</th>
											<th>動作</th>
										</tr>
									</thead>

									<tbody>
										<%@ include file="page1.file"%>
										<c:forEach var="CsMessagesVO" items="${list}"
											begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
											<tr>
												<td>${CsMessagesVO.csmsgno}</td>
												<td>${CsMessagesVO.memno}</td>
												<td>${CsMessagesVO.cscontent}</td>
												<td>${CsMessagesVO.empno}</td>
												<td><fmt:formatDate value="${CsMessagesVO.csaskdate}"
													pattern="yyyy-MM-dd HH:mm" /></td>
												<td><c:choose>
													<c:when test="${not empty CsMessagesVO.csredate}">
            										已回覆
        											</c:when>
													<c:otherwise>
														<span style="color: red;">未回覆</span>
													</c:otherwise>
												</c:choose></td>
												<td>
													<FORM METHOD="post" ACTION="csmessages.do">
														<input type="submit" value="回覆" class="btn btn-primary">
														<input type="hidden" name="csmsgno"
															value="${CsMessagesVO.csmsgno}"> <input
															type="hidden" name="action" value="getOne_For_CsMsgno">
													</FORM>
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
<!-- 	</div> -->


	<!-- 	<div class="container"> -->
	<!-- 		<nav aria-label="Page navigation"> -->
	<!-- 			<ul class="pagination justify-content-end"> -->
	<!-- 				<li class="page-item"><a class="page-link" href="#" -->
	<!-- 					aria-label="First"> <span aria-hidden="true">首頁</span></a></li> -->
	<!-- 				<li class="page-item"><a class="page-link" href="#" -->
	<!-- 					aria-label="Previous"> <span aria-hidden="true">上一頁</span></a></li> -->
	<!-- 				<li class="page-item active"><a class="page-link" href="#">1</a></li> -->
	<!-- 				<li class="page-item"><a class="page-link" href="#">2</a></li> -->
	<!-- 				<li class="page-item"><a class="page-link" href="#">3</a></li> -->
	<!-- 				<li class="page-item"><a class="page-link" href="#" -->
	<!-- 					aria-label="Next"> <span aria-hidden="true">下一頁</span></a></li> -->
	<!-- 				<li class="page-item"><a class="page-link" href="#" -->
	<!-- 					aria-label="Last"> <span aria-hidden="true">最後一頁</span></a></li> -->
	<!-- 			</ul> -->
	<!-- 		</nav> -->
	<!-- 	</div> -->


	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.2/jquery.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

	<!-- Menu Toggle Script -->
	<script>
		$("#menu-toggle").click(function(e) {
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});
	</script>
</body>
</html>

