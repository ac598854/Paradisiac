<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>結帳</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .card {
            border: 1px solid #ccc;
            margin: 10px;
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="container">

        <div class="card">
            <form method="Post" action="${pageContext.request.contextPath}/order/order.do?action=buyorder">
        <h1>你預定的房型訂單</h1>
        <div id="roomList">
            <table class="table table-bordered">
                <thead>
                    <tr>

                        <th>訂單日期</th>
                        <th>入住日期</th>
                        <th>退房日期</th>
                        <th>房型編號</th>
                        <th>員工編號</th>
                        <th>房間數量</th>
                        <th>價錢</th>
                        <th>付款方式</th>
                        <th>付款狀態</th>
                        <th>訂單狀態</th>
                    </tr>
                </thead>
                <tbody>
                <tr>
                    <td>${result.roomOrderDate}</td>
                    <td>${result.checkinDate}</td>
                    <td>${result.checkoutDate}</td>
                    <td>${result.roomTypeNo}</td>
                    <td>${result.memNo}</td>
                    <td>${result.roomAmount}</td>
                    <td>${result.price}</td>
                    <td>${result.paymentMethod}</td>
                    <td>${result.payStatus}</td>
                    <td>${result.orderStatus}</td>
                    </tr>
                </tbody>
            </table>
        </div>
                <button class="btn btn-success" type="submit" id="buyButton">確定購買</button>
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
