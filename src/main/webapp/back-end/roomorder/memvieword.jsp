<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.paradisiac.roomorder.service.*" %>
<%@ page import="com.paradisiac.roomorder.model.*" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<%
    // 取得 HttpSession 對象
    HttpSession se = request.getSession();

    // 取得 memno 屬性值
		Integer memno = (Integer) se.getAttribute("memno");
// 		memno = 3;
%>
<%
RoomOrderService ordSvc = new RoomOrderServiceImpl();
    List<RoomOrderVO> list = ordSvc.getmemOrd(memno);
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
<%--         <form method="Post" action="${pageContext.request.contextPath}/order/order.do?action=getmemord"> --%>
<!--             <div class="form-group"> -->
<!--                 <label for="memNo">memNo：</label> -->
<%--                 <input type="text" class="form-control" id="memNo" name="memNo" value="${memno}"> --%>
<!--             </div>   -->
<!--            <button class="btn btn-success" type="submit" id="getmemordButton">memord</button> -->
<!--         </form> -->
  <h1>新增的訂單列表</h1>
  <div class="container">
        <h3>會員訂房訂單列表</h3>

  <table class="table table-bordered small-table" style="font-size: 12px;">
		 <thead>
		<tr>
                    	<th>訂單編號</th>
                        <th>訂單日期</th>
                        <th>入住日期</th>
                        <th>退房日期</th>
                        <th>房型編號</th>
                        <th>員工編號</th>
                        <th>房間數量</th>
                        <th>價錢</th>
                        <th>付款方式</th>
                        <th>付款狀態</th>
                        <th>訂單狀態</th>
		</tr>
            </thead>

            <tbody>


		<c:forEach var="list" items="${list}">
		
		<tr>
                    	<td>${list.roomOrderNo}</td>
	                    <td>${list.roomOrderDate}</td>
	                    <td>${list.checkinDate}</td>
	                    <td>${list.checkoutDate}</td>
	                    <td>${list.roomTypeNo}</td>
	                    <td>${list.memNo}</td>
	                    <td>${list.roomAmount}</td>
	                    <td>${list.price}</td>
	                    <td>${list.paymentMethod}</td>
	                    <td>${list.payStatus}</td>
	                    <td>${list.orderStatus}</td>
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


 
