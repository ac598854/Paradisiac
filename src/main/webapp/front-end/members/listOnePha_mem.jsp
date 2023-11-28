<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.photoAlbum.model.*"%>
<!DOCTYPE html>


<html>
<head>
<%@ include file="/front-end/index/MembersMeta.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>會員紀念相簿</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
.btn-separator {
	margin-left: auto;
}

.flex-container {
	display: flex;
	align-items: center;
}



table {
	font-size: 15px;
}


</style>
</head>

<body>
<%@ include file="/front-end/index/MembersBody.jsp"%>
	<div class="container">
		<h1 class="text-center">會員紀念相簿</h1>
		<div>
			<h2 class="d-flex justify-content-between">
				 我的相簿				
			</h2>
			
		</div>

		<div class="album card mb-3">
			<div class="row g-0">
				<div class="col-md-7">
					<img id="albPhoto"
						src="<%=request.getContextPath()%>/dbg.do?alb_no=${phaVO.albNo}"
						style="width: 100%; height: 300px; object-fit: cover;" alt="相簿封面" class="img-fluid">
				</div>
				<div class="col-md-5">
					<div class="album-info">
						<table class="table table-bordered">
							<tr>
								<td>相簿編號:</td>
								<td>${phaVO.albNo}</td>
							</tr>
							<tr>
								<td>相簿名稱:</td>
								<td>${phaVO.albName}</td>
							</tr>
							<tr>
								<td>會員編號:</td>
								<td>${phaVO.memNo}</td>
							</tr>
							<tr>
								<td>相簿日期:</td>
								<td>${phaVO.albDate}</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
 
		<div class="flex-container">
		    <h2>我的相片</h2>		    
		</div>
		<c:if test="${not empty errorMsgs}">
			    <div style="color: red; font-size: 15px;">
			        請修正以下錯誤:
			        <ul>
			            <c:forEach var="message" items="${errorMsgs}">
			                <li>${message}</li>
			            </c:forEach>
			        </ul>
			    </div>
		</c:if>
		<c:if test="${phoPageQty > 0}">
			<b><span style="color: red; font-size: 15px;">第${currentPage}/${phoPageQty}頁</span></b>
		</c:if>
				
		<div class="album card mb-3">

			<div class="row g-0">
				<div class="col-md-12">
					<form id="photoForm" method="post"
						action="<%=request.getContextPath()%>/pho.do">
						<div class="col-md-12" >
							<c:forEach var="pha" items="${list}">									
								<div class="col-md-4"  style="padding: 5px; display: flex; flex-direction: column; align-items: center;">									
									<img
										src="<%=request.getContextPath()%>/dbg.do?photo_no=${pha.photoNo}"
										style="width: 100%; height: 400px; object-fit: cover;" alt="相片1" class="img-fluid">
									<table>
										<%--<tr>
											 <td>相片名稱:</td>
											<td>${pha.photoName}</td>
										</tr>
										<tr>
											<td>相片編號:</td>
											<td>${pha.photoNo}</td>
										</tr>--%>
										<tr>
											<td>相片日期:</td>
											<td>${pha.photoDate}</td>
										</tr>
									</table>
								</div>
							</c:forEach>
						</div>

					</form>
					
				</div>
			</div>
		</div>

		<c:if test="${currentPage > 1}">
			<a
				href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display&albNo=${phaVO.albNo}&page=1" style="font-size: 15px;">至第一頁</a>&nbsp;
		</c:if>
		<c:if test="${currentPage - 1 != 0}">
			<a
				href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display&albNo=${phaVO.albNo}&page=${currentPage - 1}" style="font-size: 15px;">上一頁</a>&nbsp;
		</c:if>
		<c:if test="${currentPage + 1 <= phoPageQty}">
			<a
				href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display&albNo=${phaVO.albNo}&page=${currentPage + 1}" style="font-size: 15px;">下一頁</a>&nbsp;
		</c:if>
		<c:if test="${currentPage != phoPageQty}">
			<a
				href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display&albNo=${phaVO.albNo}&page=${phoPageQty}" style="font-size: 15px;">至最後一頁</a>&nbsp;
		</c:if>




	</div><%--container --%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js">     
    </script>
	<script>
		// 取得"選取檔案"的檔名(輸入元素)
		function fileName(inputName, fileInput) {
			var nameInput = document.querySelector('input[name="' + inputName
					+ '"]');
			if (fileInput.files.length > 0) { //有選到檔案, 檔案名稱長度>0
				nameInput.value = fileInput.name; //nameInput.value = fileInput.files[0].name;
			} else {
				nameInput.value = "";
			}
		}

		var photo1 = document.querySelector('input[name="photo1"]');//檔案名稱
		// 當選擇檔案時觸發事件
		photo1.addEventListener('change', function() {
			fileName('photoName1', photo1);//設定相片的name = 檔案名稱
		});

		var photo2 = document.querySelector('input[name="photo2"]');//檔案名稱
		photo2.addEventListener('change', function() {
			fileName('photoName2', photo2);//設定相片的name = 檔案名稱
		});

		var photo3 = document.querySelector('input[name="photo3"]');//檔案名稱
		photo3.addEventListener('change', function() {
			fileName('photoName3', photo3);//設定相片的name = 檔案名稱
		});

		// 預覽相片
		const photoElements = document.getElementsByClassName('photo');
		for (let i = 0; i < photoElements.length; i++) {
			photoElements[i].addEventListener('change', function(e) {
				const preview = document.getElementsByName('photoPreview')[i];

				const file = e.target.files[0];
				const reader = new FileReader();

				reader.onload = function(e) {
					preview.src = e.target.result;
				};
				reader.readAsDataURL(file);

			});
		}
	</script>




</body>
</html>
