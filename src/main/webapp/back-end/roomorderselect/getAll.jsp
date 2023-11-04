<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.paradisiac.roomorder.service.*" %>
<%@ page import="com.paradisiac.roomorder.entity.*" %>
<%
request.setCharacterEncoding("UTF-8");
%>



<!DOCTYPE html>
<html>
<head>
    <title>GetAllFAQ</title>
<!--     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
    <style>
    </style>
    
</head>
<body>

<div class="container">
        <h3>搜尋全部FAQ</h3>
  <table class="table table-bordered small-table" style="font-size: 12px;">
		 <thead>
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
            </thead>

            <tbody>
		<c:forEach var="all" items="${all}">
			<tr>
				<td>${all.roomOrderNo}</td>
				<td>${all.roomOrderDate}</td>
				<td>${all.checkinDate}</td>
				<td>${all.checkoutDate}</td>
				<td>${all.roomTypeNo}</td>
				<td>${all.memNo}</td>
				<td>${all.roomAmount}</td>
				<td>${all.price}</td>
				<td>${all.paymentMethod}</td>
				<td>${all.payStatus}</td>
				<td>${all.orderStatus}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
</div>
<!--     <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script> -->
<!--     <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script> -->
<!--     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
</body>
</html>


 
