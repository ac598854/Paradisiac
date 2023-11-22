<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Paradisiac Bay度假村</title>
<!-- 引入Bootstrap CSS -->
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<style>

body {
    margin: 0;
    padding: 0;
    height: 100%;
}

#container {
    background-image: url('https://images.unsplash.com/photo-1601871925712-3c803d50fa72?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
    background-size: cover;
    background-position: center;
    background-attachment: fixed;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    padding: 20px;
}

.intro-text {
    font-size: 18px;
    line-height: 1.6;
    color: #050808;
    margin-bottom: 20px;
    padding:10px;
}

.contact-info {
    font-size: 16px;
    color: #050808;
    margin-top: 20px;
    padding:10px;
}


iframe {
    width: 100%; 
    height: 600px; 
    border: 0;
}

@import "compass/css3";

*, *:before, *:after { @include box-sizing(border-box); }
.myClass{
background:white;
background-color: rgba(255, 255, 255, 0.8); /* 白底透明度60% */
}

</style>
</head>
<body>
    <div id="dynamicContent"></div>
    <div id="container" class="container-fluid">
        <div class="myClass">
        <div class="intro-text">
            <h2>歡迎來到我們的度假村</h2>
            <p>這裡是您夢寐以求的休憩天堂！我們擁有一系列極致的服務，包括房間預定、商品訂購以及豐富多彩的活動參加，為您的度假體驗注入無盡的精彩與舒適。</p>
            <p>首先，我們提供豪華而舒適的客房，為您打造一個賓至如歸的居住空間。</p>
            <p>想要在度假村中品味美味的料理或選購特色商品？我們提供方便快捷的商品訂購服務。</p>
            <p>在度假村中，我們不僅提供極致的住宿體驗和優質的商品，更為您策劃了豐富多樣的活動，讓您的假期充滿歡笑和回憶。</p>
        </div>
</div>
    </div>
    <div>
        <iframe
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3617.2491781960202!2d121.22283401744383!3d24.957635500000002!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x346823ea50c732a5%3A0x1b5e6ee66e9fec49!2z57ev6IKyVGliYU1l6ZmE6Kit5Lit5aOi6IG36KiT5Lit5b-D!5e0!3m2!1szh-TW!2stw!4v1700476707288!5m2!1szh-TW!2stw"
            width="800" height="600" style="border: 0;" allowfullscreen=""
            loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
    </div>
    <%@ include file="/front-end/index/footer.jsp"%>

    <!-- 引入Bootstrap和jQuery JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script
        src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        $(document).ready(function(){
            $('.carousel').carousel(); // 初始化
        });

        // 首頁會員狀態判斷
        $(document).ready(function(){
            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/front-end/members/members.do?action=indexLogin",
                success: function(data) {
                    const responseMessage = parseInt(data);
                    var contextPath='<%=request.getContextPath()%>';
                    var guided = contextPath
                        + '/front-end/index/guided.jsp';
                    var guidedSignout = contextPath
                        + '/front-end/index/guidedSignout.jsp';
                    if (responseMessage === 1) {
                        $("#dynamicContent").load(
                            guided);
                    } else if (responseMessage === 0) {
                        $("#dynamicContent").load(
                            guidedSignout);
                    }
                },
                error : function(error) {
                    console.log("AJAX error:", error);
                }
            });
        });
    </script>

</body>
</html>
