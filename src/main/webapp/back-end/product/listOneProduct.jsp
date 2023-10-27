<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.paradisiac.product.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  ProductVO productVO = (ProductVO) request.getAttribute("productVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>

<html>
<head>
<title>商品資料 - listOneProduct.jsp</title>

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
		 <h3>商品資料 - listOneProduct.jsp</h3>
		 <h4><a href="select_page_product.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>商品編號</th>
		<th>商品名稱</th>
		<th>商品價格</th>
		<th>商品庫存</th>
		<th>商品狀態</th>
		<th>評價</th>
		<th>評價總人數</th>
		<th>商品類別編號</th>
	</tr>
	<tr>
		<td><%=productVO.getProductno()%></td>
		<td><%=productVO.getProductname()%></td>
		<td><%=productVO.getProductprice()%></td>
		<td><%=productVO.getProductquantity()%></td>
		<td><%=productVO.getProductstatus()%></td>
		<td><%=productVO.getProducttotalreviewcount()%></td>
		<td><%=productVO.getProducttotalreviewstatus()%></td>
		<td><%=productVO.getProductcategoryno() %></td>
	</tr>
</table>

</body>
</html>