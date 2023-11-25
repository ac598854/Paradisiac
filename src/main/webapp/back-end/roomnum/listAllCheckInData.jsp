<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>客房登記管理系統</title>
<!-- 引入 Bootstrap CSS 樣式表 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
 <style>
#checkInName {
    width: 80px; 
}
.container{	 					
 	position:relative;
 	top: -10px;
}
td {
	border: 1px solid darkgray !important;   /* 更改表格框線顏色  */
}      
    </style>
    <%@ include file="/back-end/index/ManagerMeta.jsp" %>
</head>

<body>
<%@ include file="/back-end/index/ManagerBody.jsp" %>
	<div class="container">
		<h2>客房登記管理系統</h2>
		<div class="table-responsive">
			<table class="table table-bordered table-striped">
				<tr>
					<th>訂單編號</th>
					<!-- <th>訂單日期</th> -->
					<th>會員姓名</th>
					<th>會員身份證</th>
					<!-- <th>會員電話</th> -->
					<th>房型名稱</th>
					<th>間數</th>
					<th>金額</th>
					<th>入住日期</th>
					<th>退房日期</th>
					<!-- <th>訂單狀態</th> -->
					<th>付款狀態</th>
					<th>住房姓名</th>
					<th>可分配房間</th>
					<th>已分配房間數</th>
					<th>功能</th>
				</tr>

				<c:forEach var="data" items="${checkInData}">
					<tr>
						<!-- orderStatus :1表示可入住 ：2表示已入住 ：3表示已退房， payStatus :1表示已付款 ：0表示未付款 -->
						<c:if test="${data.orderStatus == 1 && data.payStatus == 1}">
							<form method="post"	action="<%=request.getContextPath()%>/roomnum.do" style="margin-bottom: 0px;">
								<td>${data.roomOrderNo}</td>
								<%-- <td>${data.roomOrderDate}</td> --%>
								<td>${data.memName}</td>
								<td>${data.memId}</td>
								<%-- <td>${data.memPhone}</td> --%>
								<td>${data.roomName}</td>
								<td>${data.roomAmount}</td>
								<td>${data.price}</td>
								<td>${data.checkInDate}</td>
								<td>${data.checkOutDate}</td>
								<%-- <td>${data.orderStatus}</td> --%>
								<%-- <td>${data.payStatus}</td> --%>
								<!-- 顯示付款狀態 -->
								<td>
							       <c:choose>
								     <c:when test="${data.payStatus == 0}">未付款</c:when>
								     <c:when test="${data.payStatus == 1}">已付款</c:when>								
								     <c:otherwise>未知狀態</c:otherwise>
								   </c:choose>
								</td>
								
									<!-- 輸入住房姓名 -->
								<td><input type="text" name="checkInName" id="checkInName"></td>
									<!-- 下拉選擇房間號碼 -->
								<td><select size="1" name="rnum" id="selectRoomNum" class="form-select" aria-label="Default select example"  >										
										<c:forEach var="room" items="${getAll}">
											<c:if
												test="${room.roomTypeNo == data.roomTypeNo && room.roomStatus==1}">
												<option value="${room.rnum}">${room.rnum}</option>
											</c:if>
										</c:forEach>
								</select></td>
								<!--================= 取得指定的訂單編號共分配幾間房間數量========= -->								
								<c:set var="roomOrderNoCount" value="0" />
								<c:forEach var="room" items="${getAll}">
									<c:if test="${room.roomOrderNo == data.roomOrderNo}">
										<c:set var="roomOrderNoCount" value="${roomOrderNoCount + 1}" />
									</c:if>
								</c:forEach>
								<td>
								${roomOrderNoCount}
								</td>
								<!--================= 取得指定的訂單編號共分配幾間房間數量========= -->
								<td><input type="submit" class= "btn" id="checkIn_submit" value="CheckIn" ></td>
								</tr>
								<input type="hidden" name="memName" value="${data.memName}">
								
								<input type="hidden" name="orderStatus" value="${data.orderStatus}">      <!-- 當按下checkin時將 orderStatus狀態由1:未入住改變成 2:已入住-->	  			
								<input type="hidden" name="roomOrderNo" value="${data.roomOrderNo}">      <!-- 訂單編號 -->
								<input type="hidden" name="roomTypeNo" value="${data.roomTypeNo}">        <!-- 房型編號 -->
								<input type="hidden" name="roomOrderNoCount" value="${roomOrderNoCount}"> <!-- 該訂單已分配幾間房間數量 -->
								<input type="hidden" name="roomAmount" value="${data.roomAmount}">        <!-- 該訂單下訂房間數量 -->
								<input type="hidden" name="action" value="update">
						</form>
					</c:if>
				</c:forEach>
			</table>

		</div>
	</div>


	<script>
	// 獲取所有下拉選單和按鈕元素
	var selectElements = document.querySelectorAll('select[name="rnum"]');
	var checkinButtons = document.querySelectorAll('input[type="submit"]');

	// 遍歷所有下拉選單及checkinButton透過索引值可以找到同一列元素進行設定
	selectElements.forEach(function(selectElement, index) {
		var checkinButton = checkinButtons[index];

		// 確認下拉選單內的選項數量，並根據結果設置按鈕狀態和類，當下拉選單內沒有房間可以選擇時會將按鈕由綠色變成紅色
		if (selectElement.length === 0) {
			checkinButton.disabled = true;
			checkinButton.classList.remove("btn-success");
			checkinButton.classList.add("btn-danger");
		} else {
			checkinButton.disabled = false;
			checkinButton.classList.remove("btn-danger");
			checkinButton.classList.add("btn-success");
		}
	});
	</script>

	<!-- 引入 Bootstrap JavaScript 檔案 -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</body>
</html>