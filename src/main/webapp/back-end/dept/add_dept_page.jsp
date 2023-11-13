<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.department.model.*"%>
<% DeptVO deptVO = (DeptVO) request.getAttribute("deptVO");%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Hibernate Demo</title>
</head>
<body>
	<h1>新建部門</h1>
	<a href="${pageContext.request.contextPath}/dept.do?action=getAll">查詢所有部門</a>
	<br><br>
	
	<jsp:useBean id="deptSvc" scope="page" class="com.paradisiac.department.service.DeptServiceImpl" />
	<form action="${pageContext.request.contextPath}/dept.do" method="post">
		<input type="text" name="ename"><br>--%>
		<p><label>查詢單一部門：</label></p>
		
		<select name="deptname">
		  <c:forEach var="deptVO" items="${deptSvc.all}" > 
          	<option value="${deptVO.deptNo}">${deptVO.deptName}
          </c:forEach>
		</select>
		<input type="hidden" name="action" value="getOne_For_Display">
        <input type="button" value="送出">       
	</form>
	
	<form id="dept_emp_form" action="${pageContext.request.contextPath}/dept.do" method="post">
		<table style="width:30%; text-align:center;">
		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
			<font style="color:red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color:red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>
			<!-- 部門資料 -->
			<tr>
				<th>部門編號</th>
				<th>部門名稱</th>
				<th>部門狀態</th>
				<th>功能設定</th>
			</tr>
			<jsp:useBean id="fucSvc" scope="page" class="com.paradisiac.fuc.service.Fuc_ServiceImpl" />
			<tr>
				<td><input type="text" name="deptNo"></td>
				<td><input name="deptName" value="<%= (deptVO==null)? "" : deptVO.getDeptName()%>" ></td>
				<td>
					<input type="radio" name="deptStatus"  value="0" ${deptVO.isDeptStatus? 'checked' : ''} size="45"/>凍結
					<input type="radio" name="deptStatus"  value="1" checked="checked" size="45"/>未凍結 <%--預設未凍結 --%>
				</td>
				<td><input name="fucNo" value="<%= (deptVO==null)? "" : deptVO.getFucNo()%>" ></td>

				<%--<td><select name="fucNo">
					  	<c:forEach var="fucVO" items="${fucSvc.all}" > 
			          	<option value="${fucVO.fucNo}">${fucVO.fucName}
			          	</c:forEach>
					</select>
				</td>--%>
			</tr>			
		</table>
		<!-- 員工資料 -->
		<fieldset>
		<jsp:useBean id="empSvc" scope="page" class="com.paradisiac.employee.service.EmpService" />		
			<article class="task_container">
		      <h2 class="title1">新增部門員工</h2>
		
		      <%-- <div class="task_add_block">
		        <input type="text" class="task_name" placeholder="輸入員工編號…">
		        <button type="button" class="task_add">新增</button>
		      </div>--%>
		      
		      <div class="task_add_block">
				選擇員工編號<select name="empNo2" id="employeeSelect">
					<option value="none">請選擇員工編號
					<c:forEach var="empVO" items="${empSvc.all}" > 
			        <option value="${empVO.empno}">${empVO.empno}-${empVO.empName}
			        </c:forEach>
				</select>
		        <button type="button" class="task_add2">新增</button>
		      </div>
		
		      <div class="task_list_parent">
		        <ul class="task_list">
		        </ul>
		      </div>
		    </article>
	    </fieldset>
		<input type="hidden" name="action" value="insert">
		<input type="submit" value="送出新增" onclick="disableSelect()">
	</form>
	
	
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<scirpt>
	===========================
	<script>
	$(function(){
		  // ==== text 欄位新增待辦事項 ===== //
		  $("input.task_name").on("keyup", function(e){
		    //console.log(e.which);
		    if(e.which == 13){ // 按下 Enter 鍵
		      $("button.task_add").click();
		    }
		  });
		  
		  function disableSelect() {
		        // 获取<select>元素
		        var selectElement = document.getElementById("employeeSelect");

		        // 禁用<select>元素
		        selectElement.disabled = true;

		        // 在表单提交之前解除<select>元素的禁用状态
		        document.getElementById("dept_emp_form").addEventListener("submit", function () {
		            selectElement.disabled = false;
		        });
		    }
		  
		  // input輸入員工編號
		  $("button.task_add").on("click", function(){
			  let task_text = ($("input.task_name").val()).trim();
			    if(task_text != ""){
			    	let list_html = "";
			    	
			    	list_html += '<li>';
			        list_html +=   '<div class="item_flex">';
			        list_html +=     '<div class="middle_block">';
			        list_html +=       '<p class="para">' + task_text + '</p>';
			        list_html +=     '</div>';
			        list_html +=     '<div class="right_block">';
			        list_html +=         '<button type="button" class="btn_delete">移除</button>';
			        list_html +=     '</div>';
			        list_html +=   '</div>';
			    	list_html += '</li>';
			    	
			        $("ul.task_list").prepend(list_html);
			        $("input.task_name").val("");
			    }			  
		  });
		  
		  // 下拉選單輸入員工編號
			$("button.task_add2").on("click", function(){	    
			    let selectedEmpNo = $("#employeeSelect").val();
	
			    let list_html = "";
			    
			    list_html += '<li>';
			    list_html +=   '<div class="item_flex">';
			    list_html +=     '<div class="middle_block">';
			    list_html +=       '<p class="para">' + selectedEmpNo + '</p>';
			    list_html +=       '<input type="hidden" name="empNo" value="' + selectedEmpNo + '">';
			    list_html +=     '</div>';
			    list_html +=     '<div class="right_block">';
			    list_html +=         '<button type="button" class="btn_delete">移除</button>';
			    list_html +=     '</div>';
			    list_html +=   '</div>';
			    list_html += '</li>';
			    
			    $("ul.task_list").prepend(list_html);
			});
		  
		  
	});
	</script>
	
	<script>
		// ==== 移除待辦事項 ===== /
		$("ul.task_list").on("click", "button.btn_delete", function(){
			  let r = confirm("確認移除？");
			  if (r){
			    $(this).closest("li").animate({
			      "opacity": 0
			    }, 1000, "swing", function(){
			      $(this).remove();
			    });
			  }
		});
	</script>
	===========================

	</scirpt>
	
	
	
</body>
</html>