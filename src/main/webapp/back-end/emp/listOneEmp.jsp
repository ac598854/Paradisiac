<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.paradisiac.employee.model.*"%>
<%@ page import="com.paradisiac.department.model.*"%>
<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%
  EmpVO empVO = (EmpVO) request.getAttribute("empVO"); //EmpServlet.java(Concroller), �s�Jreq��empVO����

%>

<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<title>���u���</title>

<style>
<%--
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }--%>
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 600px;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
<table id="table-1">
	<tr><td>
		 <h3>���u���</h3>
		 <h4><a href="back-end/emp/select_page.jsp">�^���u����</a></h4>
	</td></tr>
</table>

<table>
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

	<tr>
		<%
		String ge = "";	
		switch(empVO.getEmpGender()){
		case 1: 
			ge = "�k";
			break;
		case 2:
			ge = "�k";
			break;
		case 3:
			ge = "��L";
			break;
		}
		
		String st = "";
		switch(empVO.getEmpStatus()){
		case 0:
			st = "�ᵲ";
			break;
		case 1:
			st = "���ᵲ";
			break;		
		}	
		%>
		<td><%=empVO.getEmpno()%></td>
		<td><%=empVO.getDept().getDeptNo()%><%=empVO.getDept().getDeptName()%></td>
		<td><%=st%></td>
		<td><%=empVO.getEmpName()%></td>
		<td><%=empVO.getEmpMail()%></td>
		<td><%=empVO.getEmpAccount()%></td>
		<td><%=empVO.getEmpPass()%></td>
		<td><%=ge%></td>
		<td><%=empVO.getEmpPhone()%></td>

	</tr>
</table>

</body>
</html>