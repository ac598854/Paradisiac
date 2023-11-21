<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.department.model.*"%>
<% DeptVO deptVO = (DeptVO) request.getAttribute("deptVO");%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>部門管理</title>
    <style>

        body {
            font-family: Arial, sans-serif;
        }

        form {
            margin: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table, th, td {
            border: 1px solid black;
            text-align: center;
        }

        th, td {
            padding: 10px;
        }
        .content-main{
            padding-top: 65px;
            padding-left: 255px;
        }
        
		.item_flex {
	    justify-content: space-between;
	    align-items: center;
	    margin-right: 10px;
		}

		.middle_block {
		    flex-grow: 1;
		}
	
		.right_block {
		    margin-left: 10px; /* 調整按鈕和文字之間的間距 */
		}
		p.para{
		display: inline;
		padding: 10px;
		}

	  	
    </style>
</head> 
<%@ include file="/back-end/index/back-left_hr.jsp" %><%----%>
<body>
	<!-- 查詢單一部門區塊 -->
	<div class="content-main">
		<h1>部門管理系統</h1>

		<form action="${pageContext.request.contextPath}/dept.do" method="post">
			
			<p>
				<a href="${pageContext.request.contextPath}/dept.do?action=getAll">查詢所有部門</a>				
			</p>
			<jsp:useBean id="deptSvc" scope="page"
				class="com.paradisiac.department.service.DeptServiceImpl" />
			<label>查詢單一部門：</label><select name="deptNo">
				<c:forEach var="dept" items="${deptSvc.all}">
					<option value="${dept.deptNo}">${dept.deptName}
				</c:forEach>
			</select> <input type="hidden" name="action" value="getOne_For_Display">
			<input type="submit" value="送出">
		</form>

		<!-- 部門資料和新增部門員工表單區塊 -->
		<form id="dept_emp_form"
			action="${pageContext.request.contextPath}/dept.do" method="post">
			<table>
				<%-- 錯誤表列 --%>
				<c:if test="${not empty errorMsgs}">
					<font style="color: red">請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color: red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>
				<tr>
					<th>部門編號</th>
					<th>部門名稱</th>
					<th>部門狀態</th>
					<th>功能設定</th>
				</tr>
				<jsp:useBean id="fucSvc" scope="page"
					class="com.paradisiac.fuc.service.Fuc_ServiceImpl" />
				<tr>
					<td><input type="text" name="deptNo" value="<%=(deptVO == null) ? "" : deptVO.getDeptNo()%>" required></td>
					<td><input type="text" name="deptName"
						value="<%=(deptVO == null) ? "" : deptVO.getDeptName()%>" required></td>
					<td><label><input type="radio" name="deptStatus"
							value="false" ${deptVO.deptStatus? '' : 'checked'}>凍結</label> <label><input
							type="radio" name="deptStatus" value="true" checked>未凍結</label></td>
					<td><select name="fucNo" >
				  	<c:forEach var="fucVO" items="${fucSvc.all}" > 
		          	<option value="${fucVO.fucNo}" ${(fucVO.fucNo==deptVO.fucNo)?'selected':'' }>${fucVO.fucName}
		          	</c:forEach>
				</select>
				</td>
				</tr>
			</table>

			<fieldset>
				<jsp:useBean id="empSvc" scope="page"
					class="com.paradisiac.employee.service.EmpService" />
				<legend>新增部門員工</legend>
				<div class="dep_add_block">
			        <input type="text" class="dep_name" placeholder="輸入員工編號…">
			        <button type="button" class="dep_add">新增</button>
		 		</div> <%----%>
				<label>選擇員工編號：</label> <select name="empNo2" id="employeeSelect">
					<option value="none">請選擇員工編號
					<c:forEach var="empVO" items="${empSvc.all}">
						<option value="${empVO.empno}">${empVO.empno}-${empVO.empName}
					</c:forEach>
				</select>
				<button type="button" class="dep_add2">新增</button>
				<div class="dep_list_parent">
					<ul class="dep_list">
					</ul>
				</div>
			</fieldset>

			<input type="hidden" name="action" value="insert"> 
			<input type="submit" value="送出新增" onclick="disableSelect()">
		</form>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>


	<script>

		$(function() {
		
		  	$(document).ready(function() {
			    $(".dep_name").on("keydown", function(event) {
			      if (event.which === 13) {
			        event.preventDefault();
			        $("button.dep_add").click();
			        return false; // 避免繼續處理 keydown 事件
			      }
			    });
			  });
/*
			function disableSelect() {
				// 取得<select>元素
				var selectElement = document.getElementById("employeeSelect");

				// 禁用取得<select>元素(直接送出)
				selectElement.disabled = true;

				// 表單提交時解除禁用
				document.getElementById("dept_emp_form").addEventListener(
						"submit", function() {
							selectElement.disabled = false;
						});
			}*/

			// input輸入員工編號
			$("button.dep_add")
					.on(
							"click",
							function() {
								let dep_text = ($("input.dep_name").val())
										.trim();
								if (dep_text != "") {
									let list_html = "";

									list_html += '<li>';
									list_html += '<div class="item_flex">';
									list_html += '<div class="middle_block">';
									list_html += '<p class="para">' + dep_text + '</p>';		
									list_html += '<input type="hidden" name="empNo" value="' + dep_text + '">';
									list_html += '<button type="button" class="btn_delete">移除</button>';
									list_html += '</div>';
									list_html += '</div>';
									list_html += '</li>';

									$("ul.dep_list").prepend(list_html);
									$("input.dep_name").val("");
								}
							});

			// 下拉選單輸入員工編號
			$("button.dep_add2")
					.on(
							"click",
							function() {
								let selectedEmpNo = $("#employeeSelect").val();

								let list_html = "";

								list_html += '<li>';
								list_html += '<div class="item_flex">';
								list_html += '<div class="middle_block">';
								list_html += '<p class="para">' + selectedEmpNo + '</p>';
										
								list_html += '<input type="hidden" name="empNo" value="' + selectedEmpNo + '">';

								list_html += '<button type="button" class="btn_delete">移除</button>';
								list_html += '</div>';
								list_html += '</div>';
								list_html += '</li>';

								$("ul.dep_list").prepend(list_html);
							});

		});
	</script>
	
	<script>
		// ==== 移除待辦事項 ===== /
		$("ul.dep_list").on("click", "button.btn_delete", function(){
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


	
	
	
</body>
</html>