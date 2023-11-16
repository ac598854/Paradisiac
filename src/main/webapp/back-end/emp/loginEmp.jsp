<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>員工登入</title>
</head>
<body>
<h1>員工登入</h1>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<form method="post" action="<%=request.getContextPath()%>/loginempN.do">
	員工編號<input type="text" name="empno"><br>
	員工密碼<input type="text" name="empPass">
	<input type="hidden" name="action" value="loginEmp">
	<input type="submit" value="登入">
	</form>

</body>
</html>