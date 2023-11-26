//$(document).ready(function() {
//	$.ajax({
//		type: "POST",
//		url: "<%=request.getContextPath()%>/front-end/members/members.do?action=indexLogin",
//		success: function(data) {
//			const responseMessage = parseInt(data);
//			var contextPath = '<%=request.getContextPath()%>';
//			var guided = contextPath + '/front-end/index/guided.jsp';
//			var guidedSignout = contextPath + '/front-end/index/guidedSignout.jsp';
//			if (responseMessage === 1) {
//				$("#dynamicContent").load(guided);
//			} else if (responseMessage === 0) {
//				$("#dynamicContent").load(guidedSignout);
//			}
//		},
//		error: function(error) {
//			console.log("AJAX error:", error);
//		}
//	});
//});
let countNum = 0;

$('#addParticipantBtn').on('click', function() {
	var participantName = document.getElementById('atnName').value;
	var participantIdNumber = document.getElementById('atnIdNumber').value;
	var participantTel = document.getElementById('atnTel').value;
	// 檢查欄位是否都有值
	if (participantName && participantIdNumber && participantTel) {
		var newRow = document.createElement('div');
		newRow.className = 'row';
		newRow.id = 'addContent';
		newRow.innerHTML = `<div><br></div>
                                <div class="col-md-12 mb-6">
                                <label for="atnName[${countNum}]">參加人姓名</label> <input type="text" name="atnName[${countNum}]" class="form-control" value="${participantName}" readonly>
                                </div>
                                <div class="col-md-12 mb-6">
                                <label for="atnIdNumber[${countNum}]">參加人身分證字號</label> <input type="text" name="atnIdNumber[${countNum}]" class="form-control" value="${participantIdNumber}" readonly>
                                </div>
                                <div class="col-md-12 mb-6">
                                <label for="atnTel[${countNum}]">參加人電話</label> <input type="text" name="atnTel[${countNum}]" class="form-control" value="${participantTel}" readonly>
                                <button type="button" class="btn_delete">移除</button>
                                </div><hr class="mb-4">`;

		// 添加新的 <div class="row"> 到 id="participantList"
		document.getElementById('participantList').appendChild(newRow);

		// 清空輸入框
		document.getElementById('atnName').value = '';
		document.getElementById('atnIdNumber').value = ''; // 修正這行的引號
		document.getElementById('atnTel').value = '';
		countNum++;
		document.getElementById('aAtnNum').value = countNum;
		document.getElementById('countNumDisplay').value = countNum;

		var unitPrice = parseFloat(document.getElementById('unitPrice').value);
		var aAtnNum = parseFloat(document.getElementById('aAtnNum').value);
		if (!isNaN(unitPrice) && !isNaN(aAtnNum)) {
			var totalPrice = unitPrice * aAtnNum;
			document.getElementById('orderAmount').value = totalPrice; // 四捨五入到小數點後兩位
		}

	} else {
		// 提示用戶填寫所有欄位
		alert('請填寫所有參加人資訊');
	}

});

//移除參加人
$("div.row").on("click", "button.btn_delete", function() {
	console.log(1);
	let r = confirm("確認移除？");
	if (r) {
		console.log(this);
		$(this).closest("div.row").animate({
			"opacity": 0
		}, 100, "swing", function() {
			$(this).remove();
			countNum = countNum - 1;
			console.log("countNum=" + countNum);
			document.getElementById('aAtnNum').value = countNum;
			document.getElementById('countNumDisplay').value = countNum;

			var unitPrice = parseFloat(document.getElementById('unitPrice').value);
			var aAtnNum = parseFloat(document.getElementById('aAtnNum').value);
			if (!isNaN(unitPrice) && !isNaN(aAtnNum)) {
				var totalPrice = unitPrice * aAtnNum;
				document.getElementById('orderAmount').value = totalPrice.toFixed(2); // 四捨五入到小數點後兩位
			}
		});
	}
});





