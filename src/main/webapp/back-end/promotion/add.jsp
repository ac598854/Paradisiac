<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.paradisiac.promotion.model.*" %>
<%@ page import="java.util.*"%>
<%PromotionVO proVO=(PromotionVO) request.getAttribute("proVO"); %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.paradisiac.promotionlist.service.ProductService" %>
<%@ page import="com.paradisiac.promotionlist.model.ProductVO" %>
<%HttpSession session2 = request.getSession();
session2.removeAttribute("formSubmitted");%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setDateHeader("Expires", 0); // Proxies.
%>

<%
    ProductService proSvc2 = new ProductService();
	List<ProductVO> list = proSvc2.getAll();
    pageContext.setAttribute("list", list);
%>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
                    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/back-end/promotion/datetimepicker/jquery.datetimepicker.css" />
                    <title>促銷編號新增</title>
                    <style type="text/css">
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
                         .xdsoft_datetimepicker .xdsoft_datepicker {
                                    width: 300px;
                                    /* width:  300px; */
                                }

                                .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
                                    height: 151px;
                                    /* height:  151px; */
                                }
                    </style>
                </head>
                <%@ include file="/back-end/index/back-left_product.jsp" %>

                    <body bgcolor='white'>
                        <div class="container-fluid text-center">
                            <div class="row justify-content-center">
                                <div class="col-lg-6 col-md-8">
                                    <div class="text">
									  <div style="width: 45rem;">
									    <div>
									        <h3 style="font-family: 'Arial', sans-serif; font-size: 28px; font-weight: bold;  margin-right: 60px;">促銷專案新增</h3>
									    </div>
									</div>
									<br>
                                        <%-- 錯誤表列 --%>
                                            <c:if test="${not empty errorMsgs}">
                                                <font style="color:red">請修正以下錯誤:</font>
                                                <ul>
                                                    <c:forEach var="message" items="${errorMsgs}">
                                                        <li style="color:red">${message}</li>
                                                    </c:forEach>
                                                </ul>
                                            </c:if>
                                            <FORM METHOD="post"  ACTION="<%=request.getContextPath() %>/PromotionListServlet" name="form1" id="mainForm">
                                                <table>
                                                    <tr>
                                                        <td class="text-start"><label for="proname" class="form-label">促銷專案名稱:</label></td>
                                                        <td><input type="TEXT" class="form-control mb-3" name="proname" value="<%= (proVO==null)? " 夏季特惠" : proVO.getProname()%>" size="30"/></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-start"><label for="proname" class="form-label">促銷專案描述:</label></td>
                                                        <td><input type="TEXT" class="form-control mb-3" name="prodes" value="<%= (proVO==null)? " 熱銷商品優惠" : proVO.getProdes()%>" size="30"/></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-start">促銷專案開始日期:</td>
                                                        <td><input name="startdate" class="form-control mb-3" id="f_date1" type="text"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-start">促銷專案結束日期:</td>
                                                        <td><input name="enddate" class="form-control mb-3" id="f_date2" type="text"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-start">促銷專案折扣:</td>
                                                        <td><input type="TEXT" class="form-control mb-3" name="discount" value="<%= (proVO==null)? " 0.80" : proVO.getDiscount()%>" size="30"/></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-start">促銷專案狀態:</td>
                                                        <td>
                                                            <select name="status" class="form-select mb-3" style="height: 35px; font-size: medium;" aria-label=".form-select-lg example">
                                                                <option value="1" ${(1==proVO.status)? 'selected' :'' }>上架</option>
                                                                <option value="0" ${(0==proVO.status)? 'selected' :'' }>下架</option>
                                                            </select>
                                                        </td>
                                                    </tr>
                                                    <jsp:useBean id="proSvc" scope="page"
                                                        class="com.paradisiac.promotion.service.PromotionService" />
                                                </table>
                                                <br>
                                                 <input type="hidden" id="selectedProducts" name="selectedProducts" value="">
                                                <input type="hidden" name="action" value="add_promotion">
                                                <input type="submit" class="btn btn-primary" value="送出新增">
                                            </FORM>
                                    </div>
                                </div>
								<div class="col-lg-6 col-md-8">
								    <div class="row row-cols-1 row-cols-md-4 g-4">
								        <c:forEach var="ProductVO" items="${list}">
								            <div class="col">
								                <div class="card">
								                    <img src="${ProductVO.imageUrl}" class="card-img-top" alt="Product Image" style="height: 100px; object-fit: cover;">
								                    <div class="card-body">
								                        <h5 class="card-title">${ProductVO.productName}</h5>
								                        <p class="card-text">${ProductVO.price}</p>
								                        <input class="form-check-input" type="checkbox" value="${ProductVO.productno}">
								                        <label class="form-check-label" for="checkboxId"></label>
								                    </div>
								                </div>
								            </div>
								        </c:forEach>
								    </div>
								</div>
                            </div>
                        </div>





                        <% java.sql.Date startdate=null; try { startdate=proVO.getStartdate(); } catch (Exception e) {
                            startdate=new java.sql.Date(System.currentTimeMillis()); } java.sql.Date enddate=null; try {
                            enddate=proVO.getEnddate(); } catch (Exception e) { enddate=new
                            java.sql.Date(System.currentTimeMillis()); } %>
                            
                            <script src="<%=request.getContextPath()%>/back-end/promotion/datetimepicker/jquery.js"></script>
                            <script src="<%=request.getContextPath()%>/back-end/promotion/datetimepicker/jquery.datetimepicker.full.js"></script>
                            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
                                integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
                                crossorigin="anonymous"></script>
                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
                                integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
                                crossorigin="anonymous"></script>
                            

                            <script>
                            toggleSidebar();
                                $.datetimepicker.setLocale('zh');
                                $('#f_date1').datetimepicker({
                                    theme: '',              //theme: 'dark',
                                    timepicker: false,       //timepicker:true,
                                    step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
                                    format: 'Y-m-d',         //format:'Y-m-d H:i:s',
                                    value: '<%=startdate%>', // value:   new Date(),
                                    //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
                                    //startDate:	            '2017/07/10',  // 起始日
                                    //minDate:               '-1970-01-01', // 去除今日(不含)之前
                                    //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
                                });
                                $.datetimepicker.setLocale('zh');
                                $('#f_date2').datetimepicker({
                                    theme: '',              //theme: 'dark',
                                    timepicker: false,       //timepicker:true,
                                    step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
                                    format: 'Y-m-d',         //format:'Y-m-d H:i:s',
                                    value: '<%=enddate%>', // value:   new Date(),
                                    //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
                                    //startDate:	            '2017/07/10',  // 起始日
                                    //minDate:               '-1970-01-01', // 去除今日(不含)之前
                                    //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
                                });
                                
                                const form = document.getElementById('mainForm');
                                const checkboxes = document.querySelectorAll('.form-check-input');
                                const selectedProductsInput = document.getElementById('selectedProducts');

                                form.addEventListener('submit', function(event) {
                                    event.preventDefault(); // 防止表單自動送出

                                    const selectedProducts = [];
                                    checkboxes.forEach(checkbox => {
                                        if (checkbox.checked) {
                                            selectedProducts.push(checkbox.value);
                                        }
                                    });

                                    // 將勾選商品的值設置到隱藏的輸入欄位中
                                    selectedProductsInput.value = selectedProducts.join(',');
                                    
                                    // 然後再提交表單
                                    form.submit();
                                });
                            </script>
                    </body>

                </html>