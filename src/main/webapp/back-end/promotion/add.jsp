<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.paradisiac.promotionlist.model.*" %>
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
                    <title>�P�P�s���s�W</title>
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
                           .card-body {
							    line-height: 1;
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
									        <h3 style="font-family: 'Arial', sans-serif; font-size: 28px; font-weight: bold;  margin-right: 60px;">�P�P�M�׷s�W</h3>
									    </div>
									</div>
									<br>
                                            <FORM METHOD="post"  ACTION="<%=request.getContextPath() %>/PromotionListServlet" name="form1" id="mainForm">
                                                <table>
                                                    <tr>
                                                        <td class="text-start"><label for="proname" class="form-label">�P�P�M�צW��:</label></td>
                                                        <td><input type="TEXT" class="form-control mb-3" name="proname" id="proname" value="�L�u�S�f" size="30"/></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-start"><label for="proname" class="form-label">�P�P�M�״y�z:</label></td>
                                                        <td><input type="TEXT" class="form-control mb-3" name="prodes" id="prodes" value="���P�ӫ~�u�f"  size="30"/></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-start">�P�P�M�׶}�l���:</td>
                                                        <td><input name="startdate" class="form-control mb-3" id="f_date1" type="text"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-start">�P�P�M�׵������:</td>
                                                        <td><input name="enddate" class="form-control mb-3" id="f_date2" type="text"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-start">�P�P�M�ק馩:</td>
                                                        <td><input type="TEXT" class="form-control mb-3"  id="discountInput" name="discount"  id="discount"  value="0.80" size="30"/></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-start">�P�P�M�ת��A:</td>
                                                        <td>
                                                            <select name="status" class="form-select mb-3" style="height: 35px; font-size: medium;" aria-label=".form-select-lg example">
                                                                <option value="true" ${(1==proVO.status)? 'selected' :'' }>�W�[</option>
                                                                <option value="false" ${(0==proVO.status)? 'selected' :'' }>�U�[</option>
                                                            </select>
                                                        </td>
                                                    </tr>
                                                    <jsp:useBean id="proSvc" scope="page"
                                                        class="com.paradisiac.promotion.service.PromotionService" />
                                                </table>
                                                <br>
                                                <input type="hidden" id="selectedStatus" name="status" value="">
                                                 <input type="hidden" id="selectedProducts" name="selectedProducts" value="">
                                                <input type="hidden" name="action" value="add_promotion">
                                                <input type="submit" class="btn btn-primary" value="�e�X�s�W" onclick="return validateForm()">
                                            </FORM>
                                    </div>
                                </div>
								<div class="col-lg-6 col-md-8">
								   <div class="row row-cols-1 row-cols-md-3 g-4">
									    <c:forEach var="ProductVO" items="${list}">
									        <div class="col">
									            <div class="card" style="width: 18rem;height: 230px;">
									                <img src="${ProductVO.imageUrl}" class="card-img-top" alt="Product Image" style="height: 100px; object-fit: cover;">
									                <div class="card-body">
									                    <h5 class="card-title">${ProductVO.productName}</h5>
									                    <p><span class="original-price-label">����G</span><span class="card-text originalPrice">${ProductVO.price}</span></p>
									                    <p class="card-text"><span class="discountedPrice"></span></p>
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
						        <div class="d-flex justify-content-end" style="margin-right: 80px">
						            <button id="prevPage" class="btn btn-primary me-2">�W�@��</button>
						            <button id="nextPage" class="btn btn-primary">�U�@��</button>
						        </div>
						 




                        <% java.sql.Date startdate=null; 
                        		try { 
                        			startdate=proVO.getStartdate(); 
                        			} 
                        			catch (Exception e) {
			                            startdate=new java.sql.Date(System.currentTimeMillis()); 
			                            } 
			                java.sql.Date enddate=null; 
                        		try {
                            		enddate=proVO.getEnddate(); 
                            		} 
                        		catch (Exception e) { 
                        			enddate=new java.sql.Date(System.currentTimeMillis()); 
                        			} %>
                            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                            <script src="<%=request.getContextPath()%>/back-end/promotion/datetimepicker/jquery.js"></script>
                            <script src="<%=request.getContextPath()%>/back-end/promotion/datetimepicker/jquery.datetimepicker.full.js"></script>
                            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
                                integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
                                crossorigin="anonymous"></script>
                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
                                integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
                                crossorigin="anonymous"></script>
                            

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
                                
                                const form = document.getElementById('mainForm');
                                const checkboxes = document.querySelectorAll('.form-check-input');
                                const selectedProductsInput = document.getElementById('selectedProducts');
                                const statusSelect = document.querySelector('select[name="status"]');
                                

                                form.addEventListener('submit', function(event) {
                                    event.preventDefault(); // ������۰ʰe�X

                                    const selectedProducts = [];
                                    checkboxes.forEach(checkbox => {
                                        if (checkbox.checked) {
                                            selectedProducts.push(checkbox.value);
                                        }
                                    });
                                    
                                    
                                    const selectedStatus = statusSelect.value;

	                                 // ������ê� STATUS ���
	                                 const hiddenStatusInput = document.querySelector('input[name="status"]');
	
	                                 // �N�ϥΪ̿�ܪ��ȳ]�w��������줤
	                                 hiddenStatusInput.value = selectedStatus;


                                    // �N�Ŀ�ӫ~���ȳ]�m�����ê���J��줤
                                    selectedProductsInput.value = selectedProducts.join(',');
                                    
                                    // �M��A������
                                    form.submit();
                                });
                                
                                document.addEventListener('DOMContentLoaded', function() {
                                    const discountInput = document.getElementById('discountInput');
                                    const originalPriceElement = document.querySelectorAll('.originalPrice');
                                    console.log(originalPriceElement)
                                    
                                    // ��s�馩���檺���
                                   function updateDiscountedPrices() {
									    const discount = parseFloat(discountInput.value);
									    
									    const discountedPriceElements = document.querySelectorAll('.discountedPrice');
									    
									    discountedPriceElements.forEach((discountedPriceElement, index) => {
									        const priceElement = originalPriceElement[index];
									        const price = parseFloat(priceElement.textContent);
									        const discountedPrice = price * discount;
									
									        if (!isNaN(discountedPrice)) {
									            discountedPriceElement.innerText = "�馩���G" + discountedPrice.toFixed(0);
									        } else {
									            discountedPriceElement.innerText = "�馩���GN/A";
									        }
									    });
									}
                                    
                                    // ��������J�����ɡA�����p��ç�s�馩����
                                    updateDiscountedPrices();
                                    
                                    // ��ť�馩��J��쪺�ܰʨƥ�A��s�馩����
                                    discountInput.addEventListener('input', updateDiscountedPrices);
                                });
                //======================================���~����================================================//                
                                function validateForm() {
								    const checkboxes = document.querySelectorAll('.form-check-input');
								    const proname = document.getElementById('proname').value;
								    const prodes = document.getElementById('prodes').value;
								    const discount = parseFloat(document.getElementById('discountInput').value);
								    const startDate = document.getElementById('f_date1').value;
								    const endDate = document.getElementById('f_date2').value;
								    const pronameRegex = /^[a-zA-Z0-9\u4e00-\u9fa5\s.,()&$!#-]+$/;
								    const prodesRegex = /^[a-zA-Z0-9\u4e00-\u9fa5\s.,()&$!#-]+$/;
								    
								    let atLeastOneChecked = false;
								
								    checkboxes.forEach(checkbox => {
								        if (checkbox.checked) {
								            atLeastOneChecked = true;
								        }
								    });
								
								    if (!atLeastOneChecked) {
								        Swal.fire({
								            icon: 'warning',
								            title: 'Oops...',
								            text: '�Цܤֿ�ܤ@���ӫ~�I',
								            confirmButtonText: '�T�w'
								        });
								        return false; // ������e�X
								    }
								    if (!pronameRegex.test(proname)) {
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'Oops...',
                                            text: '�M�צW�٤��i���S��Ÿ��I',
                                            confirmButtonText: '�T�w'
                                        });
                                        return false;
                                    }

                                    if (!prodesRegex.test(prodes)) {
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'Oops...',
                                            text: '�M�״y�z���i���S��Ÿ��I',
                                            confirmButtonText: '�T�w'
                                        });
                                        return false;
                                    }
                                    if (isNaN(discount) || discount < 0.01 || discount > 0.99) {
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'Oops...',
                                            text: '�M�ק馩�п�J0.01��0.99�I',
                                            confirmButtonText: '�T�w'
                                        });
                                        return false;
                                    }
                                    if (startDate.trim() === '' || endDate.trim() === '') {
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'Oops...',
                                            text: '�п�J�}�l����M��������I',
                                            confirmButtonText: '�T�w'
                                        });
                                        return false;
                                    }
                                    
                                    const start = new Date(startDate);
                                    const end = new Date(endDate);

                                    if (end < start) {
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'Oops...',
                                            text: '����������ভ��}�l����I',
                                            confirmButtonText: '�T�w'
                                        });
                                        return false;
                                    }
								
								    // �p�G����ܰӫ~�A���\���e�X
								    return true;
								}
                //=============================�d������=======================================//
                // �b���ɸ��J���������
				document.addEventListener('DOMContentLoaded', function() {
				    const cards = document.querySelectorAll('.col'); // ���o�Ҧ��d������
				    const cardsPerPage = 6; // �C����ܪ��d���ƶq
				    const totalCards = cards.length; // �`�d���ƶq
				    let currentPage = 1; // �ثe����
				
				    // �ھڥثe���ƩM�C����ܼƶq�p��n��ܪ��d���d��
				    function showCards() {
				        const startIndex = (currentPage - 1) * cardsPerPage;
				        const endIndex = startIndex + cardsPerPage;
				
				        // ���éҦ��d��
				        cards.forEach(card => {
				            card.style.display = 'none';
				        });
				
				        // ��ܲŦX�d�򪺥d��
				        for (let i = startIndex; i < endIndex && i < totalCards; i++) {
				            cards[i].style.display = 'block';
				        }
				    }
				
				    // ��l�Ʈ���ܲĤ@���d��
				    showCards();
				
				    // �����ܤU�@��
				    document.getElementById('nextPage').addEventListener('click', function() {
				        if (currentPage < Math.ceil(totalCards / cardsPerPage)) {
				            currentPage++;
				            showCards();
				        }
				    });
				
				    // �����ܤW�@��
				    document.getElementById('prevPage').addEventListener('click', function() {
				        if (currentPage > 1) {
				            currentPage--;
				            showCards();
				        }
				    });
				});

								



                            </script>
                    </body>

                </html>