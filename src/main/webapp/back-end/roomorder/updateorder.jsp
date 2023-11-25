<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>修改訂單</title>
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

 <style>

		.body{
			padding-left: 220px; 
		}
       
        .content {
            margin-left: 240px; 
            padding-top: 20px; 
        }
        
        
        .card {
            border: 1px solid #ccc;
            margin: 10px;
            padding: 20px;
        }
        

        .btn-icon {
            font-size: 1.2em; 
        }
        

        .custom-width {
            max-width: 640px; 
            margin: auto;
        }
    </style>
    <%@ include file="/back-end/index/ManagerMeta.jsp" %>
</head>
<body>
	   <div class="sidebar">
			<%@ include file="/back-end/index/ManagerBody.jsp" %>
       </div>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-7"> <!-- 調整這裡的col-lg來改變寬度 -->
       
       <h1>修改訂單</h1>
    	<div class="card">
	        <form method="post" action="${pageContext.request.contextPath}/order/order.do?action=updateorder" onsubmit="return validateForm()">
	            
	            <div class="form-group">
	                <label for="roomOrderNo">訂單編號：</label>
	                <input type="text" class="form-control" id="roomOrderNo" name="roomOrderNo" value="${param.roomOrderNo}" readonly>
	            </div>
	
				<div class="form-group">
				    <label for="roomOrderDate">生成訂單日期：</label>
				    <input type="text" class="form-control" id="roomOrderDate" name="roomOrderDate" value="${param.roomOrderDate}"readonly>
				    
				</div>
	
	
				<div class="form-group">
				    <label for="checkinDate">入住日期：</label>
	<%-- 			    <input type="text" class="form-control" id="checkinDate" name="checkinDate" value="${param.checkinDate}"> --%>
				    <input type="date" id="checkinDate" name="checkinDate" value="${param.checkinDate}" min="2023-11-01" max="2025-12-31" />
				</div>
				
				
				<div class="form-group">
				    <label for="checkoutDate">退房日期：</label>
	<%-- 			    <input type="text" class="form-control" id="checkoutDate" name="checkoutDate" value="${param.checkoutDate}"> --%>
				    <input type="date" id="checkoutDate" name="checkoutDate" value="${param.checkoutDate}" min="2023-11-01" max="2025-12-31" />
				</div>
	
	
	            <div class="form-group">
	                <label for="roomTypeNo">房型編號：</label>
	                <input type="number" class="form-control" id="roomTypeNo" name="roomTypeNo" value="${param.roomTypeNo}" min="1">
	            </div>
	
	            <div class="form-group">
	                <label for="memNo">員工編號：</label>
	                <input type="number" class="form-control" id="memNo" name="memNo" value="${param.memNo}" min="1">
	            </div>
	
	            <div class="form-group">
	                <label for="roomAmount">房間數量：</label>
	                <input type="number" class="form-control" id="roomAmount" name="roomAmount" value="${param.roomAmount}" min="1">
	            </div>
	
	            <div class="form-group">
	                <label for="price">價錢：</label>
	                <input type="number" class="form-control" id="price" name="price" value="${param.price}" min="1">
	            </div>
	
	            <div class="form-group">
	                <label for="paymentMethod">付款方式：</label>
			    <select class="form-control" id="paymentMethod" name="paymentMethod">
			        <option value="1" <c:if test="${param.paymentMethod eq '1'}">selected</c:if>>信用卡</option>
			        <option value="2" <c:if test="${param.paymentMethod eq '2'}">selected</c:if>>匯款</option>
			    </select>
	            </div>
	
	            <div class="form-group">
	                <label for="payStatus">付款狀態：</label>  
			    <select class="form-control" id="payStatus" name="payStatus">
			        <option value="0" <c:if test="${param.payStatus eq '0'}">selected</c:if>>已付款</option>
			        <option value="1" <c:if test="${param.payStatus eq '1'}">selected</c:if>>未付款</option>
			    </select>
	            </div>
	
	            <div class="form-group">
	                <label for="orderStatus">訂單狀態：</label>
			    <select class="form-control" id="orderStatus" name="orderStatus">
			        <option value="1" <c:if test="${param.orderStatus eq '1'}">selected</c:if>>可入住</option>
			        <option value="2" <c:if test="${param.orderStatus eq '2'}">selected</c:if>>已入住</option>
			        <option value="3" <c:if test="${param.orderStatus eq '3'}">selected</c:if>>已退房</option>
			    </select>
	            </div>
	
	            <button class="btn btn-success" type="submit">確定修改</button>
	             <a class="btn btn-secondary" href="javascript:history.back()">取消修改</a>
	        </form>

    	</div>
    	<a class="btn btn-secondary" href="${pageContext.request.contextPath}/back-end/roomorder/orderfirst.jsp">返回</a>
  </div>
  
	</div>     
 </div>        
 <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
 	<script>
		 function validateForm() {
		    var roomTypeNo = document.getElementById("roomTypeNo").value;
		    
		    var memNo = document.getElementById("memNo").value;
		    var roomAmount = document.getElementById("roomAmount").value;
		
		    var price = document.getElementById("price").value;
		
		    if (memNo === ""  ) {
		        alert("會員編號未填寫");
		        return false; 
		    }
		    if (roomAmount === ""  ) {
		        alert("房間訂購數量未填寫");
		        return false; 
		    }
		    
		    if (roomTypeNo === "" ) {
		        alert("房型編號未填寫");
		        return false; 
		    }
		    if (price === "" ) {
		        alert("價錢未填寫完整");
		        return false; 
		    }
		    return true; 
		}
	</script>
</body>
</html>
