<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

	<!-- 導覽列 -->
	<nav class="navbar navbar-expand-lg navbar-light fixed-navbar"
		style="background-color: transparent; background-color: rgba(0, 0, 0, 0.7);">
		<div class="container">
			<a class="navbar-brand mx-auto" href="#" style="color: #fff;"><i
				class="fas fa-hotel"></i>飯店訂房</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link b" href="#">首頁</a></li>
					<li class="nav-item"><a class="nav-link" href="#">客房</a></li>
					<li class="nav-item"><a class="nav-link" href="#">預訂</a></li>
					<li class="nav-item"><a class="nav-link" href="#">聯絡我們</a></li>
					<li class="nav-item"><a class="nav-link" href="#">最新活動</a></li>
					<li class="nav-item"><a class="nav-link"
						href='<%=request.getContextPath()%>/front-end/cart/ProductTest.html'>購物商城</a>
					</li>
					<li class="nav-item"><a class="nav-link"
						href='<%=request.getContextPath()%>/front-end/members/MembersUpdate.jsp'>會員專區</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="#"
						id="logoutLink">登出</a></li>

				</ul>
			</div>
		</div>
	</nav>


	<!-- 引入Bootstrap和jQuery JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
	
	//首頁登出登入
        $(document).ready(function() {
            $("#logoutLink").on("click", function(e) {            
                e.preventDefault(); 
                $.ajax({
                    type: "GET", 
                    url: `<%=request.getContextPath()%>/front-end/members/login.do?action=stateLogout`,
                    success: function(response) {
                        // 登出成功後的處理，這裡可以根據後端返回的結果執行相應的操作
                        console.log("Logout successful");
                        if (response === "ok") {
                            console.log("ok");
                            window.location.href = `<%=request.getContextPath()%>/front-end/index/index2.jsp`;
                        }
                    },
                    error: function(error) {                   
                        console.log("Logout failed");
                    }
                });
            });
        });
        
</script>
</body>
</html>