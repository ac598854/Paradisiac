<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.photoAlbum.model.*"%>

<!DOCTYPE html>

<html>
<head>
<%@ include file="/front-end/index/MembersMeta.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>會員相簿管理</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
		body::before {
	    content: "";
	    background-image: url('<%=request.getContextPath()%>/images/albumcover.png'); 
	    background-size: cover;
	    background-position: center;
	    background-attachment: fixed;
	    position: fixed;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 100%;
	    opacity: 0.5; /* 透明度 */
	    z-index: -1;
		}

        .center-box {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.2); 
            border-radius: 10px;
            text-align: center;
        }
</style>
	<title>會員紀念相簿</title>
<%@ include file="/front-end/index/MembersMeta.jsp"%>
</head>
<body>
<%@ include file="/front-end/index/MembersBody.jsp"%>
	<div class="center-box">
        <h1>歡迎蒞臨Paradisiac</h1>
        <p style="font-size: 20px;">我們將在您的旅遊或活動結束後建立您的專屬相簿</p>
    </div>
    
</body>
<script>
$(document).ready(function(){
    $.ajax({
        type: "POST",
        url: "<%=request.getContextPath()%>/front-end/members/members.do?action=indexLogin",
        success: function(data) {
            const responseMessage = parseInt(data);
            var  contextPath='<%=request.getContextPath()%>
	';
										var guided = contextPath
												+ '/front-end/index/guided.jsp';
										var guidedSignout = contextPath
												+ '/front-end/index/guidedSignout.jsp';
										if (responseMessage === 1) {
											$("#dynamicContent").load(guided);
										} else if (responseMessage === 0) {

											$("#dynamicContent").load(
													guidedSignout);
										}
									},
									error : function(error) {
										console.log("AJAX error:", error);
									}
								});
					})
</script>


</html>
