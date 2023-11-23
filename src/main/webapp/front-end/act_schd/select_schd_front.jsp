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
        flex-direction: row;
        }

        .col-md-6 {
            flex: 1; 
            flex-direction: column;
        }

        .col-md-4,
        .col-md-8 {
            width: 100%; 
        }


<%----%>/*--------封面-------------------*/

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

</style>
</head>

<body>
<%@ include file="/front-end/index/guided.jsp" %>
	<div class="container">
        <h1 class="text-center">顯示所有檔期</h1>

        <div class="album card mb-3">
            <div class="row g-0">
                <div class="col-md-12" style="height: 400px;">
                    <img src="<%=request.getContextPath()%>/dbg.do?act_no=${actVO.actNo}" alt="活動封面" class="img-fluid">
                </div>                
            </div>

        <div class="album card mb-1">
        

            <div class="row g-0">
                <div class="col-md-12">
                </div><h1>${actVO.actNo}-${actVO.actName}</h1></div>
                    <div class="card-body" >
                        <div class="col-md-6">
                            <p>${actVO.actContent}</p>
                        </div>
                        <div class="col-md-6">
                            <div class="col-md-2">                            
                                <label>報名費用NTD/人: ${actVO.unitPrice}</label>                                                                                                 
                            </div>
                            <div class="col-md-10">
                            <c:forEach var="schd" items="${actSchdSet}">
                                <ul><li>檔期編號: ${schd.schdNo}</li>
                                    <li>報名期間: ${schd.aplyTime} ~ ${schd.cutTime}</li>
                                    <li>活動舉辦日期: ${schd.holdDate}</li>
                                </ul>
                                <form  method="post" action="${pageContext.request.contextPath}/schd.do">
							      	<button type="submit" class="btn btn-primary" id="submitButton">報名</button>
							     	<input type="hidden" name="schdNo" value="${schd.schdNo}">
	     							<input type="hidden" name="action" value="getOne_For_Display">
	     						</form>
                               
                            </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js">
     
    </script>


<%@ include file="/front-end/index/footer.jsp" %>
</body>

</html>
