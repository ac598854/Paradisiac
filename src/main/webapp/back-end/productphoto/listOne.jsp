<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.paradisiac.productphoto.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%
ProductPhotoVO proVO = (ProductPhotoVO) request.getAttribute("proVO");
%>

<html>
<head>
<title>�P�P��� - listOnePromotion.jsp</title>

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

<h4>�����Ƚm�߱ĥ� Script ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>�P�P��� - listOnePromotion.jsp</h3>
	</td></tr>
</table>

<table>
	<tr>
		<th>�P�P�s��</th>
		<th>�P�P�M�צW��</th>
		<th>�P�P�M�״y�z</th>
	</tr>
	<tr>
		<td><%=proVO.getPhotono()%></td>
		<td><%=proVO.getProductno()%></td>
<%-- 		<td><%=proVO.getPicture()%></td> --%>
	</tr>
</table>

</body>
</html>