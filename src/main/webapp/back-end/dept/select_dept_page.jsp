<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Hibernate Demo</title>
</head>
<body>
	<h1>部門管理</h1>
	<a href="${pageContext.request.contextPath}/dept.do?action=getAll">查詢所有部門</a>
	<br><br>
	 
	<%-- <h3><b>複合查詢 (使用 Criteria Query)：</b></h3>--%>
	
	<jsp:useBean id="deptSvc" scope="page" class="com.paradisiac.department.service.DeptServiceImpl" />
	<form action="${pageContext.request.contextPath}/dept.do" method="post">
		<%--<p><label>部門名稱模糊查詢：</label></p>
		<input type="text" name="ename"><br>--%>
		<p><label>部門名稱：</label></p>
		
		<select name="deptname">
		  <c:forEach var="deptVO" items="${deptSvc.all}" > 
          	<option value="${deptVO.deptNo}">${deptVO.deptName}
          </c:forEach>
          
			<!--<option value="">選取部門</option>
			  <option value="sales">業務部</option>
			<option value="roomteam">房務部</option>
			<option value="hr">人資部</option>
			<option value="planning">企劃部</option>-->
		</select>

		
		<input type="hidden" name="action" value="getOne_For_Display">
        <input type="button" value="送出">

	</form>
</body>
</html>