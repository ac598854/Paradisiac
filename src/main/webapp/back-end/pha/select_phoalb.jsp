<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>相簿管理系統</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
.form-group{
	margin-top: 5px;
}
</style>
 <title>相簿管理系統</title>
</head>

<body>
	<%@ include file="/back-end/index/ManagerBody.jsp"%>
<h1>相簿管理系統</h1>	
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

    <!-- 相簿查詢 -->
    <div class="col-md-12" style="margin-top: 10px;">
    	<h2>查詢相簿</h2>
    </div>
    <div class="form-container" style="border: 1px solid #D3D3D3;">
    	<FORM METHOD="post" ACTION="${pageContext.request.contextPath}/pha.do">  		
    		<div class="form-group col-md-2" style="margin-top: 10px;">
    			<input type="hidden" name="action" value="getAll">
	       		<button class="btn btn-primary mr-2 btn-separator">查詢所有相簿</button>
	    	</div>
    	</FORM>   	
 	    <FORM METHOD="post" ACTION="${pageContext.request.contextPath}/pha.do"> 
		    <div style=" display: flex;">
		    	<div class="form-group col-md-4" >
		            <label for="albNo">輸入相簿編號-查詢相簿與照片</label>
		            <input type="text" name="albNo" id="albumNumber" class="form-control" required>
		        </div>      
		    </div>
		    <div class="form-group col-md-2"> 
		    	<input type="hidden" name="action" value="getOne_For_Display">	    	
		       	<button type="submit" class="btn btn-primary mr-2 btn-separator">查詢相簿</button>
		    </div>
	    </FORM><%----%>            
	</div>

    <!-- 新增相簿 -->
    <div class="col-md-12" style="margin-top: 10px;">
    	<h2>新增相簿</h2>
    </div> 
	<div class="form-container" style="border: 1px solid black;">
	<form action="${pageContext.request.contextPath}/pha.do" method="post"
			enctype="multipart/form-data">
		<div class="col-md-12">
			<div class="col-md-6">
				<div class="form-group">
					<label for="albumNo">相簿編號</label> <input type="text" id="albNo" name="albNo" required>
				</div>
				<div class="form-group">
					<label for="memberNo">會員編號</label> <input type="text" id="memNo" name="memNo" required>
				</div>
				<div class="form-group">
					<label for="albumName">相簿名稱</label> <input type="text"
						id="albName" name="albName" required>
				</div>
				<div class="form-group">
					<label for="createDate">相簿建立日期</label> <input type="date"
						id="createDate" id="albDate" name="albDate" required>
				</div>
			</div>

			<div class="col-md-4"
				style="padding: 5px; display: flex; flex-direction: column; align-items: center; 
    			justify-content: center; border: 1px solid #D3D3D3; margin-top:15px;">
    			<p>相簿封面</p>
				<input
					type="file" class="form-control-file" id="actPhoto"
					name="albPhoto" accept="image/*" onchange="showPreview">
				<img name="photoPreview" id="photoPreview"
					src="<%=request.getContextPath()%>/images/no-picture-taking.png"
					alt="相片預覽" style="width: 200px; height: 200px; object-fit: cover;">
			</div>
		</div>
		<div class="col-md-12"  style="margin-left: 20px; margin-bottom: 10px;">
			<input type="hidden" name="action" value="insert">							
			<input type="submit" value="新增相簿" class="btn btn-success mr-2 btn-separator" style="margin: 0px;">
		</div>
	</form>
	</div>

	<script>
		// 預覽相片
		document.getElementById('actPhoto').addEventListener('change',
				function(e) {
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
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>