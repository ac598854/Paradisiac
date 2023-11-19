<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.promotion.model.*"%>

<% //見com.emp.controller.EmpServlet.java第238行存入req的empVO物件 (此為輸入格式有錯誤時的empVO物件)
  	PromotionVO proVO = (PromotionVO) request.getAttribute("proVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<title>促銷專案修改 - update.jsp</title>

<style>
  h4 {
    color: blue;
    display: inline;
  }
  table {
            width: 800px;
            background-color: white;
            margin-top: 5px;
            margin-bottom: 5px;
        }
 table, th, td {
            border: 1px solid #CCCCFF;
            text-align: center; /* 將文字置中對齊 */
        }
        th, td {
            padding: 5px;
            text-align: center;
            width: 12%;
        }
</style>

</head>
<body bgcolor='white'>
<%@ include file="/back-end/index/back-left_product.jsp" %>
<table class="table table-bordered">
        <tr>
            <td>
                <h3 style="font-family: 'Arial', sans-serif; font-size: 28px; font-weight: bold;">促銷專案修改</h3>
            </td>
        </tr>
    </table>


<%-- 錯誤表列 --%>
<div style="margin-left: 85px ">
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
</div>
<FORM METHOD="post" ACTION="promotion" name="form1">




<div class="container">
        <table class="table table-bordered table-striped ">
            <thead class="thead-dark">
    <tr>
        <th style="text-align: center;">促銷編號</th>
        <th style="text-align: center;">促銷專案名稱</th>
        <th style="text-align: center;">促銷專案描述</th>
        <th style="text-align: center;">專案開始日期</th>
        <th style="text-align: center;">專案結束日期</th>
        <th style="text-align: center;">促銷專案折扣</th>
        <th style="text-align: center;">促銷專案狀態</th>
    </tr>
	</thead>
            <tbody>
                    <tr>
                        <td><%=proVO.getProno()%></td>
                        <td><input type="TEXT" name="proname"  value="<%=proVO.getProname()%>" size="45" style="width: 150px;"/></td>
                        <td><input type="TEXT" name="prodes"   value="<%=proVO.getProdes()%>" size="45" style="width: 150px;"/></td>
                        <td><input name="startdate"  id="f_date1" type="text" style="width: 150px;"></td>
                        <td><input name="enddate"  id="f_date2" type="text" style="width: 150px;"></td>
                        <td><input type="TEXT" name="discount"  value="<%=proVO.getDiscount()%>" size="45" style="width: 150px;"/></td>
                        <td><select name="status">
							    <option value="1">上架</option>
							    <option value="0">下架</option>
							</select>
                        </td>
                    </tr>
            </tbody>
        </table>
<input type="hidden" name="action" value="update">
<input type="hidden" name="prono" value="<%=proVO.getProno()%>">
<input type="submit" value="送出修改" class="btn btn-primary" style="margin-left: 1038px;margin-top: 10px;">
</div>
</FORM>

</body>

<% 
  java.sql.Date startdate = null;
  try {
	  startdate =proVO.getStartdate();
   } catch (Exception e) {
	   startdate = new java.sql.Date(System.currentTimeMillis());
   }
  java.sql.Date enddate = null;
  try {
	  enddate =proVO.getEnddate();
   } catch (Exception e) {
	   enddate = new java.sql.Date(System.currentTimeMillis());
   }
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/back-end/promotion/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/back-end/promotion/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/back-end/promotion/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=startdate%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=enddate%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        toggleSidebar();
        
</script>
</html>