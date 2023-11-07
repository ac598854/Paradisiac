<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>客服訊息管理</title>
    <!-- 添加Bootstrap链接 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- 自定义CSS样式 -->
    <style>
        .h1 {
            font-size: 20px;
        }
        .table-data {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .table-data .col-md-2 {
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #f8f9fa;
            margin-bottom: 10px;
            text-align: left;
            vertical-align: middle;
        }

        .table-data .col-md-2:nth-child(odd) {
            background-color: #e9ecef;
        }

        .table-data .col-md-2:nth-child(1) {
            background-color: #007bff;
            color: #fff;
            width: 10%;
        }

        .table-data .col-md-2:nth-child(2) {
            background-color: #28a745;
            color: #fff;
            width: 20%;
        }

        .table-data .col-md-2:nth-child(3) {
            background-color: #ffc107;
            width: 30%;
        }

        .table-data .col-md-2:nth-child(4) {
            background-color: #dc3545;
            color: #fff;
            width: 20%;
        }

        .table-data .col-md-2:nth-child(5) {
            background-color: #17a2b8;
            color: #fff;
            width: 20%;
        }

        .table-data .col-md-2 th {
            text-align: left;
            vertical-align: middle;
        }

        .input-group {
            margin-bottom: 10px;
        }

        .table thead {
            background-color: #343a40;
            color: #fff;
        }

        .table tbody tr:nth-child(odd) {
            background-color: #f8f9fa;
        }

        .table tbody tr:nth-child(even) {
            background-color: #e9ecef;
        }
        

    </style>
</head>
<body>
    <div class="container mt-4">
        <h1 class="h1">客服訊息管理列表</h1>
    </div>
    <!-- 查询方式部分 -->
    <div class="container">
        <div class="row mb-4">
            <div class="col-md-3">
                <label for="csMsgNo">客服編號</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="csMsgNo">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="button">送出</button>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <label for="empNo">員工編號</label>
                <div class= "input-group">
                    <input type="text" class="form-control" id="empNo">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="button">送出</button>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <label for="csStatus">處理狀態</label>
                <div class="input-group">
                    <select class="form-control" id="csStatus">
                        <option value="有回應時間">有回應時間</option>
                        <option value="無回應時間">無回應時間</option>
                    </select>
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="button">送出</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 表格部分 -->
    <div class="container">
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th style="width: 5%;">客服編號</th>
                                <th style="width: 10%;">會員編號</th>
                                <th style="width: 40%;">申訴內容</th>
                                <th style="width: 10%;">處理員工</th>
                                <th style="width: 15%;">申訴時間</th>
                                <th style="width: 15%;">回應時間</th>
                                <th style="width: 10%;">處理</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>CS_MSG_NO</td>
                                <td>MEM_NO</td>
                                <td>申訴内容申訴内容申訴内容申訴内容申訴内容申訴内容申訴内容申訴内容申訴内容申訴内容申訴内容申訴内容申訴内容申訴内容申訴内容申訴内容申訴内容申訴内容</td>
                                <td>EMP_NO</td>
                                <td>CS_ASK_DATE</td>
                                <td>CS_RE_DATE</td>
                                <td><button class="btn btn-primary">回覆</button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

<!-- 页面选择器部分 -->
<div class="container">
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-end">
            <li class="page-item"><a class="page-link" href="#" aria-label="First"> <span aria-hidden="true">首页</span></a></li>
            <li class="page-item"><a class="page-link" href="#" aria-label="Previous"> <span aria-hidden="true">上一页</span></a></li>
            <li class="page-item active"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item"><a class="page-link" href="#" aria-label="Next"> <span aria-hidden="true">下一页</span></a></li>
            <li class="page-item"><a class="page-link" href="#" aria-label="Last"> <span aria-hidden="true">尾页</span></a></li>
        </ul>
    </nav>
</div>


    <!-- 添加Bootstrap和jQuery链接 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

