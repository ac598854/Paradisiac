<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.department.model.*"%>
<% DeptVO deptVO = (DeptVO) request.getAttribute("deptVO");%>


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
	 
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<jsp:useBean id="deptSvc" scope="page" class="com.paradisiac.department.service.DeptServiceImpl" />
	<form action="${pageContext.request.contextPath}/dept.do" method="post">
		<%--<p><label>部門名稱模糊查詢：</label></p>
		<input type="text" name="ename"><br>--%>
		<p><label>部門名稱：</label></p>
		
		<select name="deptname">
		  <c:forEach var="deptVO" items="${deptSvc.all}" > 
          	<option value="${deptVO.deptNo}">${deptVO.deptName}
          </c:forEach>
		</select>
		<input type="hidden" name="action" value="getOne_For_Display">
        <input type="button" value="送出">       
	</form>
	
	<form action="${pageContext.request.contextPath}/dept.do" method="post">
		<table style="width:30%; text-align:center;">
			<!-- 部門資料 -->
			<tr>
				<th>部門名稱</th>
				<th>部門狀態</th>
				<th>功能設定</th>
			</tr>
			<jsp:useBean id="fucSvc" scope="page" class="com.paradisiac.fuc.service.Fuc_ServiceImpl" />
			<tr>
				<td><input name="deptName" value="<%= (deptVO==null)? "" : deptVO.getDeptName()%>" ></td>
				<td>
					<input type="radio" name="deptStatus"  value="0" ${deptVO.getDeptStatus() == 0 ? 'checked' : ''} size="45"/>凍結
					<input type="radio" name="deptStatus"  value="1" checked="checked" size="45"/>未凍結 <%--預設未凍結 --%>
				</td>
				<td><input name="fucNo" value="<%= (deptVO==null)? "" : deptVO.getFucNo()%>" ></td>

				<%--<td><select name="fucNo">
					  	<c:forEach var="fucVO" items="${fucSvc.all}" > 
			          	<option value="${fucVO.fucNo}">${fucVO.fucName}
			          	</c:forEach>
					</select>
				</td>--%>
			</tr>

		</table>
		<input type="hidden" name="action" value="insert">
		<input type="submit" value="送出新增">
	</form>
	
	
</body>
</html>