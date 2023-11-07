<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.members.model.*"%>
<%@ page import="com.paradisiac.members.controller.*"%>
<%@ page import="com.paradisiac.members.service.*"%>
<%@ page import="java.util.*"%>



<%
// MembersVO membersVO=null; 
// Integer memno=(Integer)session.getAttribute("memno"); 
// MembersService MembersSvc=new MembersService(); 
// membersVO = MembersSvc.getOneBymemno(memno); 
// pageContext.setAttribute("membersVO", membersVO);
// System.out.println("==check");
	MembersVO membersVO=null;
	membersVO=(MembersVO)session.getAttribute("membersVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>會員登入 - Login.jsp</title>

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
				<h3>會員登入 - Login.jsp</h3>
			</td>
		</tr>
	</table>

	<h3>錯誤檢查:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<div class="form form-signup">
		<form method="post" action="login.do" name="form1">
			<label for="singaccount">帳號</label> 
			<input type="text"
				placeholder="請輸入帳號" id="singaccount" name="memaccount" required >
								
			<label for="signpass">密碼</label> 
			<input type="password" id="signpass"
				placeholder="請輸入密碼" name="mempass" required>
			
			<input type="hidden" name="action" value="loginCheck">
			<input type="submit" class="form-btn" value="登入" /> 
				<br> <br>
			<a href='ForgetPass.jsp' class="link to-forgetpassk">忘記密碼</a> <br> <br>
			<a href='Signin.jsp' class="link to-signin">註冊會員</a> <br> <br>
		</form>
	</div>

</body>


<script>
     
</script>
</html>