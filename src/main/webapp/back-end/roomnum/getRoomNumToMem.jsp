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
       <b>選擇房號:</b>
       <select size="1" name="empno">
         <c:forEach var="empVO" items="${empSvc.all}" > 
          <option value="${empVO.empno}">${empVO.empno}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>


</body>
</html>