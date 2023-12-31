<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.csmessages.model.*"%>
<%@ page import="com.paradisiac.csmessages.controller.*"%>
<%@ page import="com.paradisiac.csmessages.service.*"%>
<%
request.setCharacterEncoding("utf-8");

String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
Integer whereMemno = (Integer) session.getAttribute("memno");
CsMessagesService csMessagesService = new CsMessagesService();
List<CsMessagesVO> list = csMessagesService.getAllBycscontent(keyword, whereMemno);
pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/front-end/index/MembersMeta.jsp" %>
<title>會員客服專區</title>
</head>

<body>
	<%@ include file="/front-end/index/MembersBody.jsp"%>
	<div class="container">
		<form action="MessageLPF.jsp" method="get">
			<div class="row">
				<div class="col-12">
					<h1>會員客服專區</h1>
					<div class="form-group2">
						<label for="csMsgNo">問題關鍵字</label>
						<div class="input-group">
							<input type="text" class="form-control" name="keyword"
								id="keyword" value="<%=keyword%>">
							<div class="input-group-append"></div>
						</div>
					</div>

					<button class="btn btn-primary" type="submit">送出</button>
				</div>
			</div>
		</form>

		<div class="row mb-4">
			<div class="col-12">
				<div class="table-responsive" id="table-responsive">
					<!-- 新增按鈕開始 -->
					<div class="text-right mb-2">
						<button class="btn btn-success" id="addButton">新增</button>
					</div>
					<!-- 新增按鈕結束 -->
					<table class="table">
						<thead>
							<tr>
								<th>客服編號</th>
								<th>申訴內容</th>
								<th>申訴時間</th>
								<th>客服狀態</th>
								<th>動作</th>
							</tr>
						</thead>
						<tbody>
							<%@ include file="page1.file"%>
							<c:forEach var="CsMessagesVO" items="${list}"
								begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
								<tr>
									<td>${CsMessagesVO.csmsgno}</td>
									<td>${CsMessagesVO.cscontent}</td>
									<td><fmt:formatDate value="${CsMessagesVO.csaskdate}"
											pattern="yyyy-MM-dd HH:mm" /></td>
									<td><c:choose>
											<c:when test="${not empty CsMessagesVO.csredate}">
            										已回覆
        											</c:when>
											<c:otherwise>
												<span style="color: red;">未回覆</span>
											</c:otherwise>
										</c:choose></td>

									<td><button class="btn btn-primary" id="reviewButton"
											data-csmsgno="${CsMessagesVO.csmsgno}">檢視</button></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<%@ include file="page2.file"%>
				</div>
			</div>

		</div>
	</div>

	<!-- Menu Toggle Script -->
<script>
<!--     // 新增 -->
    var addButton = document.getElementById("addButton");
    addButton.addEventListener("click", function() {
        window.location.href = "<%=request.getContextPath()%>/front-end/csmessages/MessageCPF.jsp";
        });
    
<!--     // 檢視    -->
	var reviewButtons = document.querySelectorAll("#reviewButton");
	reviewButtons.forEach(function(button) {
	button.addEventListener("click", function() {
    var csmsgno = this.getAttribute("data-csmsgno");
	console.log(csmsgno);
    window.location.href = "csmessages.do?action=getOne_For_CsMsgno_Front&csmsgno=" + csmsgno;
  });
});

	</script>

</body>

</html>
