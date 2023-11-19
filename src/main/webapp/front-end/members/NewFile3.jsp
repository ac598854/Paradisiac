<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.members.model.*"%>

<%
MembersVO membersVO = (MembersVO) request.getAttribute("memberVO");
pageContext.setAttribute("membersVO", membersVO);
%>
<!DOCTYPE html>
<html>
<head>

<%@ include file="/front-end/index/MembersMeta.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Paradisiac Bay-註冊會員</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/sweetalert2.min.css">

<style>
/* body { */
/* 	background: */
/* 		url('https://images.unsplash.com/photo-1610641818989-c2051b5e2cfd?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D') */
/* 		center center/cover fixed; */
/* 	position: relative; */
/* } */

/* body::before { */
/* 	content: ""; */
/* 	position: fixed; */
/* 	top: 0; */
/* 	left: 0; */
/* 	width: 100%; */
/* 	height: 100%; */
/* 	background: rgba(0, 0, 0, 0.7); */
/* 	z-index: -1; */
/* } */

/* label { */
/* 	font-weight: 600; */
/* 	color: #666; */
/* } */

/* .box8 { */
/* 	box-shadow: 0px 0px 5px 1px #343a40; */
/* } */

/* .mx-t3 { */
/* 	margin-top: -3rem; */
/* } */

/* .jumbotron { */
/* 	background-color: rgba(255, 255, 255, 0.8); */
/* } */

/* .form-group { */
/* 	padding: 5px; */
/* } */

/* label.form-check-label { */
/* 	padding-left: 20px; */
/* 	font-size: 16px; */
/* 	color: blue; */
/* } */

#preview {
	margin-top: 5px;
	border: 1px dashed #6c757d;
	display: flex;
	min-height: 150px;
	position: relative;
	border-radius: 10px;
	width: 100%;
	justify-content: center;
	align-items: center;
	border: 1px dashed #6c757d;
}

#password-container {
	position: relative;
}

.toggle-mempass {
	position: absolute;
	top: 55px;
	right: 10px;
	transform: translateY(-50%);
	cursor: pointer;
	align-items: center;
}
</style>
</head>
<body>
	<div class="container mt-3">
		<form method="post" name="form1" id="form1" action="members.do"
			enctype="multipart/form-data">
			<div class="row jumbotron box8">
				<div class="col-sm-12 mx-t3 mb-4">
					<h2 class="text-center text-info">會員註冊</h2>
				</div>
				<div class="col-sm-12 form-group">
					<label for="mememail">Email<span class="text-danger">*</span></label>
					<input type="email" class="form-control" name="memmail" id="email"
						value="${membersVO.memmail}" placeholder="請輸入Email" required>
				</div>
				<div class="col-sm-12 form-group mb-0">
					<button type="button" id="getAuthCodeButton"
						class="btn btn-primary float">取得驗證碼</button>
				</div>
				<div class="col-sm-12 form-group">
					<label for="memcaptcha">註冊驗證碼<span class="text-danger">*</span></label>
					<input type="text" class="form-control" name="memcaptcha"
						id="memcaptcha" value="${membersVO.memcaptcha}"
						placeholder="請輸入驗證碼" required>
					<div id="captchaError" style="color: red;"></div>
				</div>
				<div class="col-sm-12 form-group mb-0">
					<button type="button" id="checkCaptchaButton"
						class="btn btn-primary float">驗證</button>
				</div>
				<div class="col-sm-6 form-group">
					<label for="memaccount">帳號<span class="text-danger">*</span></label>
					<input type="text" name="memaccount" class="form-control"
						id="memaccount" value="${membersVO.memaccount}"
						placeholder="請輸入帳號" required>
					<div id="accountError" style="color: red;"></div>
				</div>
				<div class="col-sm-6 form-group" id="password-container">
					<label for="mempass">密碼<span class="text-danger">*</span></label> 
					<input type="Password" name="mempass" class="form-control" id="mempass"
						value="${membersVO.mempass}" placeholder="請輸入密碼" required>
					<span class="toggle-mempass" onclick="togglePasswordVisibility()">👁️</span>
				</div>
				<div id="MempassError" style="color: red;"></div>

				<div class="col-sm-6 form-group">
					<label for="memname">姓名<span class="text-danger">*</span></label> <input
						type="text" class="form-control" name="memname" id="memname"
						value="${membersVO.memname}" placeholder="請輸入姓名" required>
				</div>
				<div class="col-sm-2 form-group">
					<label for="memgender">性別</label> <select id="memgender"
						class="form-control browser-default custom-select" name="memgender">
						<option value="1" selected>男</option>
						<option value="2">女</option>
						<option value="3">其他</option>
					</select>
				</div>
				<div class="col-sm-4 form-group">
					<label for="memid">身分證字號<span class="text-danger">*</span></label>
					<input type="text" name="memid" class="form-control" id="memid"
						placeholder="請輸入身分證字號(首字須為英文大寫)" oninput="checkMemId()" required>
						<p>A151938787</p>
							<div id="result_Id" style="color: red;"></div>
				</div>
				<div id="MemidError" style="color: red;"></div>
				<div class="col-sm-6 form-group">
					<label for="membir">生日</label> <input type="date" name="membir"
						class="form-control" id="membir" placeholder="">
				</div>
				<div class="col-sm-6 form-group">
					<label for="memphone">電話<span class="text-danger">*</span></label>
					<input type="text" name="memphone" class="form-control"
						id="memphone" placeholder="輸入電話/手機，例如:09XXXXXXXX、02XXXXXXX"
						oninput="checkPhoneNumber()" required />
					<div id="result" style="color: red;"></div>
				</div>

				<div class="col-sm-3 form-group">
					<label for="memaddress1">縣市</label> <select id="縣市1"
						class="form-control" name="memaddress1"></select>
				</div>
				<div class="col-sm-3 form-group">
					<label for="memaddress2">鄉鎮市區</label> <select id="鄉鎮市區1"
						class="form-control" name="memaddress2"></select>
				</div>
				<div class="col-sm-6 form-group">
					<label for="memaddress3">地址</label> <input type="text"
						name="memaddress3" class="form-control" id="memaddress3"
						placeholder="請輸入地址">
				</div>
				<div class="col-sm-12 form-group">
					<label for="mempicture">會員頭像</label>
					<div class="custom-file">
						<input type="file" class="custom-file-input" id="mempicture"
							name="mempicture" accept="image/*"> <label
							class="custom-file-label" for="mempicture">選擇檔案</label>
					</div>
					<div id="preview">
						<img id="avatar-preview" class="mt-2"
							style="max-width: 100%; max-height: 200px;" />
					</div>
				</div>
				<div class="col-sm-12 form-group">
					<input type="checkbox" class="form-check d-inline" id="chb"
						style="transform: scale(1.8);" required><label for="chb"
						class="form-check-label" style="transform: scale(1);"><span class="text-danger">*</span>我接受所有條款和條件</label>
				</div>
				<div class="col-sm-12 form-group mb-0">
					<input type="submit" value="送出" name="submitButton"
						id="submitButton" class="btn btn-primary float-right"> <input
						type="hidden" name="action" value="insert"> <br>
				</div>
			</div>
		</form>
	</div>

</body>

<script src="https://use.fontawesome.com/f59bcd8580.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="../js/sweetalert2.all.min.js"></script>
<script src="./js/Address.js"></script>
<script>


var p_file_el = document.getElementById("mempicture");
var isGetAuthCodeButtonDisabled = false;
var countdown = 30; //倒數計時
var isMemaccountValid = false;//預設驗證帳號
var isMemcaptchaValid = false;//預設驗證驗證碼
var isMemphoneValid=false;
var isMemIdValid=false;

function togglePasswordVisibility() {
    var passwordInput = document.getElementById('mempass');
    var toggleButton = document.querySelector('.toggle-mempass');

    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        toggleButton.textContent = '👁️'; 
    } else {
        passwordInput.type = 'password';
        toggleButton.textContent = '👁️'; 
    }
}

    document.getElementById('mempicture').addEventListener('change', function (event) {
        var preview = document.getElementById('avatar-preview');
        var file = event.target.files[0];

        if (file) {
            var reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
            };
            reader.readAsDataURL(file);
        } else {
            preview.src = '';
        }
    });

    function startCountdown() {
    	
        isGetAuthCodeButtonDisabled = true;
        $("#getAuthCodeButton").prop("disabled", true);
        var interval = setInterval(function() {
            if (countdown > 0) {
                $("#getAuthCodeButton").text("等待 " + countdown + " 秒");
                countdown--;
            } else {
                clearInterval(interval);
                isGetAuthCodeButtonDisabled = false;
                $("#getAuthCodeButton").text("取得驗證碼");
                $("#getAuthCodeButton").prop("disabled", false);
            }
        }, 1000);
    }

    function isValidEmail(email) {
        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }
    
    $("#getAuthCodeButton").on('click', async function() {
        var emailValue = $("#email").val().trim();
        if (emailValue === "" || !isValidEmail(emailValue)) {
            alert("請輸入有效的Email地址。");
            return;
        }else{       
        // 啟動計時
        console.log("countdown="+countdown)
        startCountdown();
        var formdata = new FormData();
        formdata.append("memmail", $("#email").val());
        var url = "<%=request.getContextPath()%>/front-end/members/members.do?action=getAuthCode";
        try {
            var response = await fetch(url, {
                method: "POST",
                body: formdata
            });
            if (!response.ok) {
                throw new Error("錯誤");
            }
            const data = await response.json();
            if(data.message){
//             	alert(data.message);//mailservice成功				
            	await Swal.fire({
            		  title: "寄信成功!",
            		  text: "請到信箱收取驗證碼!",
            		  icon: "success"
            		});

//             	Swal.fire({
//             		  title: "Good job!",
//             		  text: data.message,
//             		  icon: "success"
//             		}).then();
            		
            }else{
            	alert("寄信失敗");//mailservice失敗
            	console.log(data.error)
            }
        } catch (error) {
            console.error(error);//mailservice例外失敗
        }
        }
    });
     
    // 帳號重複檢查
    $("#memaccount").on('blur', function() {
    	var memaccount = $("#memaccount").val().trim(); 
        if (memaccount === "") {
            return;
        }
        $.ajax({
            type: "post",
            url: "<%=request.getContextPath()%>/front-end/members/members.do?action=checkAccount",
            data: { memaccount: memaccount },
            async: true,
            success: function(data) {
                if (data.message == 'true') {
                    $('#accountError').text("可用帳號");
                    isMemaccountValid=true;
                } else {
                    $('#accountError').text("帳號已存在，請重新輸入");
                }
            }
        		});
   		 });

    //驗證碼驗證
    $('#checkCaptchaButton').on('click', function() {
        var memcaptcha = $('#memcaptcha').val().trim();
        if (memcaptcha === "") {
        	 isMemcaptchaValid=false;
        }
        $.ajax({
            type: "POST",
            url: "<%=request.getContextPath()%>/front-end/members/members.do?action=checkCaptcha",
            data: {
                memcaptcha: memcaptcha,
                memmail: $("#email").val(),
            },
            success: function(data) {
                // 檢查
                const responseMessage = parseInt(data);
                if (responseMessage === 1) {
                    $('#captchaError').text("驗證已逾時，請重新驗證");
                    isMemcaptchaValid=false;
                } else if (responseMessage === 3) {
                    $('#captchaError').text("驗證碼錯誤，請重新輸入");
                    isMemcaptchaValid=false;
                } else if (responseMessage === 2) {
                    $('#captchaError').text("驗證成功");
                    isMemcaptchaValid=true;
                }
            }
        });
    });

//號碼檢查
    function checkPhoneNumber() {
		var phoneInput=document.getElementById("memphone");
	 	var phoneNumber = phoneInput.value.trim().replace(/\D/g, ''); // 刪除空格並刪除非數字字符
        var mobilePattern = /^09\d{8}$/;
        var landlinePattern = /^0\d{1,2}\d{6,8}$/;
        if (mobilePattern.test(phoneNumber)) {
            document.getElementById("result").innerText = "";
            isMemphoneValid=true;
        } else if (landlinePattern.test(phoneNumber)) {
            document.getElementById("result").innerText = "";
            isMemphoneValid=true;
        } else {
            document.getElementById("result").innerText = "非有效手機、市話號碼格式";
            isMemphoneValid=false;
        }
    }
    
    function checkMemId() {
		var IdInput=document.getElementById("memid");
	 	var MemId = IdInput.value.trim(); 
	 	 var MemIdReg = /^[A-Z][12]\d{8}$/;
        if (MemIdReg.test(MemId)) {
            document.getElementById("result_Id").innerText = "";
            isMemIdValid=true;
        } else {
            document.getElementById("result_Id").innerText = "身分字號不符合規格，首字需大寫";
            isMemIdValid=false;
        }
    }
    window.onload = function () {
        AddressSeleclList.Initialize("縣市1", "鄉鎮市區1");
        AddressSeleclList.Initialize(
          "縣市2",
          "鄉鎮市區2",
        );
      };

//所有欄位濾空白、必填無值提醒
function checkRequiredFields() {
    var isValid = true;
    var fieldIds = ["email", "mempass", "memaccount", "memname", "memphone", "memid", "memaddress"];

    for (var i = 0; i < fieldIds.length; i++) {
        var fieldId = fieldIds[i];
        var inputElement = $("#" + fieldId);


        if (inputElement.length > 0) {
            var fieldValue = inputElement.val().trim();

            if (inputElement.prop("required") && fieldValue === "") {
                isValid = false;
                inputElement.val(fieldValue);
                break;
            }
            // 回寫清除空白的值
            inputElement.val(fieldValue);
        } else {
            console.error("Element with id '" + fieldId + "' not found.");
        }
    }
    return isValid;
}
$('#submitButton').click(function(e) {
	e.preventDefault();
    var fieldsValid = checkRequiredFields();//過濾空白檢查
    if (fieldsValid && isMemaccountValid && isMemcaptchaValid && isMemphoneValid&&isMemIdValid) {
        // 驗證通過
        $("#form1 input[name='action']").val("insert");
        // 送出
        $("#form1").submit();
        alert("送出成功");
    } else {
        alert("請確認所有必填欄位以及帳號、驗證碼、電話號碼是否驗證成功");
    }
});


</script>
</html>