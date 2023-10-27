<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<title>IBM Promotiom: Home</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3> 促銷專案</h3><h4>( MVC )</h4></td></tr>
</table>


<h3>專案查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listall.jsp'>List</a> all Promotion  <br><br></li>
  
  <jsp:useBean id="proSvc" scope="page" class="com.paradisiac.promotion.service.PromotionService" />
  <li>
    <FORM METHOD="post" ACTION="promotion" >
        <b>輸入促銷編號 (如101):</b>
        <input type="text" name="prono">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>
  <li>
     <FORM METHOD="post" ACTION="promotion" >
       <b>選擇促銷編號:</b>
       <select size="1" name="prono">
         <c:forEach var="proVO" items="${proSvc.all}" > 
          <option value="${proVO.prono}">${proVO.prono}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="promotion" >
       <b>選擇促銷專案名稱:</b>
       <select size="1" name="prono">
         <c:forEach var="proVO" items="${proSvc.all}" > 
          <option value="${proVO.prono}">${proVO.proname}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
  </ul>

  
 <ul>
  <li><a href='add.jsp'>Add</a> a new Emp.</li>
</ul>
</body>
</html>