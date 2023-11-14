<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.employee.model.*"%>
<%@ page import="com.paradisiac.employee.service.*"%>
<%@ page import="com.paradisiac.department.model.*"%>


<%
    EmpService empSvc = new EmpService();
    List<EmpVO> list = empSvc.getAll();
    pageContext.setAttribute("list",list);

%>


<html>
<head>
<title>所有員工資料 - listAllEmp.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
    min-width: 60%;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
    table-layout: auto;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table#table-2 {
	width: 60%;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;

  }
  table, th, td {
    border: 1px solid #CCCCFF;
	white-space: nowrap; 
	text-align: center;
  }
    th, td {
    padding: 5px;
    text-align: center;
  }
  
    table#table-1, table#table-2 {
    table-layout: auto;
  }

</style>

</head>
<body bgcolor='white'>


<table id="table-1">
	<tr><td>
		 <h3>所有員工資料 - listAllEmp.jsp</h3>
		 <h4><a href="select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<table id="table-2">
	<tr>
		<th>員工編號</th>
		<th>部門編號</th>
		<th>員工狀態</th>
		<th>員工姓名</th>
		<th>員工信箱</th>
		<th>員工帳號</th>
		<th>員工密碼</th>
		<th>員工性別</th>
		<th>員工電話</th>
	</tr>
<%@ include file="page1.file" %> 
	
	<c:forEach var="empVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">

		<tr>
			<td>${empVO.empno}</td>
			<td>${empVO.dept.deptNo}-${empVO.dept.deptName}</td>
			<%--<td>${empVO.dept.deptNo}-${empVO.dept.deptName}</td> <%--[${empVO.deptVO.deptName}] --%> 
			<td>${empVO.empStatus== 0 ? '凍結' : (empVO.empStatus == 1 ? '未凍結' : '其他')}</td>
			<td>${empVO.empName}</td>
			<td>${empVO.empMail}</td>
			<td>${empVO.empAccount}</td>
			<td>${empVO.empPass}</td> 
			<td>${empVO.empGender== 1 ? '男' : (empVO.empGender == 2 ? '女' : '其他')}</td>
			<td>${empVO.empPhone}</td>

			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="empno"  value="${empVO.empno}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>

		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>