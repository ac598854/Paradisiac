<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checkout Successful</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #d4e9e2;
        margin: 0;
        padding: 50px;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 90vh;
    }
    .checkout-success {
        background-color: #ffffff;
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        width: 500px;
        text-align: center;
    }
    .checkout-success h1 {
        color: #32a852;
        font-size: 2em;
        margin-bottom: 0.5em;
    }
    .checkout-icon {
        background-color: #4caf50;
        border-radius: 50%;
        display: inline-block;
        padding: 20px;
        margin-bottom: 20px;
    }
    .checkout-icon svg {
        fill: white;
        height: 50px;
        width: 50px;
    }
    .buttons {
        margin-top: 20px;
        display: flex;
        justify-content: space-around;
    }
    .button {
        background-color: #4caf50;
        color: white;
        border: none;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        cursor: pointer;
        border-radius: 5px;
        width: 200px;
    }
    .button:hover {
        background-color: #43a047;
    }
</style>
</head>
<body>

<div class="checkout-success">
    <div class="checkout-icon">
        <!-- Insert your check mark SVG here -->
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
            <path d="M20.292 5.292l-11.292 11.292-4.292-4.292-1.414 1.414 5.706 5.706 12.706-12.706z"/>
        </svg>
    </div>
    <h1>Checkout Successful!</h1>
    <p>你已成功下訂訂單</p>
    <div class="buttons">
      <button class="button" onclick="window.location.href='/Paradisiac/front-end/index/index2.jsp';">回到首頁</button>
        <button class="button" onclick="window.location.href='/Paradisiac/back-end/roomorder/memvieword.jsp';">查看訂單資訊</button>
    </div>
</div>

</body>
</html>
