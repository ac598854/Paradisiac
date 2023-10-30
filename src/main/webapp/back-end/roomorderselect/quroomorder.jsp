<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/main/main.css">
    <!-- 引入 Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.5.0/dist/css/bootstrap.min.css">
    <title>Hibernate Demo</title>
</head>
<body>
    <div class="container mt-5">
        <div class="text-center">
            <h1 class="mt-3">Order List Select</h1>
            <h2>員工系統</h2>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/emp/emp.do?action=getAll">查詢所有員工</a>
        </div>

        <h3 class="mt-5"><b>查詢</b></h3>
        
        <form action="${pageContext.request.contextPath}/emp/emp.do" method="post" class="mt-3">
            <div class="form-group">
                <select class="form-control" name="roomTypeNo">
                    <option value="">選取房型</option>
                    <option value="1">1人房</option>
                    <option value="2">2人房</option>
                    <option value="4">4人房</option>
                    <option value="8">8人房</option>
                </select>
            </div>
            <div class="form-group">
                <label for="checkinDate">Check-in Date:</label>
                <input type="date" class="form-control" name="checkinDate">
            </div>
            <div class="form-group">
                <label for="checkoutDate">Check-out Date:</label>
                <input type="date" class="form-control" name="checkoutDate">
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
            <input type="hidden" name="action" value="compositeQuery">
        </form>
    </div>
    <!-- 引入 Bootstrap JavaScript 和 jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.5.0/dist/js/bootstrap.min.js"></script>
</body>
</html>