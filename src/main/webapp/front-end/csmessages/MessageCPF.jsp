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
		<h1>請輸入您的問題</h1>
		<div class="row">
			<div class="col-12 text-right">
				<a
					href="<%=request.getContextPath()%>/front-end/csmessages/MessageLPF.jsp"
					class="btn btn-secondary">回上一頁</a>
			</div>

			<form id="customerForm" method="post" accept-charset="UTF-8"
				action="csmessages.do">
				<div class="form-group">
					<label for="cscontent" id="cscontentHead">申訴問題</label>
					<textarea class="form-control" name="cscontent" id="cscontent"
						rows="3"><c:out value="${CsVO.cscontent}" /></textarea>

					<br>
					<button type="button" class="btn btn-primary" id="submitButton">送出</button>
					<input type="hidden" name="action" value="insert_Front">
					<button type="reset" class="btn btn-secondary" id="resetButton">重設</button>
				</div>
			</form>
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