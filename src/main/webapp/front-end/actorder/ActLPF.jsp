<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="com.paradisiac.csmessages.model.*" %>
<%@ page import="com.paradisiac.csmessages.controller.*" %>
<%@ page import="com.paradisiac.csmessages.service.*" %>
<%@ page import="com.paradisiac.actorder.service.*" %>
<%@ page import="com.paradisiac.actattendees.model.*" %>
<%@ page import="com.paradisiac.actattendees.controller.*" %>
<%@ page import="com.paradisiac.actattendees.service.*" %>
<%@ page import="com.paradisiac.actorder.model.*" %>
<%@ page import="com.paradisiac.actorder.controller.*" %>

<%
    request.setCharacterEncoding("utf-8");
    List<ActOrder> list = null;
    Integer memNo = (Integer) session.getAttribute("memno");
    ActOrderService actOrderServ = new ActOrderService();
    list = actOrderServ.getAllByMemnoSer(memNo);
    pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html>

<head>
    <%@ include file="/front-end/index/MembersMeta.jsp" %>
    <title>會員訂單查詢</title>
</head>

<body>
    <%@ include file="/front-end/index/MembersBody.jsp" %>
    <div class="container">
        <form action="MessageLPF.jsp" method="get">
            <div class="row">
                <div class="col-12">
                    <h1>活動訂單查詢</h1>
                    <!-- 查詢 -->
                    <div class="row mb-4">
                        <div class="col-md-3">
                            <label for="actOrderNo">訂單編號</label>
                            <div class="input-group">
                                <input type="text" class="form-control" name="actOrderNo" id="actOrderNo">
                                <div class="input-group-append">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="schdNo">活動檔期</label>
                            <div class="input-group">
                                <input type="text" class="form-control" name="schdNo" id="schdNo">
                                <div class="input-group-append">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="orderStatus">訂單狀態</label>
                            <div class="input-group">
                                <select class="form-control" id="orderStatus" name="orderStatus">
                                    <option value="2">全部</option>
                                    <option value="1">訂單成立</option>
                                    <option value="0">訂單取消</option>
                                </select>
                                <div class="input-group-append">
                                </div>
                            </div>
                        </div>
                    </div>
                    <button class="btn btn-primary" id="btSubmit" type="submit">送出</button>
                    <br> <br>
                </div>
            </div>
        </form>
        <!-- 表格-->
        <form method="post" action="ActOrder.do">
            <div class="container">
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>活動訂單編號</th>
<!--                                         <th>會員編號(姓名)</th> -->
                                        <th>活動名稱</th>
                                        <th>檔期編號</th>
                                        <th>訂單狀態</th>
                                        <th>訂單成立時間</th>
                                        <th>動作</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%@ include file="page1.file" %>
                                    <c:forEach var="ActOrder" items="${list}" begin="<%=pageIndex%>"
                                        end="<%=pageIndex+rowsPerPage-1%>">
                                        <tr>
                                            <td>${ActOrder.actOrderNo}</td>
<%--                                             <td>${ActOrder.memNo}</td> --%>
                                            <td>${ActOrder.schdVO.act.actName}</td>
                                            <td>${ActOrder.schdVO.schdNo}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${ActOrder.orderStatus == 1}">
                                                        成立
                                                    </c:when>
                                                    <c:when test="${ActOrder.orderStatus== 0}">
                                                        <span style="color: red;">取消</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>${ActOrder.orderTime}</td>
                                            <td>
                                                <form method="post" action="ActOrder.do">
                                                    <button type="submit" class="btn btn-primary">修改</button>
                                                    <input type="hidden" name="actOrderNo" value="${ActOrder.actOrderNo}">
                                                    <input type="hidden" name="action" value="getOne_For_ActOrderNo_Front">
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <%@ include file="page2.file" %>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <!-- Menu Toggle Script -->
    <script>
        // 檢視
        var reviewButtons = document.querySelectorAll("#reviewButton");
        reviewButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                var csmsgno = this.getAttribute("data-csmsgno");
                console.log(csmsgno);
                window.location.href = "csmessages.do?action=getOne_For_CsMsgno_Front&csmsgno=" + csmsgno;
            });
        });
    </script>
</body>

</html>
