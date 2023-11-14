<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.department.model.*"%>
<% DeptVO deptVO = (DeptVO) request.getAttribute("deptVO");%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>部門系統首頁</title>
</head>
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
</style>

<body>
<table id="table-1">
   <tr><td><h3>部門系統首頁 Dept: Home</h3><h4></h4></td></tr>	
</table>
<ul>
	<h3>資料查詢：</h3>
	<li><a href="${pageContext.request.contextPath}/dept.do?action=getAll">List</a> all Depts.  <br><br></li>
	<jsp:useBean id="deptSvc" scope="page" class="com.paradisiac.department.service.DeptServiceImpl" />
	<li>
	<form action="${pageContext.request.contextPath}/dept.do" method="post">
		<b>選擇部門：</b>		
		<select name="deptNo">
		  <c:forEach var="deptVO" items="${deptSvc.all}" > 
          	<option value="${deptVO.deptNo}">${deptVO.deptName}
          </c:forEach>
		</select>
		<input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">       
	</form>
	</li>
</ul>	
	
	
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

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