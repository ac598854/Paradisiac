<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, shrink-to-fit=no, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>後端管理頁面</title>

  <!-- Bootstrap Core CSS -->
  <link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.6/lumen/bootstrap.min.css" rel="stylesheet"> 
</head>

<body>
	<%@ include file="back-left.jsp" %>
			<!-- Page Content -->
			<div>
			  <div class="container-custom">
        <h2>CheckIn資料查詢</h2>
        <form method="post" action="${pageContext.request.contextPath}/order.do" class="form-horizontal">
            <div class="form-group">
                <label class="control-label col-sm-2" for="memName">會員姓名:</label>
                <div class="col-sm-10">
                    <input name="memName" class="form-control" id="memName" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="memId">身份證字號:</label>
                <div class="col-sm-10">
                    <input name="memId" class="form-control" id="memId" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="memPhone">會員電話:</label>
                <div class="col-sm-10">
                    <input name="memPhone" class="form-control" id="memPhone" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="roomOrderNo">訂單編號:</label>
                <div class="col-sm-10">
                    <input name="roomOrderNo" class="form-control" id="roomOrderNo" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-default">確認</button>
                </div>
            </div>
            <input type="hidden" name="action" value="checkInData">
        </form>
    </div>
			</div>
		<!-- Page Content -->
</body>

</html>