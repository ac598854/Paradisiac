<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<meta charset="UTF-8">
<link rel="stylesheet" href="">
<%--${pageContext.request.contextPath}/main/main.css --%>
<title>部門資料 - listOneDept</title>
<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
    margin: auto;
  }
  
    table#deptContent {
        width: 100%;
        border-collapse: collapse;
        margin: auto;
    }
    table#deptContent th {
        background-color: #ccc;
    }
    
    th, td {
        border: 1px solid #000;
        padding: 8px;
        text-align: center;
    }
    table#empContent {
    	margin: auto;
    }
    table#empContent th {
        background-color: #ccc;
    }
    
    table#empContent th:nth-child(1), td:nth-child(1){
        width: 20%; /* 員工編號設定固定欄位寬度 */
    }
    table#empContent th:nth-child(2), td:nth-child(2){
        width: 20%; /* 員工編號設定固定欄位寬度 */
    }
    table#empContent
    th:nth-child(3), td:nth-child(3),
    th:nth-child(4), td:nth-child(4){
        width: 30%; /* 姓名,信箱設定固定欄位寬度 */
    }


</style>
</head>
<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
<table id="table-1">
	<tr><td>
		 <h3>部門資料 - listOneDept</h3>
		 <h4><a href="${pageContext.request.contextPath}/back-end/dept/select_dept_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

	<div>
		<table id="deptContent"class= dept style="width:30%; text-align:center;">
			<!-- 部門資料 -->
			<tr>
		        <th><label for="deptName">部門名稱:${deptVO.deptName}</label></th>
		    </tr>
		    <tr>
		        <td><label for="deptNo">部門編號:${deptVO.deptNo}</label></td>
		    </tr>
		    <tr>
		        <td><label for="deptNo">功能編號:${deptVO.fucVO.fucNo}-${deptVO.fucVO.fucName}</label></td>
		    </tr>

		</table>
		
		    <!-- 員工資料 -->
		 <table style="width:30%; text-align:center;" id="empContent">  
			<tr>
		        <th><label for="empno">員工編號</label></th>
		        <th><label for="empStatus">員工狀態</label></th>
		        <th><label for="empName">姓名</label></th>
		       	<th><label for="empMail">電子信箱</label></th>

			</tr>
			<c:forEach var="emp" items="${deptEmpSet}">
			   	<tr>
			   		<td>${emp.empno}</td>
			   		<td>${emp.empStatus==0? '凍結' : '正常'}</td>
			   		<td>${emp.empName}</td>
			   		<td>${emp.empMail}</td>   
			    </tr>

			    
			</c:forEach>
		</table>
	</div>


</body>
</html>