<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/main/main.css">
<title>房間管理系統</title>
<style>
/* .container{	 				
 		position:relative;
 		top: -72px;
}
.text-center{ 		
 		position:relative;
 		top: -60px; 		
} 	 */
.container.mt-5 {
    padding-left: 200px;
}
.addTable {
    height: 20px; /* Adjust the height as needed */
    width: 930px;
    
}

/* Optional: Adjust the height of the cells, input fields, or other elements if needed */
.addTable td,
.addTable input {
    height: 40px; /* Adjust the height as needed */
    width:150px;
}

/* Optional: If you want to center the content vertically within each cell */
.addTable td {
	text-align:center;
   padding:0;
}
.addTable select {
    height: 40px; /* Adjust the height as needed */
   	position:relative;
   	top:8px;
}
#addbutton {
    height: 40px; /* Adjust the height as needed */
   	position:relative;
    width:100%;
   
}
/*=========================  */
.table th, .table td {
	text-align: center;
	border: 1px solid #dee2e6;
}

.table th {
	background-color: #007bff;
	color: #fff;
	border-color: #007bff;
	border-radius: 0 0 0 0;
}

.table th:not(:last-child) {
	border-right: 1px solid #dee2e6;
}

.table .btn {
	width: 80px;
	margin-right: 5px;
	border-radius: 0.25rem;
}

.table .btn-primary {
	background-color: #007bff;
	border-color: #007bff;
}

.table .btn-danger {
	background-color: #dc3545;
	border-color: #dc3545;
}

.table .btn:hover {
	transform: translateY(-3px);
	box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.5);
}

.pagination-link {
	display: inline-block;
	padding: 6px 12px;
	margin-bottom: 0;
	font-size: 14px;
	font-weight: 400;
	line-height: 1.42857143;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	cursor: pointer;
	border: 1px solid transparent;
	border-radius: 4px;
	color: #fff;
	background-color: #007bff;
	border-color: #007bff;
	text-decoration: none;
}

.pagination-link:hover {
	background-color: #0056b3;
	border-color: #0056b3;
}
.container{
	margin-top: 0px;
}
</style>
<!-- 切換按鈕的文字（新增/修改） -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<!-- 切換按鈕的文字（新增/修改） -->
</head>
<body>
<%@ include file="/back-end/index/back-left_room.jsp" %>
	<!-- <DIV style="text-align:center;"><h1 >房間管理系統--新增/修改/刪除</h1></DIV> -->
	<div class="container mt-5">
	
	<br>
		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMessage}">
		<div id="errorMessages">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMessage}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
			</div>
		</c:if>
		<%-- 錯誤表列 --%>
			<%-- 成功表列 --%>
		<c:if test="${not empty successMessage}">
		<div id="successMessages">
			<font style="color: green">執行完成:</font>
			<ul>
				<c:forEach var="message" items="${successMessage}">
					<li style="color: green">${message}</li>
				</c:forEach>
			</ul>
			</div>
		</c:if>
		<%-- 成功表列 --%>
		<!--===============新增房間=====================  -->
		  <table class="addTable table-bordered" >
        <tbody>            
            <tr>
            <form method="post"	action="<%=request.getContextPath()%>/roomnum.do">
                <td colspan="2" class="text-center font-weight-bold bg-primary text-white">新增房間</td>
                <td>房間編號：</td>
                <td><input type="text" class="form-control" name="roomNum" value="" size="10"></td>            	
                <td>房型編號：</td>
                <!-- <td><input type="text" class="form-control" name="TypeNo" value="" size="10"></td> -->
				<td>
							<!--================下拉選單===================  -->
								<div class="form-group">
									<select	class="form-control" id="roomTypeSelect" name="TypeNo">
										<c:forEach var="roomType" items="${roomTypeList}">
											<option value="${roomType.roomTypeno}">${roomType.roomName}</option>
										</c:forEach>
									</select>
								</div>							
							<!--================下拉選單===================== -->
						</td>               
                <td colspan="2" class="text-center">
                    <button type="submit" id="addbutton" name="action" value="addRoomNum" class="btn btn-primary" onclick="clearMessages()">確認</button>
                </td>
                <input type="hidden" name="page" value="${currentPage}">
           </form>
            </tr>
        </tbody>
    </table>
		<!--================回首頁=====================  -->
		<!-- <a href="${pageContext.request.contextPath}/index.jsp">回首頁</a> -->
		<!--================顯示頁數=====================  -->
		<c:if test="${roomnumPageQty > 0}">
			<b><font color=red>第${currentPage}/${roomnumPageQty}頁</font></b>
		</c:if>
		<!--===============修改及刪除房間======================  -->
		<table class="table table-bordered">
			<thead>
				<tr>
					<th scope="col">房間號碼</th>
					<th scope="col">房型名稱</th>
					<th scope="col">訂單編號</th>
					<th scope="col">住房姓名</th>
					<th scope="col">房間狀態</th>
					<th scope="col">功能</th>

				</tr>
			</thead>
			<tbody>

				<c:forEach var="roomnum" items="${roomnumList}">
					<form method="post"	action="<%=request.getContextPath()%>/roomnum.do">
						<tr>
							<td><label>${roomnum.rnum}</label> <input type="hidden"
								name="rnum" value="${roomnum.rnum}" style="width: 100px;"></td>
							<td>
								<%-- <input type="text" name="roomTypeNo" value="${roomnum.roomTypeNo}" style="width: 100px;"> --%>
								<!--================下拉選單===================  --> <select
								class="form-control" id="roomTypeSelect1" name="roomTypeNo">
									<c:forEach var="roomType" items="${roomTypeList}">
										<c:choose>
											<c:when test="${roomType.roomTypeno eq roomnum.roomTypeNo}">
												<option value="${roomType.roomTypeno}" selected>${roomType.roomName}</option>
											</c:when>
											<c:otherwise>
												<option value="${roomType.roomTypeno}">${roomType.roomName}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
							</select>

							</td>
							<td><input type="text" name="roomOrderNo"
								value="${roomnum.roomOrderNo}" style="width: 100px;"></td>
							<td><input type="text" name="checkInName"
								value="${roomnum.checkInName}" style="width: 100px;"></td>
							<td><c:choose>
									<c:when test="${roomnum.roomStatus == 1}">可入住</c:when>
									<c:when test="${roomnum.roomStatus == 2}">入住中</c:when>
									<c:when test="${roomnum.roomStatus == 3}">清潔中</c:when>
									<c:otherwise>未知狀態</c:otherwise>
								</c:choose></td>
							<td><input type="hidden" name="roomStatus" value="${roomnum.roomStatus}"> <%-- <input type="hidden" name="rnum" value="${roomnum.rnum}">
								<input type="hidden" name="rnum" value="${roomnum.roomTypeNo}">
								<input type="hidden" name="rnum" value="${roomnum.roomOrderNo}">
								<input type="hidden" name="rnum" value="${roomnum.checkInName}"> --%>
								<button type="submit" name="action" value="delRoomNum"	class="btn btn-primary" onclick="clearMessages()">刪除</button>
								<button type="submit" name="action" class="btn btn-success btn-toggle" value="updateRoomNum" style="width: 100px;" onclick="clearMessages()">修改</button> <!--★★★★加了這一行可以讓按下退房或清掃完成按鈕時不會刷新回第一頁 -->
								<input type="hidden" name="page" value="${currentPage}">
					
					</form>
					</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	 <div class="text-center">
	 <c:choose>
        <c:when test="${currentPage > 1}">
            <a href="${pageContext.request.contextPath}/roomnum.do?action=roomNumModify&page=1" class="pagination-link">至第一頁</a>&nbsp;
        </c:when>
        <c:otherwise>
            <a href="#" class="pagination-link" style="pointer-events: none; cursor: default;">第一頁</a>&nbsp;
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${currentPage - 1 != 0}">
            <a href="${pageContext.request.contextPath}/roomnum.do?action=roomNumModify&page=${currentPage - 1}" class="pagination-link">上一頁</a>&nbsp;
        </c:when>
        <c:otherwise>
            <a href="#" class="pagination-link" style="pointer-events: none; cursor: default;">上一頁</a>&nbsp;
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${currentPage + 1 <= roomnumPageQty}">
            <a href="${pageContext.request.contextPath}/roomnum.do?action=roomNumModify&page=${currentPage + 1}" class="pagination-link">下一頁</a>&nbsp;
        </c:when>
        <c:otherwise>
            <a href="#" class="pagination-link" style="pointer-events: none; cursor: default;">下一頁</a>&nbsp;
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${currentPage != roomnumPageQty}">
            <a href="${pageContext.request.contextPath}/roomnum.do?action=roomNumModify&page=${roomnumPageQty}" class="pagination-link">至最後一頁</a>&nbsp;
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/roomnum.do?action=roomNumModify" class="pagination-link" style="pointer-events: none; cursor: default;">最後一頁</a>&nbsp;
        </c:otherwise>
    </c:choose>
	 </div>
	<br>	
	
	<script>
	//控制表單的按鈕當按下那個按鈕時就把按下的value值傳回給後端，做到自動切換2個按鈕的觸發，這是用來分辦現在按的是刪除按鈕還是新增/修改按鈕
    document.querySelectorAll('button[type="submit"]').forEach(button => {
        button.addEventListener('click', function() {
            document.querySelector('input[name="action"]').value = this.value;
        });
    });
	
	//在按下任何按鈕時先清空訊息
    function clearMessages() {
        // 清空錯誤訊息
        var errorMessages = document.getElementById('errorMessages');
        if (errorMessages) {
            errorMessages.innerHTML = '';
        }

        // 清空成功訊息
        var successMessages = document.getElementById('successMessages');
        if (successMessages) {
            successMessages.innerHTML = '';
        }
    }
	
	
	
	</script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>