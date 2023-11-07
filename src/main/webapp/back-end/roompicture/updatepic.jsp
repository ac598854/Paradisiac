<%@page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.roompicture.entity.*"%>
<%@ page import="com.paradisiac.roompicture.service.*"%>
<%@ page import="com.paradisiac.roompicture.dao.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<title>修改資料</title>
<style>
body {
	font-family: 'Poppins', sans-serif;
	background: linear-gradient(45deg, #c5deea 0%, #8abbd7 31%, #066dab 100%);
}

.box-area {
	width: 530px;
}

::placeholder {
	font-size: 14px;
}

span {
	font-size: 13px;
	color: red;
	white-space: nowrap;
}
</style>
</head>

<body>
	<FORM METHOD="post" ACTION="${pageContext.request.contextPath}/roompic/roompic.do" name="form1" enctype="multipart/form-data"> <!--enctype="multipart/form-data" -->
		<div
			class="container d-flex justify-content-center align-items-center min-vh-100">
			<div class="row border rounded-5 p-3 bg-white shadow box-area">
				<div class="header-text text-center">
					<div class="d-flex justify-content-end">
						<button type="button" class="btn btn-primary" id="mainPage">返回</button>
					</div>
					<h3>修改資料</h3>
				</div>
				<div class="row g-1 align-items-center ms-5">
					<div class="col-auto offset-1">
						<label for="text1" class="col-form-label">照片編號 : <font
							color=red><b>*</b></font></label>
					</div>
					<div class="col-auto">
						<div>${param.pictureNo}</div>

					</div>
				</div>
				<div class="row g-1 align-items-center ms-5">
					<div class="col-auto offset-1">
						<label for="roomTypeNo" class="col-form-label">roomTypeNo:</label>
					</div>
					<div class="col-auto">
						<div class="d-flex align-items-center">
							<input type="text" id="roomTypeNo" class="form-control" name="roomTypeNo" value="${param.roomTypeNo}">
							
						</div>
					</div>
				</div>
				
				<div class="row g-1 align-items-center ms-5">
					<div class="col-auto offset-1">
						<label for="text6" class="col-form-label">照片:</label>
					</div>
					<div class="col-auto">
						<div class="d-flex align-items-center">
							<input type="file" id="text6" name="image"
								value="${param.Pic}">
						</div>
					</div>
				</div>
			
			
				<div class="input-group g-3 mb-2">
					<button type="submit" class="btn btn-lg btn-primary w-100 fs-6">送出</button>
					<input type="hidden" name="action" value="update">
					<input type="hidden" name="adminNo" value="${param.pictureNo}">
				</div>
			</div>
		</div>
	</FORM>



</body>
</html>