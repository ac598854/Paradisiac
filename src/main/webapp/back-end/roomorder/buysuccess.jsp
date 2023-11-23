<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>訂購成功</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }
        .page-container {
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        .content-wrap {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center; /* 將內容垂直居中 */
            align-items: center; /* 將內容水平居中 */
            padding: 20px; /* 可以根據需要調整填充 */
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            border-color: #c3e6cb;
            border-radius: 5px;
            text-align: center;
            padding: 20px; /* 可以根據需要減少填充 */
            margin: 20px; /* 可以根據需要減少邊距 */
        }
        .btn-custom {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            margin: 10px; /* 可以根據需要調整間距 */
            border-radius: 5px;
            text-decoration: none;
        }
        .btn-custom:hover {
            background-color: #218838;
        }
        .footer {
            background-color: #f1f1f1;
            padding: 10px;
            text-align: center;
        }
    </style>
</head>

<body>
     <div class="page-container">
     <%@ include file="/front-end/index/guided.jsp" %>
        <div class="content-wrap">
           
            <div class="success-message">
                <h1>訂購成功！</h1>
                <p>謝謝您的訂購。</p>
                <div>
                    <a href="/Paradisiac/front-end/index/index2.jsp" class="btn-custom">返回首頁</a>
                    <a href="/Paradisiac/back-end/roomorder/memvieword.jsp" class="btn-custom">查看訂單</a>
                </div>
            </div>
        </div>

        <div class="footer">
            <%@ include file="/front-end/index/footer.jsp" %>
        </div>
    </div>


    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
