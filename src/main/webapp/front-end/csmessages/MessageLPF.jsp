<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.csmessages.model.*"%>
<%@ page import="com.paradisiac.csmessages.controller.*"%>
<%@ page import="com.paradisiac.csmessages.service.*"%>
<%
request.setCharacterEncoding("utf-8");

String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
Integer whereMemno = (Integer) session.getAttribute("memno");
CsMessagesService csMessagesService = new CsMessagesService();
List<CsMessagesVO> list = csMessagesService.getAllBycscontent(keyword, whereMemno);
pageContext.setAttribute("list", list);
%>
<!DOCTYPE html>
<html >

<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, shrink-to-fit=no, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>會員客服專區</title>

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

/*表格、查詢*/
.table {
	width: 100%;
}

.container {
	max-width: 100%;
	margin: 0;
	padding: 0;
	overflow: hidden;
}

.container-fluid {
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
				<li class="sidebar-title">訂單管理</li>
				<li><a href="#">訂房訂單管理</a></li>
				<li><a href="#">購物訂單管理</a></li>
				<li><a href="#">活動訂單管理</a></li>
				<li class="sidebar-title">會員服務</li>
				<li><a href="#">會員紀念相簿</a></li>
				<li><a
					href="<%=request.getContextPath()%>/front-end/csmessages/MessageLPF.jsp">會員客服專區</a></li>
			</ul>
		</div>
		<!-- /#sidebar-wrapper -->

		<!-- Top Navigation -->

		<ul class="navigation">
			<li id="logoutLi"><a href="#home">登出</a></li>
		</ul>
		<!-- Page Content -->
		<div id="page-content-wrapper">
			<a href="#menu-toggle" class="btn btn-success btn-sm"
				id="menu-toggle">展開畫面</a>

			<div class="container-fluid">
				<form action="MessageLPF.jsp" method="get">
					<div class="row">
						<div class="col-lg-12">
							<h1>會員客服專區</h1>
							<div class="form-group2">
								<label for="csMsgNo">問題關鍵字</label>
								<div class="input-group">
									<input type="text" class="form-control" name="keyword"
										id="keyword" value="<%=keyword%>">
									<div class="input-group-append"></div>
								</div>
							</div>

							<button class="btn btn-primary" type="submit">送出</button>
						</div>
					</div>
				</form>
			</div>

			<br>
			<!-- 表格部分 -->

			<div class="container">

				<div class="row mb-4">
					<div class="col-md-12">
						<div class="table-responsive" id="table-responsive">
							<!-- 新增按鈕開始 -->
							<div class="text-right mb-2">
								<button class="btn btn-success" id="addButton">新增</button>
							</div>
							<!-- 新增按鈕結束 -->
							<table class="table">
								<thead>
									<tr>
										<th>客服編號</th>
										<th>申訴內容</th>
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
											<td>${CsMessagesVO.cscontent}</td>
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

											<td><button class="btn btn-primary" id="reviewButton" data-msgno="${CsMessagesVO.csmsgno}">檢視</button></td>
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

    // 新增
    var addButton = document.getElementById("addButton");
    addButton.addEventListener("click", function() {
        window.location.href = "<%=request.getContextPath()%>/front-end/csmessages/MessageCPF.jsp";
    });

    // 檢視   
	var reviewButtons = document.querySelectorAll("#reviewButton");
	reviewButtons.forEach(function(button) {
	button.addEventListener("click", function() {
    var csmsgno = this.getAttribute("data-msgno");
	console.log(csmsgno);
    window.location.href = "csmessages.do?action=getOne_For_CsMsgno_Front&csmsgno=" + csmsgno;
  });
});


  
    // 登出
    var logoutLi= document.getElementById("logoutLi");
    document.getElementById("logoutLi").addEventListener("click", function(e) {
        e.preventDefault(); // 防止連結點選後的默認行為（即跳轉到 #home）
		console.log(1);
        // 透過 JavaScript 重定向到 Servlet 並傳遞 action 參數
        window.location.href ="login.do?action=stateLogout";
    });
    
    
    
</script>
	
</body>

</html>
