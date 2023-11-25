<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <title>GetAll</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
      <style>

        

        .content {
            margin-left: 100px; 
            padding-top: 20px; 
        }
        
        
        .card {
            border: 1px solid #ccc;
            margin: 10px;
            padding: 20px;
        }
        
        
        .btn-icon {
            font-size: 1.2em; 
            margin-left: 245px; 
        }
        
        
        .custom-width {
            max-width: 800px;
            margin: auto; 
        }
        
		.card {
		    /* 卡片樣式 */
		    border: 1px solid #ccc;
		    margin: 10px;
		    padding: 20px;
		    position: relative; /* 將卡片設置為相對定位，以便分頁容器相對於卡片進行定位 */
		}
		
		.pagination-container {
		    /* 分頁容器樣式 */
		    position: absolute;
		    bottom: 10px; /* 距離卡片底部的距離 */
		    left: 0;
		    right: 0;
		    text-align: center; /* 將分頁按鈕置中 */
		}
		
		.page-number {
		    /* 分頁按鈕樣式 */
		    display: inline-block;
		    margin: 5px; /* 設置按鈕之間的間距 */
		    padding: 5px 10px;
		    background-color: #007bff;
		    color: #fff;
		    text-decoration: none;
		    border-radius: 5px;
		    cursor: pointer;
		}
		
		.page-number:hover {
		    background-color: #0056b3;
		}

    </style>
    
    <%@ include file="/back-end/index/ManagerMeta.jsp" %>
</head>
<body>
	   <div class="sidebar">
			<%@ include file="/back-end/index/ManagerBody.jsp" %>
       </div>
       
         <div class="content">
        <div class="container">
            <h3>搜尋全部訂單資料</h3>
            <div class="table-responsive"> 

		           <table class="table table-bordered small-table" style="font-size: 12px;"id="data-table">
            <thead>
                <tr>
                    	<th>訂單編號</th>
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
                        <th>操作</th>
                </tr>

            </thead>
            
            <tbody>
            
                <c:forEach var="all" items="${all}">
                    <tr>
                    	<td>${all.roomOrderNo}</td>
	                    <td>${all.roomOrderDate}</td>
	                    <td>${all.checkinDate}</td>
	                    <td>${all.checkoutDate}</td>
	                    <td>${all.roomTypeNo}</td>
	                    <td>${all.memNo}</td>
	                    <td>${all.roomAmount}</td>
	                    <td>${all.price}</td>
	                    <td>								    <c:choose>
			                <c:when test="${all.paymentMethod == '1'}">信用卡</c:when>
			                    <c:otherwise>匯款</c:otherwise>
			                </c:choose>
					    </td>
   	                    <td>								    <c:choose>
			                <c:when test="${all.payStatus == '0'}">未付款</c:when>
			                    <c:otherwise>已付款</c:otherwise>
			                </c:choose>
					    </td>
   	                    <td>								    <c:choose>
			                <c:when test="${all.orderStatus == '1'}">可入住</c:when>
			                <c:when test="${all.orderStatus == '2'}">已入住</c:when>
			                <c:when test="${all.orderStatus == '3'}">已退房</c:when>
			                </c:choose>
					    </td>
						<td>
					<form method="post" action="${pageContext.request.contextPath}/back-end/roomorder/updateorder.jsp">
					    <input type="hidden" name="roomOrderNo" value="${all.roomOrderNo}">
					    <input type="hidden" name="roomOrderDate" value="${all.roomOrderDate}">
					    <input type="hidden" name="checkinDate" value="${all.checkinDate}">
					    <input type="hidden" name="checkoutDate" value="${all.checkoutDate}">
					    <input type="hidden" name="roomTypeNo" value="${all.roomTypeNo}">
					    <input type="hidden" name="memNo" value="${all.memNo}">
					    <input type="hidden" name="roomAmount" value="${all.roomAmount}">
					    <input type="hidden" name="price" value="${all.price}">
					    <input type="hidden" name="paymentMethod" value="${all.paymentMethod}">
					    <input type="hidden" name="payStatus" value="${all.payStatus}">
					    <input type="hidden" name="orderStatus" value="${all.orderStatus}">
					    
						<button class="btn btn-success small-btn" style="font-size: 10px;" type="submit">修改</button>
					</form>

                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
		     <div class="pagination-container" id="pagination-container">
                <!-- 分页按钮将被插入这里 -->
            </div>
			<a class="btn btn-secondary btn-icon" href="${pageContext.request.contextPath}/back-end/roomorder/orderfirst.jsp">
                <i class="fas fa-arrow-left"></i> 返回
            </a>
		</div>
	</div>
 </div>	


    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
	$(document).ready(function() {
	    var rowsPerPage = 5;
	    var rows = $('#data-table tbody tr');
	    var rowsCount = rows.length;
	    var pageCount = Math.ceil(rowsCount / rowsPerPage); // 計算頁數
	    var numbers = $('#pagination-container');
	
	    // 初始化分頁數字
	    for (var i = 0; i < pageCount; i++) {
	        numbers.append('<a href="#" class="page-number">' + (i + 1) + '</a>');
	    }
	
	    // 顯示第一頁的數據
	    rows.hide();
	    rows.slice(0, rowsPerPage).show();
	
	    // 分頁按鈕點擊事件
	    $('.page-number').click(function(e) {
	        e.preventDefault();
	        $('.page-number').removeClass('active');
	        $(this).addClass('active');
	
	        // 顯示對應頁面的數據
	        var index = $(this).index();
	        rows.hide();
	        var start = index * rowsPerPage;
	        var end = start + rowsPerPage;
	        rows.slice(start, end).show();
	    });
	
	    $('.page-number:first').click(); // 點擊第一頁
	});
	</script>

</body>
</html>