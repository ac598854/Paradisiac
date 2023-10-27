<%-- <%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="product.*"%>

<html>
<head>
<title>IBM Product: Home</title>

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
   <tr><td><h3> Product: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for Product: Home</p>

<h3>鞈����亥岷:</h3>

�航炊銵典��
<c:if test="${not empty errorMsgs}">
    <font style="color:red">隢�靽格迤隞乩��航炊:</font>
    <ul>
        <c:forEach var="message" items="${errorMsgs}">
            <li style="color:red">${message}</li>
        </c:forEach>
    </ul>
</c:if>




  <li>
    <FORM METHOD="post" ACTION="/IBM_emp_0201MVC_Single-Table_mySQL8/product" >
        <b>頛詨�亙����蝺刻�� (憒�301):</b>
        <input type="text" name="prono">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="����">
    </FORM>
  </li>

  <jsp:useBean id="proSvc" scope="page" class="product.ProductService" />
 �
</body>
</html> --%>