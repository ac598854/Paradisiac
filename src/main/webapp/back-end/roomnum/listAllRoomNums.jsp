<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/main/main.css">
<title>房間管理系統</title>
 <style>
        .table th,
        .table td {
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
    </style>
</head>
<body>
	<DIV style="text-align:center;"><h1 >房間管理系統</h1></DIV>
	<div class="container mt-5">
	
	<!-- ==================message==================== -->
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
	
	<!-- ==================message==================== -->
	<a href="${pageContext.request.contextPath}/index.jsp">回首頁</a>	
	<c:if test="${roomnumPageQty > 0}">
  		<b><font color=red>第${currentPage}/${roomnumPageQty}頁</font></b>	
	</c:if>
	
		<table class="table table-bordered">
			<thead>
				<tr>
					<th scope="col">房間號碼</th>
					<th scope="col">房型</th>
					<th scope="col">訂單編號</th>
					<th scope="col">住房姓名</th>
					<th scope="col">房間狀態</th>
					<th scope="col">功能</th>

				</tr>
			</thead>
			<tbody>
				<c:forEach var="roomnum" items="${roomnumList}">
					<tr>
						<td>${roomnum.rnum}</td>
						<td>${roomnum.roomTypeNo}</td>
						<td>${roomnum.roomOrderNo}</td>
						<td>${roomnum.checkInName}</td>
						<td><c:choose>
								<c:when test="${roomnum.roomStatus == 1}">可入住</c:when>
								<c:when test="${roomnum.roomStatus == 2}">入住中</c:when>
								<c:when test="${roomnum.roomStatus == 3}">清潔中</c:when>
								<c:otherwise>未知狀態</c:otherwise>
							</c:choose></td>
						<td>
							<form method="post"
								action="<%=request.getContextPath()%>/roomnum.do">
								<input type="hidden" name="rnum" value="${roomnum.rnum}">
								<button type="submit" name="action" value="checkout"
									class="btn btn-primary">退房</button>
								<button type="submit" name="action" value="cleanup"
									class="btn btn-success" style="width: 100px;" onclick="clearMessages()">清掃完成</button>
									
									 <input type="hidden" name="page" value="${currentPage}" onclick="clearMessages()"><!--★★★★加了這一行可以讓按下按鈕時不會刷新回第一頁 -->
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
            <a href="${pageContext.request.contextPath}/roomnum.do?action=getAll&page=1" class="pagination-link">至第一頁</a>&nbsp;
        </c:when>
        <c:otherwise>
            <a href="#" class="pagination-link" style="pointer-events: none; cursor: default;">第一頁</a>&nbsp;
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${currentPage - 1 != 0}">
            <a href="${pageContext.request.contextPath}/roomnum.do?action=getAll&page=${currentPage - 1}" class="pagination-link">上一頁</a>&nbsp;
        </c:when>
        <c:otherwise>
            <a href="#" class="pagination-link" style="pointer-events: none; cursor: default;">上一頁</a>&nbsp;
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${currentPage + 1 <= roomnumPageQty}">
            <a href="${pageContext.request.contextPath}/roomnum.do?action=getAll&page=${currentPage + 1}" class="pagination-link">下一頁</a>&nbsp;
        </c:when>
        <c:otherwise>
            <a href="#" class="pagination-link" style="pointer-events: none; cursor: default;">下一頁</a>&nbsp;
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${currentPage != roomnumPageQty}">
            <a href="${pageContext.request.contextPath}/roomnum.do?action=getAll&page=${roomnumPageQty}" class="pagination-link">至最後一頁</a>&nbsp;
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/roomnum.do?action=getAll" class="pagination-link" style="pointer-events: none; cursor: default;">最後一頁</a>&nbsp;
        </c:otherwise>
    </c:choose>
	 </div>
	<br>
	
	<br><br>

	<script>
	//控制表單的按鈕當按下那個按鈕時就把按下的value值傳回給後端，做到自動切換2個按鈕的觸發，這是用來分辦現在按的是退房按鈕還是清潔完成按鈕
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