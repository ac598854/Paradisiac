<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.roomnum.model.*"%>
<% //見com.emp.controller.EmpServlet.java第238行存入req的empVO物件 (此為輸入格式有錯誤時的empVO物件)
   RoomNumVO roomnumVO = (RoomNumVO) request.getAttribute("roomnumVO");
%>
<%-- --<%= RoomNumVO==null %>--  --部門編號：${RoomNumVO.deptno}- --%>- <!-- line 100 -->

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>房間資料新增 - addRoomNum.jsp</title>

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
		 <h3>房間資料新增 - addRoomNum.jsp</h3></td><td>
		 <h4><a href="select_page.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="${pageContext.request.contextPath}/roomnum.do" name="form1">
<table>	
	<tr>
		<td>房間號碼:</td>
		<td><input type="TEXT" name="rnum" value="" size="45"/></td>
	</tr>
	<tr>
	<jsp:useBean id="roomtypeSvc" scope="page" class="com.paradisiac.roomtype.service.RoomTypeServiceImpl" />
		
		<td>房型:</td>	
		<td>
		 <select size="1" name="roomTypeNo">
         <c:forEach var="roomType" items="${roomtypeSvc.all}" > <!-- var="roomType" var是從items取出的集合 -->
          <option value="${roomType.roomTypeno}">${roomType.roomName}  <!-- 使用集合的名稱取值roomType為集合名稱 -->
         </c:forEach>   
       </select>	
       </td>
		<!-- <input type="TEXT" name="roomTypeNo"   value="" size="45"/></td> -->
	</tr>
	<tr>
		<td>訂單編號:</td>
		<td><input type="TEXT" name="roomOrderNo"   value="" size="45"/></td>
	</tr>
	<tr>
		<td>住房姓名:</td>
		<td><input type="TEXT" name="checkInName"   value="" size="45"/></td>
	</tr>
	<tr>
		<td>房間狀態:</td>
		<td><input type="TEXT" name="roomStatus"  value="" size="45"/></td>
	</tr>	

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>

</body>



<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>


</html>