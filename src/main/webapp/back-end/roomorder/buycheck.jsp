<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<style>
        .container {
            text-align: center;
        }

        th {
            text-align: center;
        }

        th.scope {
            background-color: red;
            color: white;
        }
        .selected {
            background-color: #007bff;
            color: white;
        }
        .calstatus {
            padding-right: 20px;
        }
    </style>
</head>
<body>
  <h1>新增的訂單列表</h1>
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
</body>
</html>