<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.paradisiac.promotion.model.*"%>


<%
PromotionVO proVO = (PromotionVO) request.getAttribute("proVO");
%>

<html>
<head>
<title>促銷資料 - listOnePromotion.jsp</title>

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
</style>

<style>
  table {
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>促銷資料 - listOnePromotion.jsp</h3>
	</td></tr>
</table>

<table>
	<tr>
		<th>促銷編號</th>
		<th>促銷專案名稱</th>
		<th>促銷專案描述</th>
		<th>促銷專案開始日期</th>
		<th>促銷專案結束日期</th>
		<th>促銷專案折扣</th>
		<th>促銷專案狀態</th>
	</tr>
	<tr>
		<td><%=proVO.getProno()%></td>
		<td><%=proVO.getProname()%></td>
		<td><%=proVO.getProdes()%></td>
		<td><%=proVO.getStartdate()%></td>
		<td><%=proVO.getEnddate()%></td>
		<td><%=proVO.getDiscount()%></td>
		<td><%=proVO.getStatus()%></td>
	</tr>
</table>

</body>
</html>