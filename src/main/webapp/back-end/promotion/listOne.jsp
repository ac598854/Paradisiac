<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.paradisiac.promotion.model.*"%>


<%
PromotionVO proVO = (PromotionVO) request.getAttribute("proVO");
%>

<html>
<head>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<title>�P�P���</title>

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
            text-align: center; /* �N��r�m����� */
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
                <h3 style="font-family: 'Arial', sans-serif; font-size: 28px; font-weight: bold;">�P�P�M��</h3>
            </td>
        </tr>
    </table>


<div class="container">
        <table class="table table-bordered table-striped ">
            <thead class="thead-dark">
    <tr>
        <th style="text-align: center;">�P�P�s��</th>
        <th style="text-align: center;">�P�P�M�צW��</th>
        <th style="text-align: center;">�P�P�M�״y�z</th>
        <th style="text-align: center;">�M�׶}�l���</th>
        <th style="text-align: center;">�M�׵������</th>
        <th style="text-align: center;">�P�P�M�ק馩</th>
        <th style="text-align: center;">�P�P�M�ת��A</th>
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
						        out.print("�W�[");
						    } else if (status == 0) {
						        out.print("�U�[");
						    } else {
						        out.print(status); // �p�G���O 1 �� 0�A��ܭ�l���A��
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