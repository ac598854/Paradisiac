<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.actorder.model.*"%>
<%@ page import="com.paradisiac.actorder.controller.*"%>
<%@ page import="com.paradisiac.actorder.service.*"%>
<%@ page import="com.paradisiac.actattendees.model.*"%>
<%@ page import="com.paradisiac.actattendees.controller.*"%>
<%@ page import="org.hibernate.Session"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%@ page import="org.hibernate.query.Query"%>

<%
request.setCharacterEncoding("utf-8");
// List<ActOrder> list = null;
// ActOrderService actOrderServ = new ActOrderService();
// list = actOrderServ.getAll();
// pageContext.setAttribute("list", list);

 StringBuilder hql = new StringBuilder("");

String memNo = request.getParameter("memNo");
String actOrderNo = request.getParameter("actOrderNo");
String schdNo = request.getParameter("schdNo");
String orderStatus = request.getParameter("orderStatus");
String nowPage = request.getParameter("page") == null ? "0" : request.getParameter("page");
 			
			boolean notfirst = false;
		    // 條件：會員編號
		    if (memNo != null && memNo.trim().length() > 0) {
		    	if(notfirst){
		    		hql.append(" AND ");
		    	}else{
		    		notfirst = true;
		    	}
		    	hql.append(" memNo = "+memNo);
		    }
		    if (schdNo != null && schdNo.trim().length() > 0) {
		    	if(notfirst){
		    		hql.append(" AND ");
		    	}else{
		    		notfirst = true;
		    	}
		    	hql.append(" schdVO.schdNo = "+schdNo);
		    }
		    
		    // 條件：訂單編號
		    if (actOrderNo != null && actOrderNo.trim().length() > 0) {
		    	if(notfirst){
		    		hql.append(" AND ");
		    	}else{
		    		notfirst = true;
		    	}
		    	
		        hql.append(" actOrderNo = "+actOrderNo);
		    }

		    // 條件：訂單狀態
		    if (orderStatus != null && orderStatus.trim().length() > 0 && !"2".equals(orderStatus)) {
		    	if(notfirst){
		    		hql.append(" AND ");
		    	}else{
		    		notfirst = true;
		    	}
		        hql.append(" orderStatus = "+orderStatus);
		    }

		    ActOrderService actOrderSrv=new ActOrderService();
		    List<ActOrder> list = actOrderSrv.getAllByBackSearchSer(hql.toString() , nowPage);
		    pageContext.setAttribute("list", list);
		   
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<title>ParadisiacBay-活動訂單管理</title>

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
}
</style>

</head>
<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
	<!--Page Content -->
	<div id="page-content-wrapper" style="padding-left: 50px;">

			<div class="col-lg-12">
				<h1>活動訂單管理</h1>

				<!-- 查詢 -->
				<form METHOD="get" ACTION="ActLPB.jsp">
					<div class="row mb-4">
						<div class="col-sm-3 form-group">
							<label for="memNo">會員編號</label>
								<input type="text" class="form-control" name="memNo"
									id="memNo" value="${memNO}">
								<div class="input-group-append"></div>
						</div>
						<div class="col-sm-3 form-group">
							<label for="actOrderNo">訂單編號</label>
								<input type="text" class="form-control" name="actOrderNo"
									id="actOrderNo" value="${actOrderNo}">
								<div class="input-group-append"></div>
						</div>
						<div class="col-sm-3 form-group">
							<label for="schdNo">檔期編號</label>
								<input type="text" class="form-control" name="schdNo"
									id="schdNo" value="${schdNo}">
								<div class="input-group-append"></div>
						</div>
						<div class="col-sm-3 form-group">
							<label for="orderStatus">訂單狀態</label>
								<select class="form-control" id="orderStatus" name="orderStatus">
									<option value="2" ${orderStatus eq 2 ? "selected" : ""}>全部</option>
									<option value="1" ${orderStatus eq 1 ? "selected" : ""}>訂單成立</option>
									<option value="0" ${orderStatus eq 1 ? "selected" : ""}>訂單取消</option>
								</select>
								<div class="input-group-append"></div>
						</div>
					</div>
					<div class="col-sm-12 form-group mb-0">
					<button type="submit" class="btn btn-primary" id="btSubmit">送出</button>
				</div>
				</form>
				<br> <br>
			</div>
			<!-- 表格-->
				<div class="container">
					<div class="row mb-4">
						<div class="col-md-12">
							<div class="table-responsive">
								<table class="table">
									<thead>
										<tr>
											<th>活動訂單編號</th>
											<th>會員編號</th>
											<th>活動名稱</th>
											<th>檔期編號</th>
											<th>訂單狀態</th>
											<th>訂單成立時間</th>
											<th>動作</th>
										</tr>
									</thead>

									<tbody>
										<%@ include file="page1.file"%>
										<c:forEach var="ActOrder" items="${list}"
											begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
											<tr>
												<td>${ActOrder.actOrderNo}</td>
												<td>${ActOrder.memNo}</td>
												<td>${ActOrder.schdVO.act.actName}</td>
												<td>${ActOrder.schdVO.schdNo}</td>
												<td><c:choose>
														<c:when test="${ActOrder.orderStatus == 1}">
            				成立
        				</c:when>
														<c:when test="${ActOrder.orderStatus== 0}">
															<span style="color: red;">取消</span>
														</c:when>
													</c:choose></td>
												<td>${ActOrder.orderTime}</td>
												<td>
													<form method="post" action="ActOrder.do">
														<button type="submit" class="btn btn-primary">修改</button>
														<input type="hidden" name="actOrderNo"
															value="${ActOrder.actOrderNo}"> <input
															type="hidden" name="action"
															value="getOne_For_ActOrderNo_Back">
													</form>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<input type="hidden" name="nowPage" value="${param.nowPage != null ? param.nowPage : '0' }" />
								<%@ include file="page2.file"%>
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

