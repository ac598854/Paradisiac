<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.paradisiac.csmessages.model.*"%>
<%@ page import="com.paradisiac.csmessages.service.*"%>
<%@ page import="com.paradisiac.csmessages.controller.*"%>
<!DOCTYPE html>
<%@ include file="/front-end/index/MembersMeta.jsp"%>
<html>
<head>

<title>會員客服訊息</title>


<%@ include file="/front-end/index/MembersBody.jsp" %>
<style>
 #resetButton { 
	color: #fff; 
 	background-color: #6c757d; 
 	border-color: #6c757d; 
 } 

 #cscontent, #csreply {
 	height: 300px; 
 } 

 #cscontentHead,#csreplyHead { 
 	font-size: 20px; 
 	font-weight: bold; 
 } 

 #csreply{ 
 border-radius: 10px;   
    background-color: #c0c0c0;  
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);  
     padding: 10px;   
} 
 </style>  
</head>
<body>


			<div class="container mt-3">
				<h1>請輸入您的問題</h1>
				<div class="row">
					<div class="col-12 text-right">
						<a
							href="<%=request.getContextPath()%>/front-end/csmessages/MessageLPF.jsp"
							class="btn btn-secondary">回上一頁</a>
					</div>
					<!-- 第一部分表單 -->
					<form id="customerForm" method="post" accept-charset="UTF-8"
						action="csmessages.do">

						<div class="form-group">
							<label for="cscontent" id="cscontentHead">申訴問題</label>
							<textarea class="form-control" name="cscontent" id="cscontent"
								rows="3"><c:out value="${CsVO.cscontent}" /></textarea>

						</div>

					</form>
					<br>
					<!-- 第二部分 -->
					<form>
						<div class="form-group">
							<label for="csreply" id="csreplyHead">客服回覆</label>
							<p id="csreply">${CsVO.csreply}</p>
						</div>
						<div class="form-group">
							<label for="csredate">回覆時間</label> <input type="text"
								class="form-control" id="csredate" value="${CsVO.csredate}"
								readonly>
						</div>
					</form>
					
				</div>

			</div>

</body>
<link rel="stylesheet" asset="eduser.css"
	href="chrome-extension://mjdbhokoopacimoekfgkcoogikbfgngb/assets/eduser.css">
</html>