<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>新增</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>

    </style>
</head>
<body>

    <div class="container">
        <h1>新增</h1>

        <form action="${pageContext.request.contextPath}/type/type.do/addtype" method="post">

            <table class="table table-bordered">
                <tr>
                    <th>編號</th>
                    <th>名稱</th>
                    <th>房型</th>
                    <th>總數</th>
                    <th>價錢</th>
                    <th>原價錢</th>
                    <th>節日價錢</th>
                    <th>連續假期價錢</th>
                    <th>備註</th>
                    <th>設施</th>
                    <th>狀態</th>
                </tr>

                <tr>
                    <td>${result.roomTypeNo}</td>
                    <td>${result.roomName}</td>
                    <td>${result.rtype}</td>
                    <td>${result.roomTotal}</td>
                    <td>${result.price}</td>
                    <td>${result.normalPrice}</td>
                    <td>${result.holidayPrice}</td>
                    <td>${result.bridgeHolidayPrice}</td>
                    <td>${result.notice}</td>
                    <td>${result.facility}</td>
                    <td>${result.rTypeStatus}</td>
                    
                </tr>
            </table>
            <a class="btn btn-secondary" href="javascript:history.back()">返回</a>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
