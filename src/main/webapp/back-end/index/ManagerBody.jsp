<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<style>
@import url(https://fonts.googleapis.com/css?family=Lato:400,700);

body {
	overflow-x: hidden;
	font-family: 'Lato', sans-serif;
	background: #f2f2f2;
}

h1, h2, h3, h4 {
	font-family: 'Lato', sans-serif;
	font-weight: 700;
}

/* Toggle Styles */
#menu-toggle {
	position: absolute;
	top: 10px;
	right: 10px;
}

ul.navigation {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
	background: #4aafd2;
	/*COLOR*/
	width: 100%;
	height: 61px;
}

.navigation li {
	float: right;
}

.navigation li a {
	display: block;
	color: white;
	text-align: center;
	padding: 20px 16px;
	text-decoration: none;
	transition: 0.1s all;
}

.navigation li a:hover {
	background-color: #4aafd2;
	/*COLOR*/
}

.container-fluid {
	max-width: 100%;
	margin-top: 10px;
	padding: 0;
	overflow: hidden;
	margin-top: 10px;
}

.sidebar-nav>.sidebar-title {
	color: #dddddd;
	text-transform: uppercase;
	margin-bottom: -10px;
	font-size: 14px;
}

.sidebar-nav>.sidebar-brand a, .sidebar-nav>.sidebar-brand a:active,
	.sidebar-nav>.sidebar-brand a:hover, .sidebar-nav>.sidebar-brand a:visited
	{
	background: #4aafd2;
	/*COLOR*/
	color: #ffffff !important;
	font-size: 24px;
	font-family: 'Lato', sans-serif;
	font-weight: 700;
	border: 0px solid #000 !important;
}

.sidebar-nav li a {
	border-left: 0px solid #000;
	transition: 0.1s all;
}

.sidebar-nav li a:hover {
	border-left: 4px solid #BEE3DB;
	/*COLOR*/
}

#wrapper {
	padding-left: 100px;
	-webkit-transition: all 0.5s ease;
	-moz-transition: all 0.5s ease;
	-o-transition: all 0.5s ease;
	transition: all 0.5s ease;
}

#wrapper.toggled {
	padding-left: 250px;
}

#sidebar-wrapper {
	z-index: 1000;
	position: fixed;
	left: 250px;
	width: 0;
	height: 100%;
	margin-left: -250px;
	overflow-y: auto;
	background: #4d4d4d;
	-webkit-transition: all 0.5s ease;
	-moz-transition: all 0.5s ease;
	-o-transition: all 0.5s ease;
	transition: all 0.5s ease;
}

#wrapper.toggled #sidebar-wrapper {
	width: 250px;
}

#page-content-wrapper {
	width: 100%;
	position: absolute;
	padding: 15px;
}

#wrapper.toggled #page-content-wrapper {
	position: absolute;
	margin-right: -250px;
}

/* Sidebar Styles */
.sidebar-nav {
	position: absolute;
	top: 0;
	width: 250px;
	margin: 0;
	padding: 0;
	list-style: none;
}

.sidebar-nav li {
	text-indent: 20px;
	line-height: 40px;
}

.sidebar-nav li a {
	display: block;
	text-decoration: none;
	color: #999999;
}

.sidebar-nav li a:hover {
	text-decoration: none;
	color: #fff;
	background: rgba(255, 255, 255, 0.2);
}

.sidebar-nav li a:active, .sidebar-nav li a:focus {
	text-decoration: none;
}

.sidebar-nav>.sidebar-brand {
	height: 65px;
	font-size: 18px;
	line-height: 60px;
}

.sidebar-nav>.sidebar-brand a:hover {
	border: 1px solid #000 !important;
}

@media ( min-width :768px) {
	#wrapper {
		padding-left: 250px;
	}
	#wrapper.toggled {
		padding-left: 0;
	}
	#sidebar-wrapper {
		width: 250px;
	}
	#wrapper.toggled #sidebar-wrapper {
		width: 0;
	}
	#page-content-wrapper {
		padding: 20px;
		position: relative;
	}
	#wrapper.toggled #page-content-wrapper {
		position: relative;
		margin-right: 0;
	}
}

/* sidbar */
.sidebar-title {
	cursor: pointer;
}

.sub-menu {
	display: none;
}

}
.sub-menu {
	max-height: 0;
	overflow: hidden;
	transition: max-height 0.3s ease-in-out;
}

/*表格、查詢*/
.table {
	width: 100%;
}

.container {
	max-width: 100%;
	margin: 0;
	padding: 20px;
	overflow: hidden;
}

.container-fluid {
	overflow: visible;
}

.table-data {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
}

.table-data .col-md-2 {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	background-color: #f8f9fa;
	margin-bottom: 10px;
	text-align: left;
	vertical-align: middle;
}

.table-data .col-md-2:nth-child(odd) {
	background-color: #e9ecef;
}

.table-data .col-md-2:nth-child(1) {
	background-color: #007bff;
	color: #fff;
	width: 10%;
}

.table-data .col-md-2:nth-child(2) {
	background-color: #28a745;
	color: #fff;
	width: 20%;
}

.table-data .col-md-2:nth-child(3) {
	background-color: #ffc107;
	width: 30%;
}

.table-data .col-md-2:nth-child(4) {
	background-color: #dc3545;
	color: #fff;
	width: 20%;
}

.table-data .col-md-2:nth-child(5) {
	background-color: #17a2b8;
	color: #fff;
	width: 20%;
}

.table-data .col-md-2 th {
	text-align: left;
	vertical-align: middle;
}

.input-group {
	margin-bottom: 10px;
}

.table thead {
	background-color: #343a40;
	color: #fff;
}

.table tbody tr:nth-child(odd) {
	background-color: #f8f9fa;
}

.table tbody tr:nth-child(even) {
	background-color: #e9ecef;
}

.input-group {
	width: 500px;
}

.row {
	margin-left: 0px;
	margin-right: 0px;
}
</style>

<div id="wrapper" class="">

	<!-- Sidebar -->
	<div id="sidebar-wrapper">
		<ul class="sidebar-nav">
			<li class="sidebar-brand"><a
				href="/Paradisiac/front-end/index/index2.jsp">後台管理系統</a>
			<%--/Paradisiac/front-end/index/index2.jsp --%></li>

			<li class="sidebar-title" data-toggle="submenu-1">前端頁面管理</li>
			<!-- 企劃 -->
			<!--訂房-->
			<li class="sidebar-title" data-toggle="submenu-2">訂房系統管理</li>
			<ul class="sub-menu" id="submenu-2">
				<li><a
					href="${pageContext.request.contextPath}/back-end/roomtype/typefirst.jsp">訂房房型管理</a>
				</li>
				<li><a
					href="${pageContext.request.contextPath}/back-end/roomorder/orderfirst.jsp">訂房訂單管理</a>
				</li>
				<li><a
					href="${pageContext.request.contextPath}/back-end/roompicture/addpic.jsp">訂房房型圖片管理</a>
				</li>
				<li><a
					href="${pageContext.request.contextPath}/back-end/roomnum/selectCheckInData.jsp">客房登記管理系統</a>
				</li>
				<li><a
					href="${pageContext.request.contextPath}/roomnum.do?action=getAll">退房管理系統</a>
				</li>
				<li><a
					href="${pageContext.request.contextPath}/roomnum.do?action=roomNumModify">房間管理系統</a>
				</li>
			</ul>
			<!--會員服務-->
			<li class="sidebar-title" data-toggle="submenu-3">會員管理</li>
			<ul class="sub-menu" id="submenu-3">
				<li><a
					href="<%=request.getContextPath()%>/back-end/members/MembersLPB.jsp">會員帳號管理</a>
				</li>
				<li><a
					href="${pageContext.request.contextPath}/back-end/pha/select_phoalb.jsp">會員紀念相簿管理</a>
				</li>
				<li><a
					href="<%=request.getContextPath()%>/back-end/csmessages/MessageLPB.jsp">客服訊息管理</a>
				</li>

			</ul>
			<!--活動-->
			<li class="sidebar-title" data-toggle="submenu-4">活動管理</li>
			<ul class="sub-menu" id="submenu-4">
				<li><a
					href='${pageContext.request.contextPath}/act.do?action=getAll'>活動類別管理</a>
				</li>
				<li><a
					href="${pageContext.request.contextPath}/back-end/act/add_act.jsp">建立新活動</a>
				</li>
				<li><a
					href="${pageContext.request.contextPath}/back-end/schd/add_schd.jsp">建立新檔期</a>
				</li>
				<li><a
					href="${pageContext.request.contextPath}/back-end/actorder/ActLPB.jsp">活動訂單管理</a>
				</li>

			</ul>
			<!--人資-->
			<li class="sidebar-title" data-toggle="submenu-5">人資管理</li>
			<ul class="sub-menu" id="submenu-5">
				<li><a
					href="${pageContext.request.contextPath}/back-end/emp/select_page.jsp">員工管理</a></li>
				<li><a
					href="${pageContext.request.contextPath}/back-end/dept/select_dept_page.jsp">部門管理</a></li>
			</ul>

			<li class="sidebar-title" data-toggle="submenu-6">商品系統管理</li>
			<ul class="sub-menu" id="submenu-6">
				<li><a href="#">商品訂單管理</a></li>
				<li><a href="#">商品類型管理</a></li>
				<li><a href="#">商品相片管理</a></li>
				<li><a href="#" id="promotionLeft">促銷專案管理</a></li>
				<li><a href="#">促銷商品管理</a></li>
			</ul>
	</div>
	<!-- /#sidebar-wrapper -->

	<!-- Top Navigation -->
	<ul class="navigation">
		<li class="nav-item"><a class="nav-link"
			href="${pageContext.request.contextPath}/loginempN.do?action=logoutEmp"
			id="logoutLi">登出</a></li>
		<li class="nav-item"><a class="nav-link" href='#'>首頁</a></li>
	</ul>

	<div id="page-content-wrapper">
		<a href="#menu-toggle" class="btn btn-success btn-sm" id="menu-toggle">側邊欄關閉</a>
	</div>


	<!-- Menu Toggle Script -->
	<script>
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });

    var sidebarTitles = document.querySelectorAll('.sidebar-title');
        sidebarTitles.forEach(function(title) {
        title.addEventListener('click', function() {
            var toggleId = this.getAttribute('data-toggle');
            var subMenu = document.getElementById(toggleId);
            if (subMenu) {
            if (subMenu.style.display === 'block') {
                subMenu.style.display = 'none';
            } else {
                subMenu.style.display = 'block';
            }
            }
        });
        });
        var sidebarTitles = document.querySelectorAll('.sidebar-title');
            sidebarTitles.forEach(function (title) {
              title.addEventListener('click', function () {
                var toggleId = this.getAttribute('data-toggle');
                var subMenu = document.getElementById(toggleId);
                if (subMenu) {
                  if (subMenu.style.maxHeight === '0px' || !subMenu.style.maxHeight) {
                    subMenu.style.maxHeight = subMenu.scrollHeight + "px";
                  } else {
                    subMenu.style.maxHeight = '0px';
                  }
                }
              });
            });


  </script>