<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.photoAlbum.model.*"%>
<!DOCTYPE html>


<html>
<head>
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
		    max-width: 30%;  /*添加此行以限制最大宽度 */
		    height: 200px; /* auto自动调整高度以保持纵横比 */
            background-color: #eee;
            border: 1px solid #ccc;
            margin: 5px;
        }
        /*
        .album .d-flex.justify-content-end {
        position: absolute;
        bottom: 0;
        right: 0;
        }*/

        .d-flex.justify-content-end {
        position: absolute;
        bottom: 0;
        right: 0;
        }

        .album-info {
        margin-bottom: 50px; /* 调整表格与按钮之间的距离 */
        }

        .btn-separator {
        margin-right: 5px; /* 为按钮之间添加5px的间距 */
        }

    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center">相簿管理</h1>
        <div>
            <h2 class="d-flex justify-content-between">
                瀏覽紀念相簿
                <a href="${pageContext.request.contextPath}/back-end/pha/select_phoalb.jsp" class="btn btn-secondary">回首頁</a>
            </h2>
        </div>

        <div class="album card mb-3">
            <div class="row g-0">
                <div class="col-md-4">
                    <img id="albPhoto" src="<%=request.getContextPath()%>/dbg.do?alb_no=${list[0].albNo}" alt="相簿封面" class="img-fluid">
                </div>
                <div class="col-md-8">
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
                        <div class="d-flex justify-content-end">
                            <button class="btn btn-primary mr-2 btn-separator">修改相簿</button>
                            <button class="btn btn-danger">刪除相簿</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <h2>相片管理</h2>
        <c:if test="${phoPageQty > 0}">
	  	<b><font color=red>第${currentPage}/${phoPageQty}頁</font></b>
		</c:if>
		<div class="album card mb-3">
			<div class="row g-0">
				<div class="col-md-8">
					<div class="card-body">
						<FORM id= "photoForm" METHOD="post" ACTION="<%=request.getContextPath()%>/pho.do">
							<div class="photo-content d-flex">
								<c:forEach var="pha" items="${list}">
									<input type="checkbox" name="photoNo" id="${pha.photoNo}" value="${pha.photoNo}">										
									<img src="<%=request.getContextPath()%>/dbg.do?photo_no=${pha.photoNo}" alt="相片1" class="img-fluid">
								</c:forEach>
							</div>
							<div class="d-flex justify-content-end">											
								<input type="hidden" name="action" value="delete"> 
								<input type="hidden" name="albNo" value="${list[0].albNo}"> 
								<%-- <button class="btn btn-danger" id="delpho">刪除相片</button>--%>
								<input class="btn btn-danger" type="submit" value="刪除相片">
							</div>
						</FORM>
						<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pha.do" class="btn btn-success mr-2 btn-separator">			
							<input type="hidden" name="action" value="insertPhoto">
							<input type="submit" value="新增相片" class="btn btn-success mr-2 btn-separator"> <input type="hidden" name="albNo" value="${list[0].albNo}"> 
						</FORM>
						
					</div>
				</div>
			</div>
		</div>
		<c:if test="${currentPage > 1}">
			<a href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display&albNo=${list[0].albNo}&page=1">至第一頁</a>&nbsp;
		</c:if> 
		<c:if test="${currentPage - 1 != 0}">
			<a href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display&albNo=${list[0].albNo}&page=${currentPage - 1}">上一頁</a>&nbsp;
		</c:if>                                             
		<c:if test="${currentPage + 1 <= phoPageQty}">      
			<a href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display&albNo=${list[0].albNo}&page=${currentPage + 1}">下一頁</a>&nbsp;
		</c:if>                                             
		<c:if test="${currentPage != phoPageQty}">          
			<a href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display&albNo=${list[0].albNo}&page=${phoPageQty}">至最後一頁</a>&nbsp;
		</c:if>
    </div>

    <!-- 引入 Bootstrap JavaScript 文件（如果需要） -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js">
     
    </script>



</body>
</html>
