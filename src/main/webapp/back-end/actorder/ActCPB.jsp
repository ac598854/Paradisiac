<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.paradisiac.csmessages.model.*"%>
<%@ page import="com.paradisiac.csmessages.service.*"%>
<%@ page import="com.paradisiac.csmessages.controller.*"%>
<!DOCTYPE html>

<html>
<head>
<%@ include file="/front-end/index/MembersMeta.jsp"%>
<title>會員客服訊息</title>
<style>
#resetButton {
	color: #fff;
	background-color: #6c757d;
	border-color: #6c757d;
}

#cscontent, #csreply {
	height: 300px;
}

#cscontentHead {
	font-size: 20px;
	font-weight: bold;
}
</style>
</head>

<body>
	<%@ include file="/front-end/index/MembersBody.jsp"%>
	<div class="container mt-3">
		<h1>活動訂單資訊</h1>
		<div class="row">
			<div class="col-12 text-right">
				<a
					href="<%=request.getContextPath()%>/front-end/csmessages/MessageLPF.jsp"
					class="btn btn-secondary">回上一頁</a>
			</div>

				<form method="post" action="members.do" name="form1"
		enctype="multipart/form-data">
		<table>
			<tr>
				<td>活動訂單編號:<font color="red"><b>*</b></font></td>
				<td><input type="hidden" name="memno"
					value="${membersVO.memno}" readonly size="45" />${membersVO.memno}</td>
			</tr>
			<tr>
				<td>會員編號:</td>
				<td><select name="memstatus">
						<option value="true"
							${membersVO.memstatus == true ? 'selected' : ''}>訂單成立</option>
						<option value="false"
							${membersVO.memstatus == false ? 'selected' : ''}>取消訂單</option>
				</select></td>
			</tr>

			<tr>
				<td>檔期編號:<font color="red"><b>*</b></font></td>
				<td><input type="text" name="memname"
					value="${membersVO.memname}" size="45" readonly /></td>
			</tr>
			<tr>
				<td>處理員工(編號):<font color="red"><b>*</b></font></td>
				<td><input type="text" name="memmail"
					value="${membersVO.memmail}" size="45" readonly /></td>
			</tr>
			<tr>
				<td>訂單日期:<font color="red"><b>*</b></font></td>
				<td><input type="text" name="memmail"
					value="${membersVO.memmail}" size="45" readonly /></td>
			</tr>
			<tr>
				<td>報名人數:<font color="red"><b>*</b></font></td>
				<td><input type="text" name="memaccount"
					value="${membersVO.memaccount}" size="45" readonly /></td>
			</tr>
			<tr>
				<td>訂單狀態:<font color="red"><b>*</b></font></td>
				<td><input type="text" name="memaccount"
					value="${membersVO.memaccount}" size="45" readonly /></td>
			</tr>
			<tr>
				<td>付款方式:<font color="red"><b>*</b></font></td>
				<td><input type="text" name="memaccount"
					value="${membersVO.memaccount}" size="45" readonly /></td>
			</tr>
			<tr>
				<td>付款狀態:<font color="red"><b>*</b></font></td>
				<td><input type="text" name="memaccount"
					value="${membersVO.memaccount}" size="45" readonly /></td>
			</tr>
			<tr>
				<td>訂單總金額:<font color="red"><b>*</b></font></td>
				<td><input type="text" name="memaccount"
					value="${membersVO.memaccount}" size="45" readonly /></td>
			</tr>
			<tr>
				<td>參加人姓名A:<font color="red"><b>*</b></font></td>
				<td><input type="text" name="mempass"
					value="${membersVO.mempass}" size="45" readonly /></td>
			</tr>
			<tr>
				<td>參加人身分證字號A:<font color="red"><b>*</b></font></td>
				<td><input type="text" name="mempass"
					value="${membersVO.mempass}" size="45" readonly /></td>
			</tr>
			<tr>
				<td>參加人電話A:<font color="red"><b>*</b></font></td>
				<td><input type="text" name="mempass"
					value="${membersVO.mempass}" size="45" readonly /></td>
			</tr>

		</table>
		<br> <input type="hidden" name="action"
			value="update_Back_Status"> <input type="submit" value="送出修改">

	</FORM>
			<br>
		</div>
	</div>

	<!-- Menu Toggle Script -->
	<script>
		// 送出訊息確認
		document.getElementById('submitButton').addEventListener('click',
				function() {
					if (confirm('送出申訴訊息？')) {
						document.getElementById('customerForm').submit();
					}
				});
	</script>
</body>
</html>