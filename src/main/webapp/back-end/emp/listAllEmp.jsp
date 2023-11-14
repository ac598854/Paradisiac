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
<title>�Ҧ����u��� - listAllEmp.jsp</title>

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
		 <h3>�Ҧ����u��� - listAllEmp.jsp</h3>
		 <h4><a href="select_page.jsp">�^����</a></h4>
	</td></tr>
</table>

<table id="table-2">
	<tr>
		<th>���u�s��</th>
		<th>�����s��</th>
		<th>���u���A</th>
		<th>���u�m�W</th>
		<th>���u�H�c</th>
		<th>���u�b��</th>
		<th>���u�K�X</th>
		<th>���u�ʧO</th>
		<th>���u�q��</th>
	</tr>
<%@ include file="page1.file" %> 
	
	<c:forEach var="empVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">

		<tr>
			<td>${empVO.empno}</td>
			<td>${empVO.dept.deptNo}-${empVO.dept.deptName}</td>
			<%--<td>${empVO.dept.deptNo}-${empVO.dept.deptName}</td> <%--[${empVO.deptVO.deptName}] --%> 
			<td>${empVO.empStatus== 0 ? '�ᵲ' : (empVO.empStatus == 1 ? '���ᵲ' : '��L')}</td>
			<td>${empVO.empName}</td>
			<td>${empVO.empMail}</td>
			<td>${empVO.empAccount}</td>
			<td>${empVO.empPass}</td> 
			<td>${empVO.empGender== 1 ? '�k' : (empVO.empGender == 2 ? '�k' : '��L')}</td>
			<td>${empVO.empPhone}</td>

			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�ק�">
			     <input type="hidden" name="empno"  value="${empVO.empno}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>

		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>