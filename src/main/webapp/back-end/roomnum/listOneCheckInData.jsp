<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<%@ page import = "com.paradisiac.roomorder.model.RoomOrderDTO" %>
<!DOCTYPE html>
<%
RoomOrderDTO data = (RoomOrderDTO) request.getAttribute("checkInData");
%>


<html>
<head>
    <meta charset="BIG5">
    <title>會員CheckIn確認表 </title>
    <!-- 引入 Bootstrap CSS 樣式表 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Room Order Details</h2>
        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>訂單編號</th>
                        <th>訂單日期</th>
                        <th>會員姓名</th>
                        <th>會員身份證</th>
                        <th>會員電話</th>
                        <th>房型名稱</th>
                        <th>下訂間數</th>
                        <th>金額</th>
                        <th>入住日期</th>
                        <th>退房日期</th>
                        <th>訂單狀態</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%=data.getRoomOrderNo()%></td>
                        <td><%=data.getRoomOrderDate()%></td>
                        <td><%=data.getMemName()%></td>
                        <td><%=data.getMemId()%></td>
                      	<td><%=data.getMemPhone()%></td>
                        <td><%=data.getRoomName()%></td>
                        <td><%=data.getRoomAmount()%></td>
                        <td><%=data.getPrice()%></td>
                        <td><%=data.getCheckInDate()%></td>
                        <td><%=data.getCheckOutDate()%></td>
                        <td><%=data.getOrderStatus()%></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 引入 Bootstrap JavaScript 檔案 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</body>
</html>