<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/main/main.css">
<title>Insert title here</title>
</head>
<body>
	<h1>部門列表</h1>
	<a>${pageContext.request.contextPath}</a>
	<c:if test="${deptPageQty > 0}">
  		<b><font color=red>第${currentPage}/${deptPageQty}頁</font></b>
	</c:if>
	<br>

	<table style="width:50%; text-align:center;">
		<tr>
			<th>部門編號</th>
			<th>部門名稱</th>

		</tr>
		<c:forEach var="dept" items="${deptList}">
			<tr>
				<td>${dept.deptNo}</td>
				<td>${dept.deptName}</td>
			</tr>
		</c:forEach>
	</table>
	<c:if test="${currentPage > 1}">
		<a href="${pageContext.request.contextPath}/dept.do?action=getAll&page=1">至第一頁</a>&nbsp;
	</c:if>
	<c:if test="${currentPage - 1 != 0}">
		<a href="${pageContext.request.contextPath}/dept.do?action=getAll&page=${currentPage - 1}">上一頁</a>&nbsp;
	</c:if>                                         
	<c:if test="${currentPage + 1 <= deptPageQty}"> 
		<a href="${pageContext.request.contextPath}/dept.do?action=getAll&page=${currentPage + 1}">下一頁</a>&nbsp;
	</c:if>                                         
	<c:if test="${currentPage != deptPageQty}">     
		<a href="${pageContext.request.contextPath}/dept.do?action=getAll&page=${deptPageQty}">至最後一頁</a>&nbsp;
	</c:if>                                         
	<br>

	<br><br>
	
	<a href="${pageContext.request.contextPath}/index.jsp">回首頁</a>	

</body>
</html>