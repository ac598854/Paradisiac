<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.members.model.*"%>
<%@ page import="com.paradisiac.members.controller.*"%>
<%@ page import="com.paradisiac.members.service.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>

<head>
<!-- 引入Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.min.css">

<meta charset="UTF-8">
<title>Paradisiac Bay-忘記密碼</title>

<style>
body {
	background:
		url('https://images.unsplash.com/photo-1610641818989-c2051b5e2cfd?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')
		center center/cover fixed;
	position: relative;
}

body::before {
	content: "";
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.7);
	z-index: -1;
}

.container {
	width: 65%;
}

.form-style input {
	border: 0;
	height: 50px;
	border-radius: 0;
	border-bottom: 1px solid #ebebeb;
}

.form-style input:focus {
	border-bottom: 1px solid #007bff;
	box-shadow: none;
	outline: 0;
	background-color: #ebebeb;
}

.sideline {
	display: flex;
	width: 100%;
	justify-content: center;
	align-items: center;
	text-align: center;
	color: #ccc;
}

button {
	height: 50px;
}

.sideline:before, .sideline:after {
	content: '';
	border-top: 1px solid #ebebeb;
	margin: 0 20px 0 0;
	flex: 1 0 20px;
}

.sideline:after {
	margin: 0 0 0 20px;
}

.img-fluid {
	min-height: 100%;
	position: relative;
	border-top-left-radius: 20px;
	border-bottom-left-radius: 20px;
}

.img-fluid::after {
	content: "";
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(255, 255, 255, 0.6);
	z-index: 1;
}

.p-5 {
	border-top-right-radius: 20px;
	border-bottom-right-radius: 20px;
}

#mempass1{
	position: relative;
}

#toggle-mempass1 {
	position: absolute;
	top: 25%;
	right: 60px;
	transform: translateY(-50%);
	cursor: pointer;
}

#mempass{
	position: relative;
}

#toggle-mempass2 {
	position: absolute;
	top: 40%;
	right: 60px;
	transform: translateY(-50%);
	cursor: pointer;
}
</style>
</head>

<body>
    <div id="dynamicContent"></div>
    <div class="container">
        <div class="row m-5 no-gutters shadow-lg">
            <div class="col-md-6 d-none d-md-block">
                <img src="https://images.unsplash.com/photo-1590166771575-5a50c6dd507b?q=80&w=1889&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" class="img-fluid" />
            </div>

            <div class="col-md-6 bg-white p-5">
                <h3 class="pb-3">重設密碼</h3>
                <div class="form-style">
                    <form method="post" action="ResetPass.do" name="form1" id="resetPassForm">
                        <div class="form-group pb-3">
                            <input type="password" placeholder="新密碼" class="form-control" id="mempass1" name="mempass1" required>
                             <span
								class="toggle-mempass" id="toggle-mempass1" onclick="togglePasswordVisibility1()">👁️</span>
                        </div>
                        <div class="form-group pb-3">
                            <input type="password" placeholder="請再次輸入新密碼" class="form-control" id="mempass" name="mempass" required>
                             <span
								class="toggle-mempass" id="toggle-mempass2" onclick="togglePasswordVisibility2()">👁️</span>
                        </div>
                        <div id="errorMessages"></div>
                        <input type="submit" value="送出" name="submitButton" id="submitButton" class="btn btn-dark w-100 font-weight-bold mt-2"> 
                        <input type="hidden" name="action" value="restPass">
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/front-end/index/footer.jsp"%>
    <script src="https://use.fontawesome.com/f59bcd8580.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <script>
        var isMempassValid = true;

        function togglePasswordVisibility1() {
            var passwordInput1 = document.getElementById('mempass1');
            var toggleButton1 = document.getElementById('toggle-mempass1');

            if (passwordInput1.type === 'password') {
                passwordInput1.type = 'text';
                toggleButton1.textContent = '👁️';
            } else {
                passwordInput1.type = 'password';
                toggleButton1.textContent = '👁️';
            }
        }

        function togglePasswordVisibility2() {
            var passwordInput2 = document.getElementById('mempass');
            var toggleButton2 = document.getElementById('toggle-mempass2');

            if (passwordInput2.type === 'password') {
                passwordInput2.type = 'text';
                toggleButton2.textContent = '👁️';
            } else {
                passwordInput2.type = 'password';
                toggleButton2.textContent = '👁️';
            }
        }
        
        $(document).ready(function() {
            $("#mempass").on("input", function() {
                var password = $("#mempass1").val().trim();
                var confirmPassword = $("#mempass").val().trim();
                if (password !== confirmPassword) {
                    $("#errorMessages").html("<p style='color: red;'>" + "密碼不一致" + "</p>");
                    isMempassValid =false
                }else{
                	$("#errorMessages").empty();
                	 isMempassValid =true
                }
            });

            $("#resetPassForm").submit(function(event) {
                event.preventDefault();
                $("#errorMessages").empty();
                var formData = $(this).serialize();
                if(isMempassValid){
                $.ajax({
                    type: "POST",
                    url: "ResetPass.do", 
                    data: formData,
                    success: function(response) {     
                        if(response.error){
                            $("#errorMessages").html("<p style='color: red;'>" + response.error + "</p>");				                
                        } else if (response.success) {
                            alert(response.success);
                            window.location.href = "<%=request.getContextPath()%>/front-end/members/Login.jsp";
                        }
                    },
                    error: function() {
                        alert("例外錯誤");
                    }
                });
                }else{
                	 $("#errorMessages").html("<p style='color: red;'>" + "密碼不一致，無法送出" + "</p>");
                }
            });
        });
    </script>
</body>

</html>