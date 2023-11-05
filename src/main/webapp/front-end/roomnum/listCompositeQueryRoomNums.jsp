<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
            width: 100px;
            border-radius: 0.3rem;
            transition: all 0.3s ease;
        }

        .table .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            box-shadow: 0 0.5rem 1rem rgba(0, 123, 255, 0.2);
        }

        .table .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
            box-shadow: 0 0.5rem 1rem rgba(220, 53, 69, 0.2);
        }

        .table .btn-primary:hover, 
        .table .btn-danger:hover {
            transform: translateY(-3px);
        }

        .table {
            border-radius: 0.5rem;
            overflow: hidden;
            border: 2px solid #dee2e6;
        }

        .table-bordered {
            border-radius: 10px;
        }
    </style>
</head>
<body>
	<h1>員工列表</h1>
	<br>
	<img width="140px" height="100px" alt="要飛囉貓貓" src="${pageContext.request.contextPath}/img/cat.png">
	<img width="140px" height="100px" alt="要飛囉貓貓" src="${pageContext.request.contextPath}/img/cat.png">
	<img width="140px" height="100px" alt="要飛囉貓貓" src="${pageContext.request.contextPath}/img/cat.png">
	<table class="table table-bordered">
		<tr>
			<th>房間號碼</th>
			<th>房型</th>
			<th>訂單編號</th>
			<th>住房姓名</th>
			<th>房間狀態</th>
			
		</tr>
		<c:forEach var="roomnum" items="${RoomNumList}">
			<tr>
				<td>${roomnum.rNum}</td>
				<td>${roomnum.roomTypeNo}</td>
				<td>${roomnum.roomOrderNo}</td>
				<td>${roomnum.checkInName}</td>
				<td>${roomnum.roomStatus}</td>
				<button type="button" class="btn btn-primary">修改</button>
                <button type="button" class="btn btn-danger">刪除</button>
			</tr>
		</c:forEach>
	</table>
	<br>
	<img width="140px" height="100px" alt="要飛囉貓貓" src="${pageContext.request.contextPath}/img/inversecat.png">
	<img width="140px" height="100px" alt="要飛囉貓貓" src="${pageContext.request.contextPath}/img/inversecat.png">
	<img width="140px" height="100px" alt="要飛囉貓貓" src="${pageContext.request.contextPath}/img/inversecat.png">
	<br><br>
	
	<a href="${pageContext.request.contextPath}/index.jsp">回首頁</a>	
</body>
</html>