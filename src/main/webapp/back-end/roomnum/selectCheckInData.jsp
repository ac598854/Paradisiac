<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>客房登記管理系統</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
    src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
.container-custom {
	max-width: 960px;
	margin: 0 auto;
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #f9f9f9;
	margin-top: 50px;
}

.form-group {
	margin-bottom: 20px;
}
</style>
</head>
<body>
<%@ include file="/back-end/index/back-left_room.jsp" %>
    <div class="container-custom">
        <h2>客房登記管理系統</h2>
        
        <form method="post" action="${pageContext.request.contextPath}/order.do" class="form-horizontal">
            <div class="form-group">
                <label class="control-label col-sm-2" for="memName">會員姓名:</label>
                <div class="col-sm-10">
                    <input name="memName" class="form-control" id="memName" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="memId">身份證字號:</label>
                <div class="col-sm-10">
                    <input name="memId" class="form-control" id="memId" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="memPhone">會員電話:</label>
                <div class="col-sm-10">
                    <input name="memPhone" class="form-control" id="memPhone" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="roomOrderNo">訂單編號:</label>
                <div class="col-sm-10">
                    <input name="roomOrderNo" class="form-control" id="roomOrderNo" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-default">確認</button>
                </div>
            </div>
            <input type="hidden" name="action" value="checkInData">
        </form>
    </div>

</body>
</html>
