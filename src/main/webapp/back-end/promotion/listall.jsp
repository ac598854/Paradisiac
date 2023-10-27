<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.promotion.model.*"%>
<%@ page import="com.paradisiac.promotion.service.*"%>


<%
    PromotionService proSvc = new PromotionService();
    List<PromotionVO> list = proSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>�Ҧ����u��� - listAllEmp.jsp</title>

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
	width: 800px;
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
     width:12%;
  }
 
</style>

</head>
<body bgcolor='white'>


<table id="table-1">
	<tr><td>
		 <h3>�Ҧ��P�P��� - listAllPromotion.jsp</h3>
		 
		 <h4><a href="select.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
		 
		 
	</td></tr>
</table>

<table>
	<tr>
		<th>�P�P�s��</th>
		<th>�P�P�M�צW��</th>
		<th>�P�P�M�״y�z</th>
		<th>�P�P�M�׶}�l���</th>
		<th>�P�P�M�׵������</th>
		<th>�P�P�M�ק馩</th>
		<th>�P�P�M�ת��A</th>
		<th>�ק�</th>
		<th>�R��</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="proVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${proVO.prono}</td>
			<td>${proVO.proname}</td>
			<td>${proVO.prodes}</td>
			<td>${proVO.startdate}</td>
			<td>${proVO.enddate}</td>
			<td>${proVO.discount}</td>
			<td>${proVO.status}</td> 
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/promotion/promotion" style="margin-bottom: 0px;">
			     <input type="submit" value="�ק�">
			     <input type="hidden" name="prono"  value="${proVO.prono}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/promotion/promotion" style="margin-bottom: 0px;">
			     <input type="submit" value="�R��">
			     <input type="hidden" name="prono"  value="${proVO.prono}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>