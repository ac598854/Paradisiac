package com.paradisiac.promotionlist.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.paradisiac.promotionlist.model.PromotionVO;
import com.paradisiac.promotionlist.service.PromotionService;

@WebServlet("/PromotionListServlet")
public class PromotionListServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;

		public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		}
		
		
		public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			HttpSession session = request.getSession();
			request.setCharacterEncoding("UTF-8");
			String action = request.getParameter("action");
			
			
			if("add_promotion".equals(action) && session.getAttribute("formSubmitted") == null) {

					List<String> errorMsgs = new LinkedList<String>();
					request.setAttribute("errorMsgs", errorMsgs);

					/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
					String proname = request.getParameter("proname");
					String Reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
					if (proname == null || proname.trim().length() == 0) {
						errorMsgs.add("促銷專案名稱: 請勿空白");
					} else if (!proname.trim().matches(Reg)) { // 正則(規)表示式(regular-expresponsesion)
						errorMsgs.add("促銷專案名稱:只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
					}

					String prodes = request.getParameter("prodes");
					if (prodes == null || prodes.trim().length() == 0) {
						errorMsgs.add("促銷專案描述: 請勿空白");
					} else if (!prodes.trim().matches(Reg)) { // 正則(規)表示式(regular-expresponsesion)
						errorMsgs.add("促銷專案描述:只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
					}

					Date startdate = null;
					try {
						startdate = Date.valueOf(request.getParameter("startdate").trim());
					} catch (IllegalArgumentException e) {
						startdate = new Date(System.currentTimeMillis());
						errorMsgs.add("請輸入日期!");
					}

					java.sql.Date enddate = null;
					try {
						enddate = Date.valueOf(request.getParameter("enddate").trim());
					} catch (IllegalArgumentException e) {
						enddate = new Date(System.currentTimeMillis());
						errorMsgs.add("請輸入日期!");
					}

					Double discount = null;
					try {
						discount = Double.valueOf(request.getParameter("discount").trim());
						if (discount < 0.1 || discount > 0.99) {
							throw new NumberFormatException();
						}
					} catch (NumberFormatException e) {
						discount = 0.9;
						errorMsgs.add("專案折扣請填數字且在0.1到0.99之間.");
					}

					Boolean status = Boolean.valueOf(request.getParameter("status").trim());
					
					

					PromotionVO proVO = new PromotionVO();

					proVO.setProname(proname);
					proVO.setProdes(prodes);
					proVO.setStartdate(startdate);
					proVO.setEnddate(enddate);
					proVO.setDiscount(discount);
					proVO.setStatus(status);

					if (!errorMsgs.isEmpty()) {
						request.setAttribute("proVO", proVO);
						RequestDispatcher failureView = request.getRequestDispatcher("/back-end/promotion/add.jsp");
						failureView.forward(request, response);
						return;
					}else {

					// 提交成功後才設置 session 屬性
					session.setAttribute("formSubmitted", true);

					// 提交資料到資料庫
					PromotionService proSvc = new PromotionService();
					proVO = proSvc.addPro(proname, prodes, startdate, enddate, discount, status);

					// 取得新建的資料編號
					Integer prono = proVO.getProno();
					String url = "/back-end/promotion/listall.jsp";
					request.setAttribute("prono", prono);
					RequestDispatcher successView = request.getRequestDispatcher(url);
					successView.forward(request, response);
					return;
					}
				} 
				
				if("insert".equals(action) && session.getAttribute("formSubmitted") != null){
					response.sendRedirect("add.jsp");
				}
				
				
				
			};
			
		}
