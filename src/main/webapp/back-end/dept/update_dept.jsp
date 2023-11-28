<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<meta charset="UTF-8">
<link rel="stylesheet" href="">
<title>部門列表</title>
<style>
table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
	min-width: 60%;
}

div#box {
	margin: auto;
}

table {
	width: 30%;
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

td form {
	display: flex;
	justify-content: space-around; /* 按鈕橫向排列 */
}

td form input[type="submit"] {
	width: 100%; /* 設定按鈕寬度 */
}
</style>
</head>
<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
	<div id="box">
		<table id="table-1">
			<tr>
				<td>
					<h3>更新部門 - UpdatelistAllDepts</h3>
					<h4>
						<a href="${pageContext.request.contextPath}/back-end/dept/select_dept_page.jsp">回首頁</a>							
					</h4>
				</td>
			</tr>
		</table>
		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
			<font style="color:red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color:red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/dept.do"
			style="margin-bottom: 0px;">
			<table style="width: 30%; text-align: center;">
				<tr>
					<th>部門編號</th>
					<th>部門名稱</th>
					<th>部門狀態</th>
					<th>功能編號</th>
				</tr>

				<tr>
					<td><input type="hidden" name="deptNo" value="${deptVO.deptNo}">${deptVO.deptNo}</td>
					<td><input type="text" name="deptName" value="${deptVO.deptName}"></td>
					<td><input type="radio" name="deptStatus" value="false"
						${deptVO.isDeptStatus()? '' : 'checked'} size="45" />凍結 
						<input type="radio" name="deptStatus" value="true"						
						${deptVO.isDeptStatus()? 'checked' : ''} size="45" />正常</td>
					 <td>
					 <jsp:useBean id="fucSvc" scope="page"
							class="com.paradisiac.fuc.service.Fuc_ServiceImpl" /> 
					<select size="1" name="funNo">						
							<c:forEach var="fuc" items="${fucSvc.all}">
								<option  value="${fuc.fucNo}"
									${(fuc.fucNo==deptVO.fucNo)?'selected':'' }>${fuc.fucNo}-${fuc.fucName}
							</c:forEach>
					</select></td>
				</tr>

			</table>
			<input type="hidden" name="action" value="update">
			<input type="submit" value="送出">
		</FORM>
	</div>




</body>
</html>