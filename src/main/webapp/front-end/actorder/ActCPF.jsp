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

.form-control {
	display: block;
	width: 100%;
	height: 38px;
	padding: 7px 12px;
	font-size: 14px;
	line-height: 1.42857143;
	color: #555555;
	background-color: #ffffff;
	background-image: none;
	border: 1px solid #e7e7e7;
	border-radius: 4px;
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
					href="<%=request.getContextPath()%>/back-end/members/MembersLPB.jsp"
					class="btn btn-secondary">回上一頁</a>
			</div>
		</div>
		<div class="container">
			<div class="table-responsive">
				<form method="post" action="members.do" name="form1"
					enctype="multipart/form-data">
					<table class="table">

						<tr>
							<td>活動訂單編號:<font color="red"><b>*</b></font></td>
							<td><input type="text" class="form-control" id="memno"
								name="memno" value="${membersVO.memno}" readonly></td>
						</tr>
						<tr>
							<td>會員編號:</td>
							<td><select name="memstatus"
								class="form-control browser-default custom-select">
									<option value="true"
										${membersVO.memstatus == true ? 'selected' : ''}>正常</option>
									<option value="false"
										${membersVO.memstatus == false ? 'selected' : ''}>凍結</option>
							</select></td>
						</tr>

						<tr>
							<td>檔期編號:<font color="red"><b>*</b></font></td>
							<td><input type="text" name="memname" class="form-control"
								class="custom-file-input" value="${membersVO.memname}" size="45"
								readonly /></td>
						</tr>
						<tr>
							<td>訂單日期:<font color="red"><b>*</b></font></td>
							<td><input type="date" name="memaccount"
								class="form-control" value="${membersVO.memaccount}" size="45"
								readonly /></td>
						</tr>
						<tr>
							<td>報名人數:<font color="red"><b>*</b></font></td>
							<td><input type="date" name="memaccount"
								class="form-control" value="${membersVO.memaccount}" size="45"
								readonly /></td>
						</tr>
						<tr>
							<td>訂單狀態:</td>
							<td><select name="memgender"
								class="form-control browser-default custom-select" disabled>
									<option value="1"
										<c:if test="${membersVO.memgender == 1}">selected</c:if>>男</option>
									<option value="2"
										<c:if test="${membersVO.memgender == 2}">selected</c:if>>女</option>
									<option value="3"
										<c:if test="${membersVO.memgender == 3}">selected</c:if>>其他</option>
							</select></td>
						</tr>
						<tr>
							<td>訂單總金額:<font color="red"><b>*</b></font></td>
							<td><input type="text" name="memid" class="form-control"
								value="${membersVO.memid}" size="45" readonly /></td>
						</tr>

						<tr>
							<td>參加人姓名A:<font color="red"><b>*</b></font></td>
							<td><input type="text" name="memphone" class="form-control"
								value="${membersVO.memphone}" size="45" readonly /></td>
						</tr>
						<tr>
							<td>參加人身分證字號A:<font color="red"><b>*</b></font></td>
							<td><input type="text" name="memphone" class="form-control"
								value="${membersVO.memphone}" size="45" readonly /></td>
						</tr>
						<tr>
							<td>參加人電話A:<font color="red"><b>*</b></font></td>
							<td><input type="text" name="memphone" class="form-control"
								value="${membersVO.memphone}" size="45" readonly /></td>
						</tr>

					</table>
					<br> <input type="hidden" name="action"
						value="update_Back_Status"> <input type="submit"
						class="btn btn-primary" value="送出修改">
				</form>
			</div>
		</div>
		<br>
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