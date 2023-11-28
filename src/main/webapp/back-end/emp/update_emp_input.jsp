<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.employee.model.*"%>
<%@ page import="com.paradisiac.department.model.*"%>

<% 
   EmpVO empVO = (EmpVO) request.getAttribute("empVO");
   DeptVO deptVO = (DeptVO) request.getAttribute("deptVO");
%>
<%= empVO==null%>
<%= deptVO==null%>
<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>員工資料修改</title>

<style>
  <%--table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }--%>
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
<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
<table id="table-1">
	<tr><td>
		 <h3>員工資料修改</h3>
		 <h4><a href="back-end/emp/select_page.jsp">回員工首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="emp.do" name="form1">
<table>
	<tr>
		<td>員工編號:<font color=red><b>*</b></font></td>
		<td><%=empVO.getEmpno()%></td>
	</tr>
	<tr>
		<%-- <td>部門編號:</td>
		<td><input type="TEXT" name="deptno" value="<%=empVO.getDeptno()%>" size="45"/></td>
	</tr>--%>
	<tr>
		<td>員工狀態:</td> <%--若員工狀態1則男的radio打勾--%>
		<td><input type="radio" name="empStatus"  value="0" ${empVO.getEmpStatus() == 0 ? 'checked' : ''} size="45"/>凍結
			<input type="radio" name="empStatus"  value="1" ${empVO.getEmpStatus() == 1 ? 'checked' : ''} size="45"/>未凍結</td>
	</tr>
	<tr>
		<td>員工姓名:</td>
		<td><input name="empName" id="f_date1" value="<%=empVO.getEmpName()%>" ></td> 
	</tr>
	<tr>
		<td>員工信箱:</td>
		<td><input type="TEXT" name="empMail"   value="<%=empVO.getEmpMail()%>" size="45"/></td>
	</tr>
	<tr>
		<td>員工帳號:</td>
		<td><input type="TEXT" name="empAccount"  value="<%=empVO.getEmpAccount()%>" size="45"/></td>
	</tr>
	<tr>
		<td>員工密碼:</td>
		<td><input type="TEXT" name="empPass"  value="<%=empVO.getEmpPass()%>" size="45"/></td>
	</tr>
	<tr>
		<td>員工性別:</td>
		<td><input type="radio" name="empGender"  value="1" ${empVO.getEmpGender() == 1 ? 'checked' : ''} size="45"/>男
			<input type="radio" name="empGender"  value="2" ${empVO.getEmpGender() == 2 ? 'checked' : ''} size="45"/>女
			<input type="radio" name="empGender"  value="3" ${empVO.getEmpGender() == 3 ? 'checked' : ''} size="45"/>其他</td>
	</tr>
	<tr>
		<td>員工電話:</td>
		<td><input type="TEXT" name="empPhone"  value="<%=empVO.getEmpPhone()%>" size="45"/></td>
	</tr>

	<jsp:useBean id="deptSvc" scope="page" class="com.paradisiac.department.service.DeptServiceImpl" />
	<tr>
		<td>部門:<font color=red><b>*</b></font></td>
		<td><select size="1" name="deptno"> <%--deptno --%>
			<c:forEach var="deptVO" items="${deptSvc.all}" >
				<option value="${deptVO.deptNo}" ${(empVO.dept.deptNo==deptVO.deptNo)?'selected':'' } >${deptVO.deptName}<%--將本來的部門設為預設 --%>
				
			</c:forEach>
		</select></td>
	</tr>
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="empno" value="<%=empVO.getEmpno()%>">
<input type="submit" value="送出修改"></FORM>
</body>


<script>
        
        
</script>
</html>