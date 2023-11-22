<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" import="org.json.JSONObject" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.*"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // 取得 HttpSession 對象
    HttpSession se = request.getSession();

    // 取得 memno 屬性值
		Integer memno = (Integer) se.getAttribute("memno");
%>
<!DOCTYPE html>
<html>

<head>
    <title>結帳</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .card {
            border: 1px solid #ccc;
            margin: 10px;
            padding: 20px;
        }
    </style>

</head>
<body>


                
        <div id="roomList">
            <table class="table table-bordered">
                <thead>
                    <tr>

                        <th>行事曆編號</th>
                        <th>入住日期</th>
                        <th>房型編號</th>
                        <th>房間總數</th>
                        <th>訂購間數</th>
                        <th>房間狀態</th>
                    </tr>
                </thead>
                <tbody>
					<c:forEach var="roomCalendar" items="${resultList}">
					    <tr>
					        <td>${roomCalendar.calendarNo}</td>
					        <td>${roomCalendar.cDate}</td>
					        <td>${roomCalendar.roomTypeno}</td>
					        <td>${roomCalendar.roomTotal}</td>
					        <td>${roomBooking}</td>
					        <td>${roomCalendar.available}</td>
					    </tr>
					    
					  <form method="post" action="${pageContext.request.contextPath}/calender.do?action=Update">
					    <input type="hidden" name="calendarNo" value="${roomCalendar.calendarNo}">
					    <input type="hidden" name="cDate" value="${roomCalendar.cDate}">
					    <input type="hidden" name="roomTypeno" value="${roomCalendar.roomTypeno}">
					    <input type="hidden" name="roomTotal" value="${roomCalendar.roomTotal}">
					    <input type="hidden" name="roomBooking" value="${roomCalendar.roomBooking + roomBooking}">
					    <input type="hidden" name="available" value="${roomCalendar.available}">
					    
						<button class="btn btn-success small-btn" style="font-size: 10px;" type="submit">修改a</button>
					</form>
					</c:forEach>
                </tbody>
            </table>
        </div>


    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
	// 監聽窗口加載事件
	window.onload = function() {
	    // 檢查當前路徑是否滿足特定條件
	    var dynamicPath = "/Paradisiac/order/order.do?action=buyorder";
	    if (window.location.href.includes(dynamicPath)) {
	        // 返回上一頁
	        window.history.back();
	    }
	};
	</script>
</body>
</html>
