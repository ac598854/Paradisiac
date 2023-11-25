<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>訂單管理</title>
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
        	<div class="col-lg-7">
      			  <h1 class="mt-5">搜尋全部</h1>
        <form method="Post">
            <a class="btn btn-primary mb-4" href="${pageContext.request.contextPath}/order/order.do?action=getAll">查詢所有訂單資料</a>
        </form>

        <h1>新增訂單</h1>
        <div class="card">
            <form method="Post" action="${pageContext.request.contextPath}/order/order.do?action=addorder" onsubmit="return validateForm()">

<!-- 			<div class="form-group"> -->
<!-- <!-- 			    <label for="roomOrderDate">roomOrderDate：</label> -->
<%-- 			    <input type="text" class="form-control" id="roomOrderDate" name="roomOrderDate" value="${roomOrderDate.roomOrderDate}"readonly> --%>
<!-- <!-- 					<input type="hidden" class="form-control" id="roomOrderDate" name="roomOrderDate" value=""> --> 

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
                <input type="number" class="form-control" id="roomTypeNo" name="roomTypeNo" value="" placeholder="1" min="1">
            </div>  

                        <div class="form-group">
                <label for="memNo">memNo：</label>
                <input type="number" class="form-control" id="memNo" name="memNo" value="" placeholder="1" min="1">
            </div>  
                        <div class="form-group">
                <label for="roomAmount">roomAmount：</label>
                <input type="number" class="form-control" id="roomAmount" name="roomAmount" value="" placeholder="1" min="1">
            </div>  
                        <div class="form-group">
                <label for="price">price：</label>
                <input type="number" class="form-control" id="price" name="price" value="" placeholder="訂單總價錢" min="1">
            </div>  
                        <div class="form-group">
                <label for="paymentMethod">paymentMethod：</label>
                    <select class="form-control" id="paymentMethod" name="paymentMethod">
                        <option value="1">信用卡</option>
                        <option value="2">匯款</option>
                    </select>

            </div>  
                        <div class="form-group">
                <label for="payStatus">payStatus：</label>
                    <select class="form-control" id="payStatus" name="payStatus">
                        <option value="0">已付款</option>
                        <option value="1">未付款</option>
                    </select>
            </div>   
            
                                    <div class="form-group">
                <label for="orderStatus">orderStatus：</label>
                    <select class="form-control" id="orderStatus" name="orderStatus">
                        <option value="1">可入住</option>
                        <option value="2">已入住</option>
                        <option value="3">已退房</option>
                    </select>
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
</div>
</div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
	  var today = new Date();
	  var dd = String(today.getDate()).padStart(2, '0');
	  var mm = String(today.getMonth() + 1).padStart(2, '0');
	  var yyyy = today.getFullYear();
	  today = yyyy + '-' + mm + '-' + dd;
	  document.getElementById("checkinDate").value = today;
	  document.getElementById("checkoutDate").value = today;
	</script>
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
