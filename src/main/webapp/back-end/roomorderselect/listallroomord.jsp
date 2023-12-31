<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List" %>
<%@ page import="com.paradisiac.roomorder.service.*" %>
<%@ page import="com.paradisiac.roomorder.entity.*" %>




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/main/main.css">
<title>List Ords</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
  	<%@ include file="/guided.jsp" %>
  	
	<h1>訂房訂單</h1>
	<c:if test="${ordPageQty > 0}">
  		<b><font color=red>第${currentPage}/${ordPageQty}頁</font></b>
	</c:if>
	<br>
	<table style="width:50%; text-align:center;">
		<tr>
			<th>訂單編號</th>
			<th>下訂日期</th>
			<th>入住時間</th>
			<th>退房時間</th>
			<th>房型</th>
			<th>員工編號</th>
			<th>房間號碼</th>
			<th>價錢</th>
			<th>付款方式</th>
			<th>付款狀態</th>
			<th>訂單狀態</th>
		</tr>

		<c:forEach var="ord" items="${list}">
			<tr>
				<td>${ord.roomOrderNo}</td>
				<td>${ord.roomOrderDate}</td>
				<td>${ord.checkinDate}</td>
				<td>${ord.checkoutDate}</td>
				<td>${ord.roomTypeNo}</td>
				<td>${ord.memNo}</td>
				<td>${ord.roomAmount}</td>
				<td>${ord.price}</td>
				<td>${ord.paymentMethod}</td>
				<td>${ord.payStatus}</td>
				<td>${ord.orderStatus}</td>
			</tr>
		</c:forEach>
	</table>

	<c:if test="${currentPage > 1}">
		<a href="${pageContext.request.contextPath}/emp/emp.do?action=getAll&page=1">至第一頁</a>&nbsp;
	</c:if>
	<c:if test="${currentPage - 1 != 0}">
		<a href="${pageContext.request.contextPath}/emp/emp.do?action=getAll&page=${currentPage - 1}">上一頁</a>&nbsp;
	</c:if>
	<c:if test="${currentPage + 1 <= ordPageQty}">
		<a href="${pageContext.request.contextPath}/emp/emp.do?action=getAll&page=${currentPage + 1}">下一頁</a>&nbsp;
	</c:if>
	<c:if test="${currentPage != ordPageQty}">
		<a href="${pageContext.request.contextPath}/emp/emp.do?action=getAll&page=${ordPageQty}">至最後一頁</a>&nbsp;
	</c:if>
	<br>

	<br><br>
	
	<a href="${pageContext.request.contextPath}/index2.jsp">回首頁</a>	
	<%@ include file="/footer.jsp" %>
	 <!-- 引入Bootstrap和jQuery JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>