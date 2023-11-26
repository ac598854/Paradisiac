<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.employee.model.*"%>
<%@ page import="com.paradisiac.employee.service.*"%>
<%@ page import="com.paradisiac.department.model.*"%>


<%
    EmpService empSvc = new EmpService();
    List<EmpVO> list = empSvc.getAll();
    pageContext.setAttribute("list",list);

%>


<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<title>�Ҧ����u��� - listAllEmp.jsp</title>

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
        /* �Ĥ@���B�W�@���B�U�@���B�̫ܳ�@��  */
        .pagination-link {
       		position:relative;
 			top: -60px;
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
<body bgcolor='white'>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
<div class="container mt-5">
<table id="table-1">
	<tr>
	<td>
		 <h3>�Ҧ����u��� - listAllEmp.jsp</h3>
		 <h4><a href="select_page.jsp">�^����</a></h4>
	</td>
	</tr>
</table>

<table class="table table-bordered">
	<tr>
		<th>���u�s��</th>
		<th>�����s��</th>
		<th>���u���A</th>
		<th>���u�m�W</th>
		<th>���u�H�c</th>
		<th>���u�b��</th>
		<th>���u�K�X</th>
		<th>���u�ʧO</th>
		<th>���u�q��</th>
		<th>�\��</th>
	</tr>
<%@ include file="page1.file" %> 
	
	<c:forEach var="empVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">

		<tr>
			<td>${empVO.empno}</td>
			<td>${empVO.dept.deptNo}-${empVO.dept.deptName}</td>
			<%--<td>${empVO.dept.deptNo}-${empVO.dept.deptName}</td> <%--[${empVO.deptVO.deptName}] --%> 
			<td>${empVO.empStatus== 0 ? '�ᵲ' : (empVO.empStatus == 1 ? '���ᵲ' : '��L')}</td>
			<td>${empVO.empName}</td>
			<td>${empVO.empMail}</td>
			<td>${empVO.empAccount}</td>
			<td>${empVO.empPass}</td> 
			<td>${empVO.empGender== 1 ? '�k' : (empVO.empGender == 2 ? '�k' : '��L')}</td>
			<td>${empVO.empPhone}</td>

			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp.do" style="margin-bottom: 0px;">
			    <!--  <input type="submit" value="�ק�"> -->
			     <input type="hidden" name="empno"  value="${empVO.empno}">
			   <!--   <input type="hidden" name="action" value="getOne_For_Update"> -->
			     <button type="submit" class="btn btn-primary" name="action" value="getOne_For_Update">�ק�</button>
			     </FORM>
			    
			</td>

		</tr>
	</c:forEach>
</table>
</div>
<%@ include file="page2.file" %>

</body>
</html>