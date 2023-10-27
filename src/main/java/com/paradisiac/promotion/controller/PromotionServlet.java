package com.paradisiac.promotion.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.paradisiac.promotion.model.PromotionVO;
import com.paradisiac.promotion.service.PromotionService;
@WebServlet("/back-end/promotion/promotion")
public class PromotionServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		if ("getOne_For_Display".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);	
			String str = req.getParameter("prono");
			if (str == null || (str.trim()).length() == 0) {
				errorMsgs.add("請輸入促銷編號");
		}
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/promotion/select.jsp");
				failureView.forward(req, res);
				return;
			}
			Integer prono = null;
			//包裝類別不設為null也會自動初始化為null自己設為null目的是好理解好維護
			try {
				prono = Integer.valueOf(str);
			} catch (Exception e) {
				errorMsgs.add("促銷編號格式不正確");
			}
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/promotion/select.jsp");
				failureView.forward(req, res);
				return;
			}
			/***************************2.開始查詢資料*****************************************/
			PromotionService ProSvc = new PromotionService();
			PromotionVO proVO = ProSvc.getOnePro(prono);
			if (proVO == null) {
				//對於檢查對象是否為 null，使用 ==
				//而對於比較對象的內容是否為 null，應該使用 equals 
				errorMsgs.add("查無資料");
			}
			
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/promotion/select.jsp");
				failureView.forward(req, res);
				return;
			}
			/***************************3.查詢完成,準備轉交(Send the Success view)*************/
			req.setAttribute("proVO", proVO); 
			String url = "/back-end/promotion/listOne.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); 
			successView.forward(req, res);//只有JAVA環境可以用FORWARD
	}
		
		if ("getOne_For_Update".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
				/***************************1.接收請求參數****************************************/
				Integer prono = Integer.valueOf(req.getParameter("prono"));
				
				/***************************2.開始查詢資料****************************************/
				PromotionService proSvc = new PromotionService();
				PromotionVO proVO = proSvc.getOnePro(prono);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("proVO", proVO);        
				String url = "/back-end/promotion/update.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
		}
		
		
		if ("update".equals(action)) { 
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
		
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer prono = Integer.valueOf(req.getParameter("prono").trim());
				
				String proname = req.getParameter("proname");
				String Reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (proname == null || proname.trim().length() == 0) {
					errorMsgs.add("促銷專案名稱: 請勿空白");
				} else if(!proname.trim().matches(Reg)) { 
					errorMsgs.add("促銷專案名稱:只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            }
				
				String prodes = req.getParameter("prodes");
				if (prodes == null || prodes.trim().length() == 0) {
					errorMsgs.add("促銷專案描述: 請勿空白");
				} else if(!prodes.trim().matches(Reg)) { 
					errorMsgs.add("促銷專案描述:只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            }
				
				Date startdate = null;
				try {
					startdate = java.sql.Date.valueOf(req.getParameter("startdate").trim());
				} catch (IllegalArgumentException e) {
					startdate=new Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				java.sql.Date enddate = null;
				try {
					enddate = java.sql.Date.valueOf(req.getParameter("enddate").trim());
				} catch (IllegalArgumentException e) {
					enddate=new Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				

				Double discount = null;
				try {
					discount = Double.valueOf(req.getParameter("discount").trim());
				} catch (NumberFormatException e) {
					discount = 0.0;
					errorMsgs.add("專案折扣請填數字.");
				}

				Integer status = Integer.valueOf(req.getParameter("status").trim());

				PromotionVO proVO = new PromotionVO();
				proVO.setProno(prono);
				proVO.setProname(proname);
				proVO.setProdes(prodes);
				proVO.setStartdate(startdate);
				proVO.setEnddate(enddate);
				proVO.setDiscount(discount);
				proVO.setStatus(status);

			
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("proVO", proVO);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/promotion/update.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始修改資料*****************************************/
				PromotionService proSvc = new PromotionService();
				proVO = proSvc.updatePro(prono,proname,prodes,startdate,enddate,discount,status);
				
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("proVO", proVO);
				String url = "/back-end/promotion/listOne.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);	
		}
		
		
		
		
			if ("insert".equals(action)) {  
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String proname = req.getParameter("proname");
				String Reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (proname == null || proname.trim().length() == 0) {
					errorMsgs.add("促銷專案名稱: 請勿空白");
				} else if(!proname.trim().matches(Reg)) { //正則(規)表示式(regular-expression)
					errorMsgs.add("促銷專案名稱:只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            }
				
				
				
				String prodes = req.getParameter("prodes");
				if (prodes == null || prodes.trim().length() == 0) {
					errorMsgs.add("促銷專案描述: 請勿空白");
				} else if(!prodes.trim().matches(Reg)) { //正則(規)表示式(regular-expression)
					errorMsgs.add("促銷專案描述:只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            }
				
				Date startdate = null;
				try {
					startdate = Date.valueOf(req.getParameter("startdate").trim());
				} catch (IllegalArgumentException e) {
					startdate=new Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				java.sql.Date enddate = null;
				try {
					enddate = Date.valueOf(req.getParameter("enddate").trim());
				} catch (IllegalArgumentException e) {
					enddate=new Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				Double discount = null;
				try {
					discount = Double.valueOf(req.getParameter("discount").trim());
				} catch (NumberFormatException e) {
					discount = 0.0;
					errorMsgs.add("專案折扣請填數字.");
				}
				
				
				
				Integer status = Integer.valueOf(req.getParameter("status").trim());

				PromotionVO proVO = new PromotionVO();
				
				proVO.setProname(proname);
				proVO.setProdes(prodes);
				proVO.setStartdate(startdate);
				proVO.setEnddate(enddate);
				proVO.setDiscount(discount);
				proVO.setStatus(status);
				

				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("proVO", proVO); 
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/promotion/add.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				PromotionService proSvc = new PromotionService();
				proVO = proSvc.addPro(proname,prodes,startdate,enddate,discount,status);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/promotion/listall.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);				
		}

			if ("delete".equals(action)) { 

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
		
					/***************************1.接收請求參數***************************************/
					Integer prono = Integer.valueOf(req.getParameter("prono"));
					
					/***************************2.開始刪除資料***************************************/
					PromotionService proSvc = new PromotionService();
					proSvc.deletePro(prono);
					
					/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
					int itemsPerPage = 3;
					int currentPage = (prono - 1) / itemsPerPage + 1;
					String url = "/back-end/promotion/listall.jsp?whichPage="+currentPage;
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);
			}
		
	}
}
