<%@ page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.roomZ.roompicture.entity.*"%>
<%@ page import="com.paradisiac.roomZ.roompicture.service.*"%>
<%@ page import="com.paradisiac.roomZ.roompicture.dao.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
    <title>新增照片</title>
    <style>

    </style>
</head>
<body>
    <form method="POST" action="${pageContext.request.contextPath}/roompic/roompic.do" name="form1" enctype="multipart/form-data" >
        <div class="container d-flex justify-content-center align-items-center min-vh-100">
            <div class="row border rounded-5 p-3 bg-white shadow box-area">
                <div class="header-text text-center">
                    <h3>請填寫資料</h3>
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
                            <input type="file" id="text6" name="image" value="${param.Pic}" onchange="previewImage(this)">
                            <img id="imagePreview" src="#" alt="Preview" style="max-width: 100px; display: none;">
                        </div>
                    </div>
                </div>
                <div class="input-group g-3 mb-2">
                    <button type="submit" class="btn btn-lg btn-primary w-100 fs-6">送出</button>
                    <input type="hidden" name="action" value="insert">
                </div>
            </div>
        </div>
    </form>


    <script>
        function previewImage(input) {
            var imagePreview = document.getElementById('imagePreview');
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    imagePreview.src = e.target.result;
                    imagePreview.style.display = 'block';
                };
                reader.readAsDataURL(input.files[0]);
            } else {
                imagePreview.style.display = 'none';
            }
        }
        

    </script>
</body>
</html>
