<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG-5">
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/main/main.css">加了這行filter會多執行一次開始跟結束 --%>
<title>Hibernate Demo</title>
</head>
<body>
	<h1>後台查詢系統</h1>
	
	<a href="${pageContext.request.contextPath}/front-end/roomnum/getRoomNum.jsp">查詢房間資料</a>
	<br>
	<a href="${pageContext.request.contextPath}/front-end/roomorder/getOrderInfo.jsp">訂單查詢</a>
	<br>
	<a href="${pageContext.request.contextPath}/calender.do?action=getAll">行事曆(全部房型)OK</a>
	<br> 
	<a href="${pageContext.request.contextPath}/calender.do?action=getSingle">行事曆(單一房型)</a>
	<br>
	<a href="${pageContext.request.contextPath}/roomnum.do?action=getAll">房間查詢OK</a>
	<br>
	<a href="${pageContext.request.contextPath}/roomnum.do?action=roomNumModify">房間刪除-修改-新增OK</a>
	
	<br>
	<a href="${pageContext.request.contextPath}/RoomType.do?action=getRoomTypeNo">下拉選單測試</a>
	<%-- <a href="${pageContext.request.contextPath}/roominfo.do/firstGet">測試</a> --%>
</body>
</html>