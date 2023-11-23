<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>
<%@ page import="com.paradisiac.roomorder.model.RoomOrderVO"%>
<%@ page import="com.paradisiac.roomorder.service.RoomOrderService"%>
<%@ page import="com.paradisiac.roomorder.service.RoomOrderServiceImpl"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%
    // 取得 HttpSession 對象
    HttpSession se = request.getSession();

    // 取得 memno 屬性值
		Integer memno = (Integer) se.getAttribute("memno");
// 		memno = 3;
%>
<%
RoomOrderService ordSvc = new RoomOrderServiceImpl();
    List<RoomOrderVO> list = ordSvc.getmemOrd(memno);
    pageContext.setAttribute("list",list);
%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>會員訂單查詢</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<style>
.footer {
    background-color: #333;
    color: #fff;
    text-align: center;
    padding: 1rem 0;
    width: 100%;
    position: relative;
    /* 移除 position: fixed; 使頁腳靜態顯示 */
}
.content-wrap {
    margin-bottom: 150px; /* 根據您的頁腳高度調整此值 */
}


	</style>
</head>
<body>
<%@ include file="/front-end/index/guidednoboot.jsp" %>
<div class="container mt-5">
    <h2>會員訂單查詢</h2>
    <div id="accordion">
        <c:forEach items="${list}" var="order" varStatus="status">
            <div class="card">
                <div class="card-header" id="heading${status.index}">
                    <h5 class="mb-0">
                        <button class="btn btn-link" data-toggle="collapse" data-target="#collapse${status.index}" aria-expanded="false" aria-controls="collapse${status.index}">
                            訂單編號：${order.roomOrderNo}
                        </button>
                    </h5>
                </div>
                <div id="collapse${status.index}" class="collapse" aria-labelledby="heading${status.index}" data-parent="#accordion">
                    <div class="card-body">
                        <p>訂單日期：${order.roomOrderDate}</p>
                        <p>入住日期：${order.checkinDate}</p>
                        <p>退房日期：${order.checkoutDate}</p>
                        <p>房型編號：${order.roomTypeNo}</p>
                        <p>房間數量：${order.roomAmount}</p>
                        <p>總價：${order.price}</p>

                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

</div>	
        <div class="footer">
            <%@ include file="/front-end/index/footernoboot.jsp" %>
        </div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
