<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
    <title>修改</title>
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
			<%@ include file="/back-end/index/ManagerBody.jsp" %>
  <div class="container">
     <div class="row justify-content-center">
        	<div class="col-lg-7">
        <h1>修改房型資料</h1>
        <div class="card">
          <form method="post" action="${pageContext.request.contextPath}/type/type.do?action=updatetype" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="roomTypeNo">房型編號：</label>
            	<input type="text" class="form-control" id="faqNo" name="roomTypeNo" value="${param.roomTypeNo}" readonly>
            </div>
 

	        <div class="form-group">
			    <label for="roomName">房型名稱：</label>
			    <select class="form-control" id="roomName" name="roomName">
			        <option value="標準單人房" <c:if test="${param.roomName eq '標準單人房'}">selected</c:if>>標準單人房</option>
			        <option value="標準雙人房" <c:if test="${param.roomName eq '標準雙人房'}">selected</c:if>>標準雙人房</option>
			        <option value="海景雙人房" <c:if test="${param.roomName eq '海景雙人房'}">selected</c:if>>海景雙人房</option>
			        <option value="家庭四人房" <c:if test="${param.roomName eq '家庭四人房'}">selected</c:if>>家庭四人房</option>
			        <option value="家庭八人房" <c:if test="${param.roomName eq '家庭八人房'}">selected</c:if>>家庭八人房</option>
			        <option value="山景四人房" <c:if test="${param.roomName eq '山景四人房'}">selected</c:if>>山景四人房</option>

			    </select>
			</div>
	            
			<div class="form-group">
			    <label for="rtype">房間類別：</label>
			    <select class="form-control" id="rtype" name="rtype">
			        <option value="單人房" <c:if test="${param.rtype eq '單人房'}">selected</c:if>>單人房</option>
			        <option value="二人房" <c:if test="${param.rtype eq '二人房'}">selected</c:if>>二人房</option>
			        <option value="四人房" <c:if test="${param.rtype eq '四人房'}">selected</c:if>>四人房</option>
			        <option value="八人房" <c:if test="${param.rtype eq '八人房'}">selected</c:if>>八人房</option>
			    </select>
			</div>


            <div class="form-group">
                <label for="roomTotal">總數：</label>
                <input type="number" class="form-control" id="faqContent" name="roomTotal" value="${param.roomTotal}" min="1">
            </div>
             <div class="form-group">
                    <label for="price">價格：</label>
                    <input type="number" class="form-control" id="price" name="price" value="${param.price}" min="1">
                </div>
                       <div class="form-group">
                <label for="normalPrice">普通價格：</label>
                <input type="number" class="form-control" id="normalPrice" name="normalPrice" value="${param.normalPrice}" min="1">
            </div>
            
                        <div class="form-group">
                <label for="holidayPrice">節日價格：</label>
                <input type="number" class="form-control" id="holidayPrice" name="holidayPrice" value="${param.holidayPrice}" min="1">
            </div>
                        <div class="form-group">
                <label for="bridgeHolidayPrice">連續假期價格：</label>
                <input type="number" class="form-control" id="bridgeHolidayPrice" name="bridgeHolidayPrice" value="${param.bridgeHolidayPrice}" min="1">
            </div>
                        <div class="form-group">
                <label for="notice">備註：</label>
                <input type="text" class="form-control" id="notice" name="notice" value="${param.notice}">
            </div>
                        <div class="form-group">
                <label for="facility">設施：</label>
                <input type="text" class="form-control" id="facility" name="facility" value="${param.facility}">
            </div>      
            
            <div class="form-group">
                <label for="rTypeStatus">房間狀態：</label>
			    <select class="form-control" id="rTypeStatus" name="rTypeStatus">
			        <option value="true" <c:if test="${param.rTypeStatus eq 'true'}">selected</c:if>>true</option>
			        <option value="false" <c:if test="${param.rTypeStatus eq 'false'}">selected</c:if>>false</option>
			    </select>
			</div>
            
            <button class="btn btn-success" type="submit">確定修改</button>
               <a class="btn btn-secondary" href="javascript:history.back()">取消修改</a>
        </form>

    </div>
     <a class="btn btn-secondary" href="typefirst.jsp">返回</a>
   </div>      
       
</div>
</div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
		function validateForm(){
		    var notice = document.getElementById("notice").value;
		    var facility = document.getElementById("facility").value;
		    
		    var price = document.getElementById("price").value;
		    var normalPrice = document.getElementById("normalPrice").value;
		    var holidayPrice = document.getElementById("holidayPrice").value;
		    var bridgeHolidayPrice = document.getElementById("bridgeHolidayPrice").value;
		  
		    var roomTotal = document.getElementById("faqContent").value;
		    if (roomTotal === ""  ) {
		        alert("房間總數未填寫");
		        return false; 
		    }
		    
		    if (notice === "" || facility ==="" ) {
		        alert("設施或備註未填寫");
		        return false; 
		    }
		    if (price === "" || normalPrice ==="" || holidayPrice ==="" || bridgeHolidayPrice ==="" ) {
		        alert("價錢未填寫完整");
		        return false; 
		    }
		    return true; 
		}
	</script>
</body>
</html>