<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>會員CheckIn確認表</title>
<!-- 引入 Bootstrap CSS 樣式表 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h2>Room Order Details</h2>
		<div class="table-responsive">
			<table class="table table-bordered table-striped">
				<tr>
					<th>訂單編號</th>
					<th>訂單日期</th>
					<th>會員姓名</th>
					<th>會員身份證</th>
					<th>會員電話</th>
					<th>房型名稱</th>
					<th>下訂間數</th>
					<th>金額</th>
					<th>入住日期</th>
					<th>退房日期</th>
					<th>訂單狀態</th>
					<th>住房姓名</th>
					<th>可分配房間</th>
					<th>功能</th>
				</tr>

				<c:forEach var="data" items="${checkInData}">
					<tr>
					<form method="post" action="<%=request.getContextPath()%>/roomnum.do" style="margin-bottom: 0px;">
						<input type="hidden" name="roomOrderNo" value="${data.roomOrderNo}">
						<input type="hidden" name="roomTypeNo" value="${data.roomTypeNo}">					
						<td>${data.roomOrderNo}</td>
						<td>${data.roomOrderDate}</td>
						<td>${data.memName}</td>
						<td>${data.memId}</td>
						<td>${data.memPhone}</td>
						<td>${data.roomName}</td>
						<td>${data.roomAmount}</td>
						<td>${data.price}</td>
						<td>${data.checkInDate}</td>
						<td>${data.checkOutDate}</td>
						<td>${data.orderStatus}</td>
						<td><input type="text" name="checkInName"></td>
						<td>						
						<select size="1" name="rnum">
							<c:forEach var="room" items="${getAll}">
						 	<c:if test="${room.roomTypeNo == data.roomTypeNo && room.roomStatus==1}">
								<option value="${room.rnum}">${room.rnum}</option>	
						    </c:if>		
							</c:forEach>
						</select>
						
						</td>
						<td>
							<input type="submit" value="CheckIn">
						</td>
						<input type="hidden" name="action" value="update">
						</form>
					</tr>
				</c:forEach>
			</table>
			
		</div>
	</div>
 	
	<!-- 引入 Bootstrap JavaScript 檔案 -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	
</body>
</html>