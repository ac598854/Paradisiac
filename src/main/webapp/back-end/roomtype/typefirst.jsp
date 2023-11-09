<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>房型管理</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .card {
            border: 1px solid #ccc;
            margin: 10px;
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="mt-5">搜尋全部</h1>
        <form method="Post">
            <a class="btn btn-primary mb-4" href="${pageContext.request.contextPath}/type/type.do?action=getAll">查詢所有房型資料</a>
        </form>

        <h1>新增房型</h1>
        <div class="card">
            <form method="Post" action="${pageContext.request.contextPath}/type/type.do?action=addtype">

                <div class="form-group">
                     <label for="roomName">NAME：</label>
                    <select class="form-control" id="roomName" name="roomName">
                        <option value="標準套房">標準套房</option>
                        <option value="家庭套房">家庭套房</option>
                        <option value="豪華套房">豪華套房</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="rtype">房間類別：</label>
                    <select class="form-control" id="rtype" name="rtype">
                        <option value="單人房">單人房</option>
                        <option value="二人房">二人房</option>
                        <option value="四人房">四人房</option>
                        <option value="八人房">八人房</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="roomTotal">TOTAL：</label>
                    <input type="text" class="form-control" id="roomTotal" name="roomTotal" value="1">
                </div>
                <div class="form-group">
                    <label for="price">價格：</label>
                    <input type="text" class="form-control" id="price" name="price" value="1">
                </div>
                       <div class="form-group">
                <label for="normalPrice">普通價格：</label>
                <input type="text" class="form-control" id="normalPrice" name="normalPrice" value="1">
            </div>
            
                        <div class="form-group">
                <label for="holidayPrice">節日價格：</label>
                <input type="text" class="form-control" id="holidayPrice" name="holidayPrice" value="1">
            </div>
                        <div class="form-group">
                <label for="bridgeHolidayPrice">連續假期價格：</label>
                <input type="text" class="form-control" id="bridgeHolidayPrice" name="bridgeHolidayPrice" value="1">
            </div>
                        <div class="form-group">
                <label for="notice">備註：</label>
                <input type="text" class="form-control" id="notice" name="notice" value="1">
            </div>
                        <div class="form-group">
                <label for="facility">設施：</label>
                <input type="text" class="form-control" id="facility" name="facility" value="1">
            </div>      

            
               <div class="form-group">
                     <label for="rTypeStatus">房間狀態：</label>
                    <select class="form-control" id="rTypeStatus" name="rTypeStatus">
                        <option value="true">true</option>
                        <option value="false">false</option>
                    </select>
                </div>
                
                <button class="btn btn-success" type="submit" id="addButton">確定新增</button>
            </form>
        </div>



        <h1>新增的房型列表</h1>
        <div id="roomList">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>房型編號</th>
                        <th>房型名稱</th>
                        <th>房型類別</th>
                        <th>房型總數</th>
                        <th>價錢</th>
                        <th>一般價錢</th>
                        <th>節日價錢</th>
                        <th>連續假期價錢</th>
                        <th>注意事項</th>
                        <th>設施</th>
                        <th>房型狀態</th>
                    </tr>
                </thead>
                <tbody>
                <tr>
                    <td>${result.roomTypeNo}</td>
                    <td>${result.roomName}</td>
                    <td>${result.rtype}</td>
                    <td>${result.roomTotal}</td>
                    <td>${result.price}</td>
                    <td>${result.normalPrice}</td>
                    <td>${result.holidayPrice}</td>
                    <td>${result.bridgeHolidayPrice}</td>
                    <td>${result.notice}</td>
                    <td>${result.facility}</td>
                    <td>${result.rTypeStatus}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
