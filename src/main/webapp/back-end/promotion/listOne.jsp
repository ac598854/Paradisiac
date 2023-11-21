<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.paradisiac.promotion.model.*"%>


<%
PromotionVO proVO = (PromotionVO) request.getAttribute("proVO");
%>

<html>
<head>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<title>促銷資料</title>

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

</head>
<body bgcolor='white'>

<%@ include file="/back-end/index/back-left_product.jsp" %>
<table class="table table-bordered">
        <tr>
            <td>
                <h3 style="font-family: 'Arial', sans-serif; font-size: 28px; font-weight: bold;">促銷專案</h3>
            </td>
        </tr>
    </table>


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
    </tr>
	</thead>
            <tbody>
                    <tr>
                        <td><%=proVO.getProno()%></td>
						<td><%=proVO.getProname()%></td>
						<td><%=proVO.getProdes()%></td>
						<td><%=proVO.getStartdate()%></td>
						<td><%=proVO.getEnddate()%></td>
						<td><%=proVO.getDiscount()%></td>
						<td><% 
						    Integer status = proVO.getStatus();
						    if (status == 1) {
						        out.print("上架");
						    } else if (status == 0) {
						        out.print("下架");
						    } else {
						        out.print(status); // 如果不是 1 或 0，顯示原始狀態值
						    }
						    %>
						</td>
							
                    </tr>
            </tbody>
        </table>
</div>



<script>
toggleSidebar();
</script>

</body>
</html>