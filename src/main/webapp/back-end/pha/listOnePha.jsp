<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.paradisiac.photoAlbum.model.*"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>


<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>瀏覽紀念相簿</title> <a href="${pageContext.request.contextPath}/back-end/pha/select_phoalb.jsp">回首頁</a>	
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .custom-container {
            max-width: 960px;
            border: 1px solid #ccc;
            padding: 20px;
            margin: 0 auto;
        }
        .photo-preview {
            max-width: 100%;
            max-height: 200px;
        }
        .btn-space {
            margin-right: 10px;
        }
        .readonly {
            border: none;
            background-color: lightgray;
            outline: none;
        }
    </style>
</head>
<body>


    <div class="custom-container">
        <h1>瀏覽紀念相簿</h1>
        <form action="#" method="post">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        相簿編號: <input type="text" class="form-control readonly" id="albNo" name="albNo" readonly value="${list[0].albNo}">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        會員編號: <input type="text" class="form-control readonly" id="memNo" name="memNo" readonly value="${list[0].memNo}">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        相簿名稱: <input type="text" class="form-control readonly" id="albName" name="albName" readonly value="${list[0].albName}">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        相簿時間: <input type="text" class="form-control readonly" id="albDate" name="albDate" readonly value="${list[0].albDate}">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <h4>相片封面</h4>
                    <img id="albPhoto" class="photo-preview" src="<%=request.getContextPath()%>/dbg.do?alb_no=${list[0].albNo}" alt="相片预览">
                </div>
            </div>
    <c:if test="${phoPageQty > 0}">
  	<b><font color=red>第${currentPage}/${phoPageQty}頁</font></b>
	</c:if>
            <div class="row">
                <div class="col-12">
                    <button type="submit" class="btn btn-primary btn-space" id="editButton">修改相簿</button>
                    <button type="submit" class="btn btn-primary btn-space">儲存相簿</button>
                    <button type="submit" class="btn btn-danger btn-space">刪除相簿</button>
                    <button type="submit" class="btn btn-primary btn-space">新增相片</button>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4">
             
                <c:forEach var="pha" items="${list}" >
                    <div class="form-group">
                        <img class="photo-preview" src="<%=request.getContextPath()%>/dbg.do?photo_no=${pha.photoNo}" alt="相片预览">
                    </div>
                </div>
                </c:forEach>

            </div>

        </form>
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
    

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        document.getElementById('editButton').addEventListener('click', function() {
            const inputs = document.querySelectorAll('.readonly');
            inputs.forEach(input => {
                input.readOnly = false;
                input.classList.remove('readonly');
            });
        });
    </script>
</body>
</html>
