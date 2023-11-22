<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.photoAlbum.model.*"%>
<!DOCTYPE html>


<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>測試報名檔期</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
 

</style>
</head>

<body>
<%@ include file="/front-end/index/guided.jsp" %>
	<div class="container">
        <h1 class="text-center">報名頁面</h1>
        <div>
            <h2 class="d-flex justify-content-between">           
                <a href="index.html" class="btn btn-secondary">回首頁</a>
            </h2>
        </div>

        <div class="album card mb-3">
            <h2>活動:${schdVO.act.actNo}-${schdVO.act.actName}</h2>
            <h2>檔期編號:${schdVO.schdNo}</h2>
        </div>


    </div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js">
     
    </script>



</body>
<%@ include file="/front-end/index/footer.jsp" %>
</html>
