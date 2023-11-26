<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.paradisiac.actorder.model.*"%>
<%@ page import="com.paradisiac.actorder.controller.*"%>
<%@ page import="com.paradisiac.actorder.service.*"%>
<%@ page import="com.paradisiac.actattendees.model.*"%>
<%@ page import="com.paradisiac.actattendees.controller.*"%>
<%@ page import="com.paradisiac.actattendees.service.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>

<html>
<head>
<%@ include file="/front-end/index/MembersMeta.jsp"%>

<link rel="stylesheet" href="../css/sweetalert2.min.css">
<title>活動訂單資料</title>
<style>
#resetButton {
	color: #fff;
	background-color: #6c757d;
	border-color: #6c757d;
}

#cscontent, #csreply {
	height: 300px;
}

#cscontentHead {
	font-size: 20px;
	font-weight: bold;
}

.form-control {
	display: block;
	width: 100%;
	height: 38px;
	padding: 7px 12px;
	font-size: 14px;
	line-height: 1.42857143;
	color: #555555;
	background-color: #ffffff;
	background-image: none;
	border: 1px solid #e7e7e7;
	border-radius: 4px;
}

.tableDetail {
	width: 100%;
	margin-top: 10px;
	margin-bottom: 1px;
	padding: 0.75rem;
	vertical-align: top;
	border-top: 1px solid #dee2e6;
	background-color: #e9ecef;
}

.detailTd {
	padding: 0.75rem;
	vertical-align: top;
	border-top: 1px solid #dee2e6;
}

.detailTl {
	padding: 0.75rem;
	vertical-align: top;
	border-top: 1px solid #dee2e6;
}

.btn-secondary {
	color: #fff;
	background-color: #6c757d;
}
</style>
</head>

<body>
	<%@ include file="/front-end/index/MembersBody.jsp"%>
	<div class="container mt-3">
		<h1>活動訂單資訊</h1>
		<div class="row">
			<div class="col-12 text-right">
				<a
					href="<%=request.getContextPath()%>/front-end/actorder/ActLPF.jsp"
					class="btn btn-secondary">回上一頁</a>
			</div>
		</div>
		<div class="container">

			<div class="table-responsive">
				<form method="post" name="form1" id="form1">
					<table class="table">
						<tr>
							<td>活動訂單編號:</td>
							<td><input type="text" class="form-control" id="actOrderNo"
								name="actOrderNo" value="${actOrder.actOrderNo}" readonly></td>
						</tr>
						<tr>
							<td>檔期編號:</td>
							<td><input type="text" name="schdNo" id="schdNo"
								class="form-control" class="custom-file-input"
								value="${actOrder.schdVO.schdNo}" size="45" readonly /></td>
						</tr>
						<tr>
							<td>訂單日期:</td>
							<td><input type="datetime-local" name="orderTime"
								id="orderTime" class="form-control"
								value="${actOrder.orderTime}" size="45" readonly /></td>
						</tr>
						<tr>
							<td>報名人數:</td>
							<td><input type="text" name="aAtnNum" id="aAtnNum"
								class="form-control" value="${actOrder.aAtnNum}" size="45"
								readonly /></td>
						</tr>
						<tr>
							<td>訂單狀態:</td>
							<td><select name="orderStatus" id="orderStatus"
								class="form-control browser-default custom-select"
								<c:if test="${actOrder.orderStatus == 0}">disabled="disabled"
            					</c:if>>
									<option value="1"
										<c:if test="${actOrder.orderStatus == 1}">selected</c:if>>成立</option>
									<option value="0"
										<c:if test="${actOrder.orderStatus == 0}">selected style="color: red;"</c:if>>取消</option>
							</select></td>
						</tr>
						<tr>
							<td>訂單總金額:</td>
							<td><input type="text" name="orderAmount" id="orderAmount"
								class="form-control" value="${actOrder.orderAmount}" size="45"
								readonly /></td>
						</tr>
					</table>
					<br>
					<h5 style="font-weight: bold; font-size: 20px">活動參加人明細</h5>
					<table class="tableDetail">
						<c:forEach var="actorder2" items="${list}">
							<tr>
								<td class="detailTd">參加人編號:</td>
								<td class="detailTl">${actorder2.atnNo}</td>
								<td class="detailTd">參加人姓名:</td>
								<td class="detailTl">${actorder2.atnName}</td>
								<td class="detailTd">參加人身分證字號:</td>
								<td class="detailTl">${actorder2.atnIdNumber}</td>
								<td class="detailTd">參加人電話:</td>
								<td class="detailTl">${actorder2.atnTel}</td>
							</tr>
						</c:forEach>
					</table>
					<br>
					<div class="col-sm-12" style="padding-left: 0;">
						<button type="submit" class="btn btn-primary" id="submitButton"
							<c:if test="${actOrder.orderStatus == 0}">style="display:none;"
        					</c:if>>送出</button>
						<input type="hidden" name="action" value="updateStatus" />
					</div>
				</form>
			</div>
		</div>
		<br>
	</div>


	<script src="../js/sweetalert2.all.min.js"></script>
	<script type="text/javascript">
	
	<!-- Menu Toggle Script -->
	
	$(document).ready(function () {
	        var orderStatus = ${actOrder.orderStatus};

	        if (orderStatus === 0) {
	            $("#orderStatus").prop("disabled", true);
	            $("#submitButton").hide();
	        }
	    });
	

	  
	$(document).ready(function () {
	    $("#form1").submit(async function (event) {
	        event.preventDefault();

	        var orderStatus = $("#orderStatus").val();

	        if (orderStatus === "1") {
	            await Swal.fire({
	                title: "訂單已成立，請再次確認選擇",
	                icon: "error"
	            });
	        } else {
	            if (confirm('確認取消訂單？')) {
	                var formData = $(this).serialize();	                
	                $.ajax({
	                    type: "POST",
	                    url: "ActOrder.do",
	                    data: formData,
	                    success: async function (response) {
	                        if (response.message) {
	                        	console.log(response.message)
	                            await Swal.fire({
	                          	  title: response.message,
			            		  text: "訂單取消成功，已寄送取消訂單通知信!",
			            		  icon: "success"
	                            });
	                            window.location.href = "<%=request.getContextPath()%>/front-end/actorder/ActLPF.jsp";
	                        } else if (response.error) {
	                            alert(response.message);
	                        }
	                    },
	                    error: function () {
	                        alert("例外错误。");
	                    }
	                });
	            }
	        }
	    });
	});


	</script>
</body>
</html>