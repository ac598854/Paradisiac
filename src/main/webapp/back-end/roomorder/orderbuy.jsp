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

        <h1>下訂訂單</h1>
        <div class="card">
            <form method="Post" action="${pageContext.request.contextPath}/order/order.do?action=buyorder" id="ord">

<!-- 			<div class="form-group"> -->
<!-- <!-- 			    <label for="roomOrderDate">roomOrderDate：</label> -->
<%-- 			    <input type="text" class="form-control" id="roomOrderDate" name="roomOrderDate" value="${roomOrderDate.roomOrderDate}"readonly> --%>
<!-- <!-- 					<input type="hidden" class="form-control" id="roomOrderDate" name="roomOrderDate" value=""> --> 

<!-- 			</div> -->

            
			<div class="form-group">
			    <label for="checkinDate">checkinDate：</label>
<!-- 			    <input type="text" class="form-control" id="checkinDate" name="checkinDate" value="2023-11-05"> -->
			     <input type="date" id="vDateinput" name="checkinDate" value="2023-11-01" min="2023-11-01" max="2025-12-31" />
			</div>
			
			            
			<div class="form-group">
			    <label for="checkoutDate">checkoutDate：</label>
<!-- 			    <input type="text" class="form-control" id="checkoutDate" name="checkoutDate" value="2023-11-05"> -->
			     <input type="date" id="formattedNextDayinput" name="checkoutDate" value="2023-11-01" min="2023-11-01" max="2025-12-31" />
			</div>

                        <div class="form-group">
                <label for="roomTypeNo">roomTypeNo：</label>
                <input type="text" class="form-control" id="roomTypeNoinput" name="roomTypeNo" value="1">
            </div>  

                        <div class="form-group">
                <label for="memNo">memNo：</label>
                <input type="text" class="form-control" id="memNo" name="memNo" value="${memno}">
            </div>  
                        <div class="form-group">
                <label for="roomAmount">roomAmount：</label>
                <input type="text" class="form-control" id="rbookinginput" name="roomAmount" value="1">
            </div>  
                        <div class="form-group">
                <label for="price">price：</label>
                <input type="text" class="form-control" id="priceinput" name="price" value="1">
            </div>  

                           <div class="form-group">
                     <label for="paymentMethod">paymentMethod：</label>
                    <select class="form-control" id="paymentMethod" name="paymentMethod">
                        <option value="1">信用卡</option>
                        <option value="2">匯款</option>
                    </select>
                </div>

                                    <div class="form-group">
                <label for="paymentMethod">payStatus：</label>
                <input type="text" class="form-control" id="payStatus" name="payStatus" value="0">
            </div>  
                                    <div class="form-group">
                <label for="orderStatus">orderStatus：</label>
                <input type="text" class="form-control" id="orderStatus" name="orderStatus" value="1">
            </div>           
                
                <button class="btn btn-success" type="submit" id="addButton">確定新增</button>
            </form>
        </div>

    </div>
    
    <div class="container">

        <h1>CAL</h1>
        <div class="card">
            <form method="Post" action="${pageContext.request.contextPath}/calender.do?action=saveUpdate" id="cal">

                                    <div class="form-group">
                <label for="roomTypeNo">roomTypeNo：</label>
                <input type="text" class="form-control" id="roomTypeNoinput" name="roomTypeno" value="1">
            </div>  
			<div class="form-group">
			    <label for="checkinDate">checkinDate：</label>
<!-- 			    <input type="text" class="form-control" id="checkinDate" name="checkinDate" value="2023-11-05"> -->
			     <input type="date" id="vDateinput" name="cDate" value="2023-11-01" min="2023-11-01" max="2025-12-31" />
			</div>

                        <div class="form-group">
                <label for="roomTotal">roomTotal：</label>
                <input type="text" class="form-control" id="roomTotal" name="roomTotal" value="5">
            </div>  
                        <div class="form-group">
                <label for="roomAmount">roomAmount：</label>
                <input type="text" class="form-control" id="rbookinginput2" name="roomBooking" value="1">
            </div>  


                                    <div class="form-group">
                <label for="available">available：</label>
                <input type="text" class="form-control" id="available" name="available" value="0">
            </div>           
                
                <button class="btn btn-success" type="submit" id="CALButton">確定新增CAL</button>
            </form>
        </div>
 <button class="btn btn-success" type="submit" id="a">確定新增a</button>

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
        document.getElementById('priceinput').value = roomInfo.price;


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
