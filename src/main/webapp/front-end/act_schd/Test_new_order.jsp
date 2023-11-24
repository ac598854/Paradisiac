<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.schd.service.*"%>
<%@ page import="com.paradisiac.schd.model.*"%>
<!DOCTYPE html>

<%--	SchdServiceImpl svc = new SchdServiceImpl(); 
	Integer num = 10;
	Integer schno = 5;
	Integer orgin = svc.getSchdBySchdno(schno).getPaidNum();
	svc.generateNewOrder(schno, num);
	Integer update = svc.getSchdBySchdno(schno).getPaidNum();
	
--%>


<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>測試新增活動</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
 

</style>
</head>

<body>
<%@ include file="/front-end/index/guided.jsp" %>
	<div class="container">
        <h1 class="text-center">訂單送出畫面</h1>
        <div>
        <h2>新增訂單</h2>
 			<form  method="post" action="${pageContext.request.contextPath}/schd.do">
		      	<button type="submit" class="btn btn-primary" id="submitButton">報名</button>
		     	<input type="hidden" name="schdNo" value="5">
		     	<input type="hidden" name="num" value="5">
 				<input type="hidden" name="action" value="add_atn">
 			</form>
 		<h2>取消訂單</h2>
 			<form  method="post" action="${pageContext.request.contextPath}/schd.do">
		      	<button type="submit" class="btn btn-primary" id="submitButton">取消</button>
		     	<input type="hidden" name="schdNo" value="5">
		     	<input type="hidden" name="num" value="5">
 				<input type="hidden" name="action" value="reduce_atn">
 			</form>
 		
        </div>
                   
        


    </div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js">
     
    </script>



</body>
<%@ include file="/front-end/index/footer.jsp" %>
</html>
