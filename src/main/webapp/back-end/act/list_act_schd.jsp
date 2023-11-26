<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.act.service.*"%>
<%@ page import="com.paradisiac.act.model.*"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>顯示活動檔期</title>
<style>
		.container {
        padding-top: 65px;
        padding-left: 255px;
        border: 1px solid black;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            border: 1px solid black;
            
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
            border: 1px solid black;
        }

        th {
            background-color: #f2f2f2;
            border: 1px solid black;
        }

        .form-section {
            margin-bottom: 20px;
        }
              
        .form-section-act{
         margin-bottom: 20px;
        }
        
        .form-section-act th, .form-section-act td {
    	text-align: center;
  		}

        h2 {
            margin-bottom: 10px;
        }

        .modify-button {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 8px 16px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 4px 2px;
            transition-duration: 0.4s;
            cursor: pointer;
            border-radius: 4px;
        }

        .modify-button:hover {
            background-color: white;
            color: black;
            border: 1px solid #4CAF50;
        }
        
       


</style>

</head>
<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
<div class="container">
	<div style="text-align: center; padding-right:0;">
		<form method="post" action="${pageContext.request.contextPath}/act.do">
			<input type="hidden" name="action" value="getAll">
			<button class="btn btn-primary mr-2 btn-separator" style="margin-bottom: 15px; font-size: 15px;">活動類別管理首頁</button>		
		</form>
			
	</div>

    <table class="form-section-act" style="border: 1px solid black;">
        <tr>
            <th>活動編號</th>
            <th>活動名稱</th>
            <th>活動狀態</th>
        </tr>
        <tr>
            <td>${actVO.actNo}</td>
            <td>${actVO.actName}</td>
            <td>${actVO.actStatus? '上架':'下架'}</td>
        </tr>
    </table>

    <table class="form-section">
        <tr>
            <th colspan="14" style="text-align: center;">檔期列表</th>
        </tr>
        <tr>
            <th>檔期編號</th>
            <th>上架日期</th>
            <th>下架日期</th>
            <th>活動舉辦日期</th>
            <th>報名開始時間</th>
            <th>報名截止時間</th>
            <th>參加費用</th>
            <th>已繳費人數</th>
            <th>報名狀態</th>
            <th>操作</th>
        </tr>

        <c:forEach var="schd" items="${actSchdSet}">
        <tr> 
            <td>${schd.schdNo}</td>
            <td>${schd.ancDate}</td>
            <td>${schd.drpoSchdDate}</td>
            <td>${schd.holdDate}</td>
            <td>${schd.aplyTime}</td>
            <td>${schd.cutTime}</td>
            <td>${schd.unitPrice}</td>
            <td>${schd.paidNum}</td>
            <td>
			    ${schd.applStatus == 1 ? '1-報名中' : 
			      (schd.applStatus == 2 ? '2-成團' : 
			        (schd.applStatus == 3 ? '3-未成團' : 
			          (schd.applStatus == 4 ? '4-因故取消' : '')))}
			</td>         
            <td>
	            <form action="${pageContext.request.contextPath}/schd.do" method="post">
	            	<input type="hidden" name="action" value="getOne_For_Update">
	            	<input type="hidden" name="schdNo" value="${schd.schdNo}">
	            	<input type="submit" value="修改" class="modify-button">
	            </form>
            </td>
        </tr>
        </c:forEach>
    </table>

</div>
</body>
</html>