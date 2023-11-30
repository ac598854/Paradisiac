<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>員工登入</title>

<style>
		body::before {
	    content: "";
	    background-image: url('<%=request.getContextPath()%>/images/albumcover.png'); 
	    background-size: cover;
	    background-position: center;
	    background-attachment: fixed;
	    position: fixed;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 100%;
	    opacity: 0.5; /* 透明度 */
	    z-index: -1;
		}

        .center-box {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.2); 
            border-radius: 10px;
            text-align: center;
        }
</style>
</head>
<body>
	<div class="center-box">
        <h1>Paradisiac後台管理系統</h1>
        <h2>員工登入</h2>
        <div>
	        <c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
        </div>
        <div>
	        <form method="post" action="<%=request.getContextPath()%>/loginempN.do">
				員工編號<input type="text" name="empno" style="margin: 10px;"><br>
				員工密碼<input type="password" name="empPass" style="margin: 5px;"><br>
				<input type="hidden" name="action" value="loginEmp">
				<input type="submit" value="登入" style="margin: 10px;">
			</form>
        </div>
        
    </div>
	
	

</body>
</html>