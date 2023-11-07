<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
    <title>GetAll</title>
<!--     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
    <style>



    </style>
    
    
</head>
<body>

    <div class="container">
        <h3>搜尋全部</h3>
        <table class="table table-bordered small-table" style="font-size: 12px;">
            <thead>
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
            </thead>
            <tbody>
                <c:forEach var="all" items="${all}">
                    <tr>
                    	<td>${all.roomTypeNo}</td>
	                    <td>${all.roomName}</td>
	                    <td>${all.rtype}</td>
	                    <td>${all.roomTotal}</td>
	                    <td>${all.price}</td>
	                    <td>${all.normalPrice}</td>
	                    <td>${all.holidayPrice}</td>
	                    <td>${all.bridgeHolidayPrice}</td>
	                    <td>${all.notice}</td>
	                    <td>${all.facility}</td>
	                    <td>${all.rTypeStatus}</td>
						<td>
					<form method="post" action="${pageContext.request.contextPath}/back-end/roomtype/updatetype.jsp">
					    <input type="hidden" name="roomTypeNo" value="${all.roomTypeNo}">
					    <input type="hidden" name="roomName" value="${all.roomName}">
					    <input type="hidden" name="rtype" value="${all.rtype}">
					    <input type="hidden" name="roomTotal" value="${all.roomTotal}">
					    <input type="hidden" name="price" value="${all.price}">
					    <input type="hidden" name="normalPrice" value="${all.normalPrice}">
					    <input type="hidden" name="holidayPrice" value="${all.holidayPrice}">
					    <input type="hidden" name="bridgeHolidayPrice" value="${all.bridgeHolidayPrice}">
					    <input type="hidden" name="notice" value="${all.notice}">
					    <input type="hidden" name="facility" value="${all.facility}">
					    <input type="hidden" name="rTypeStatus" value="${all.rTypeStatus}">
					    
						<button class="btn btn-success small-btn" style="font-size: 10px;" type="submit">修改</button>
					</form>

                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        
	
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/back-end/roomtype/typefirst.jsp">返回</a>
    </div>



<!--     <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script> -->
<!--     <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script> -->
<!--     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
</body>
</html>