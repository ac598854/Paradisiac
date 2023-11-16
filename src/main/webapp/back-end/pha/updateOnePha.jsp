<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>相簿管理系統</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .custom-container {
            max-width: 960px;
            border: 1px solid #ccc;
            padding: 20px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
	<div class="custom-container">

	<h1>相簿管理系統</h1>
	<a href='${pageContext.request.contextPath}/pha.do?action=getAll'>查詢</a>所有相簿.
	<a href="${pageContext.request.contextPath}/back-end/pha/select_phoalb.jsp">回首頁</a>	
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<div class="custom-container">
	<h2>修改相簿</h2>
        <form action="${pageContext.request.contextPath}/pha.do" method="post" enctype="multipart/form-data">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="albumNumber">相簿編號</label>
                        <input type="text" class="form-control" id="albNo" name="albNo" value="${phaVO.albNo}" readonly>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="memberNumber">會員編號</label>
                        <input type="text" class="form-control" id="memNo" name="memNo" value="${phaVO.memNo}" readonly>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="albumName">相簿名稱</label>
                        <input type="text" class="form-control" id="albName" name="albName" value="${phaVO.albName}">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="albumCover" id = "albumCover">相簿封面</label>
                        <img id="albPhoto" src="<%=request.getContextPath()%>/dbg.do?alb_no=${phaVO.albNo}" alt="相簿封面" class="img-fluid">
                        <input type="file" class="form-control-file" id="albPhoto" name="albPhoto" accept="image/*">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="createTime">相簿建立時間</label>
                        <input type="date" class="form-control" id="albDate" name="albDate" value="${phaVO.albDate}" required>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>相片封面預覽區</label>
                        <img id="photoPreview" src="#" alt="封面預覽" style="max-width: 100%; max-height: 200px;">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <input type="hidden" name="action" value="update">
                        <button type="submit" class="btn btn-primary" id="albumSubmit">送出</button>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <script>
        // 預覽相片
        document.getElementById('albumCover').addEventListener('change', function(e) {
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