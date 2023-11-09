<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<%@ page import = "com.paradisiac.roomorder.model.RoomOrderDTO" %>
<!DOCTYPE html>
<%
RoomOrderDTO data = (RoomOrderDTO) request.getAttribute("checkInData");
%>


<html>
<head>
    <meta charset="BIG5">
    <title>�|��CheckIn�T�{�� </title>
    <!-- �ޤJ Bootstrap CSS �˦��� -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Room Order Details</h2>
        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>�q��s��</th>
                        <th>�q����</th>
                        <th>�|���m�W</th>
                        <th>�|��������</th>
                        <th>�|���q��</th>
                        <th>�Ы��W��</th>
                        <th>�U�q����</th>
                        <th>���B</th>
                        <th>�J����</th>
                        <th>�h�Ф��</th>
                        <th>�q�檬�A</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%=data.getRoomOrderNo()%></td>
                        <td><%=data.getRoomOrderDate()%></td>
                        <td><%=data.getMemName()%></td>
                        <td><%=data.getMemId()%></td>
                      	<td><%=data.getMemPhone()%></td>
                        <td><%=data.getRoomName()%></td>
                        <td><%=data.getRoomAmount()%></td>
                        <td><%=data.getPrice()%></td>
                        <td><%=data.getCheckInDate()%></td>
                        <td><%=data.getCheckOutDate()%></td>
                        <td><%=data.getOrderStatus()%></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- �ޤJ Bootstrap JavaScript �ɮ� -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</body>
</html>