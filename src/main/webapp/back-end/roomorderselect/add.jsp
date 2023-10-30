<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List" %>
<%@ page import="com.paradisiac.roomorder.service.*" %>
<%@ page import="com.paradisiac.roomorder.entity.*" %>
<HTML>
<HEAD>
<TITLE> 查詢訂房訂單資料 </TITLE>
<STYLE>
.button {
    display: inline-block;
    padding: 5px 10px;
    background-color: gray;
    color: black;
    text-decoration: none;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    text-align: center;
}

.button a {
    color: black;
    text-decoration: none;
}

.button:hover {
    background-color: #0056b3;
}
</STYLE>

</HEAD>
<BODY>

<%
       Context ctx = new javax.naming.InitialContext();
       DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB2");
       Connection con =  ds.getConnection();
       Statement stmt = con.createStatement();
       ResultSet rs = stmt.executeQuery("SELECT room_order_no,room_order_date,checkin_date,checkout_date,room_type_no,mem_no,room_amount,price,payment_method,pay_status,order_status from roomee.room_order");
            
       ResultSetMetaData rsmd = rs.getMetaData();
	     int numberOfColumns = rsmd.getColumnCount();
%>

	<table style="width:50%; text-align:center;">
		<tr>
			<th>訂單編號</th>
			<th>下訂日期</th>
			<th>入住時間</th>
			<th>退房時間</th>
			<th>房型</th>
			<th>員工編號</th>
			<th>房間號碼</th>
			<th>價錢</th>
			<th>付款方式</th>
			<th>付款狀態</th>
			<th>訂單狀態</th>
		</tr>

	<c:forEach var="ord" items="${ordList}">
			<tr>
				<td>${ord.roomOrderNo}</td>
				<td>${ord.roomOrderDate}</td>
				<td>${ord.checkinDate}</td>
				<td>${ord.checkoutDate}</td>
				<td>${ord.roomTypeNo}</td>
				<td>${ord.memNo}</td>
				<td>${ord.roomAmount}</td>
				<td>${ord.price}</td>
				<td>${ord.paymentMethod}</td>
				<td>${ord.payStatus}</td>
				<td>${ord.orderStatus}</td>
			</tr>
		</c:forEach>
	</table>


