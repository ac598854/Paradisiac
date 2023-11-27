<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<meta charset="UTF-8">
    <title>修改活動</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
body {
	font-size: 15px;
}

h1 {
	text-align: center;
}

.form-container {
	display: flex;
	flex-direction: column;
	margin-top: 20px;
}

.form-container .form-group {
	margin-bottom: 10px;
}

.form-container .form-group input {
	width: 100%;
	padding: 5px;
}

.col-md-6 {
	width: 50%;
	float: left;
	box-sizing: border-box;
}

.preview-container {
	display: flex;
	justify-content: center;
	align-items: center;
}

.preview-container img {
	max-width: 100%;
	max-height: 200px;
	object-fit: cover;
}

.btn-separator {
	margin-left: 10px;
	font-size: 12px
}

.form-group {
	margin-top: 5px;
}
</style>
</head>

<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
	<div class="custom-container">	
	<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>
		<form method="post" action="${pageContext.request.contextPath}/act.do">
		<div style="text-align: center;">
			<h1 class="text-center"
				style="display: inline-block;">更新活動資訊</h1>
			<input type="hidden" name="action" value="getAll">
			<button class="btn btn-primary mr-2 btn-separator" style="margin-bottom: 15px; font-size: 15px;">活動類別管理首頁</button>
		</div>
	</form>	
	</div>
	
	<div class="form-container" style="border: 1px solid #D3D3D3;">
	<form action="${pageContext.request.contextPath}/act.do" method="post"
			enctype="multipart/form-data">
		<div class="col-md-12">
		<div class="row g-0">
		<%--活動內容${(empVO.dept.deptNo==deptVO.deptNo)?'selected':'' }--%>
			<div class="col-md-4">
				<div class="form-group">
					<label for="actNo">活動編號</label> <input type="text" id="actNo" name="actNo" value="${actVO.actNo}" readonly>
				</div>
				<div class="form-group">
					<label for="actName">活動名稱</label> <input type="text" name="actName" required value=${actVO.actName==null? '': actVO.actName}>
				</div>
				<div class="form-group">
					<label for="actStatus">活動狀態</label> 
					<select size="1" name="actStatus">
					    <option value="true" ${actVO.actStatus ? 'selected' : ''}>上架</option>
					    <option value="false" ${!actVO.actStatus ? 'selected' : ''}>下架</option>
					</select>
					
		<%-- <select size="1" name="deptno"> 
			<c:forEach var="deptVO" items="${deptSvc.all}" >
				<option value="${deptVO.deptNo}" ${(empVO.dept.deptNo==deptVO.deptNo)?'selected':'' } >${deptVO.deptName}
				
			</c:forEach>
		</select>--%>

					
													
				</div>
				<div class="form-group">
					<label for="unitPrice">參加費用</label> <input type="text" name="unitPrice" required value=${actVO.unitPrice==null? '': actVO.unitPrice}>
				</div>				
			</div>
		<%--照片 style="padding: 2px; display: flex; flex-direction: column; align-items: center; justify-content: center; border: 1px solid #D3D3D3 
			 ;margin-top:15px; margin-right: 5px;"--%>
			<div class= "col-md-4">
    			<p>活動照片</p>
				<img src="<%=request.getContextPath()%>/dbg.do?act_no=${actVO.actNo==null? '':actVO.actNo}" alt="活動照片" class="img-fluid" <%--${actVO.actNo}--%>
				style="width: 250px; height: 200px; object-fit: cover;">
			</div>
		<%--預覽圖style="padding: 2px; display: flex; flex-direction: column; align-items: 
			center; justify-content: center; border: 1px solid #D3D3D3; margin-top:15px; margin-right: 5px;"--%>
			<div  class="col-md-4"  >
    			<p>選擇另一張封面</p>
				<input
					type="file" class="form-control-file" id="actPho1"
					name="actPho1" accept="image/*" onchange="showPreview">
				<img name="photoPreview" id="photoPreview"
					src="<%=request.getContextPath()%>/images/no-picture-taking.png"
					alt="相片預覽" style="width: 200px; height: 171px; object-fit: cover;">
			</div>
		</div>		
		
		<div id="actContent" class="col-md-12">
			<p><b>活動內容:</b></p>
			<textarea name="actContent" rows="10" cols="50" placeholder="請輸入" required >${actVO.actContent==null? '': actVO.actContent}</textarea>
		</div>
	
		</div>
		<div class="col-md-12"  style="margin-left: 20px; margin-bottom: 10px;">
			 <input type="hidden" name="actNo"value="${actVO.actNo}">
			 <input type="hidden" name="action"value="update">					
			<input type="submit" value="送出" class="btn btn-success mr-2 btn-separator" style="margin: 0px;">
		</div>
	</form>
	</div>

    <script>
    // 預覽相片
    document.getElementById('actPho1').addEventListener('change', function(e) {
        const preview = document.getElementById('photoPreview');
        const file = e.target.files[0];
        const reader = new FileReader();

        reader.onload = function(e) {
            preview.src = e.target.result;
        };

        reader.readAsDataURL(file);
    });
    </script>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>