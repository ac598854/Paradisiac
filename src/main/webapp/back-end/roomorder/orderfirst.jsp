<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>訂單管理</title>
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
        <h1 class="mt-5">搜尋全部</h1>
        <form method="Post">
            <a class="btn btn-primary mb-4" href="${pageContext.request.contextPath}/order/order.do?action=getAll">查詢所有房型資料</a>
        </form>

        <h1>新增訂單</h1>
        <div class="card">
            <form method="Post" action="${pageContext.request.contextPath}/order/order.do?action=addorder">

<!-- 			<div class="form-group"> -->
<!-- <!-- 			    <label for="roomOrderDate">roomOrderDate：</label> --> -->
<%-- 			    <input type="text" class="form-control" id="roomOrderDate" name="roomOrderDate" value="${roomOrderDate.roomOrderDate}"readonly> --%>
<!-- <!-- 					<input type="hidden" class="form-control" id="roomOrderDate" name="roomOrderDate" value=""> --> -->

<!-- 			</div> -->

            
			<div class="form-group">
			    <label for="checkinDate">checkinDate：</label>
<!-- 			    <input type="text" class="form-control" id="checkinDate" name="checkinDate" value="2023-11-05"> -->
			     <input type="date" id="checkinDate" name="checkinDate" value="2023-11-01" min="2023-11-01" max="2025-12-31" />
			</div>
			
			            
			<div class="form-group">
			    <label for="checkoutDate">checkoutDate：</label>
<!-- 			    <input type="text" class="form-control" id="checkoutDate" name="checkoutDate" value="2023-11-05"> -->
			     <input type="date" id="checkoutDate" name="checkoutDate" value="2023-11-01" min="2023-11-01" max="2025-12-31" />
			</div>

                        <div class="form-group">
                <label for="roomTypeNo">roomTypeNo：</label>
                <input type="text" class="form-control" id="roomTypeNo" name="roomTypeNo" value="1">
            </div>  

                        <div class="form-group">
                <label for="memNo">memNo：</label>
                <input type="text" class="form-control" id="memNo" name="memNo" value="1">
            </div>  
                        <div class="form-group">
                <label for="roomAmount">roomAmount：</label>
                <input type="text" class="form-control" id="roomAmount" name="roomAmount" value="1">
            </div>  
                        <div class="form-group">
                <label for="price">price：</label>
                <input type="text" class="form-control" id="price" name="price" value="1">
            </div>  
                        <div class="form-group">
                <label for="paymentMethod">paymentMethod：</label>
                <input type="text" class="form-control" id="paymentMethod" name="paymentMethod" value="1">
            </div>  
                        <div class="form-group">
                <label for="payStatus">payStatus：</label>
                <input type="text" class="form-control" id="payStatus" name="payStatus" value="true">
            </div>   
            
                                    <div class="form-group">
                <label for="orderStatus">orderStatus：</label>
                <input type="text" class="form-control" id="orderStatus" name="orderStatus" value="1">
            </div>           
                
                <button class="btn btn-success" type="submit" id="addButton">確定新增</button>
            </form>
        </div>



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
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>


			//獲取當前日期和時間
			var currentDate = new Date();
			
			// 格式化日期和時間為 "yyyy-MM-dd HH:mm:ss.SSS" 的格式
			var formattedDate = currentDate.getFullYear() + '-' +
			    (currentDate.getMonth() + 1).toString().padStart(2, '0') + '-' +
			    currentDate.getDate().toString().padStart(2, '0') + ' ' +
			    currentDate.getHours().toString().padStart(2, '0') + ':' +
			    currentDate.getMinutes().toString().padStart(2, '0') + ':' +
			    currentDate.getSeconds().toString().padStart(2, '0') + '.' +
			    currentDate.getMilliseconds().toString().padStart(3, '0');
			
			// 將格式化日期設定為輸入字段的值
			document.getElementById("roomOrderDate").value = formattedDate;



    $(document).ready(function() {
        // 紀錄房型數
        let roomCount = 1;

        $("#addButton").click(function(event) {
            event.preventDefault(); // 防止表單提交

            // 獲取新資料
            var roomName = $("#roomOrderDate").val();
            var rtype = $("#checkinDate").val();
            var roomTotal = $("#checkoutDate").val();
            var price = $("#roomTypeNo").val();
            var normalPrice = $("#memNo").val();
            var holidayPrice = $("#roomAmount").val();
            var bridgeHolidayPrice = $("#price").val();
            var notice = $("#paymentMethod").val();
            var facility = $("#payStatus").val();
            var rTypeStatus = $("#orderStatus").val();

            // 創建新的表格行
            var newRow = 
                <tr>
                    <td>${roomCount}</td>
                    <td>${roomName}</td>
                    <td>${rtype}</td>
                    <td>${roomTotal}</td>
                    <td>${price}</td>
                    <td>${normalPrice}</td>
                    <td>${holidayPrice}</td>
                    <td>${bridgeHolidayPrice}</td>
                    <td>${notice}</td>
                    <td>${facility}</td>
                    <td>${rTypeStatus}</td>
                </tr>;

            // 將新行添加到表格
            $("#roomList tbody").append(newRow);

            roomCount++; // 更新房型數

            // 清除表單輸入欄位
            $("#roomOrderDate, #checkinDate, #checkoutDate, #roomTypeNo, #memNo, #roomAmount, #price, #paymentMethod, #payStatus, #orderStatus").val("");
        });
    });
</script>
</body>
</html>
