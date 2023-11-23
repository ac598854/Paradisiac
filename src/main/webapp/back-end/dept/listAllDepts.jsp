<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<meta charset="UTF-8">
<link rel="stylesheet" href="">
<%--${pageContext.request.contextPath}/main/main.css --%>
<title>部門列表</title>
	<style>
	  table#table-1 {
		background-color: #CCCCFF;
	    border: 2px solid black;
	    text-align: center;
	    min-width: 60%;
  		}
  		
  		div#box{
  		margin: auto; 
  		}
		table {
		   	width: 30%;
        	border-collapse: collapse; <%--預設邊框合併--%> 
	
		}
		
		th, td {
        border: 1px solid #000;
        padding: 8px;
        text-align: center;
    	}
    	
    	th {
        background-color: #ccc;
    	}
    	
    	td form {
        display: flex;
        justify-content: space-around; /* 按鈕橫向排列 */
    	}

    	td form input[type="submit"] {
        width: 100%; /* 設定按鈕寬度 */
    	}
		
	</style>
</head>
<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
<div id="box">
<table id="table-1">
	<tr><td>
		 <h3>所有部門資料 - listAllDepts</h3>
		 <h4><a href="${pageContext.request.contextPath}/back-end/dept/select_dept_page.jsp">回首頁</a></h4>
	</td></tr>
</table>
	<c:if test="${deptPageQty > 0}">
  		<b><font color=red>第${currentPage}/${deptPageQty}頁</font></b>
	</c:if>
	<br>
	
	
		<table style="width:30%; text-align:center;">
			<tr>
				<th>部門編號</th>
				<th>部門名稱</th>
				<th>部門狀態</th>
				<th>功能編號</th>
			</tr>

			<c:forEach var="dept" items="${deptList}">
				<tr>
					<td>${dept.deptNo}</td>
					<td>${dept.deptName}</td>
					<td>${dept.deptStatus? '正常' : '凍結'}</td>
					<td>${dept.fucNo}-${dept.fucVO.fucName}</td> 
					<td>
						<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/dept.do" style="margin-bottom: 0px;">			
							<input type="hidden" name="action" value="getOne_For_Display">
							<input type="hidden" name="deptNo" value="${dept.deptNo}"> 
							<input type="hidden" name="deptName" value="${dept.deptName}">
							<input type="submit" value="查詢"> 
						</FORM>

						<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/dept.do" style="margin-bottom: 0px;">
							<input type="hidden" name="deptNo" value="${dept.deptNo}"> 
							<input type="hidden" name="action" value="getOne_For_Update">
							<input type="submit" value="修改">
						</FORM>

					</td>

				</tr>
			</c:forEach>
		</table>
	
	

	<c:if test="${currentPage > 1}">
		<a href="${pageContext.request.contextPath}/dept.do?action=getAll&page=1">至第一頁</a>&nbsp;
	</c:if>
	<c:if test="${currentPage - 1 != 0}">
		<a href="${pageContext.request.contextPath}/dept.do?action=getAll&page=${currentPage - 1}">上一頁</a>&nbsp;
	</c:if>                                         
	<c:if test="${currentPage + 1 <= deptPageQty}"> 
		<a href="${pageContext.request.contextPath}/dept.do?action=getAll&page=${currentPage + 1}">下一頁</a>&nbsp;
	</c:if>                                         
	<c:if test="${currentPage != deptPageQty}">     
		<a href="${pageContext.request.contextPath}/dept.do?action=getAll&page=${deptPageQty}">至最後一頁</a>&nbsp;
	</c:if>                                         
	<br>
</div>

	
		

</body>
</html>