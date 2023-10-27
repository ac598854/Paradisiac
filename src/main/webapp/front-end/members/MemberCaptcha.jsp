<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.paradisiac.members.model.*"%>
<%@ page import="com.paradisiac.members.service.*"%>

<%
	MembersVO membersVO=null;
	membersVO=(MembersVO)session.getAttribute("memberVO");
%>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>驗證頁</title>
    
</head>

<body>

<div class="checkMemContainer">
<div class="card checkMem" >
  <h5 class="card-header">會員驗證</h5>
  <form method="POST" action="member.do">
  <div class="card-body">
    <div class="card-text">
    	<div class="form-group">
			<label for="inputID">帳號</label>
            <input type="text" class="form-control" id="inputID" name="memaccount" placeholder="請輸入註冊帳號">
        </div>
        <div class="form-group">
            <label for="inputPassword1">驗證碼</label>
            <input type="text" class="form-control" id="inputPassword1" name="memcaptcha" placeholder="請輸入驗證碼">
        </div>
    </div>
    <input type="hidden" name="action" value="email-Confirm"">
    <div id="errorShow"style="display:flex; justify-content:flex-start;"></div>
    <div style="display:flex; justify-content:flex-end;">
    <button type="submit" class="btn btn-primary" >驗證</button>
    </div>
  </div>
  </form>
</div>
</div>

<script>
 var error='${param.error}';
 if(error=='space'){
	 Swal.fire({
		  title: '請勿不輸入',
		  text: "請重新輸入",
		  icon: 'error',
		  showConfirmButton: false,
		  timer: 1500
		}).then(function () {
	        window.location.href = "<%=request.getContextPath()%>/front-end/member/MemberCaptcha.jsp"
	    })
	 
 }else if(error=='noId'){
	 Swal.fire({
		  title: '沒有此帳號',
		  text: "請重新輸入",
		  icon: 'error',
		  showConfirmButton: false,
		  timer: 1500
		}).then(function () {
	        window.location.href = "<%=request.getContextPath()%>/front-end/member/MemberCaptcha.jsp"
	    })
	 
 }else if(error=='wrongNum'){
	 
	 Swal.fire({
		  title: '驗證碼錯誤',
		  text: "請重新輸入",
		  icon: 'error',
		  showConfirmButton: false,
		  timer: 1500
		}).then(function () {
	        window.location.href = "<%=request.getContextPath()%>/front-end/member/MemberCaptcha.jsp"
	    }) 
 }else if(error=='success'){
	 Swal.fire({
		  title: '驗證成功',
		  text: "1.5秒後跳轉至登入換面",
		  icon: 'success',
		  showConfirmButton: false,
		  timer: 1500
		}).then(function () {
	        window.location.href = "<%=request.getContextPath()%>/front-end/member/Login.jsp"
	    })
 }

</script>         
</body>

</html>