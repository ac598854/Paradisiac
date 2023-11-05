<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
    .query-container {
      width: 960px;
      margin: 0 auto;     
    }
    .query-title {
      text-align: left;
    }
    .query-form {
      width: 470px; /* 調整 query-form 的寬度 */
      height: 630px;
      border: 1px solid #000;
      border-radius: 10px;
      margin: 10px 5px 0 0; /* 調整外邊距 */
      padding: 20px; 
      float: left; /* 左浮動 */
      transition: box-shadow 0.6s; /* 添加過渡效果 */
    }
     .query-form:hover {
      box-shadow: 5px 5px 15px 5px rgba(0,0,0,0.3); /* 懸停時的陰影效果 */
    }
    .query-All {
      width: 470px; /* 調整 query-All 的寬度 */
      height: 580px;
      border: 1px solid #000;
      border-radius: 10px;
      margin: 10px 0 0 5px; /* 調整外邊距 */
      padding: 20px; 
      float: left; /* 左浮動 */
      transition: box-shadow 0.6s; /* 添加過渡效果 */
    }
    .query-All:hover {
      box-shadow: 5px 5px 15px 5px rgba(0,0,0,0.3); /* 懸停時的陰影效果 */
    }
</style>
</head>
<body>
	<div class="container mt-5 query-container">
  <div class="query-form">      
    <form action="${pageContext.request.contextPath}/roomnum/roomnum.do" method="post">         
        <div style="display: flex; justify-content: space-between;">
            <h4>房間查詢</h4> <a href="${pageContext.request.contextPath}/index.jsp">回首頁</a>
        </div>
        <hr>
      <div class="form-group">
        <label for="roomType">房型</label>
        <input type="text" name="roomType" class="form-control" id="roomType" placeholder="輸入房型">
      </div>
      <div class="form-group">
        <label for="roomNumber">房間號碼</label>
        <input type="text" name="roomNumber" class="form-control" id="roomNumber" placeholder="輸入房間號碼">
      </div>
      <div class="form-group">
        <label for="orderNumber">訂單編號</label>
        <input type="text" name="orderNumber" class="form-control" id="orderNumber" placeholder="輸入訂單編號">
      </div>
      <div class="form-group">
        <label for="checkin_name">住房姓名</label>
        <input type="text" name="checkin_name" class="form-control" id="checkin_name" placeholder="輸入住房姓名">
      </div>
      <div class="form-group">
        <label for="roomStatus">房間狀態</label>
        <input type="text" name="roomStatus" class="form-control" id="roomStatus" placeholder="輸入房間狀態">
      </div>      
        <button type="submit" class="btn btn-primary d-block mx-auto" style="width: 100%;">條件查詢</button>   
         <input type="hidden" name="action" value="compositeQuery">    
         <br>
         <a href="${pageContext.request.contextPath}/roomnum/roomnum.do?action=getAll" 
         class="btn btn-primary d-block mx-auto" style="width: 100%; text-decoration: none;">查詢全部</a>
      </div>
      
     
    </form>
 <%--  </div>
  <div class="query-All">   
    <form action="${pageContext.request.contextPath}/roomnum/roomnum.do" method="post">      
           <h4 style="margin-bottom:25px">查詢所有房間信息</h4>
           <hr >
            <button type="submit" class="btn btn-primary d-block mx-auto" style="width: 100%;margin-top:443px">查詢全部</button> 
            <input type="hidden" name="action" value="getAll">         
    </form>
  </div>
</div> --%>
		<!-- 引入 Bootstrap JS 和相依的 Popper.js 及 jQuery -->
		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
		<script
			src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>