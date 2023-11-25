<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.paradisiac.actorder.service.*"%>
<%@ page import="com.paradisiac.actattendees.model.*"%>
<%@ page import="com.paradisiac.actattendees.controller.*"%>
<%@ page import="com.paradisiac.actattendees.service.*"%>
<%@ page import="com.paradisiac.actorder.model.*"%>
<%@ page import="com.paradisiac.actorder.controller.*"%>
<%@ page import="com.paradisiac.schd.controller.*"%>
<%@ page import="com.paradisiac.schd.model.*"%>
<%@ page import="com.paradisiac.schd.service.*"%>

<%
// request.setCharacterEncoding("utf-8");
// List<ActOrder> list2 = null;
// Integer memNo = (Integer) session.getAttribute("memno");
// ActOrderService actOrderServ = new ActOrderService();
// list = actOrderServ.getAllByMemnoSer(memNo);
// pageContext.setAttribute("list2", list2);

 StringBuilder hql = new StringBuilder("");

String memNo = String.valueOf(session.getAttribute("memno"));
String schdNo = request.getParameter("schdNo");
String orderStatus = request.getParameter("orderStatus");
String nowPage = request.getParameter("page") == null ? "0" : request.getParameter("page");
 			
			boolean notfirst = false;
		    // 條件：會員編號
		    if (memNo != null && memNo.trim().length() > 0) {
		    	if(notfirst){
		    		hql.append(" AND ");
		    	}else{
		    		notfirst = true;
		    	}
		    	hql.append(" memNo = "+memNo);
		    }   
		    
		    // 條件：訂單狀態
		    if (orderStatus != null && orderStatus.trim().length() > 0 && !"2".equals(orderStatus)) {
		    	if(notfirst){
		    		hql.append(" AND ");
		    	}else{
		    		notfirst = true;
		    	}
		        hql.append(" orderStatus = "+orderStatus);
		    }

		    ActOrderService actOrderSrv=new ActOrderService();
		    List<ActOrder> list = actOrderSrv.getAllByFrontSearchSer(hql.toString() , nowPage);
		    pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html>

<head>
<%@ include file="/front-end/index/MembersMeta.jsp"%>
<title>會員訂單查詢</title>
</head>
<style>
.col-12 {
    padding-left: 20px;
}
</style>
<body>
	<%@ include file="/front-end/index/MembersBody.jsp"%>
	<div class="container">
			<div class="row">
				<div class="col-12">
					<h1>活動訂單查詢</h1>
					<!-- 查詢 -->
					<form METHOD="get" ACTION="ActLPF.jsp">
					<div class="row mb-4">
						<div class="col-sm-3 form-group">
							<label for="orderStatus">訂單狀態</label> <select
								class="form-control" id="orderStatus" name="orderStatus">
								<option value="2">全部</option>
								<option value="1">訂單成立</option>
								<option value="0">訂單取消</option>
							</select>
							<div class="input-group-append"></div>
						</div>
					</div>
					<div class="col-sm-12 form-group mb-0">
					<button class="btn btn-primary" id="btSubmit" type="submit">送出</button>
					</div>
					</form>
					<br> <br>
				</div>
			</div>
		</form>
		<!-- 表格-->
			<div class="container">
				<div class="row mb-4">
					<div class="col-md-12">
						<div class="table-responsive">
							<table class="table">
								<thead>
									<tr>
										<th>活動訂單編號</th>
										<th>活動名稱</th>
										<th>檔期編號</th>
										<th>訂單狀態</th>
										<th>訂單成立時間</th>
										<th>動作</th>
									</tr>
								</thead>
								<tbody>
									<%@ include file="page1.file"%>
									<c:forEach var="ActOrder" items="${list}"
										begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
										<tr>
											<td>${ActOrder.actOrderNo}</td>
											<td>${ActOrder.schdVO.act.actName}</td>
											<td>${ActOrder.schdVO.schdNo}</td>
											<td><c:choose>
													<c:when test="${ActOrder.orderStatus == 1}">
                                                        成立
                                                    </c:when>
													<c:when test="${ActOrder.orderStatus== 0}">
														<span style="color: red;">取消</span>
													</c:when>
												</c:choose></td>
											<td>${ActOrder.orderTime}</td>
											<td>
												<form method="post" action="ActOrder.do">
													<button type="submit" class="btn btn-primary">修改</button>
													<input type="hidden" name="actOrderNo"
														value="${ActOrder.actOrderNo}"> <input
														type="hidden" name="action"
														value="getOne_For_ActOrderNo_Front">
												</form>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<input type="hidden" name="nowPage" value="${param.nowPage != null ? param.nowPage : '0' }" />
							<%@ include file="page2.file"%>
						</div>
					</div>
				</div>
			</div>
	</div>
	<!-- Menu Toggle Script -->
	<script>
		
	</script>
</body>

</html>
