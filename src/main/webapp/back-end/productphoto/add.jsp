<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.productphoto.model.*"%>

<% //��com.emp.controller.EmpServlet.java��238��s�Jreq��empVO���� (������J�榡�����~�ɪ�empVO����)
	ProductPhotoVO proVO = (ProductPhotoVO) request.getAttribute("proVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>�P�P�s���s�W - addpromotion.jsp</title>

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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>�P�P�M�׷s�W - add.jsp</h3></td><td>
		 <h4><a href="select.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">�^����</a></h4>
	</td></tr>
</table>

<h3>��Ʒs�W:</h3>

<%-- ���~��C --%>
<%-- <c:if test="${not empty errorMsgs}"> --%>
<!-- 	<font style="color:red">�Эץ��H�U���~:</font> -->
<!-- 	<ul> -->
<%-- 		<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 			<li style="color:red">${message}</li> --%>
<%-- 		</c:forEach> --%>
<!-- 	</ul> -->
<%-- </c:if> --%>

<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/back-end/productphoto/photo" name="form1"  enctype="multipart/form-data">
<table>
	
	
	
	<tr>
		<td>�ӫ~�s��:</td>
		<td><input type="TEXT" name="productno"  value="<%= (proVO==null)? "1" : proVO.getPhotono()%>"  size="30"/></td>
	</tr>
	<tr>
		<td>�Ϥ��s��:</td>
		<td><input type="TEXT" name="photono"   value="<%= (proVO==null)? "1" : proVO.getProductno()%>"  size="30"/></td>
	</tr>
	<tr>
		<td>�Ϥ��s��:</td>
		<td><input type="file" name="upfile1"   value="<%= (proVO==null)? "���P�ӫ~�u�f" : proVO.getPicture()%>"  size="30"/></td>
	</tr>
        
	
</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="�e�X�s�W"></FORM>

</body>
</html>