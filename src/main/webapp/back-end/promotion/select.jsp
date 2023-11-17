<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>IBM Promotion: Home</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        #header {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 10px;
        }

        #main-content {
            margin: 20px;
        }

        table#table-1 {
            width: 450px;
            background-color: #f9f9f9;
            border: 2px solid #ddd;
            border-radius: 5px;
            margin-top: 20px;
            margin-bottom: 20px;
            text-align: center;
        }

        table#table-1 h3 {
            color: red;
            margin: 5px;
        }

        table#table-1 h4 {
            color: blue;
            margin: 5px;
        }

        h3 {
            margin-bottom: 10px;
        }

        ul {
            list-style: none;
            padding-left: 0;
        }

        ul li {
            margin-bottom: 10px;
        }

        a {
            text-decoration: none;
            color: #333;
        }

        a:hover {
            color: #f00;
        }

        form {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<div id="header">
    <h1>IBM Promotion</h1>
</div>

<div id="main-content">
    <table id="table-1">
        <tr>
            <td>
                <h3>促銷專案</h3>
                <h4>( MVC )</h4>
            </td>
        </tr>
    </table>

    <h3>專案查詢:</h3>

    <c:if test="${not empty errorMsgs}">
        <p style="color:red;">請修正以下錯誤:</p>
        <ul>
            <c:forEach var="message" items="${errorMsgs}">
                <li style="color:red;">${message}</li>
            </c:forEach>
        </ul>
    </c:if>

    <ul>
        <li><a href='listall.jsp'>List</a> all Promotion</li>

        <jsp:useBean id="proSvc" scope="page" class="com.paradisiac.promotion.service.PromotionService" />
        <li>
            <form method="post" action="promotion">
                <b>輸入促銷編號 (如101):</b>
                <input type="text" name="prono">
                <input type="hidden" name="action" value="getOne_For_Display">
                <input type="submit" value="送出">
            </form>
        </li>
        <li>
            <form method="post" action="promotion">
                <b>選擇促銷編號:</b>
                <select size="1" name="prono">
                    <c:forEach var="proVO" items="${proSvc.all}">
                        <option value="${proVO.prono}">${proVO.prono}</option>
                    </c:forEach>
                </select>
                <input type="hidden" name="action" value="getOne_For_Display">
                <input type="submit" value="送出">
            </form>
        </li>

        <li>
            <form method="post" action="promotion">
                <b>選擇促銷專案名稱:</b>
                <select size="1" name="prono">
                    <c:forEach var="proVO" items="${proSvc.all}">
                        <option value="${proVO.prono}">${proVO.proname}</option>
                    </c:forEach>
                </select>
                <input type="hidden" name="action" value="getOne_For_Display">
                <input type="submit" value="送出">
            </form>
        </li>
    </ul>

    <ul>
        <li><a href='add.jsp'>Add</a> a new Emp.</li>
    </ul>
</div>

</body>
</html>
