<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        .navbar-nav .nav-item .nav-link {
        color: rgb(231, 231, 236) !important; 
        transition: color 0.3s; 
        }

        .navbar-nav .nav-item .nav-link:hover {
            color: #ffcc00 !important; 
            text-decoration: underline;
        }
</style>
</head>
<body>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <!-- 導覽列 -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-navbar" style="background-color: transparent; background-color: rgba(0, 0, 0, 0.7);"> 
        <div class="container">
            <a class="navbar-brand mx-auto" href="/Paradisiac/front-end/index/index2.jsp" style="color: #fff;"><i class="fas fa-hotel"></i>飯店訂房</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link b" href="${pageContext.request.contextPath}	/front-end/index/index2.jsp">首頁</a>
                    </li>
					<li class="nav-item"><a class="nav-link" href="/Paradisiac/front-end/index/roomviewsingle.jsp">客房資訊</a></li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/calender.do?action=getAll">線上訂房</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/front-end/other/ContectUs.jsp">關於我們</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/act.do?action=getAll_Front">最新活動</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/productFront.html">購物商城</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href='<%=request.getContextPath()%>/front-end/members/Signin.jsp'>註冊會員</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href='<%=request.getContextPath()%>/front-end/members/Login.jsp'>登入會員</a>
                    </li>                

                </ul>
            </div>
        </div>
    </nav>


 <!-- 引入Bootstrap和jQuery JS -->
   	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>