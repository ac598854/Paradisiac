<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.product.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
ProductService productSvc = new ProductService();
List<ProductVO> list = productSvc.getAll();
pageContext.setAttribute("list", list);
%>


<html>
<head>
<title>所有商品資料</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<style>
*{
	background-color: lightblue;
}
body {
	background-color: #f8f9fa;
	font-family: 'Arial', sans-serif;
}

.main-container {
	margin: 2rem auto;
	background-color: #ffffff;
	padding: 2rem;
	border-radius: 8px;
	box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
}

.table-hover tbody tr:hover {
	background-color: #f5f5f5;
}

.btn-outline-dark {
	border-color: #343a40;
}

.btn-outline-dark:hover {
	background-color: #343a40;
	color: #ffffff;
}
</style>

</head>
<body bgcolor='white'>
	<div class="container main-container">
		<div class="text-center mb-5">
			<table id="table-1">
				<tr>
					<td>
						<h3>所有商品資料 - listAllEmp.jsp</h3>
						<h4>
							<a href="select_page_product.jsp"
								class="btn btn-outline-dark mt-3"><img
								src="images/back1.gif" width="100" height="32" border="0">回首頁</a>
						</h4>
					</td>
				</tr>
			</table>
		</div>

		<table class="table table-striped table-hover">
			<tr>
				<th>商品編號</th>
				<th>商品名稱</th>
				<th>商品價格</th>
				<th>商品庫存</th>
				<th>商品狀態</th>
				<th>商品總評價</th>
				<th>商品評價人數</th>
				<th>商品類別編號</th>
				<th>修改</th>
				<th>刪除</th>
			</tr>
			<%@ include file="page1.file"%>
			<c:forEach var="productVO" items="${list}" begin="<%=pageIndex%>"
				end="<%=pageIndex+rowsPerPage-1%>">

				<tr>
					<td>${productVO.productno}</td>
					<td>${productVO.productname}</td>
					<td>${productVO.productprice}</td>
					<td>${productVO.productquantity}</td>
					<td>${productVO.productstatus}</td>
					<td>${productVO.producttotalreviewcount}</td>
					<td>${productVO.producttotalreviewstatus}</td>
					<td>${productVO.productcategoryno}</td>
					<td>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/view/product"
							style="margin-bottom: 0px;">
							<input type="submit" value="修改"> <input type="hidden"
								name="productno" value="${productVO.productno}"> <input
								type="hidden" name="action" value="getOne_For_Update">
						</FORM>
					</td>
					<td>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/view/product"
							style="margin-bottom: 0px;">
							<input type="submit" value="刪除"> <input type="hidden"
								name="productno" value="${productVO.productno}"> <input
								type="hidden" name="action" value="delete">
						</FORM>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<%@ include file="page2.file"%>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>