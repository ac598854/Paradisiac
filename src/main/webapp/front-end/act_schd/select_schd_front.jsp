<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.photoAlbum.model.*"%>
<!DOCTYPE html>


<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>檔期列表</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
.album card mb-3 {
	position: relative;
}

.row.g-0 {
	position: relative;
}

.card-body {
	display: flex;
	justify-content: space-between; 
	flex-direction: row;
}

.col-md-6 {
	flex: 1;
	flex-direction: column;
}
<%--
.col-md-4, .col-md-8 {
	width: 100%;
}--%>


.album.card.mb-3 .row.g-0 .col-md-12 img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.album.card.mb-3 .row.g-0 .col-md-12 {
	height: 50%;
}

.d-flex.justify-content-end {
	position: absolute;
	bottom: 0;
	right: 0;
}
</style>
</head>

<body>
	<div id="dynamicContent"></div>
	<div class="container">
		<h1 class="text-center" style="margin-top: 10px;">顯示所有檔期</h1>

		<div class="album card mb-3">
			<div class="row g-0">
				<div class="col-md-12" style="height: 400px;">
					<img
						src="<%=request.getContextPath()%>/dbg.do?act_no=${actVO.actNo}"
						alt="活動封面" class="img-fluid">
				</div>

				<div class="col-md-12" style="margin-top: 10px;">
				<h1>${actVO.actNo}-${actVO.actName}</h1></div>
			</div>
			<div class="card-body">
				<%-- --%>
				<div class="col-md-6">
					<c:forEach var="line" items="${contents}">
                         	${line}<br />
					</c:forEach>
				</div>
				<div class="col-md-6"
					style="border: 1px solid gray; border-radius: 5px;">
					<p style="margin: 10px; font-weight: bold; font-size:20px;">報名費用NTD/人: ${actVO.unitPrice}</p>
					<c:forEach var="schd" items="${actSchdSet}">
						<ul style="margin-bottom: 0px;">
							<li>檔期編號: ${schd.schdNo}</li>
							<li>報名期間: ${schd.aplyTime} ~ ${schd.cutTime}</li>
							<li>活動舉辦日期: ${schd.holdDate}</li>
						</ul>
						<form method="post"
							action="${pageContext.request.contextPath}/schd.do">
							<button type="submit" class="btn btn-primary" id="submitButton"
								style="margin: 10px;">報名</button>
							<input type="hidden" name="schdNo" value="${schd.schdNo}">
							<input type="hidden" name="action" value="getOne_For_Display">
						</form>

					</c:forEach>
				</div>
			</div>
		</div>

	</div>




	<%@ include file="/front-end/index/footer.jsp" %>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js">     
    </script>
    <script>
	
    $(document).ready(function(){
        $.ajax({
            type: "POST",
            url: "<%=request.getContextPath()%>/front-end/members/members.do?action=indexLogin",
            success: function(data) {
                const responseMessage = parseInt(data);
                var  contextPath='<%=request.getContextPath()%>';
                var guided = contextPath + '/front-end/index/guided.jsp';
                var guidedSignout= contextPath + '/front-end/index/guidedSignout.jsp';
                if (responseMessage === 1) {
                    $("#dynamicContent").load(guided);
                } else if (responseMessage === 0) {

                    $("#dynamicContent").load(guidedSignout);
                }
            },
            error: function(error) {
                console.log("AJAX error:", error);
            }
        });
    });
        
</script>



</body>

</html>
