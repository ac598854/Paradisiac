<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="">
<%--${pageContext.request.contextPath}/main/main.css --%>
<title>Insert title here</title>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }
    
    th, td {
        border: 1px solid #000;
        padding: 8px;
        text-align: center;
    }
    
    th {
        background-color: #ccc;
    }
    
    th:nth-child(1), td:nth-child(1){
        width: 20%; /* 設定固定欄位寬度 */
    }
    
    th:nth-child(2), td:nth-child(2),
    th:nth-child(3), td:nth-child(3){
        width: 40%; /* 設定固定欄位寬度 */
    }


</style>
</head>
<body>
	<h1>部門列表</h1>
	<h2>部門員工明細</h2>
	<%-- 
	<c:if test="${deptPageQty > 0}">
  		<b><font color=red>第${currentPage}/${deptPageQty}頁</font></b>
	</c:if>--%>
	<br>
	
	<div>
		<table class= dept style="width:30%; text-align:center;">
			<!-- 部門資料 -->
			<tr>
		        <th><label for="deptName">部門名稱:${deptVO.deptName}</label></th>
		    </tr>
		    <tr>
		        <td><label for="deptNo">部門編號:${deptVO.deptNo}</label></td>
		    </tr>
		</table>
		
		    <!-- 員工資料 -->
		 <table style="width:30%; text-align:center;">  
			<tr>
		        <th><label for="empno">員工編號</label></th>
		        <th><label for="empName">姓名</label></th>
		       	<th><label for="empMail">電子信箱</label></th>

			</tr>
			<c:forEach var="emp" items="${deptEmpSet}">
			   	<tr>
			   		<td>${emp.empno}</td>
			   		<td>${emp.empName}</td>
			   		<td>${emp.empMail}</td>   
			    </tr>

			    
			</c:forEach>
		</table>
	</div>
	

<%-- 
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
--%>                                         
	<br>

	<br><br>
	<a href="${pageContext.request.contextPath}/back-end/dept/select_dept_page.jsp">回首頁</a>
</body>
</html>