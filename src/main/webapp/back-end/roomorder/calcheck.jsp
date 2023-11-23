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
        .form-card {
            border: 1px solid #ccc;
            margin: 10px;
            padding: 20px;
            background-color: #f8f9fa; /* 設定背景顏色 */
        }
        .form-group {
            margin-bottom: 15px; /* 調整間距 */
        }
        .btn-success {
            background-color: #28a745; /* 按鈕背景顏色 */
            border-color: #28a745; /* 按鈕邊框顏色 */
        }
        .btn-success:hover {
            background-color: #218838; /* 滑鼠懸停時的背景顏色 */
            border-color: #1e7e34; /* 滑鼠懸停時的邊框顏色 */
        }
    </style>
</head>

<body>
    <div class="container">

        <c:forEach var="roomCalendar" items="${resultList}">
            <div class="form-card">
                <form method="post" action="${pageContext.request.contextPath}/calender.do?action=Update" id="cal">
                    <div class="form-group">
                        <label>行事曆編號</label>
                        <input type="text" class="form-control" name="calendarNo" value="${roomCalendar.calendarNo}" readonly>
                    </div>
                    <div class="form-group">
                        <label>入住日期</label>
                        <input type="text" class="form-control" name="cDate" value="${roomCalendar.cDate}" readonly>
                    </div>
                    <div class="form-group">
                        <label>房型編號</label>
                        <input type="text" class="form-control" name="roomTypeno" value="${roomCalendar.roomTypeno}" readonly>
                    </div>
                    <div class="form-group">
                        <label>房間總數</label>
                        <input type="text" class="form-control" name="roomTotal" value="${roomCalendar.roomTotal}" readonly>
                    </div>
                    <div class="form-group">
                        <label>訂購間數</label>
                        <input type="number" class="form-control" name="roomBooking" value="${roomCalendar.roomBooking + roomBooking}">
                    </div>
                    <div class="form-group">
                        <label>房間狀態</label>
                        <input type="text" class="form-control" name="available" value="${roomCalendar.available}" readonly>
                    </div>
                    <button class="btn btn-success" type="submit">確認訂購</button>
                </form>
            </div>
        </c:forEach>
        
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
		    else{
		    	 document.getElementById("cal").submit();
// 		    	 window.location.href = '/Paradisiac/back-end/roomorder/buysuccess.jsp';
		    }
		};
	</script>
</body>
</html>

