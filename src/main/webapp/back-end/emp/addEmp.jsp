<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.employee.model.*"%>

<%
//見com.emp.controller.EmpServlet.java第238行存入req的empVO物件 (此為輸入格式有錯誤時的empVO物件)
EmpVO empVO = (EmpVO) request.getAttribute("empVO");
%>
--<%=empVO == null%>--
<!-- line 100 -->
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>員工資料新增 - addEmp.jsp</title>

<style>
table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
</style>

<style>
table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
}

table, th, td {
	border: 0px solid #CCCCFF;
}

th, td {
	padding: 1px;
}
</style>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>員工資料新增</h3>
			</td>
			<td>
				<h4>
					<a
						href="${pageContext.request.contextPath}/back-end/emp/select_page.jsp">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>資料新增:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post" ACTION="${pageContext.request.contextPath}/emp.do"
		name="form1">
		<table>
			<tr>
				<td>員工編號:</td>
				<td><input type="text" name="empno" id="f_date1"
					value="${param.empVO.getEmpno() == '' ? '' : empVO.getEmpno()}"></td>
			</tr>

			<jsp:useBean id="deptSvc" scope="page"
				class="com.paradisiac.department.service.DeptServiceImpl" />
			<tr>
				<td>部門:</td>
				<td><select size="1" name="deptno">
						<c:forEach var="deptVO" items="${deptSvc.all}">
							<option value="${deptVO.deptNo}">${deptVO.deptNo}-${deptVO.deptName}
						</c:forEach>
				</select></td>
			</tr>

			<tr>
				<td>員工狀態:</td>
				<td><input type="radio" name="empStatus" value="0"
					${empVO.getEmpStatus() == 0 ? 'checked' : ''} size="45" />凍結 <input
					type="radio" name="empStatus" value="1" checked="checked"
					} size="45" />未凍結</td>
			</tr>
			<tr>
				<td>員工姓名:</td>
				<td><input name="empName" id="f_date1"
					value="<%=(empVO == null) ? "" : empVO.getEmpName()%>"></td>
			</tr>
			<tr>
				<td>員工信箱:</td>
				<td><input type="TEXT" name="empMail"
					value="<%=(empVO == null) ? "" : empVO.getEmpMail()%>" size="45" /></td>
			</tr>
			<tr>
				<td>員工帳號:</td>
				<td><input type="TEXT" name="empAccount"
					value="<%=(empVO == null) ? "" : empVO.getEmpAccount()%>" size="45" /></td>
			</tr>
			<tr>
				<td>員工密碼:</td>
				<td><input type="TEXT" name="empPass"
					value="<%=(empVO == null) ? "" : empVO.getEmpPass()%>" size="45" /></td>
			</tr>
			<tr>
				<td>員工性別:</td>
				<td><input type="radio" name="empGender" value="1"
					${empVO.getEmpGender() == 1 ? 'checked' : ''} size="45" />男 <input
					type="radio" name="empGender" value="2"
					${empVO.getEmpGender() == 2 ? 'checked' : ''} size="45" />女 <input
					type="radio" name="empGender" value="3"
					${empVO.getEmpGender() == 3 ? 'checked' : ''} size="45" />其他</td>
			</tr>
			<tr>
				<td>員工電話:</td>
				<td><input type="TEXT" name="empPhone"
					value="<%=(empVO == null) ? "" : empVO.getEmpPhone()%>" size="45" /></td>
			</tr>

		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>

</body>



<script>
        
        
</script>
</html>