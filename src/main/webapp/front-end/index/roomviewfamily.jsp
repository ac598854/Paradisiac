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
        body {
            
            margin: 0; 
            padding: 0; 
        }
		.fixed-image {
		  width: 1000px; /* 設定固定寬度 */
		  height: 800px; /* 設定固定高度 */
		  display: block; /* 確保圖片不會顯示為行內元素 */
		  margin: 0 auto; /* 如果需要，可使圖片在容器中居中 */
		  border: 1px solid #ccc; /* 如果需要，可添加邊框 */
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
    nav, main, footer { 
      padding: 15px; 
    }

    nav { 
      background-color: #eee; 
      width: 200px; 
      position: fixed; 
      top: 0; 
      bottom: 0; 
      overflow-y: auto; 
      z-index: 1; /* 將側邊欄的z-index設置得比頁腳低 */
    }
    nav .nav-header { 
      font-size: 1.5em; 
      text-align: center; 
      padding: 10px 0; 
      border-bottom: 1px solid #ccc; 
    }
    nav ul { 
      list-style: none; 
      padding: 0; 
      margin: 0; 
    }
    nav ul li { 
      padding: 10px; 
      border-bottom: 1px solid #ddd; 
    }
    /* 側邊欄連結樣式 */
    nav ul li a {
    display: block;
    color: #333; /* 連結文字顏色 */
    text-decoration: none; /* 移除下劃線 */
    padding: 10px 15px; /* 上下左右的間距 */
    font-weight: bold; /* 文字加粗 */
    }

    nav ul li a:hover {
    background-color: #f5f5f5; /* 滑鼠移過時的背景顏色 */
    }

    /* 按鈕樣式 */
    button {
    background-color: #c59d5f; /* 按鈕背景顏色 */
    color: white; /* 按鈕文字顏色 */
    border: none; /* 移除邊框 */
    padding: 10px 20px; /* 內邊距 */
    text-align: center; /* 文字置中 */
    text-decoration: none; /* 移除文字下劃線 */
    display: inline-block; /* 使按鈕可置於行內 */
    font-size: 16px; /* 文字大小 */
    margin: 4px 2px; /* 外邊距 */
    cursor: pointer; /* 滑鼠樣式變為指針 */
    border-radius: 5px; /* 邊框圓角 */
    }

    button:hover {
    background-color: #d3a96e; /* 滑鼠移過時按鈕的背景顏色 */
    }
    main { 
      margin-left: 220px; /* Adjusted to prevent overlap with the sidebar */
    }
    .content {
      display: flex;
      justify-content: space-between;
      margin-bottom: 50px; /* 在主要內容區底部添加足夠的邊距，以防止內容被頁腳遮擋 */
    }
    .main-content {
      width: calc(100% - 220px); /* Adjust the width to prevent overlap */
      padding: 20px;
    }
    .sidebar {
/*       width: 100px; /* Sidebar width */ */
      flex-shrink: 0; /* Prevent the sidebar from shrinking */
    }
    .room-info {
      margin-bottom: 20px;
    }


		footer {
		  z-index: 2; /* 將頁腳的z-index設置得比側邊欄高 */
		  position: relative; /* 這將確保z-index生效 */
		  margin-left: 0; /* 將頁腳的左邊距設為0 */
		  clear: both; /* 清除浮動，以防止頁腳上方的內容浮動 */
		  background-color: #333; /* 頁腳背景色 */
		  padding: 20px; /* 頁腳填充 */
		  color: white; /* 頁腳文字顏色 */
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


<nav>

  <div class="nav-header">CATEGORY</div>
  <ul>
    <li><a href="/Paradisiac/calender.do?action=getAll">客房預訂</a></li>
    <li><a href="/Paradisiac/front-end/index/roomviewsingle.jsp">精緻客房</a></li>
    <li><a href="/Paradisiac/front-end/index/roomviewsea.jsp">海景客房</a></li>
    <li><a href="/Paradisiac/front-end/index/roomviewmon.jsp">山景客房</a></li>
    <li><a href="/Paradisiac/front-end/index/roomviewfamily.jsp">家庭套房</a></li>
  	 <li><a href="${pageContext.request.contextPath}/front-end/index/index2.jsp">返回首頁</a></li>
  </ul>
</nav>

  <div class="content">
<!--       <aside class="sidebar"> -->
          
<!--       </aside> -->

  <main class="main-content">
      <div class="image-container">
          <div class="image-container">
              <img src="/Paradisiac/images/05.jpg" alt="Interior" class="fixed-image">
            </div>
      </div>

      <div class="room-info">
         <h2>家庭套房資訊</h2>
	<p class="price">價格：NT$8,300+10%</p>
      <p>床型：兩大床 160cm*200cm</p>
      <p>特色：家庭套房設計寬敞，提供足夠空間給一個家庭享受共同時光。內部裝飾以明亮舒適為主，牆面裝飾著溫馨的藝術作品，創造出一個適合家庭成員放鬆的環境。房間設有一個活動區，配備遊戲機和兒童玩具，確保所有年齡段的孩子都能找到娛樂。</p>
      <p>房內設施：此套房配備了完整的家庭娛樂系統，包括大屏幕電視和高速無線網絡，讓全家人都能享受電影之夜。寬敞的浴室配有浴缸和獨立的淋浴間，方便家庭成員使用。</p>


        <div class="additional-info">
          <h3>訂房須知</h3>
          <ul>
            <li>此房型不提供加床服務。</li>
            <li>每日入住時間為下午3:00後，每日退房時間為上午11:00前。</li>
            <li>若遇早鳥或延遲退房，須另外收費視情況。</li>

          </ul>
        </div>
        
        <div class="cancellation-policy">
          <h3>取消政策</h3>
          <ul>
            <li>取消入住日期前三天內將收取房價的全部費用：早於此期限，住宿費將全額退回。</li>
            <li>若訂房人在預定入住日當天未到達，將視同取消訂房。</li>

          </ul>
        </div>
        
        <div class="size-info">
          <h3>尺寸資訊</h3>
          <ul>
            <li>單人床114CM以下為單人兒童床。</li>
            <li>單人床115CM(含)~150CM(含)為雙人，收費視兩成人入住計。</li>
            <li>雙人床151CM(含)以上為雙人入住，也歡迎小加床入住。</li>
          </ul>
          
        </div>
      </div>
    </main>
     </div>

        
  	<%@ include file="footer.jsp" %>

    <!-- 引入Bootstrap和jQuery JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

  </body>
</html>

