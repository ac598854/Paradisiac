<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.act.service.*"%>
<%@ page import="com.paradisiac.act.model.*"%>
<%--	ActService actSvc = new ActServiceImpl();
	List<ActVO> actList = actSvc.getAllActs();
	pageContext.setAttribute("actList",actList);

--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>顯示活動詳情</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
.container {
	padding-top: 65px;
	padding-left: 255px;
}

#searchBlock {
	margin-bottom: 20px;
}

#activityTableBlock {
	display: flex;
	flex-wrap: nowrap;
}

.activityCard {
	width: 48%;
	margin-right: 2%;
	margin-bottom: 20px;
	padding: 5px;
	margin: 2px;
}

#activityImageBlock {
	border: 1px solid #ddd;
	padding: 15px;
	width: 40%;
	height: 295px;
	float: right;
	margin-left: 2%;
	margin-top: 5px;
}

#activityTableBlock {
	border: 1px solid #ddd;
}

.actContent{
	border: 1px solid #ddd;
	padding: 8px;
}

.modify-button {
    display: inline-block;
    background-color: #4CAF50;
    color: white;
    padding: 8px 16px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin: 4px 2px;
    transition-duration: 0.4s;
    cursor: pointer;
    border-radius: 4px;
}
</style>
</head>
<body>
	<div class="container">
		<div>
			<h2>顯示一筆活動資訊</h2>				
				<div id="activityTableBlock">
					<!-- 顯示所有活動的區塊 -->
					<div class="activityCard">

						<table class="table table-bordered">
							<tr>
								<th>活動編號</th>
								<td>${actVO.actNo}</td>
							</tr>
							<tr>
								<th>活動名稱</th>
								<td>${actVO.actName}</td>
							</tr>
							<tr>
								<th>最低成團人數</th>
								<td>${actVO.lowNum}</td>
							</tr>
							<tr>
								<th>最高上限人數</th>
								<td>${actVO.highNum}</td>
							</tr>
							<tr>
								<th>活動狀態</th>
								<td>${actVO.actStatus? '上架':'下架'}</td>
							</tr>
							<tr>
								<th>參加費用</th>
								<td>${actVO.unitPrice}</td>
							</tr>
						</table>

					</div>
					<div id="activityImageBlock">
						<img
							src="<%=request.getContextPath()%>/dbg.do?act_no=${actVO.actNo}"
							alt="相簿封面" class="img-fluid">
					</div>

				</div>
				<div class="actContent">
				<p><b>活動內容</b></p>				
				<p>${actVO.actContent}</p>
				</div>
				<form>
				<input type="hidden" name="actNo" value="${actVO.actNo}"> 
				<input type="hidden" name="action" value="getOne_For_Update">
				<input type="submit" value="修改" class="modify-button">
				</form>
		</div>
	</div>

</body>
</html>