<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.photoAlbum.model.*"%>

<!DOCTYPE html>

<html>
<head>
<%@ include file="/front-end/index/MembersMeta.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>相簿管理</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
	body {
            margin: 0;
            padding: 0;
            background-image: url('<%=request.getContextPath()%>/images/act_main_front.png'); 
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            opacity: 0.8; 
        }

        .center-box {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.2); 
            border-radius: 10px;
            text-align: center;
        }
</style>
	<title>會員紀念相簿</title>
</head>
<body>
	<div class="center-box">
        <h1>歡迎蒞臨Paradisiac</h1>
        <p style="font-size: larger;">我們將在您的旅遊或活動結束後建立您的專屬相簿</p>
    </div>
</body>


</html>
