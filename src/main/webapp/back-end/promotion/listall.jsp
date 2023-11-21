<%@page import="javax.print.DocFlavor.STRING"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.promotionlist.model.*"%>
<%@ page import="com.paradisiac.promotionlist.service.*"%>

<%
    PromotionService proSvc = new PromotionService();
    List<PromotionVO> list = proSvc.getAll();
    pageContext.setAttribute("list", list);
%>



<!DOCTYPE html>
<html>
<head>
    <title>所有促銷專案</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        h4 {
            color: blue;
            display: inline;
        }
        table {
            width: 800px;
            background-color: white;
            margin-top: 5px;
            margin-bottom: 5px;
        }
        table, th, td {
            border: 1px solid #CCCCFF;
            text-align: center; /* 將文字置中對齊 */
        }
        th, td {
            padding: 5px;
            text-align: center;
            width: 12%;
        }
    </style>
      <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>
<body bgcolor='white'>
    <%@ include file="/back-end/index/back-left_product.jsp" %>
    
    <table class="table table-bordered">
        <tr>
            <td>
               <h3 style="font-family: 'Arial', sans-serif; font-size: 28px; font-weight: bold;">促銷專案管理</h3>
            </td>
        </tr>
    </table>
<div style="display: flex; align-items: center; margin-left: 80px;">
    <form style="margin-right: 10px;">
        <b>搜尋促銷編號 (如101):</b>
        <input type="text" name="prono">
        <input type="submit" value="送出" class="btn btn-primary">
    </form>

    <div style="display: flex; align-items: center; margin-left: 20px;">
        <b style="white-space: nowrap;">選擇促銷編號:</b>
        <select class="form-control" id="selectProno" name="prono" style="margin-left: 10px;">
            <c:forEach var="proVO" items="${list}" >
                <option value="${proVO.prono}">${proVO.prono}</option>
            </c:forEach>
        </select>
    </div>
	<a href="#" class="btn btn-primary" style="margin-left: 370px;" id="add">新增專案</a>
    <button id="showAllBtn" class="btn btn-primary" style="margin-left:10px;">顯示所有專案</button>
</div>



    <div class="container">
        <table class="table table-bordered table-striped ">
            <thead class="thead-dark">
    <tr>
        <th style="text-align: center;">促銷編號</th>
        <th style="text-align: center;">促銷專案名稱</th>
        <th style="text-align: center;">促銷專案描述</th>
        <th style="text-align: center;">專案開始日期</th>
        <th style="text-align: center;">專案結束日期</th>
        <th style="text-align: center;">促銷專案折扣</th>
        <th style="text-align: center;">促銷專案狀態</th>
        <th style="text-align: center;">修改</th>
    </tr>
</thead>
            <tbody>
                <c:forEach var="proVO" items="${list}">
                    <tr class="promotion-row" data-prono="${proVO.prono}">
                        <td>${proVO.prono}</td>
                        <td>${proVO.proname}</td>
                        <td>${proVO.prodes}</td>
                        <td>${proVO.startdate}</td>
                        <td>${proVO.enddate}</td>
                        <td>${proVO.discount}</td>
                        <td>
						    <c:choose>
						        <c:when test="${proVO.status eq true}">
						            上架
						        </c:when>
						        <c:when test="${proVO.status eq false}">
						            下架
						        </c:when>
						        <c:otherwise>
						            其他狀態
						        </c:otherwise>
						    </c:choose>
						</td>
                        <td>
                            <form method="post" action="<%=request.getContextPath()%>/back-end/promotion/promotion" style="margin-bottom: 0px;">
                                <input type="submit" value="修改" class="btn btn-primary">
                                <input type="hidden" name="prono" value="${proVO.prono}">
                                <input type="hidden" name="action" value="getOne_For_Update">
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>


    <%
        Integer prono = (Integer)request.getAttribute("prono");
		request.removeAttribute("prono");
        if (prono != null) {
    %>
        
        <script>
        
            Swal.fire({
                title: '促銷專案已新增',
                html: `<span style="font-weight: bold; font-family: 'Comic Sans MS', cursive; font-size: 20px;">專案編號<%= prono %> 已成功新增</span>`,
                icon: 'success',
                timer: 2000,
                showConfirmButton: false
            });
        </script>
    <%
        }
    %>
		<script>
	    
	    var addLink = document.getElementById('add');
	 	addLink.setAttribute('href', projectName+"/back-end/promotion/add.jsp");

			toggleSidebar();
			  document.addEventListener("DOMContentLoaded", function() {
			    // 監聽表單提交事件
			    document.querySelector('form').addEventListener('submit', function(event) {
			      event.preventDefault(); // 防止表單的預設提交行為

			      var searchProno = document.querySelector('input[name="prono"]').value; // 獲取搜尋編號
			      var rows = document.querySelectorAll(".promotion-row"); // 選取所有表格行

			      if (searchProno.trim() === '') {
			        alert('請輸入搜尋編號'); // 若輸入為空值，顯示提醒訊息
			        return; // 阻止後續執行
			      }

			      rows.forEach(function(row) {
			        var rowProno = row.getAttribute("data-prono"); // 獲取該行的編號

			        if (rowProno !== searchProno) {
			          row.style.display = "none"; // 隱藏不符合搜尋編號的行
			        } else {
			          row.style.display = "table-row"; // 如果符合搜尋編號，則顯示該行
			        }
			      });
			    });
			  });
			  
			  
			  // 獲取下拉選單元素
			    var selectProno = document.getElementById('selectProno');
			    console.log(selectProno)
			    selectProno.addEventListener('change', function() {
			        var selectedValue = this.value; // 獲取選擇的值
			        console.log(selectedValue) 
			        var rows = document.querySelectorAll(".promotion-row"); // 選取所有表格行

			        rows.forEach(function(row) {
			            var rowProno = row.getAttribute("data-prono"); // 獲取該行的編號
			            console.log(rowProno) 
			            if (selectedValue !== rowProno) {
			                row.style.display = "none"; // 隱藏不符合選擇編號的行
			            } else {
			                row.style.display = "table-row"; // 顯示符合選擇編號的行
			            }
			        });
			    });
			  
			  document.getElementById('showAllBtn').addEventListener('click', function() {
			      var rows = document.querySelectorAll(".promotion-row"); // 選取所有表格行

			      rows.forEach(function(row) {
			        row.style.display = "table-row"; // 將所有行顯示
			      });
			    });
			  
		</script>
</body>
</html>
