<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.photoAlbum.model.*"%>
<!DOCTYPE html>


<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>相簿管理</title>
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

.btn-separator {
	margin-left: 10px;
	font-size: 12px
}

table {
	font-size: 15px;
}
<%--新增相片--%>
 .col-md-12 p,
  .col-md-12 label,
  .col-md-12 input[type="submit"],
  .col-md-12 input[type="file"] {
    font-size: 12px;
}

</style>
</head>

<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
	<div class="container">
		<h1 class="text-center">相簿管理</h1>
		<div>
			<h2 class="d-flex justify-content-between">
				瀏覽紀念相簿 <a href="${pageContext.request.contextPath}/back-end/pha/select_phoalb.jsp" class="btn btn-secondary" style="font-size: 12px;">會員相簿首頁</a>				
			</h2>
			
		</div>

		<div class="album card mb-3">
			<div class="row g-0">
				<div class="col-md-7">
					<img id="albPhoto"
						src="<%=request.getContextPath()%>/dbg.do?alb_no=${list[0].albNo}"
						style="width: 100%; height: 200px; object-fit: cover;" alt="相簿封面" class="img-fluid">
				</div>
				<div class="col-md-5">
					<div class="album-info">
						<table class="table table-bordered">
							<tr>
								<td>相簿編號:</td>
								<td>${list[0].albNo}</td>
							</tr>
							<tr>
								<td>相簿名稱:</td>
								<td>${list[0].albName}</td>
							</tr>
							<tr>
								<td>會員編號:</td>
								<td>${list[0].memNo}</td>
							</tr>
							<tr>
								<td>相簿日期:</td>
								<td>${list[0].albDate}</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>

		<div class="flex-container">
		    <h2>相片管理</h2>
		</div>
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
									<input type="checkbox" name="photoNo" id="${pha.photoNo}" style="margin-bottom: 5px;"
									value="${pha.photoNo}">
									<img
										src="<%=request.getContextPath()%>/dbg.do?photo_no=${pha.photoNo}"
										style="width: 100%; height: 200px; object-fit: cover;" alt="相片1" class="img-fluid">
									<table>
										<tr>
											<td>相片名稱:</td>
											<td>${pha.photoName}</td>
										</tr>
										<tr>
											<td>相片編號:</td>
											<td>${pha.photoNo}</td>
										</tr>
										<tr>
											<td>相片日期:</td>
											<td>${pha.photoDate}</td>
										</tr>
									</table>
								</div>
							</c:forEach>
						</div>
												
						<div class="col-md-12">
							<div>
								<input type="hidden" name="action" value="delete"> <input
									type="hidden" name="albNo" value="${list[0].albNo}"> <input
									class="btn btn-danger" type="submit" value="刪除相片" style="font-size: 12px;">
							</div>
						</div>
					</form>
					
				</div>
			</div>
		</div>

		<c:if test="${currentPage > 1}">
			<a
				href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display&albNo=${list[0].albNo}&page=1" style="font-size: 15px;">至第一頁</a>&nbsp;
		</c:if>
		<c:if test="${currentPage - 1 != 0}">
			<a
				href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display&albNo=${list[0].albNo}&page=${currentPage - 1}" style="font-size: 15px;">上一頁</a>&nbsp;
		</c:if>
		<c:if test="${currentPage + 1 <= phoPageQty}">
			<a
				href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display&albNo=${list[0].albNo}&page=${currentPage + 1}" style="font-size: 15px;">下一頁</a>&nbsp;
		</c:if>
		<c:if test="${currentPage != phoPageQty}">
			<a
				href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display&albNo=${list[0].albNo}&page=${phoPageQty}" style="font-size: 15px;">至最後一頁</a>&nbsp;
		</c:if>

		<%--新增相片 --%>
		<div class="album card mb-3" style="border: 1px solid #CFCFCF">
			<div class="row g-0">
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
				<div class="col-md-12">
					<form action="${pageContext.request.contextPath}/pho.do"
						method="post" enctype="multipart/form-data">
						<div class="col-md-12" style="display: flex; align-items: center; margin-top: 10px;">
						  <p style="margin: 0px;">相片日期：</p>
						  <input type="date" name="photoDate" required>
						</div>							
						<div class="col-md-4"
							style="padding: 5px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
							<input type="hidden" name="photoName1"> 
							<input class="photo" type="file"
								name="photo1" accept="image/*" onchange="showPreview">
							<img name="photoPreview" src="<%=request.getContextPath()%>/images/no-picture-taking.png" alt="相片預覽"
								style="width: 200px; height: 200px; object-fit: cover;">
						</div>
						<div class="col-md-4"
							style="padding: 5px; display: flex; flex-direction: column; align-items: center; ">
							<input type="hidden" name="photoName2"> 
							<input class="photo" type="file"
								name="photo2" accept="image/*" onchange="showPreview" >
							<img name="photoPreview" src="<%=request.getContextPath()%>/images/no-picture-taking.png" alt="相片預覽"
								style="width: 200px; height: 200px; object-fit: cover;">
						</div>
						<div class="col-md-4"
							style="padding: 5px; display: flex; flex-direction: column; align-items: center; ">
							<input type="hidden" name="photoName3">
							<input class="photo" type="file"
								name="photo3" accept="image/*" onchange="showPreview">
							<img name="photoPreview" src="<%=request.getContextPath()%>/images/no-picture-taking.png" alt="相片預覽"
								style="width: 200px; height: 200px; object-fit: cover;">
						</div>

						<div class="col-md-12">
							<input type="hidden" name="memNo" value="${list[0].memNo}">
							<input type="hidden" name="albNo" value="${list[0].albNo}">
							<input type="hidden" name="action" value="insert"> <input
								type="submit" value="新增相片"
								class="btn btn-success mr-2 btn-separator" style="margin: 0px;">
						</div>
					</form>
				</div>
			</div>
		</div>



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
