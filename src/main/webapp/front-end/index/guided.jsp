<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
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
            <a class="navbar-brand mx-auto" href="#" style="color: #fff;"><i class="fas fa-hotel"></i>飯店訂房</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link b" href="#">首頁</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">客房</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">預訂</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">聯絡我們</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">最新活動</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">註冊會員</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">登入會員</a>
                    </li>
                    

                </ul>
            </div>
        </div>
    </nav>


 <!-- 引入Bootstrap和jQuery JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>