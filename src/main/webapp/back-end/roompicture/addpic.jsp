<%@ page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		.body{
			padding-left: 220px; 
			margin-left: 240px;
		}
       
		.container {
		    display: flex;
		    justify-content: center; /* 水平居中 */
		    align-items: center; /* 垂直居中 */
		    height: 100vh; /* 容器高度設置為視窗高度 */
		    padding-left: 50px;
		}
        
        
        .card {
	        max-width: 1240px;
		    width: 100%; 
		    margin: auto; 
            border: 1px solid #ccc;
            padding: 20px;
        }
        

        .btn-icon {
            font-size: 1.2em; 
        }
        

        .custom-width {
            max-width: 640px; 
            margin: auto;
        }
        .image-preview-card {
		    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
		    transition: 0.3s;
		    width: 100%; /* 根據需要調整 */
		}
		
		.image-preview-card:hover {
		    box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
		}
		
		.image-preview-card img {
		    width: 80%; 
		    display: block; 
		    height: auto; 
		}
		
    </style>
     <%@ include file="/back-end/index/ManagerMeta.jsp" %>
</head>
<body>
	   <div class="sidebar">
			<%@ include file="/back-end/index/ManagerBody.jsp" %>
       </div>

		<div class="container">
		    <div class="row">
		        	<h3>新增房型圖片資料</h3>
		        <div class="col-md-6">
		              <div class="card">
		            <form method="POST" action="${pageContext.request.contextPath}/roompic/roompic.do?action=insert" name="form1" enctype="multipart/form-data" onsubmit="return validateForm()">

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
			                            <input type="file" id="text6" name="image" value="${param.Pic}" accept="image/png, image/jpeg, image/gif" onchange="previewImage(this)">
			                        </div>
			                    </div>
			                </div>
			                <div class="input-group g-3 mb-2">
			                    <button type="submit" class="btn btn-lg btn-primary w-100 fs-6">送出</button>
			                    <input type="hidden" name="action" value="insert">
			                </div>
	                 </form>
		        	</div>
				</div>
		        <!-- 圖片預覽所在的列 -->
		        <div class="col-md-6">
		            <div class="card image-preview-card">
		                <div class="card-body">
		                    <h5 class="card-title">您準備新增的房型圖片</h5>
		                    <img id="imagePreview" src="#" alt="Image Preview" style="display: none;">
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
       
	<script>
			function validateForm() {
			    var roomTypeNo = document.getElementById('roomTypeNo').value;
			    var imageInput = document.getElementById('text6');
			    var image = imageInput.files && imageInput.files[0] ? imageInput.files[0] : null;
		
			    if (!roomTypeNo) {
			        alert('請輸入編號。');
			        return false;
			    }
			    
			    if (!image) {
			        alert('請選擇圖片。');
			        return false;
			    }
		
			    return true;
			}

	</script>

    <script>
	    function previewImage(input) {
	        var imagePreview = document.getElementById('imagePreview'); // 確保這是正確的img元素的id
	        if (input.files && input.files[0]) {
	            var reader = new FileReader();
	            reader.onload = function (e) {
	                imagePreview.src = e.target.result;
	                imagePreview.style.display = 'block'; // 顯示圖片
	            };
	            reader.readAsDataURL(input.files[0]);
	        } else {
	            imagePreview.style.display = 'none'; // 如果沒有選擇圖片，則隱藏
	        }
	    }
    </script>
</body>
</html>
