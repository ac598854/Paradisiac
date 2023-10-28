<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.productphoto.model.*"%>
<%@ page import="com.paradisiac.productphoto.service.*"%>


<%
	ProductPhotoService proSvc = new ProductPhotoService();
    List<ProductPhotoVO> list = proSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有員工資料 - listAllEmp.jsp</title>

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
		 <h3>所有促銷資料 - listAllPromotion.jsp</h3>
		 
		 <h4><a href="select.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
		 
		 
	</td></tr>
</table>

<table>
	<tr>
		<th>促銷編號</th>
		<th>促銷專案名稱</th>
		<th>促銷專案描述</th>
<!-- 		<th>修改</th> -->
<!-- 		<th>刪除</th> -->
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="proVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${proVO.productno}</td>
			<td>${proVO.photono}</td>
			<td>${proVO.picture}</td>
			<c:forEach items="${productPhotos}" var="photo">
        	<img src="data:image/png;base64,${photo.picture}" alt="Product Photo">
   			</c:forEach>
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/promotion/promotion" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="修改"> -->
<%-- 			     <input type="hidden" name="prono"  value="${proVO.prono}"> --%>
<!-- 			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM> -->
<!-- 			</td> -->
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/promotion/promotion" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="刪除"> -->
<%-- 			     <input type="hidden" name="prono"  value="${proVO.prono}"> --%>
<!-- 			     <input type="hidden" name="action" value="delete"></FORM> -->
<!-- 			</td> -->
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>