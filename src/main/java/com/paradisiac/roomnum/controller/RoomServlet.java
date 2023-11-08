package com.paradisiac.roomnum.controller;

import java.io.*;
import java.util.*;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.paradisiac.roomnum.model.RoomNumVO;
import com.paradisiac.roomnum.service.*;
//import com.paradisiac.roomnum.RoomNumJDBCDAO;

//新增房號使用
@WebServlet("/roomnum.do")
public class RoomServlet extends HttpServlet{
	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		RoomNumServiceImpl roomnumService = new RoomNumServiceImpl();
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		System.out.println(action);
		if ("getAll".equals(action)) { 
			String page = req.getParameter("page");
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);
			
			List<RoomNumVO> roomnumList = roomnumService.getAllRoomNums(currentPage);

			if (req.getSession().getAttribute("roomnumPageQty") == null) {
				int roomnumPageQty = roomnumService.getPageTotal();
				req.getSession().setAttribute("roomnumPageQty", roomnumPageQty);
			}		
			req.setAttribute("roomnumList", roomnumList);
			req.setAttribute("currentPage", currentPage);	
			String url = "/back-end/roomnum/listAllRoomNums.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
			successView.forward(req, res);
//			return "/back-end/roomnum/listAllRoomNums.jsp";
			
		}
		
		
//		//=====================顯示一筆房間
//		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求
//
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
//			String str = req.getParameter("empno");
//			if (str == null || (str.trim()).length() == 0) {
//				errorMsgs.add("請輸入員工編號");
//			}
//			// Send the use back to the form, if there were errors
//			if (!errorMsgs.isEmpty()) {
//				RequestDispatcher failureView = req.getRequestDispatcher("/emp/select_page.jsp");
//				failureView.forward(req, res);
//				return;// 程式中斷
//			}
//
//			Integer empno = null;
//			try {
//				empno = Integer.valueOf(str);
//			} catch (Exception e) {
//				errorMsgs.add("員工編號格式不正確");
//			}
//			// Send the use back to the form, if there were errors
//			if (!errorMsgs.isEmpty()) {
//				RequestDispatcher failureView = req.getRequestDispatcher("/emp/select_page.jsp");
//				failureView.forward(req, res);
//				return;// 程式中斷
//			}
//
//			/*************************** 2.開始查詢資料 *****************************************/
//			RoomNumServiceImpl roomnumSvc = new RoomNumServiceImpl();
//			EmpVO empVO = roomnumSvc.getOneEmp(empno);
//			if (empVO == null) {
//				errorMsgs.add("查無資料");
//			}
//			// Send the use back to the form, if there were errors
//			if (!errorMsgs.isEmpty()) {
//				RequestDispatcher failureView = req.getRequestDispatcher("/emp/select_page.jsp");
//				failureView.forward(req, res);
//				return;// 程式中斷
//			}
//
//			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
//			req.setAttribute("empVO", empVO); // 資料庫取出的empVO物件,存入req
//			String url = "/emp/listOneEmp.jsp";
//			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
//			successView.forward(req, res);
//		}
        //======================CheckIn 房間=========================
		if ("getRoomNum".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 ****************************************/
			Integer roomTypeNo = Integer.valueOf(req.getParameter("roomTypeNo"));			

			/*************************** 2.開始查詢資料 ****************************************/
			RoomNumServiceImpl roomnumSvc = new RoomNumServiceImpl();
			List<RoomNumVO> roomNum = roomnumSvc.getSerivceRoomNums(roomTypeNo);
			List<RoomNumVO> getAll =roomnumSvc.getAllRoomNums();
			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("roomNum", roomNum); // 資料庫取出的empVO物件,存入req
			
			String url = "/back-end/roomnum/update_roomnum_input.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
			successView.forward(req, res);
		}
      //========================更新房間狀態5========================
		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			
			Integer rnum =null; 
			try {
				rnum= Integer.valueOf(req.getParameter("rnum").trim());
			}catch (NumberFormatException e) {
				rnum=0;
				errorMsgs.add("房間編號請填數字.");
			}		
			
			Integer roomTypeNo =null; 
			try {
				roomTypeNo= Integer.valueOf(req.getParameter("roomTypeNo").trim());
			}catch (NumberFormatException e) {
				roomTypeNo=0;
				errorMsgs.add("房型編號請填數字.");
			}	
			
			Integer roomOrderNo =null; 
			try {
				roomOrderNo= Integer.valueOf(req.getParameter("roomOrderNo").trim());
			}catch (NumberFormatException e) {
				roomOrderNo=0;
				errorMsgs.add("訂單編號請填數字.");
			}			
			
			String checkInNameReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{2,10}$";
			String checkInName = req.getParameter("checkInName").trim();
			if(!checkInName.trim().matches(checkInNameReg)) { //以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("住房姓名: 只能是中、英文字母 , 且長度必需在2到10之間");
            }
			String roomStatusReg = "^[(0-9){1}$";			
			//String roomStatusStr = req.getParameter("roomStatus").trim();
			Byte roomStatus = null;			
			RoomNumVO roomnumVO = new RoomNumVO();
			roomnumVO.setRnum(rnum);
			roomnumVO.setRoomTypeNo(roomTypeNo);
			roomnumVO.setRoomOrderNo(roomOrderNo);
			roomnumVO.setCheckInName(checkInName);
			//2表示已入住
			int status =2;  
			roomStatus = (byte)status;
			roomnumVO.setRoomStatus(roomStatus);	
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("roomnumVO", roomnumVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/emp/update_emp_input.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2.開始修改資料 *****************************************/
			RoomNumServiceImpl roomnumSvc = new RoomNumServiceImpl();
			 
			 System.out.println("更新狀態："+roomnumSvc.updateRoomNum(roomnumVO));
			/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
			req.setAttribute("roomnumVO", roomnumVO); // 資料庫update成功後,正確的的empVO物件,存入req
			String url = "/roomnum.do?action=getAll";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
			successView.forward(req, res);
		}
//		//================新增房間=================
		if ("insert".equals(action)) { // 來自addEmp.jsp的請求
			System.out.println("insert =========");
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				
			Integer rnum =null; 
			try {
rnum= Integer.valueOf(req.getParameter("rnum").trim());
			}catch (NumberFormatException e) {
				rnum=0;
				errorMsgs.add("房間編號請填數字.");
			}		
			
			Integer roomTypeNo =null; 
			try {
roomTypeNo= Integer.valueOf(req.getParameter("roomTypeNo").trim());
			}catch (NumberFormatException e) {
				roomTypeNo=0;
				errorMsgs.add("房型編號請填數字.");
			}	
			
//			Integer roomOrderNo =null; 
//			try {
//roomOrderNo= Integer.valueOf(req.getParameter("roomOrderNo").trim());
//			}catch (NumberFormatException e) {
//				roomOrderNo=0;
//				errorMsgs.add("訂單編號請填數字.");
//			}			
//			
//			String checkInNameReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{2,10}$";
//String checkInName = req.getParameter("checkInName").trim();
//			if(!checkInName.trim().matches(checkInNameReg)) { //以下練習正則(規)表示式(regular-expression)
//				errorMsgs.add("住房姓名: 只能是中、英文字母 , 且長度必需在2到10之間");
//            }
//			String statusReg = "^[0-9]{1}$";
//			
//			
//			String statusStr = req.getParameter("roomStatus").trim();
//			System.out.println(statusStr);
//			Byte roomStatus = null;
//			if (!statusStr.trim().matches(statusReg)) { // 以下練習正則(規)表示式(regular-expression)
//				errorMsgs.add("住房姓名: 只能是中、英文字母 , 且長度必需在2到10之間");
//			} else {
//				
//				try {
//roomStatus = Byte.valueOf(statusStr);
//				} catch (NumberFormatException e) {
//					roomStatus = 0;
//					errorMsgs.add("房間狀態請填數字.");
//					System.out.println("無法將房間狀態轉換為數字：" + e.getMessage());
//				}
//			}
			
			RoomNumVO roomnumVO = new RoomNumVO();
			roomnumVO.setRnum(rnum);
			roomnumVO.setRoomTypeNo(roomTypeNo);
//			roomnumVO.setRoomOrderNo(roomOrderNo);
//			roomnumVO.setCheckInName(checkInName);
//			roomnumVO.setRoomStatus(roomStatus);	
			
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("roomnumVO", roomnumVO); // 含有輸入格式錯誤的empVO物件,也存入req
				//若輸入錯誤資料將頁面轉回原來新增的頁面
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/roomnum/addRoomNum.jsp");
				failureView.forward(req, res);
				return;
			}

			/*************************** 2.開始新增資料 ***************************************/
			RoomNumServiceImpl roomnumSvc = new RoomNumServiceImpl();
			//將資料轉往service的addRoomNum();
			
			roomnumSvc.addRoomNum(roomnumVO);
			/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
			String url = "/back-end/roomnum/listAllRoom.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
			successView.forward(req, res);
		}
		//==========================刪除房間=======================
//		if ("delete".equals(action)) { // 來自listAllEmp.jsp
//
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			/*************************** 1.接收請求參數 ***************************************/
//			Integer rnum = Integer.valueOf(req.getParameter("rnum"));
//
//			/*************************** 2.開始刪除資料 ***************************************/
//			RoomNumServiceImpl roomnumSvc = new RoomNumServiceImpl();
//			roomnumSvc.deleteRoomNum(rnum);
//
//			/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
//			String url = "/back-end/roomnum/listAllRoom.jsp";
//			RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
//			successView.forward(req, res);
//		}
	}
}
