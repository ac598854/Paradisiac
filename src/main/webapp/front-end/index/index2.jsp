<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>飯店訂房</title>
  <!-- 引入Bootstrap CSS -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
 <style>
        body , header{
            background-image: linear-gradient(to right, #eea2a2 0%, #bbc1bf 19%, #57c6e1 42%, #b49fda 79%, #7ac5d8 100%);
            margin: 0; 
            padding: 0; 
        }
		.fixed-image {
		    width: 500px; /* 设置图片的宽度 */
		    height: 300px; /* 设置图片的高度 */
		}
        /* 導覽列 */
        .fixed-navbar {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        }
        
        .navbar-nav .nav-item .nav-link {
        color: rgb(231, 231, 236) !important; 
        transition: color 0.3s; 
        }

        .navbar-nav .nav-item .nav-link:hover {
            color: #ffcc00 !important; 
            text-decoration: underline;
        }

        .dropdown-item {
        color: #fff !important;
        }

        .dropdown-item:hover {
        background-color: #ffcc00 !important;
        }

        /* 頁尾樣式 */
        footer {
            background-color: #333; 
            color: #fff; 
            padding: 20px 0; 
        }

        /* 標題 */
        footer h4 {
            font-size: 24px; 
            text-align: left; 
        }

        /* 段落 */
        footer p {
            font-size: 16px; 
            line-height: 1.5; 
            text-align: left; 
        }

        /* 連結 */
        footer a {
            color: #fff; 
            text-decoration: none; 
            transition: color 0.2s; 
        }

        /* hover */
        footer a:hover {
            color: #ffcc00; 
        }

        /* 外框样式 */
        #imageTextCarousel {
            border: 2px solid #007BFF; 
            border-radius: 10px;
            padding: 20px; 
            clip-path: polygon(0% 0%, 100% 0%, 100% 100%, 10% 100%); 
        }
        /* 文字輪播 */
        .carousel-text {
            font-size: 36px; 
            color: #050808;
            background-color: #edf88e; 
            padding: 10px; 
            border-radius: 5px; 
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); 

        }
        .carousel-item{
            color: #050808;
            
        }

  </style>
</head>
<body>

  	<%@ include file="guided.jsp" %>   <!-- 導覽列 -->
   
    <div id="image1Carousel" class="carousel slide" data-ride="carousel" data-interval="3000"> <!-- 3秒 -->
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://picsum.photos/2000/700?random=10" class="d-block w-100" alt="1">
            </div>
            <div class="carousel-item">
                <img src="https://picsum.photos/2000/700?random=11" class="d-block w-100" alt="2">
            </div>
            <div class="carousel-item">
                <img src="https://picsum.photos/2000/700?random=12" class="d-block w-100" alt="3">
            </div>
        </div>
        <a class="carousel-control-prev" href="#image1Carousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">上一個</span>
        </a>
        <a class="carousel-control-next" href="#image1Carousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon" ariahidden="true"></span>
            <span class="sr-only">下一個</span>
        </a>
    </div>

  	<%@ include file="header.jsp" %>
  
            <div class="container">
                <div class="row">
                <div class="col-md-8">
                    <div id="imageTextCarousel" class="carousel slide" data-ride="carousel" data-interval="4500">
                            <div class="carousel-inner">

                                <div class="carousel-item active">
                                <a href="/Paradisiac/front-end/roomtype/getOne.jsp"> 
                                    <img src="/Paradisiac/front-end/roomtype/image/00101.jpg" class="d-block w-100 fixed-image" alt="1">
                                    <div class="carousel-caption">
                                    <h3>單人套房</h3>
                                    <p></p>
                                    </div>
                                </a>
                                </div>

                                <div class="carousel-item">
                                <a href="/Paradisiac/front-end/roomtype/getTwo.jsp">
                                    <img src="/Paradisiac/front-end/roomtype/image/00201.jpg" class="d-block w-100 fixed-image" alt="2">
                                    <div class="carousel-caption">
                                    <h3>雙人套房</h3>
                                    <p></p>
                                    </div>
                                </a>
                                </div>

                                <div class="carousel-item">
                                    <a href="/Paradisiac/front-end/roomtype/getFour.jsp">
                                    <img src="/Paradisiac/front-end/roomtype/image/00401.jpg" class="d-block w-100 fixed-image" alt="3">
                                    <div class="carousel-caption">
                                        <h3>四人套房</h3>
                                        <p></p>
                                    </div>
                                    </a>
                                </div>

                                <div class="carousel-item">
                                    <a href="/Paradisiac/front-end/roomtype/getEight.jsp">
                                    <img src="/Paradisiac/front-end/roomtype/image/00801.jpg" class="d-block w-100 fixed-image" alt="4">
                                    <div class="carousel-caption">
                                        <h3>八人套房</h3>
                                        <p></p>
                                    </div>
                                    </a>
                                </div>

                            </div>

                            
                            <a class="carousel-control-prev" href="#imageTextCarousel" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">上一個</span>
                            </a>
                            <a class="carousel-control-next" href="#imageTextCarousel" role="button" data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">下一個</span>
                            </a>
                    </div>
                </div>
                <div class="col-md-4">
                    
                    <h3>客房介紹</h3>
                    <p>最敞佯的空間分享好友私語、親人歡笑，不經意地讓彼此心中最真的情感在此流露；留宿於此的旅人們可以在充滿陽光綠意的窗邊或坐或臥，隨心所欲的放鬆；是讓想要小憩的人，擁有一個靜謐的空間。</p>
                </div>
                </div>
            </div>
      
      
      <br>
        <div id="carousel">

            <!-- 文字輪播 -->
            <div id="textCarousel" class="carousel slide" data-ride="carousel" data-interval="4500">
                <div class="carousel-inner">
                    <div class="carousel-item active text-center">
                        <p class="carousel-text">特價優惠：週末住宿滿三晚，第四晚免費！</p>
                    </div>

                    <div class="carousel-item text-center">
                        <p class="carousel-text">豪華客房套餐：包括早餐、SPA和晚餐。</p>
                    </div>

                    <div class="carousel-item text-center">
                        <p class="carousel-text">慶祝特殊時刻：我們提供特別的住宿選項。</p>
                    </div>
                </div>
            </div>

	        <!-- 圖 -->
	        <div id="image2Carousel" class="carousel slide" data-ride="carousel" data-interval="4500">
	            <div class="carousel-inner">
	                <div class="carousel-item active">
	                    <img src="https://picsum.photos/1600/400?random=14" class="d-block w-100" alt="特價優惠">
	                </div>
	
	                <div class="carousel-item">
	                    <img src="https://picsum.photos/1600/400?random=15" class="d-block w-100" alt="豪華客房套餐">
	                </div>
	
	                <div class="carousel-item">
	                    <img src="https://picsum.photos/1600/400?random=16" class="d-block w-100" alt="慶祝特殊時刻">
	                </div>
	            </div>
	            <a class="carousel-control-prev" href="#image2Carousel" role="button" data-slide="prev">
	                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	                <span class="sr-only">上一個</span>
	            </a>
	            <a class="carousel-control-next" href="#image2Carousel" role="button" data-slide="next">
	                <span class="carousel-control-next-icon" aria-hidden="true"></span>
	                <span class="sr-only">下一個</span>
	            </a>
	        </div>
        </div>

        
  	<%@ include file="footer.jsp" %>

    <!-- 引入Bootstrap和jQuery JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function(){
        $('.carousel').carousel(); // 初始化
        });
    </script>
  </body>
</html>
