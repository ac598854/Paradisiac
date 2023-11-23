<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" import="org.json.JSONObject" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.*"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // 取得 HttpSession 對象
    HttpSession se = request.getSession();

    // 取得 memno 屬性值
    Integer memno = (Integer) se.getAttribute("memno");
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>結帳</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }

        .container {
            margin-top: 50px;
        }

        .card {
            border: 1px solid #ccc;
            margin: 10px;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px; /* 圓角 */
        }

        form {
            margin-bottom: 20px;
        }

        /* 添加動畫效果 */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        /* 使用動畫效果 */
        .animate-fade-in {
            animation: fadeIn 0.5s ease-in-out;
        }

        h1 {
            color: #007bff; /* 飯店風格的主色調 */
            font-size: 2rem;
            font-weight: bold;
        }

        label {
            color: #495057;
            font-weight: bold;
        }

        input,
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ced4da;
            border-radius: 5px;
        }

        /* 將文字置中 */
        .text-center {
            text-align: center;
        }

        button {
            padding: 10px 20px;
            background-color: green;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #0056b3; /* hover 時的顏色 */
        }
    </style>
</head>


<body>


    <div class="container">

        <h1>下訂訂單</h1>
        <div class="card animate-fade-in" style="border: none; ">
    		<div class="card-body">
            <form method="Post" action="${pageContext.request.contextPath}/order/order.do?action=buyorder" id="ord" class="animate-fade-in">

<!-- 			<div class="form-group"> -->
<!-- <!-- 			    <label for="roomOrderDate">roomOrderDate：</label> -->
<%-- 			    <input type="text" class="form-control" id="roomOrderDate" name="roomOrderDate" value="${roomOrderDate.roomOrderDate}"readonly> --%>
<!-- <!-- 					<input type="hidden" class="form-control" id="roomOrderDate" name="roomOrderDate" value=""> --> 

<!-- 			</div> -->

            
			<div class="form-group">
			    <label for="checkinDate">入住日期：</label>
<!-- 			    <input type="text" class="form-control" id="checkinDate" name="checkinDate" value="2023-11-05"> -->
			     <input type="date" id="vDateinput" name="checkinDate" value="2023-11-01" min="2023-11-01" max="2025-12-31" readonly/>
			</div>
			
			            
			<div class="form-group">
			    <label for="checkoutDate">退房日期：</label>
<!-- 			    <input type="text" class="form-control" id="checkoutDate" name="checkoutDate" value="2023-11-05"> -->
			     <input type="date" id="formattedNextDayinput" name="checkoutDate" value="2023-11-01" min="2023-11-01" max="2025-12-31" readonly/>
			</div>

                        <div class="form-group">
                <label for="roomTypeNo">房型編號：</label>
                <input type="text" class="form-control" id="roomTypeNoinput" name="roomTypeNo" value="1" readonly>
            </div>  

                        <div class="form-group">
<!--                 <label for="memNo">memNo：</label> -->
                <input type="hidden" class="form-control" id="memNo" name="memNo" value="${memno}" readonly>
            </div>  
                        <div class="form-group">
                <label for="roomAmount">訂購間數：</label>
                <input type="text" class="form-control" id="rbookinginput" name="roomAmount" value="1" readonly>
            </div>  
                        <div class="form-group">
                <label for="price">價錢:：</label>
                <input type="text" class="form-control" id="priceinput" name="price" value="1" readonly>
            </div>  

                           <div class="form-group">
                     <label for="paymentMethod">付款方式:</label>
                    <select class="form-control" id="paymentMethod" name="paymentMethod">
                        <option value="1">信用卡</option>
                        <option value="2">匯款</option>
                    </select>
                </div>

                                    <div class="form-group">
<!--                 <label for="paymentMethod">payStatus：</label> -->
                <input type="hidden" class="form-control" id="payStatus" name="payStatus" value="1" readonly>
            </div>  
                                    <div class="form-group">
<!--                 <label for="orderStatus">orderStatus：</label> -->
                <input type="hidden" class="form-control" id="orderStatus" name="orderStatus" value="1" readonly>
            </div>           
                
               
            </form>
 
		</div>
    </div>
    

            <form method="Post" action="${pageContext.request.contextPath}/calender.do?action=saveUpdate" id="cal">

                                    <div class="form-group">

                <input type="hidden" class="form-control" id="roomTypeNoinput2" name="roomTypeno" value="1">
            </div>  
			<div class="form-group">
<!-- 			    <input type="text" class="form-control" id="checkinDate" name="checkinDate" value="2023-11-05"> -->
			     <input type="hidden" id="vDateinput2" name="cDate" value="2023-11-01" min="2023-11-01" max="2025-12-31" />
			</div>

                        <div class="form-group">
                <input type="hidden" class="form-control" id="roomTotal" name="roomTotal" value="2">
            </div>  
                        <div class="form-group">
                <input type="hidden" class="form-control" id="rbookinginput2" name="roomBooking" value="1">
            </div>  
                                    <div class="form-group">
                <input type="hidden" class="form-control" id="available" name="available" value="1">
            </div>           
                
            </form>
			<div class="text-center mt-4">
			    <button class="btn btn-lg" type="submit" id="a" style="background-color: green; color: white;">確定訂購</button>
			</div>

    </div>
<script>
    let roomInfoString = localStorage.getItem('roomInfo');

    // 檢查 roomInfoString 是否為 null
    if (roomInfoString !== null) {
        let roomInfo = JSON.parse(roomInfoString);

        document.getElementById('vDateinput').value = roomInfo.vDate;
        document.getElementById('formattedNextDayinput').value = roomInfo.formattedNextDay;
        document.getElementById('roomTypeNoinput').value = roomInfo.roomTypeNo;
        document.getElementById('rbookinginput').value = roomInfo.rbooking;
        document.getElementById('rbookinginput2').value = roomInfo.rbooking;
        document.getElementById('priceinput').value = roomInfo.price * roomInfo.rbooking;
        
        document.getElementById('vDateinput2').value = roomInfo.vDate;
        document.getElementById('roomTypeNoinput2').value = roomInfo.roomTypeNo;
        document.getElementById('roomTotal').value = roomInfo.roomtotal;
        console.log(roomInfo.roomtotal);

    } else {
        console.log('No roomInfo found in localStorage.');
    }

    document.addEventListener("DOMContentLoaded", function() {
        document.getElementById("a").addEventListener("click", function(event) {
            event.preventDefault(); // 防止點擊按鈕後直接提交表單

            // 提交 "ord" 表單
            document.getElementById("ord").submit();

            // 延遲一點時間再提交 "cal" 表單，確保 "ord" 表單的數據能夠成功提交
            setTimeout(function() {
                document.getElementById("cal").submit();
            }, 100);
        });
    });

</script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
