package com.paradisiac.promotionlist.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.paradisiac.promotionlist.service.ProductService;
import com.paradisiac.promotionlist.model.ProductVO;
import com.paradisiac.promotionlist.model.PromotionVO;
import com.paradisiac.promotionlist.service.PromotionService;

@WebServlet("/PromotionListServlet")
public class PromotionListServlet extends HttpServlet {

	public class PromotionDiscount {
		private String promotionName;
		private double discount;
		private Integer productNo;

		public PromotionDiscount(String promotionName, double discount, Integer productNo) {
			this.promotionName = promotionName;
			this.discount = discount;
			this.productNo = productNo;
		}

		public Integer getProductNo() {
			return productNo;
		}

		public void setProductNo(Integer productNo) {
			this.productNo = productNo;
		}

		public String getPromotionName() {
			return promotionName;
		}

		public void setpPromotionName(String promotionName) {
			this.promotionName = promotionName;
		}

		public double getDiscount() {
			return discount;
		}

		public void setDiscount(double discount) {
			this.discount = discount;
		}

	}

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

		PromotionService proSvc = new PromotionService();
		List<PromotionVO> list = proSvc.getAll();
		long currentMillis = System.currentTimeMillis(); // 取得當前時間
		Map<Integer, PromotionDiscount> maxDiscountsMap = new HashMap<>(); // 儲存每個商品對應的最大促銷折扣

		for (PromotionVO promotion : list) {
			Date startTime = promotion.getStartdate();
			Date endTime = promotion.getEnddate();
			Boolean statusBoolean = promotion.getStatus();
			long startMillis = startTime.getTime();
			long endMillis = endTime.getTime();

			 if (currentMillis >= startMillis && currentMillis <= endMillis && statusBoolean == true) {
				String promotionName = promotion.getProname(); // 取得促銷專案名稱
				List<Integer> productList = proSvc.getProductnoFromView(promotion.getProno());

				for (Integer productNo : productList) {
					double discount = promotion.getDiscount(); // 假設 PromotionVO 中有獲取折扣的方法

					// 檢查商品是否已經在 Map 中，如果不存在或新折扣較大，更新最大折扣
					if (!maxDiscountsMap.containsKey(productNo)
							|| discount > maxDiscountsMap.get(productNo).getDiscount()) {
						maxDiscountsMap.put(productNo, new PromotionDiscount(promotionName, discount, productNo));
					}
				}
//	            System.out.println("促銷活動已經開始: " + promotionName); // 顯示促銷專案名稱
			} else {
//	            System.out.println("促銷活動尚未開始: " + promotion.getProname());
			}
		}

		ObjectMapper objectMapper = new ObjectMapper();
		String jsonData = objectMapper.writeValueAsString(maxDiscountsMap);

		// 設定回應的 Content-Type 為 application/json
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		// 將 JSON 字串寫入回應中
		response.getWriter().write(jsonData);

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");

		if ("add_promotion".equals(action) && session.getAttribute("formSubmitted") == null) {

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
			String selectedProducts = null;
			try {
				selectedProducts = request.getParameter("selectedProducts");
				if (selectedProducts == null || selectedProducts == "") {
					throw new Exception();
				}
			} catch (Exception e) {
				errorMsgs.add("請選擇折扣商品");
			}
			String statusString = request.getParameter("status");
			System.out.println(statusString);
			Boolean status = Boolean.parseBoolean(statusString); // 嚴格轉換字串成布林值

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
			} else {

				// 提交成功後才設置 session 屬性
				session.setAttribute("formSubmitted", true);

				// 提交資料到資料庫
				PromotionService proSvc = new PromotionService();
				proVO = proSvc.addPro(proname, prodes, startdate, enddate, discount, status, selectedProducts);

				// 取得新建的資料編號
				Integer prono = proVO.getProno();
				String url = "/back-end/promotion/listall.jsp";
				request.setAttribute("prono", prono);
				RequestDispatcher successView = request.getRequestDispatcher(url);
				successView.forward(request, response);
				return;
			}
		}

		if ("add_promotion".equals(action) && session.getAttribute("formSubmitted") != null) {
			response.sendRedirect("/Paradisiac/back-end/promotion/add.jsp");
		}

		if ("getOne_For_Update".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			request.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 ****************************************/
			Integer prono = Integer.valueOf(request.getParameter("prono"));

			/*************************** 2.開始查詢資料 ****************************************/
			PromotionService proSvc = new PromotionService();
			PromotionVO proVO = proSvc.getById(prono);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			request.setAttribute("proVO", proVO);
			String url = "/back-end/promotion/update.jsp";
			RequestDispatcher successView = request.getRequestDispatcher(url);
			successView.forward(request, response);
		}
		
		
		
		
		if ("update".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			request.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			Integer prono = Integer.valueOf(request.getParameter("prono").trim());

			String proname = request.getParameter("proname");
			String Reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
			if (proname == null || proname.trim().length() == 0) {
				errorMsgs.add("促銷專案名稱: 請勿空白");
			} else if (!proname.trim().matches(Reg)) {
				errorMsgs.add("促銷專案名稱:只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
			}

			String prodes = request.getParameter("prodes");
			if (prodes == null || prodes.trim().length() == 0) {
				errorMsgs.add("促銷專案描述: 請勿空白");
			} else if (!prodes.trim().matches(Reg)) {
				errorMsgs.add("促銷專案描述:只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
			}

			Date startdate = null;
			try {
				startdate = java.sql.Date.valueOf(request.getParameter("startdate").trim());
			} catch (IllegalArgumentException e) {
				startdate = new Date(System.currentTimeMillis());
				errorMsgs.add("請輸入日期!");
			}
			java.sql.Date enddate = null;
			try {
				enddate = java.sql.Date.valueOf(request.getParameter("enddate").trim());
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
			String selectedProducts = null;
			try {
				selectedProducts = request.getParameter("selectedProducts");
				if (selectedProducts == null || selectedProducts == "") {
					throw new Exception();
				}
			} catch (Exception e) {
				errorMsgs.add("請選擇折扣商品");
			}
			
			Boolean status = Boolean.valueOf(request.getParameter("status").trim());

			PromotionVO proVO = new PromotionVO();
			proVO.setProno(prono);
			proVO.setProname(proname);
			proVO.setProdes(prodes);
			proVO.setStartdate(startdate);
			proVO.setEnddate(enddate);
			proVO.setDiscount(discount);
			proVO.setStatus(status);

			if (!errorMsgs.isEmpty()) {
				request.setAttribute("proVO", proVO);
				RequestDispatcher failureView = request.getRequestDispatcher("/back-end/promotion/update.jsp");
				failureView.forward(request, response);
				return;
			}

			/*************************** 2.開始修改資料 *****************************************/
			PromotionService proSvc = new PromotionService();
			proVO = proSvc.updatePro(prono, proname, prodes, startdate, enddate, discount, status, selectedProducts);

			/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
			String url = "/back-end/promotion/listall.jsp";
			request.setAttribute("prono", prono);
			RequestDispatcher successView = request.getRequestDispatcher(url);
			successView.forward(request, response);
			return;
		}

	};

}
