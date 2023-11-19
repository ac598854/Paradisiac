<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page import="com.paradisiac.promotion.model.*" %>

            <% //��com.emp.controller.EmpServlet.java��238��s�Jreq��empVO���� (������J�榡�����~�ɪ�empVO����) 
            PromotionVO proVO = (PromotionVO) request.getAttribute("proVO"); %>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
                    <title>�P�P�s���s�W</title>
                    <!-- �Ϥ��Ӥj�[css -->
                    <style type="text/css">

                        table#table-1 {
                            background-color: #CCCCFF;
                            border: 2px solid black;
                            text-align: center;
                        }

                        table#table-1 h4 {
                            color: red;
                            display: block;
                            margin-bottom: 1px;
                        }

                        h4 {
                            color: blue;
                            display: inline;
                        }

                        table {
                            width: 450px;
                            background-color: white;
                            margin-top: 1px;
                            margin-bottom: 1px;
                        }

                        table,
                        th,
                        td {
                            border: 0px solid #CCCCFF;
                        }

                        th,
                        td {
                            padding: 1px;
                        }
                    </style>

                </head>
<%@ include file="/back-end/index/back-left_product.jsp" %>
                <body bgcolor='white'>
                    <div class="container-fluid">
                        <div class="row justify-content-end">
                            <div class="col-lg-5 col-md-8">
                                <div class="text">
                                    <table id="table-1">
                                        <tr>
                                            <td>
                                                <h3>�P�P�M�׷s�W</h3>
                                            </td>
                                            <td>
                                                <h4><a href="select.jsp">�^����</a></h4>
                                            </td>
                                        </tr>
                                    </table>
                                    <h3>��Ʒs�W:</h3>
                                    <%-- ���~��C --%>
                                        <c:if test="${not empty errorMsgs}">
                                            <font style="color:red">�Эץ��H�U���~:</font>
                                            <ul>
                                                <c:forEach var="message" items="${errorMsgs}">
                                                    <li style="color:red">${message}</li>
                                                </c:forEach>
                                            </ul>
                                        </c:if>
                                        <FORM METHOD="post"
                                            ACTION="<%=request.getContextPath() %>/back-end/promotion/promotion" name="form1">
                                            <table>
                                                <tr>
                                                    <td><label for="proname" class="form-label">�P�P�M�צW��:</label></td>
                                                    <td><input type="TEXT"  class="form-control" name="proname" value="<%= (proVO==null)? "�L�u�S�f" : proVO.getProname()%>" size="30"/></td>
                                                </tr>
                                                <tr>
                                                	<td><label for="proname" class="form-label">�P�P�M�״y�z:</label></td>
                                                    <td><input type="TEXT" class="form-control" name="prodes" value="<%= (proVO==null)? "���P�ӫ~�u�f" : proVO.getProdes()%>" size="30"/></td>
                                                </tr>
                                                <tr>
                                                    <td>�P�P�M�׶}�l���:</td>
                                                    <td><input name="startdate"  class="form-control"  id="f_date1" type="text"></td>
                                                </tr>
                                                <tr>
                                                    <td>�P�P�M�׵������:</td>
                                                    <td><input name="enddate" class="form-control"  id="f_date2" type="text"></td>
                                                </tr>
                                                <tr>
                                                    <td>�P�P�M�ק馩:</td>
                                                    <td><input type="TEXT"  class="form-control"  name="discount" value="<%= (proVO==null)? "0.80" : proVO.getDiscount()%>" size="30"/></td>
                                                </tr>
                                                <tr>
                                                    <td>�P�P�M�ת��A:</td>
                                                    <td>
                                                        <select name="status" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
                                                            <option value="1" ${(1==proVO.status)? 'selected' :'' }>�W�[</option>
                                                            <option value="0" ${(0==proVO.status)? 'selected' :'' }>�U�[</option>
                                                        </select>
                                                    </td>
                                                </tr>
                                                <jsp:useBean id="proSvc" scope="page" class="com.paradisiac.promotion.service.PromotionService" />
                                            </table>
                                            <br>
                                            <input type="hidden" name="action" value="insert">
                                            <input type="submit" class="btn btn-primary" value="�e�X�s�W">
                                        </FORM>
                                </div>
                            </div>
                             <div class="col-lg-5 col-md-8">
									    <table class="table table-bordered">
									        <tbody>
									            <tr>
									                <th scope="row">�P�P�s��</th>
									                <td><%=proVO.getProno()%></td>
									            </tr>
									            <tr>
									                <th scope="row">�P�P�M�צW��</th>
									                <td><%=proVO.getProname()%></td>
									            </tr>
									            <tr>
									                <th scope="row">�P�P�M�״y�z</th>
									                <td><%=proVO.getProdes()%></td>
									            </tr>
									            <tr>
									                <th scope="row">�P�P�M�׶}�l���</th>
									                <td><%=proVO.getStartdate()%></td>
									            </tr>
									            <tr>
									                <th scope="row">�P�P�M�׵������</th>
									                <td><%=proVO.getEnddate()%></td>
									            </tr>
									            <tr>
									                <th scope="row">�P�P�M�ק馩</th>
									                <td><%=proVO.getDiscount()%></td>
									            </tr>
									            <tr>
									                <th scope="row">�P�P�M�ת��A</th>
									                <td><%=proVO.getStatus()%></td>
									            </tr>
									        </tbody>
									    </table>
                             </div>   
                        </div>
                    </div>




                </body>
                <% java.sql.Date startdate=null; try { startdate=proVO.getStartdate(); } catch (Exception e) {
                    startdate=new java.sql.Date(System.currentTimeMillis()); } java.sql.Date enddate=null; try {
                    enddate=proVO.getEnddate(); } catch (Exception e) { enddate=new
                    java.sql.Date(System.currentTimeMillis()); } %>
                    <link rel="stylesheet" type="text/css"
                        href="<%=request.getContextPath()%>/back-end/promotion/datetimepicker/jquery.datetimepicker.css" />
                    <script src="<%=request.getContextPath()%>/back-end/promotion/datetimepicker/jquery.js"></script>
                    <script src="<%=request.getContextPath()%>/back-end/promotion/datetimepicker/jquery.datetimepicker.full.js"></script>
					<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
					<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
                    <style>
                        .xdsoft_datetimepicker .xdsoft_datepicker {
                            width: 300px;
                            /* width:  300px; */
                        }

                        .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
                            height: 151px;
                            /* height:  151px; */
                        }
                    </style>

                    <script>
                        $.datetimepicker.setLocale('zh');
                        $('#f_date1').datetimepicker({
                            theme: '',              //theme: 'dark',
                            timepicker: false,       //timepicker:true,
                            step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
                            format: 'Y-m-d',         //format:'Y-m-d H:i:s',
                            value: '<%=startdate%>', // value:   new Date(),
                            //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
                            //startDate:	            '2017/07/10',  // �_�l��
                            //minDate:               '-1970-01-01', // �h������(���t)���e
                            //maxDate:               '+1970-01-01'  // �h������(���t)����
                        });
                        $.datetimepicker.setLocale('zh');
                        $('#f_date2').datetimepicker({
                            theme: '',              //theme: 'dark',
                            timepicker: false,       //timepicker:true,
                            step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
                            format: 'Y-m-d',         //format:'Y-m-d H:i:s',
                            value: '<%=enddate%>', // value:   new Date(),
                            //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
                            //startDate:	            '2017/07/10',  // �_�l��
                            //minDate:               '-1970-01-01', // �h������(���t)���e
                            //maxDate:               '+1970-01-01'  // �h������(���t)����
                        });


                    </script>

                </html>