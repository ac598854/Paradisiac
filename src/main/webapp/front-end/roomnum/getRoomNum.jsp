<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
    .query-container {
      width: 960px;
      margin: 0 auto;     
    }
    .query-title {
      text-align: left;
    }
    .query-form {
      width: 470px; /* �վ� query-form ���e�� */
      height: 630px;
      border: 1px solid #000;
      border-radius: 10px;
      margin: 10px 5px 0 0; /* �վ�~��Z */
      padding: 20px; 
      float: left; /* ���B�� */
      transition: box-shadow 0.6s; /* �K�[�L��ĪG */
    }
     .query-form:hover {
      box-shadow: 5px 5px 15px 5px rgba(0,0,0,0.3); /* �a���ɪ����v�ĪG */
    }
    .query-All {
      width: 470px; /* �վ� query-All ���e�� */
      height: 580px;
      border: 1px solid #000;
      border-radius: 10px;
      margin: 10px 0 0 5px; /* �վ�~��Z */
      padding: 20px; 
      float: left; /* ���B�� */
      transition: box-shadow 0.6s; /* �K�[�L��ĪG */
    }
    .query-All:hover {
      box-shadow: 5px 5px 15px 5px rgba(0,0,0,0.3); /* �a���ɪ����v�ĪG */
    }
</style>
</head>
<body>
	<div class="container mt-5 query-container">
  <div class="query-form">      
    <form action="${pageContext.request.contextPath}/roomnum/roomnum.do" method="post">         
        <div style="display: flex; justify-content: space-between;">
            <h4>�ж��d��</h4> <a href="${pageContext.request.contextPath}/index.jsp">�^����</a>
        </div>
        <hr>
      <div class="form-group">
        <label for="roomType">�Ы�</label>
        <input type="text" name="roomType" class="form-control" id="roomType" placeholder="��J�Ы�">
      </div>
      <div class="form-group">
        <label for="roomNumber">�ж����X</label>
        <input type="text" name="roomNumber" class="form-control" id="roomNumber" placeholder="��J�ж����X">
      </div>
      <div class="form-group">
        <label for="orderNumber">�q��s��</label>
        <input type="text" name="orderNumber" class="form-control" id="orderNumber" placeholder="��J�q��s��">
      </div>
      <div class="form-group">
        <label for="checkin_name">��Щm�W</label>
        <input type="text" name="checkin_name" class="form-control" id="checkin_name" placeholder="��J��Щm�W">
      </div>
      <div class="form-group">
        <label for="roomStatus">�ж����A</label>
        <input type="text" name="roomStatus" class="form-control" id="roomStatus" placeholder="��J�ж����A">
      </div>      
        <button type="submit" class="btn btn-primary d-block mx-auto" style="width: 100%;">����d��</button>   
         <input type="hidden" name="action" value="compositeQuery">    
         <br>
         <a href="${pageContext.request.contextPath}/roomnum/roomnum.do?action=getAll" 
         class="btn btn-primary d-block mx-auto" style="width: 100%; text-decoration: none;">�d�ߥ���</a>
      </div>
      
     
    </form>
 <%--  </div>
  <div class="query-All">   
    <form action="${pageContext.request.contextPath}/roomnum/roomnum.do" method="post">      
           <h4 style="margin-bottom:25px">�d�ߩҦ��ж��H��</h4>
           <hr >
            <button type="submit" class="btn btn-primary d-block mx-auto" style="width: 100%;margin-top:443px">�d�ߥ���</button> 
            <input type="hidden" name="action" value="getAll">         
    </form>
  </div>
</div> --%>
		<!-- �ޤJ Bootstrap JS �M�̪ۨ� Popper.js �� jQuery -->
		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
		<script
			src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>