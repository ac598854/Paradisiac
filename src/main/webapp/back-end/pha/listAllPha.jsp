<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.photoAlbum.model.*"%>
<!DOCTYPE html>


<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <title>相簿管理</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .album card mb-3 {
            position: relative;
        }

        .row.g-0 {
        position: relative;
        }
        .d-flex justify-content-end {
            position: absolute;
            bottom: 0;
            right: 0;
        }
        .photo-content d-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .photo-content img {
		    max-width: 40%;  
		    height: 200px; 
            background-color: #eee;
            border: 1px solid #ccc;
            margin: 5px;
        }


        .d-flex.justify-content-end {
        position: absolute;
        bottom: 0;
        right: 0;
        }

        .album-info {
        margin-bottom: 50px; 
        }

        .btn-separator {
        margin-right: 5px; 
        }

    </style>
</head>

<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
    <div class="container">
        <h1 class="text-center">相簿管理</h1>
        <div>
            <h2 class="d-flex justify-content-between">
                顯示所有相簿
                <a href="${pageContext.request.contextPath}/back-end/pha/select_phoalb.jsp" class="btn btn-secondary">回首頁</a>
            </h2>
        </div>
	<c:if test="${phaPageQty > 0}">
  	<b><font color=red>第${currentPage}/${phaPageQty}頁</font></b>
	</c:if>
		<c:forEach var="pha" items="${phaList}">
        <div class="album card mb-3">
            <div class="row g-0">
                <div class="col-md-4">
                    <img id="albPhoto" src="<%=request.getContextPath()%>/dbg.do?alb_no=${pha.albNo}" 
                    style="height: 200px; object-fit: cover;" alt="相簿封面" class="img-fluid">
                </div>
                <div class="col-md-8">
                    <div class="album-info">
                        <table class="table table-bordered">
                            <tr>
                                <td>相簿名稱:</td>
                                <td>${pha.albName}</td>
                            </tr>
                            <tr>
                                <td>相簿編號:</td>
                                <td>${pha.albNo}</td>
                            </tr>
                            <tr>
                                <td>會員編號:</td>
                                <td>${pha.memNo}</td>
                            </tr>
                            <tr>
                                <td>相簿建立時間</td>
                                <td>${pha.albDate}</td>
                            </tr>
                        </table>
                        <div class="d-flex justify-content-end">
                        <FORM METHOD="post" ACTION="${pageContext.request.contextPath}/pha.do" style="margin-bottom: 0px;">
                        	<input type="hidden" name="albNo" value="${pha.albNo}"> 
							<input type="hidden" name="action" value="getOne_For_Update">
                            <button type="submit" class="btn btn-primary mr-2 btn-separator">修改相簿</button>
                        </FORM>                        
                        </div>
                    </div>
                </div>
            </div>
        </div>
    	</c:forEach>

	<c:if test="${currentPage > 1}">
		<a href="${pageContext.request.contextPath}/pha.do?action=getAll&page=1">至第一頁</a>&nbsp;
	</c:if>
	<c:if test="${currentPage - 1 != 0}">
		<a href="${pageContext.request.contextPath}/pha.do?action=getAll&page=${currentPage - 1}">上一頁</a>&nbsp;
	</c:if>                                             
	<c:if test="${currentPage + 1 <= phaPageQty}">      
		<a href="${pageContext.request.contextPath}/pha.do?action=getAll&page=${currentPage + 1}">下一頁</a>&nbsp;
	</c:if>                                             
	<c:if test="${currentPage != phaPageQty}">          
		<a href="${pageContext.request.contextPath}/pha.do?action=getAll&page=${phaPageQty}">至最後一頁</a>&nbsp;
	</c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js">
   
    </script>



</body>
</html>
