<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
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
						<td>
					<form method="post" action="${pageContext.request.contextPath}/back-end/roomorder/updateorder.jsp">
					    <input type="hidden" name="roomOrderNo" value="${all.roomOrderNo}">
					    <input type="hidden" name="roomOrderDate" value="${all.roomOrderDate}">
					    <input type="hidden" name="checkinDate" value="${all.checkinDate}">
					    <input type="hidden" name="checkoutDate" value="${all.checkoutDate}">
					    <input type="hidden" name="roomTypeNo" value="${all.roomTypeNo}">
					    <input type="hidden" name="memNo" value="${all.memNo}">
					    <input type="hidden" name="roomAmount" value="${all.roomAmount}">
					    <input type="hidden" name="price" value="${all.price}">
					    <input type="hidden" name="paymentMethod" value="${all.paymentMethod}">
					    <input type="hidden" name="payStatus" value="${all.payStatus}">
					    <input type="hidden" name="orderStatus" value="${all.orderStatus}">
					    
						<button class="btn btn-success small-btn" style="font-size: 10px;" type="submit">修改</button>
					</form>

                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        
	
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/back-end/roomorder/orderfirst.jsp">返回</a>
    </div>



<!--     <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script> -->
<!--     <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script> -->
<!--     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
</body>
</html>