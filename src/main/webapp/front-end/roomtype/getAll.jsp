<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.paradisiac.roomZ.roomtype.service.*" %>
<%@ page import="com.paradisiac.roomZ.roomtype.entity.*" %>
<%
request.setCharacterEncoding("UTF-8");
%>

<%
RoomTypeService typeSvc = new RoomTypeServiceImpl();
    List<RoomTypeeVO> list = typeSvc.getAllOrd();
    pageContext.setAttribute("list",list);
%>


<!DOCTYPE html>
<html>
<head>
    <title>GetAll</title>
<!--     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
    <style>
    </style>
    
</head>
<body>

<div class="container">
        <h3>搜尋全部</h3>
  <table class="table table-bordered small-table" style="font-size: 12px;">
		 <thead>
		<tr>
			<th>房型編號</th>
			<th>房型名稱</th>
			<th>房型類別</th>
			<th>房型總數</th>
			<th>價錢</th>
			<th>一般價錢</th>
			<th>節日價錢</th>
			<th>連續假期價錢</th>		
			<th>注意事項</th>	
			<th>設施</th>	
			<th>房型狀態</th>	
		</tr>
            </thead>

            <tbody>

		
		<c:forEach var="list" items="${list}">
		
		<tr>
				<td>${list.roomTypeNo}</td>
				<td>${list.roomName}</td>
				<td>${list.rtype}</td>
				<td>${list.roomTotal}</td>
				<td>${list.price}</td>
				<td>${list.normalPrice}</td>
				<td>${list.holidayPrice}</td>
				<td>${list.bridgeHolidayPrice}</td>
				<td>${list.notice}</td>
				<td>${list.facility}</td>
				<td>${list.rTypeStatus}</td>
			<td>
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


 
