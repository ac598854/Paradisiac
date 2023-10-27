<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.product.model.*"%>

<%
//見com.emp.controller.EmpServlet.java第238行存入req的empVO物件 (此為輸入格式有錯誤時的empVO物件)
ProductVO productVO = (ProductVO) request.getAttribute("productVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>g; uqp3資料新增 - addProduct.jsp</title>

<style>
/* 公共樣式 */
body {
	font-family: Arial, sans-serif;
	background-color: #f8f8f8;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
}

.container {
	background-color: white;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	width: 70%;
	max-width: 1000px;
}

.table-wrapper {
	overflow-x: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
}

table, th, td {
	border: 1px solid #ccccff;
}

th, td {
	padding: 15px;
	text-align: left;
}

table.center {
	margin-left: auto;
	margin-right: auto;
}

.pagination-container {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 20px;
}

/* 特定樣式 */
table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}

.form-container {
	width: 100%;
	display: flex;
	flex-direction: column;
	align-items: center;
}
</style>

</head>
<body bgcolor='lightblue'>
	<div class="container">
		<h3>資料新增:</h3>

		<table id="table-1">
			<tr>
				<td colspan="2">
					<h3>商品資料新增</h3>
				</td>
				<td>
					<h4>
						<a href="select_page_product.jsp">回首頁</a>
					</h4>
				</td>
			</tr>
		</table>


		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>
	</div>

	<FORM METHOD="post" ACTION="product" name="form1">
		<table>




			<tr>
				<td>商品名稱:</td>
				<td><input type="TEXT" name="productname"
					value="<%=(productVO == null) ? "LV" : productVO.getProductname()%>"
					size="45" /></td>
			</tr>
			<tr>
				<td>商品價格:</td>
				<td><input type="TEXT" name="productprice"
					value="<%=(productVO == null) ? "10000" : productVO.getProductprice()%>"
					size="45" /></td>
			<tr>
				<td>商品庫存:</td>
				<td><input type="TEXT" name="productquantity"
					value="<%=(productVO == null) ? "10" : productVO.getProductquantity()%>"
					size="45" /></td>
			</tr>
			<tr>
				<td>商品狀態:</td>
				<td><input type="TEXT" name="productstatus"
					value="<%=(productVO == null) ? "1" : productVO.getProductstatus()%>"
					size="45" /></td>
			</tr>
			<tr>
				<td>商品評價:</td>
				<td><input type="TEXT" name="producttotalreviewcount"
					value="<%=(productVO == null) ? "9" : productVO.getProducttotalreviewcount()%>"
					size="45" /></td>
			</tr>
			<tr>
				<td>評價人數:</td>
				<td><input type="TEXT" name="producttotalreviewstatus"
					value="<%=(productVO == null) ? "100" : productVO.getProducttotalreviewstatus()%>"
					size="45" /></td>
			</tr>
			<tr>
				<td>商品類別名稱:</td>
				<td><input type="TEXT" name="productcategoryno"
					value="<%=(productVO == null) ? "100" : productVO.getProductcategoryno()%>"
					size="45" /></td>
			</tr>

			<%-- <jsp:useBean id="productSvc" scope="page"
				class="com.paradisiac.model.DeptService" />
			<tr>
				<td>部門:<font color=red><b>*</b></font></td>
				<td><select size="1" name="deptno">
						<c:forEach var="deptVO" items="${deptSvc.all}">
							<option value="${deptVO.deptno}"
								${(empVO.deptno==deptVO.deptno)? 'selected':'' }>${deptVO.dname}
						</c:forEach>
				</select></td>
			</tr> --%>

		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>

</body>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script
	src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>



</html>