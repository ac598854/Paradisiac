package com.paradisiac.product.controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.paradisiac.product.model.*;

public class ProductServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			// (1)
			String str = req.getParameter("productno");
			if (str == null || (str.trim()).length() == 0) {
				errorMsgs.add("請輸入商品編號");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/view/select_page_product.jsp");
				failureView.forward(req, res);
				return;
			}

			Integer productno = null;
			try {
				productno = Integer.valueOf(str);
			} catch (Exception e) {
				errorMsgs.add("請輸入正確格式");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/view/select_page_product.jsp");
				failureView.forward(req, res);
				return;
			}

			// (2)查詢
			ProductService productSvc = new ProductService();
			ProductVO productVO = productSvc.getOneProduct(productno);
			if (productVO == null) {
				errorMsgs.add("請輸入商品編號");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/view/select_page_product.jsp");
				failureView.forward(req, res);
				return;
			}

			// (3)送出畫面
			req.setAttribute("productVO", productVO);
			String url = "/view/index.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // listOneEmp.jsp
			successView.forward(req, res);

		}

		if ("getOne_For_Update".equals(action)) { // 修改單一商品listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			// (1)
			Integer productno = Integer.valueOf(req.getParameter("productno"));

			// (2)查詢
			ProductService productSvc = new ProductService();
			ProductVO productVO = productSvc.getOneProduct(productno);

			// (3)送出畫面
			req.setAttribute("productVO", productVO);
			String url = "/view/update_product_input.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// update_emp_input.jsp
			successView.forward(req, res);
		}

		if ("update".equals(action)) { // 修改商品update_emp_input.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			// (1)
			// 商品編號
			Integer productno = Integer.valueOf(req.getParameter("productno").trim());

			// 商品名稱
			String productname = req.getParameter("productname");
			String productReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,30}$";
			if (productname == null || productname.trim().length() == 0) {
				errorMsgs.add("請輸入商品名稱");
			} else if (!productname.trim().matches(productReg)) { // �H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
				errorMsgs.add("商品名稱必須為2到30個字的中英數字符號");
			}

			// 商品價格
			Integer productprice;
			try {
				productprice = Integer.valueOf(req.getParameter("productprice").trim());
			} catch (NumberFormatException e) {
				productprice = 0;
				errorMsgs.add("請輸入價格！");
			}

			// 商品庫存
			Integer productquantity;
			try {
				productquantity = Integer.valueOf(req.getParameter("productquantity").trim());
			} catch (NumberFormatException e) {
				productquantity = 0;
				errorMsgs.add("請輸入庫存量！");
			}

			// 商品狀態
			Integer productstatus = 0;
			try {
				productstatus = Integer.valueOf(req.getParameter("productstatus").trim());
			} catch (NumberFormatException e) {
				productstatus = 0;
				errorMsgs.add("商品未上架！");
			}

			// 商品總評價
			Integer producttotalreviewcount;
			try {
				producttotalreviewcount = Integer.valueOf(req.getParameter("producttotalreviewcount").trim());
			} catch (NumberFormatException e) {
				producttotalreviewcount = 0;
				errorMsgs.add("尚未評價");
			}

			// 商品評價人數
			Integer producttotalreviewstatus;
			try {
				producttotalreviewstatus = Integer.valueOf(req.getParameter("producttotalreviewstatus").trim());
			} catch (NumberFormatException e) {
				producttotalreviewstatus = 0;
				errorMsgs.add("尚未評價");
			}

			// 商品類別編號
			Integer productcategoryno;
			try {
				productcategoryno = Integer.valueOf(req.getParameter("productcategoryno").trim());
			} catch (NumberFormatException e) {
				productcategoryno = 0;
				errorMsgs.add("請輸入類別編號");
			}
			ProductVO productVO = new ProductVO();
			productVO.setProductno(productno);
			productVO.setProductname(productname);
			productVO.setProductprice(productprice);
			productVO.setProductquantity(productquantity);
			productVO.setProductstatus(productstatus);
			productVO.setProducttotalreviewcount(producttotalreviewcount);
			productVO.setProducttotalreviewstatus(producttotalreviewstatus);
			productVO.setProductcategoryno(productcategoryno);

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("productVO", productVO);
				RequestDispatcher failureView = req.getRequestDispatcher("/view/update_product_input.jsp");
				failureView.forward(req, res);
				return;
			}

			// (2)查詢
			ProductService productSvc = new ProductService();
			productVO = productSvc.updateProduct(productno, productname, productprice, productquantity, productstatus,
					producttotalreviewcount, producttotalreviewstatus, productcategoryno);

			// (3)送出畫面
			req.setAttribute("productVO", productVO);
			String url = "/view/listOneProduct.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // listOneEmp.jsp
			successView.forward(req, res);
		}

		if ("insert".equals(action)) { // 新增商品addEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			// (1)
			// 商品名稱
			String productname = req.getParameter("productname");
			String productReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,30}$";
			if (productname == null || productname.trim().length() == 0) {
				errorMsgs.add("請輸入商品名稱");
			} else if (!productname.trim().matches(productReg)) { 
				errorMsgs.add("商品名稱必須為2到30個字的中英數字符號");
			}

			// 商品價格
			Integer productprice;
			try {
				productprice = Integer.valueOf(req.getParameter("productprice").trim());
			} catch (NumberFormatException e) {
				productprice = 0;
				errorMsgs.add("請輸入價格！");
			}

			// 商品庫存
			Integer productquantity;
			try {
				productquantity = Integer.valueOf(req.getParameter("productquantity").trim());
			} catch (NumberFormatException e) {
				productquantity = 0;
				errorMsgs.add("請輸入庫存量！");
			}

			// 商品狀態
			Integer productstatus = 0;
			try {
				productstatus = Integer.valueOf(req.getParameter("productstatus").trim());
			} catch (NumberFormatException e) {
				productstatus = 0;
				errorMsgs.add("商品未上架！");
			}

			// 商品總評價
			Integer producttotalreviewcount;
			try {
				producttotalreviewcount = Integer.valueOf(req.getParameter("producttotalreviewcount").trim());
			} catch (NumberFormatException e) {
				producttotalreviewcount = 0;
				errorMsgs.add("尚未評價");
			}

			// 商品評價人數
			Integer producttotalreviewstatus;
			try {
				producttotalreviewstatus = Integer.valueOf(req.getParameter("producttotalreviewstatus").trim());
			} catch (NumberFormatException e) {
				producttotalreviewstatus = 0;
				errorMsgs.add("沒有人評價");
			}

			// 商品類別編號
			Integer productcategoryno;
			try {
				productcategoryno = Integer.valueOf(req.getParameter("productcategoryno").trim());
			} catch (NumberFormatException e) {
				productcategoryno = 0;
				errorMsgs.add("請輸入類別編號");
			}

			ProductVO productVO = new ProductVO();
			productVO.setProductname(productname);
			productVO.setProductprice(productprice);
			productVO.setProductquantity(productquantity);
			productVO.setProductstatus(productstatus);
			productVO.setProducttotalreviewcount(producttotalreviewcount);
			productVO.setProducttotalreviewstatus(producttotalreviewstatus);
			productVO.setProductcategoryno(productcategoryno);

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("productVO", productVO); 
				RequestDispatcher failureView = req.getRequestDispatcher("/view/addProduct.jsp");
				failureView.forward(req, res);
				return;
			}

			// (2)查詢
			ProductService productSvc = new ProductService();
			productVO = productSvc.addProduct(productname, productprice, productquantity, productstatus,
					producttotalreviewcount, producttotalreviewstatus, productcategoryno);

			// (3)送出畫面
			String url = "/view/listAllProduct.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // listAllEmp.jsp
			successView.forward(req, res);
		}

		if ("delete".equals(action)) { // 刪除（下架）商品listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			//(1)
			Integer productno = Integer.valueOf(req.getParameter("productno"));

			//(2)查詢
			ProductService productSvc = new ProductService();
			productSvc.deleteProduct(productno);

			//(3)送出畫面
			String url = "/view/listAllProduct.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

	}

}
