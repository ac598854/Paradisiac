<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body>
	

	<jsp:useBean id="roomnum" scope="page" class="com.paradisiac.roomnum.service.RoomNumServiceImpl" />
   
  <li>
     <FORM METHOD="post" ACTION="emp.do" >
       <b>��ܩи�:</b>
       <select size="1" name="empno">
         <c:forEach var="empVO" items="${empSvc.all}" > 
          <option value="${empVO.empno}">${empVO.empno}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
    </FORM>
  </li>


</body>
</html>