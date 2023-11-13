package com.paradisiac.csmessages.controller;

import java.io.*;
import java.sql.Timestamp;
import java.util.*;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.paradisiac.csmessages.model.CsMessagesVO;
import com.paradisiac.csmessages.service.CsMessagesService;
import com.paradisiac.members.model.MembersVO;
import com.paradisiac.members.service.MembersService;


@MultipartConfig
public class CsmessagesServlet<Session> extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		System.out.println("現在action：" + action);

		// 後台抓客服編號
		if ("getOne_For_CsMsgno".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			Integer csmsgno = Integer.valueOf(req.getParameter("csmsgno"));
			System.out.println("後台取得什麼"+(req.getParameter("csmsgno")));
			/*************************** 2開始查詢資料 *****************************************/
			CsMessagesService csMegSvc = new CsMessagesService();
			CsMessagesVO CsVO = csMegSvc.getOneByCsmsgno(csmsgno);
			
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/backe-end/csmessages/MessageLPB.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}
			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("CsVO", CsVO);
			String url = "/back-end/csmessages/MessageCPB.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交
			successView.forward(req, res);
		}

		// 抓客服編號(前台)檢視
		if ("getOne_For_CsMsgno_Front".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			Integer csmsgno = Integer.valueOf(req.getParameter("csmsgno"));
		
			/*************************** 2開始查詢資料 *****************************************/
			CsMessagesService csMegSvc = new CsMessagesService();
			CsMessagesVO CsVO = csMegSvc.getOneByCsmsgno(csmsgno);
						
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/csmessages/MessageLPF.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}
			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("CsVO", CsVO);
			String url = "/front-end/csmessages/MessageCPF_readonly.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交
			successView.forward(req, res);
		}

		if ("getAll_For_Empno".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			String str = req.getParameter("empno");
			if (str == null || str.trim().isEmpty()) {
				errorMsgs.add("請輸入員工編號");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/backe-end/csmessages/MessageLPB.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			Integer empno = null;
			try {
				empno = Integer.valueOf(str);
			} catch (Exception e) {
				errorMsgs.add("員工編號不正確");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/backe-end/csmessages/MessageLPB.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}
			/*************************** 2開始查詢資料 *****************************************/
			CsMessagesService csMegSvc = new CsMessagesService();
			List<CsMessagesVO> list = csMegSvc.getAllByEmpno(empno);
			if (list == null) {
				errorMsgs.add("查無資料");
			}
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/csmessages/MessageLPB.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}
			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("list", list);
			String url = "/back-end/csmessages/MessageCPB.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("getAll_For_Status".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// 處理狀態
			String resStatus = req.getParameter("resStatus");
			// 申訴內容 關鍵字
			String keyword = req.getParameter("keyword") != null ? req.getParameter("keyword") : "";

			StringBuffer whereCondition = new StringBuffer("");
			if (keyword.trim().length() > 0) {
				whereCondition.append(" cs_content LIKE ?  ");
			}
//			下拉式選單resStatus 有 0 , 1, 2三種狀態
			if (whereCondition.length() > 0) {
				whereCondition.append(" and ");
			}
			if (resStatus.equals("1")) {
				whereCondition.append(" emp_no is  not NULL ");
			} else if (resStatus.equals("2")) {
				whereCondition.append(" emp_no is  NULL ");
			}
			whereCondition.append(" where " + whereCondition.toString());
			req.setAttribute("errorMsgs", errorMsgs);
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/backe-end/csmessages/MessageLPB.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/backe-end/csmessages/MessageLPB.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}
			/*************************** 2開始查詢資料 *****************************************/
			CsMessagesService csMegSvc = new CsMessagesService();
			List<CsMessagesVO> list = csMegSvc.getAllBystatus(whereCondition, keyword);
			if (list == null) {
				errorMsgs.add("查無資料");
			}
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/csmessages/MessageLPB.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}
			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("list", list);
			String url = "/back-end/csmessages/MessageLPB.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("insert_Front".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			// 1. 接收請求參數 - 輸入格式的錯誤處理
			String cscontent = req.getParameter("cscontent");
			System.out.println("客戶問題：" + cscontent);
			HttpSession session = req.getSession();
			Integer memno = (Integer) session.getAttribute("memno");
			System.out.println("測試取得放入session的會員編號" + memno);// 測試用
			if (!errorMsgs.isEmpty()) {
				// 錯誤停留在註冊頁
				System.out.println("錯誤停留在註冊頁");
				String url = "/front-end/members/MembersUpdate.jsp";
				RequestDispatcher errorView = req.getRequestDispatcher(url);
				errorView.forward(req, res);
			} else {
				// 3.新增完成,準備轉交(Send the Success view)
				CsMessagesService csMegSvc = new CsMessagesService();
				CsMessagesVO CsVO = csMegSvc.insertFront(memno, cscontent);
				req.setAttribute("CsVO_SA", CsVO);
				String url = "/front-end/csmessages/MessageLPF.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				System.out.println("新增成功");
			}
		}
		
		
//		if ("get_all_back".equals(action)) {
//			List<String> errorMsgs = new LinkedList<String>();
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			/*************************** 1.接收請求參數(取值) - 輸入格式的錯誤處理 **********************/
//			Integer csmsgno  = Integer.valueOf(req.getParameter("csmsgno "));
//			CsMessagesService csMegSvc = new CsMessagesService();
//			CsMessagesVO CsVO = csMegSvc.getOneByCsmsgno(csmsgno );
//
//			if (!errorMsgs.isEmpty()) {
//				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/csmessages/MessageLPB.jsp");
//				failureView.forward(req, res);
//				return; 
//			}
//
//			/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
//			req.setAttribute("CsVO", CsVO); 
//			String url = "/back-end/members/MembersCPB.jsp";
//			
//			RequestDispatcher successView = req.getRequestDispatcher(url); 
//			successView.forward(req, res);
//		}
		
		
		
		if ("update_Back".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 ****************************************/	
			Integer csmsgno = Integer.valueOf(req.getParameter("csmsgno").trim());
			System.out.println("回覆訊息，取得訊息編號:"+csmsgno);
			
			//取(員編)
			HttpSession session= req.getSession();
			Integer empno=103;//先塞假資料
//			Integer empno = (Integer) session.getAttribute("empno");//正式用
			
			//取回覆
			String csreply = req.getParameter("csreply");
			if (req.getParameter("csreply") == null) {
				errorMsgs.add("請回覆客戶");
			} else {
				csreply = req.getParameter("csreply");
			}

			CsMessagesVO CsVO = new CsMessagesVO();
	
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("CsVO", CsVO); 
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/csmessages/MessageCPB.jsp");
				failureView.forward(req, res);
				return;
			}

			/*************************** 2.開始查詢資料 ****************************************/
			CsMessagesService csMegSvc = new CsMessagesService();
			CsVO= csMegSvc.updateBack(empno, csreply,csmsgno);
			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("CsVO", CsVO); 
			String url = "/back-end/csmessages/MessageLPB.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
	}
}
