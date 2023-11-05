<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/main/main.css">
<title>List RoomNums</title>
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
	<DIV style="text-align:center;"><h1 >住房管理系統</h1></DIV>
	
	<a href="${pageContext.request.contextPath}/index.jsp">回首頁</a>	
	<c:if test="${roomnumPageQty > 0}">
  		<b><font color=red>第${currentPage}/${roomnumPageQty}頁</font></b>
	</c:if>
	<br>
	<%-- <img width="140px" height="100px" alt="要飛囉貓貓" src="${pageContext.request.contextPath}/img/cat.png">
	<img width="140px" height="100px" alt="要飛囉貓貓" src="${pageContext.request.contextPath}/img/cat.png">
	<img width="140px" height="100px" alt="要飛囉貓貓" src="${pageContext.request.contextPath}/img/cat.png"> --%>
	<div class="container mt-5">
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
				<td>${roomnum.rNum}</td>
				<td>${roomnum.roomTypeNo}</td>
				<td>${roomnum.roomOrderNo}</td>
				<td>${roomnum.checkInName}</td>
				<td>${roomnum.roomStatus}</td>
				<td>
				<button type="button" class="btn btn-primary">修改</button>
                <button type="button" class="btn btn-danger">刪除</button>
                </td>
			</tr>
		</c:forEach>
	 </tbody>
	</table>
	</div>
	 <div class="text-center">
	 <c:choose>
        <c:when test="${currentPage > 1}">
            <a href="${pageContext.request.contextPath}/roomnum/roomnum.do?action=getAll&page=1" class="pagination-link">至第一頁</a>&nbsp;
        </c:when>
        <c:otherwise>
            <a href="#" class="pagination-link" style="pointer-events: none; cursor: default;">第一頁</a>&nbsp;
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${currentPage - 1 != 0}">
            <a href="${pageContext.request.contextPath}/roomnum/roomnum.do?action=getAll&page=${currentPage - 1}" class="pagination-link">上一頁</a>&nbsp;
        </c:when>
        <c:otherwise>
            <a href="#" class="pagination-link" style="pointer-events: none; cursor: default;">上一頁</a>&nbsp;
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${currentPage + 1 <= roomnumPageQty}">
            <a href="${pageContext.request.contextPath}/roomnum/roomnum.do?action=getAll&page=${currentPage + 1}" class="pagination-link">下一頁</a>&nbsp;
        </c:when>
        <c:otherwise>
            <a href="#" class="pagination-link" style="pointer-events: none; cursor: default;">下一頁</a>&nbsp;
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${currentPage != roomnumPageQty}">
            <a href="${pageContext.request.contextPath}/roomnum/roomnum.do?action=getAll&page=${roomnumPageQty}" class="pagination-link">至最後一頁</a>&nbsp;
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/emp/emp.do?action=getAll" class="pagination-link" style="pointer-events: none; cursor: default;">最後一頁</a>&nbsp;
        </c:otherwise>
    </c:choose>
	 </div>
	<br>
	<%-- <img width="140px" height="100px" alt="要飛囉貓貓" src="${pageContext.request.contextPath}/img/inversecat.png">
	<img width="140px" height="100px" alt="要飛囉貓貓" src="${pageContext.request.contextPath}/img/inversecat.png">
	<img width="140px" height="100px" alt="要飛囉貓貓" src="${pageContext.request.contextPath}/img/inversecat.png"> --%>
	<br><br>
	
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>