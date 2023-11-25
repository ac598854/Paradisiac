<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="">
<%--${pageContext.request.contextPath}/main/main.css --%>
<title>部門列表</title>
	<style>
	 		.container{	 			
 			position:relative;
 			top: -50px;
 		}
 		.text-center{ 		
 			position:relative;
 			top: 0px; 		
 		}
 		#checkoutbtn{
 			width:60px;
 		}
        .table th,
        .table td {
            text-align: center;
            border: 1px solid #dee2e6;
        }

        .table th {
            background-color: #007bff;
            color: #fff;
            border-color: #007bff;
            border-radius: 0 0 0 0;
        }

        .table th:not(:last-child) {
            border-right: 1px solid #dee2e6;
        }

        .table .btn {
            width: 80px;
            margin-right: 5px;
            border-radius: 0.25rem;
        }

        .table .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .table .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }
		 .table .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.5);
        }
        /* 第一頁、上一頁、下一頁、至最後一頁  */
        .pagination-link {
            display: inline-block;
            padding: 6px 12px;
            margin-bottom: 0;
            font-size: 14px;
            font-weight: 400;
            line-height: 1.42857143;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            cursor: pointer;
            border: 1px solid transparent;
            border-radius: 4px;
            color: #fff;
            background-color: #007bff;
            border-color: #007bff;
            text-decoration: none;
        }

        .pagination-link:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
		
	</style>
</head>
<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
<div class="container mt-5">
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
	
	
		<table class="table table-bordered">
			<tr>
				<th>部門編號</th>
				<th>部門名稱</th>
				<th>部門狀態</th>
				<th>功能編號</th>
				<th>功能執行</th>
			</tr>

			<c:forEach var="dept" items="${deptList}">
				<tr>
					<td>${dept.deptNo}</td>
					<td>${dept.deptName}</td>
					<td>${dept.deptStatus? '正常' : '凍結'}</td>
					<td>${dept.fucNo}-${dept.fucVO.fucName}</td> 
					<td>
						<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/dept.do" style="margin-bottom: 0px;">								
							<input type="hidden" name="deptNo" value="${dept.deptNo}"> 
							<input type="hidden" name="deptName" value="${dept.deptName}">					
							<input type="hidden" name="deptNo" value="${dept.deptNo}"> 		
							<button type="submit" class="btn btn-primary" name="action" value="getOne_For_Display">查詢</button> 					
							<button type="submit" class="btn btn-primary" name="action" value="getOne_For_Update">修改</button>
						</FORM>

					</td>

				</tr>
			</c:forEach>
		</table>
	</div>
	
	<div class="text-center">
	 <c:choose>
        <c:when test="${currentPage > 1}">
		<a href="${pageContext.request.contextPath}/dept.do?action=getAll&page=1" class="pagination-link">至第一頁</a>&nbsp;
	  </c:when>
        <c:otherwise>
            <a href="#" class="pagination-link" style="pointer-events: none; cursor: default;">第一頁</a>&nbsp;
        </c:otherwise>
    </c:choose>
    
    <c:choose>
        <c:when test="${currentPage - 1 != 0}">
		<a href="${pageContext.request.contextPath}/dept.do?action=getAll&page=${currentPage - 1}" class="pagination-link">上一頁</a>&nbsp;
	  </c:when>
        <c:otherwise>
            <a href="#" class="pagination-link" style="pointer-events: none; cursor: default;">上一頁</a>&nbsp;
        </c:otherwise>
    </c:choose>
 
	
	<c:choose>
        <c:when test="${currentPage + 1 <= roomnumPageQty}">
		<a href="${pageContext.request.contextPath}/dept.do?action=getAll&page=${currentPage + 1}" class="pagination-link">下一頁</a>&nbsp;
	 </c:when>
        <c:otherwise>
            <a href="#" class="pagination-link" style="pointer-events: none; cursor: default;">下一頁</a>&nbsp;
        </c:otherwise>
    </c:choose> 
	
	                                      
	  <c:choose>
        <c:when test="${currentPage != roomnumPageQty}">   
		<a href="${pageContext.request.contextPath}/dept.do?action=getAll&page=${deptPageQty}" class="pagination-link">至最後一頁</a>&nbsp;
	  </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/roomnum.do?action=getAll" class="pagination-link" style="pointer-events: none; cursor: default;">最後一頁</a>&nbsp;
        </c:otherwise>
    </c:choose>                                     
	<br>
</div>
<script>
	//控制表單的按鈕當按下那個按鈕時就把按下的value值傳回給後端，做到自動切換2個按鈕的觸發，這是用來分辦現在按的是退房按鈕還是清潔完成按鈕
    document.querySelectorAll('button[type="submit"]').forEach(button => {
        button.addEventListener('click', function() {
            document.querySelector('input[name="action"]').value = this.value;
        });
    });
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>	

</body>
</html>