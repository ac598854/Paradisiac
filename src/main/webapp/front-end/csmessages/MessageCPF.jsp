<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.paradisiac.csmessages.model.*"%>
<%@ page import="com.paradisiac.csmessages.service.*"%>
<%@ page import="com.paradisiac.csmessages.controller.*"%>
<!DOCTYPE html>

<html>
<head>
<link rel="stylesheet" href="../css/sweetalert2.min.css">
<%@ include file="/front-end/index/MembersMeta.jsp"%>
<title>會員客服訊息</title>
<style>
#resetButton {
	color: #fff;
	background-color: #6c757d;
	border-color: #6c757d;
}

.btn btn-secondary {
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
</style>
</head>

<body>
	<%@ include file="/front-end/index/MembersBody.jsp"%>
	<div class="container mt-3">
		<h1>請輸入您的問題</h1>
		<div class="row">
			<div class="col-12 text-right">
				<a
					href="<%=request.getContextPath()%>/front-end/csmessages/MessageLPF.jsp"
					class="btn btn-secondary">回上一頁</a>
			</div>

			<form id="customerForm" method="post" accept-charset="UTF-8">
				<div class="form-group">
					<label for="cscontent" id="cscontentHead">申訴問題<span class="text-danger">*</span></label>
					<textarea class="form-control" name="cscontent" id="cscontent"
						rows="3" required><c:out value="${CsVO.cscontent}" /></textarea>
					<br>
					<button type="submit" class="btn btn-primary" id="submitButton">送出</button>
					<input type="hidden" name="action" value="insert_Front">
					<button type="reset" class="btn btn-secondary" id="resetButton">重設</button>
				</div>
			</form>
			<br>
		</div>
	</div>

	<!-- Menu Toggle Script -->
	<script src="../js/sweetalert2.all.min.js"></script>
	<script>
	var fieldsValid = false;

	function checkRequiredFields() {
	  var isValid = true;
	  var fieldIds = ["cscontent"];
	  for (var i = 0; i < fieldIds.length; i++) {
	    var fieldId = fieldIds[i];
	    var inputElement = $("#" + fieldId);

	    if (inputElement.length > 0) {
	      var fieldValue = inputElement.val().trim();

	      if (inputElement.prop("required") && fieldValue === "") {
	        isValid = false;
	        break;
	      }
	      // 清除首尾空格
	      inputElement.val(fieldValue.trim());
	    }
	  }
	  return isValid;
	}

	$(document).ready(function () {
	  $("#customerForm").submit(function (event) {
	    event.preventDefault();
	    var fieldsValid = checkRequiredFields();
	    console.log(fieldsValid)
	    if (fieldsValid) {
	      if (confirm('確認送出申訴？')) {
	        var formData = $(this).serialize();
	        $.ajax({
	          type: "POST",
	          url: "csmessages.do",
	          data: formData,
	          success: async function (response) {
	            if (response.message) {
	              	await Swal.fire({
	              	title: response.message,
	                icon: "success"
	              });
	              window.location.href = "<%=request.getContextPath()%>/front-end/csmessages/MessageLPF.jsp";
	            } else if (response.error) {
	              alert(response.message);
	            }
	          },
	          error: function () {
	            alert("例外错误。");
	          }
	        });
	      }
	    } else {
	      Swal.fire({
	        title: "必填请勿空白!",
	        icon: "error"
	      });
	    }
	  });
	});

	</script>
</body>
</html>