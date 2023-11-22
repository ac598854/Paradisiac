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
    <title>�Ҧ��P�P�M��</title>
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
            text-align: center; /* �N��r�m����� */
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
               <h3 style="font-family: 'Arial', sans-serif; font-size: 28px; font-weight: bold;">�P�P�M�׺޲z</h3>
            </td>
        </tr>
    </table>
<div style="display: flex; align-items: center; margin-left: 80px;">
    <form style="margin-right: 10px;">
        <b>�j�M�P�P�s�� (�p101):</b>
        <input type="text" name="prono">
        <input type="submit" value="�e�X" class="btn btn-primary">
    </form>

    <div style="display: flex; align-items: center; margin-left: 20px;">
        <b style="white-space: nowrap;">��ܫP�P�s��:</b>
        <select class="form-control" id="selectProno" name="prono" style="margin-left: 10px;">
            <c:forEach var="proVO" items="${list}" >
                <option value="${proVO.prono}">${proVO.prono}</option>
            </c:forEach>
        </select>
    </div>
	<a href="#" class="btn btn-primary" style="margin-left: 370px;" id="add">�s�W�M��</a>
    <button id="showAllBtn" class="btn btn-primary" style="margin-left:10px;">��ܩҦ��M��</button>
</div>



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
        <th style="text-align: center;">�ק�</th>
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
						            �W�[
						        </c:when>
						        <c:when test="${proVO.status eq false}">
						            �U�[
						        </c:when>
						        <c:otherwise>
						            ��L���A
						        </c:otherwise>
						    </c:choose>
						</td>
                        <td>
                            <form method="post" action="<%=request.getContextPath()%>/back-end/promotion/promotion" style="margin-bottom: 0px;">
                                <input type="submit" value="�ק�" class="btn btn-primary">
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
                title: '�P�P�M�פw�s�W',
                html: `<span style="font-weight: bold; font-family: 'Comic Sans MS', cursive; font-size: 20px;">�M�׽s��<%= prono %> �w���\�s�W</span>`,
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
			    // ��ť��洣��ƥ�
			    document.querySelector('form').addEventListener('submit', function(event) {
			      event.preventDefault(); // �����檺�w�]����欰

			      var searchProno = document.querySelector('input[name="prono"]').value; // ����j�M�s��
			      var rows = document.querySelectorAll(".promotion-row"); // ����Ҧ�����

			      if (searchProno.trim() === '') {
			        alert('�п�J�j�M�s��'); // �Y��J���ŭȡA��ܴ����T��
			        return; // ����������
			      }

			      rows.forEach(function(row) {
			        var rowProno = row.getAttribute("data-prono"); // ����Ӧ檺�s��

			        if (rowProno !== searchProno) {
			          row.style.display = "none"; // ���ä��ŦX�j�M�s������
			        } else {
			          row.style.display = "table-row"; // �p�G�ŦX�j�M�s���A�h��ܸӦ�
			        }
			      });
			    });
			  });
			  
			  
			  // ����U�Կ�椸��
			    var selectProno = document.getElementById('selectProno');
			    console.log(selectProno)
			    selectProno.addEventListener('change', function() {
			        var selectedValue = this.value; // �����ܪ���
			        console.log(selectedValue) 
			        var rows = document.querySelectorAll(".promotion-row"); // ����Ҧ�����

			        rows.forEach(function(row) {
			            var rowProno = row.getAttribute("data-prono"); // ����Ӧ檺�s��
			            console.log(rowProno) 
			            if (selectedValue !== rowProno) {
			                row.style.display = "none"; // ���ä��ŦX��ܽs������
			            } else {
			                row.style.display = "table-row"; // ��ܲŦX��ܽs������
			            }
			        });
			    });
			  
			  document.getElementById('showAllBtn').addEventListener('click', function() {
			      var rows = document.querySelectorAll(".promotion-row"); // ����Ҧ�����

			      rows.forEach(function(row) {
			        row.style.display = "table-row"; // �N�Ҧ������
			      });
			    });
			  
		</script>
</body>
</html>
