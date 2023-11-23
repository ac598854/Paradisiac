<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<style>
        @import url(https://fonts.googleapis.com/css?family=Lato:400,700);
        body {
        overflow-x: hidden;
        font-family: 'Lato', sans-serif;
        background: #f2f2f2;
        }

        h1,
        h2,
        h3,
        h4 {
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
        background-color: rgba(0, 0, 0, 0.7);
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
        background-color: #89B0AE;
        /*COLOR*/
        }

        .container-fluid {
         max-width: 100%; 
		margin-top: 10px;
		padding: 0;
		overflow: hidden;
        margin-top: 10px; 
        }

        .sidebar-nav > .sidebar-title {
        color: #dddddd;
        text-transform: uppercase;
        margin-bottom: -10px;
        font-size: 14px;
        }

        .sidebar-nav > .sidebar-brand a,
        .sidebar-nav > .sidebar-brand a:active,
        .sidebar-nav > .sidebar-brand a:hover,
        .sidebar-nav > .sidebar-brand a:visited {
        background:rgba(0, 0, 0, 0.7);
        /*COLOR*/
        color: #ffffff!important;
        font-size: 24px;
        font-family: 'Lato', sans-serif;
        font-weight: 700;
        border: 0px solid #000!important;
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
        #sidebar-wrapper {
        z-index: 1000;
        position: fixed;
        left: 250px;
        width: 0;
        height: 100%;
        margin-left: -250px;
        overflow-y: auto;
        background: cadetblue;
        -webkit-transition: all 0.5s ease;
        -moz-transition: all 0.5s ease;
        -o-transition: all 0.5s ease;
        transition: all 0.5s ease;
        }
        
      	.sidebar-nav li a {
        border-left: 0px solid #000;
        transition: 0.1s all;
        }

        .sidebar-nav li a:hover {
        border-left: 4px solid #BEE3DB;
        text-decoration: none;
        color: #fff;
        background: rgba(255, 255, 255, 0.2);
        /*COLOR*/
        }

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
        list-style-type: none;
        }

        .sidebar-nav li a {
        display: block;
        text-decoration: none;
        color: white;
        }

/*         .sidebar-nav li a:hover { */
/*         text-decoration: none; */
/*         color: #fff; */
/*         background: rgba(255, 255, 255, 0.2); */
/*         } */

        .sidebar-nav li a:active,
        .sidebar-nav li a:focus {
        text-decoration: none;
        }

        .sidebar-nav > .sidebar-brand {
        height: 65px;
        font-size: 18px;
        line-height: 60px;
        }

        .sidebar-nav > .sidebar-brand a:hover {
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
        <li class="sidebar-brand">
          <a href="/Paradisiac/front-end/index/index2.jsp">Paradisiac Bay</a>
        </li>

        <li class="sidebar-title" data-toggle="submenu-1">會員專區</li>
        <!-- 選單 -->
        <ul class="sub-menu" id="submenu-1">
          <li><a href='<%=request.getContextPath()%>/front-end/members/MembersUpdate.jsp'>會員基本資料</a></li>
        </ul>
        
            <!--訂單管理-->  
        <li class="sidebar-title" data-toggle="submenu-2">
          訂單管理
        </li>
        <ul class="sub-menu" id="submenu-2">
            <li>
            <a href="#">訂房訂單查詢</a>
            </li>
            <li>
            <a href="#">購物訂單查詢</a>
            </li>
            <li>
            <a href="#">活動訂單查詢</a>
            </li>
     </ul>
            <!--會員服務-->  
        <li class="sidebar-title" data-toggle="submenu-3">
            會員服務
          </li>
            <ul class="sub-menu" id="submenu-3">
            <li>
                <a href='${pageContext.request.contextPath}/pha.do?action=getOne_For_Display'>會員紀念相簿</a>
            </li>
            <li>
                <a href='<%=request.getContextPath()%>/front-end/csmessages/MessageLPF.jsp'>會員客服專區</a>
            </li>
        </ul>
    </div>
    <!-- /#sidebar-wrapper -->

    <!-- Top Navigation -->
    <ul class="navigation">
            <li class="nav-item"><a class="nav-link" href="#" id="logoutLi">登出</a></li>
            <li class="nav-item"><a class="nav-link"
				href='<%=request.getContextPath()%>/front-end/members/MembersUpdate.jsp'>會員專區</a>
			</li>
			<li class="nav-item"><a class="nav-link"
				href='<%=request.getContextPath()%>/front-end/cart/ProductTest.html'>購物商城</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/act.do?action=getAll_Front">最新活動</a></li>
			<li class="nav-item"><a class="nav-link" href="#">聯絡我們</a></li>
			<li class="nav-item"><a class="nav-link" href="#">預訂</a></li>
			<li class="nav-item"><a class="nav-link" href="#">客房</a></li>
			<li class="nav-item"><a class="nav-link" href='<%=request.getContextPath()%>/front-end/index/index2.jsp'>首頁</a></li>
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

            // 登出
            $(document).ready(function () {
                $("#logoutLi").on("click", function (e) {
                    e.preventDefault();
                    $.ajax({
                        type: "GET",
                        url: "<%=request.getContextPath()%>/front-end/members/login.do?action=stateLogout",
                        success: function (response) {
                            console.log("Logout successful");
                            if (response === "ok") {
                                console.log("ok");
                                window.location.href = "<%=request.getContextPath()%>/front-end/index/index2.jsp";
                            }
                        },
                        error: function (error) {
                            console.log("Logout failed");
                        }
                    });
                });
            });
  </script>

