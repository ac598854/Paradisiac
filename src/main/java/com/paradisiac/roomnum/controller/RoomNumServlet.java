package com.paradisiac.roomnum.controller;

import java.io.*;
import java.util.*;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import static com.paradisiac.util.Constants.PAGE_MAX_RESULT;
import com.paradisiac.roomnum.model.RoomNumDAOImpl;
import com.paradisiac.roomnum.model.RoomNumVO;
import com.paradisiac.roomnum.service.*;
//import com.paradisiac.roomnum.RoomNumJDBCDAO;
import com.paradisiac.roomorder.model.*;
import com.paradisiac.roomorder.service.*;
import com.paradisiac.roomtype.service.*;
import com.paradisiac.roomtype.model.*;
//新增房號使用
@WebServlet("/roomnum.do")
public class RoomNumServlet extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}
	//顯示全部房間狀態
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		RoomNumServiceImpl roomnumService = new RoomNumServiceImpl();
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		System.out.println(action);
		//取得所有房間資料
		if ("getAll".equals(action)) {
			
			getAllRoomNum(roomnumService, req, res);
		}

			// ======更新房間狀態，當listAllCheckInData.jsp按下checkin按鈕時要更新RoomOrder及RoomNum========================
		if ("update".equals(action)) { // 來自listAllCheckInData.jsp的請求
			//傳送錯誤訊息
			List<String> errorMessage = new LinkedList<String>();
			req.setAttribute("errorMessage", errorMessage);
			//傳送成功訊息
			List<String> successMessage = new LinkedList<String>();
			req.setAttribute("successMessage", successMessage);
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			//取得房間編號
			Integer rnum = null;
			try {
				rnum = Integer.valueOf(req.getParameter("rnum").trim());
			} catch (NumberFormatException e) {
				rnum = 0;
				errorMessage.add("房間編號請填數字.");
			}
			//取得房型編號
			Integer roomTypeNo = null;
			try {
				roomTypeNo = Integer.valueOf(req.getParameter("roomTypeNo").trim());
			} catch (NumberFormatException e) {
				roomTypeNo = 0;
				errorMessage.add("房型編號請填數字.");
			}
			//取得訂單編號
			Integer roomOrderNo = null;
			try {
				roomOrderNo = Integer.valueOf(req.getParameter("roomOrderNo").trim());
			} catch (NumberFormatException e) {
				roomOrderNo = 0;
				errorMessage.add("訂單編號請填數字.");
			}
			
			String memName = req.getParameter("memName").trim();
			//取得住房人姓名
			String checkInNameReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{2,10}$";
			String checkInName = req.getParameter("checkInName").trim();
			if(checkInName =="" || checkInName.isEmpty() ) {
				checkInName = memName;
			}
			if (!checkInName.trim().matches(checkInNameReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMessage.add("住房姓名: 只能是中、英文字母 , 且長度必需在2到10之間");
			}							
			
			//取得該訂單已分配房間數量-(當該訂單當天有下訂3間房間時，要以此來判斷已分配幾間房間給該訂單)
			Integer roomOrderNoCount = null;
			try {
				roomOrderNoCount = Integer.valueOf(req.getParameter("roomOrderNoCount").trim());
			} catch (NumberFormatException e) {
				roomOrderNoCount = 0;
				errorMessage.add("訂單房間數請填數字.");
			}
			//取得該訂單下訂幾間房間
			Integer roomAmount = null;
			try {
				roomAmount = Integer.valueOf(req.getParameter("roomAmount").trim());
			} catch (NumberFormatException e) {
				roomAmount = 0;
				errorMessage.add("房型編號請填數字.");
			}
			
			/*************************** 2.開始修改資料 *****************************************/			
			//★★★更新訂單狀態將訂房狀態改變為2，(說明：1表示未入住，2表示已入住-已給過房間號碼)
			RoomOrderServiceImpl roomorderSvc = new RoomOrderServiceImpl();
			byte orderStatus = 2;
			roomOrderNoCount +=1; //listAllCheckInDate.jsp每按一下checkin按鈕時就讀取roomOrderNoCount並加一比對會員下訂的房間數量是否相等
			System.out.println("roomOrderNoCount"+roomOrderNoCount+"==,==roomAmount"+roomAmount);
			
			if(roomOrderNoCount==roomAmount) {
				roomorderSvc.updateOrderStatus(roomOrderNo, orderStatus);
			}
			//★★★更新房間狀態
			// 2表示已入住，這間房間便不可以再分配給下一個人，除非狀態改變為1
			int status = 2; // 在這直接將status狀態值改變為2
			Byte roomStatus = null;
			roomStatus = (byte) status;
			RoomNumServiceImpl roomnumSvc = new RoomNumServiceImpl();
			System.out.println("更新房間狀態(顯示1表示成功，-1表示失敗)：" + roomnumSvc.updateRoomNumStatus(rnum, roomOrderNo, checkInName, roomStatus));
			/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
//			getAllRoomNum(roomnumService, req, res);
			//String url = "/order.do?action=handleCheckIn";
			String url = "/order.do?action=handleCheckIn&source=update";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交roomorder/RoomOrderServlet.java
			successView.forward(req, res);
		}

				// 改變房間狀態-checkout-退房 -將狀態2(住房中)改變為3(清潔中)
				if ("checkout".equals(action)) {
					String page = req.getParameter("page");
					int currentPage = (page == null) ? 1 : Integer.parseInt(page);
					//傳送錯誤訊息
					List<String> errorMessage = new LinkedList<String>();
					req.setAttribute("errorMessage", errorMessage);
					//傳送成功訊息
					List<String> successMessage = new LinkedList<String>();
					req.setAttribute("successMessage", successMessage);
					
					//取得訂單編號
					String roomOrderNoStr = req.getParameter("roomOrderNo");
					System.out.println("訂單編號："+roomOrderNoStr);
					Integer roomOrderNo = null;
					if (roomOrderNoStr != null && !roomOrderNoStr.isEmpty()) {
						try {
							roomOrderNo = Integer.valueOf(roomOrderNoStr.trim());
						} catch (NumberFormatException e) {					
							
							getAllRoomNum(roomnumService, req, res);
						}
					}
					//點擊退房按鈕時將訂單狀態改為3表示已結案(入住完畢)
					byte orderStatus = 3;
					System.out.println("訂單編號："+roomOrderNo+"，訂單狀態更新為："+orderStatus);
					RoomOrderServiceImpl roomorderSvc = new RoomOrderServiceImpl();
					roomorderSvc.updateOrderStatus(roomOrderNo, orderStatus);
					
					
					//★★★★★★
					//========================更新房間狀態=================================
					// 3表示退房，將訂單及住房姓名清空，但此時還是不能加入分配房間的清單中，此時狀態為清掃中
					String rnumParam = req.getParameter("rnum");
					Integer rnum;
					System.out.println(action+"房間號碼："+rnumParam);
					if (rnumParam != null && !rnumParam.isEmpty()) {
					    rnum = Integer.valueOf(rnumParam.trim());
					    System.out.println("退房-房間號碼："+rnum);
					roomOrderNo = null;
					String checkInName ="";
					int status = 3; // 將status狀態值改變為3表示清潔中
					Byte roomStatus = null;
					roomStatus = (byte) status;	
					RoomNumServiceImpl roomnumSvc = new RoomNumServiceImpl();
					roomnumSvc.updateRoomNumStatus(rnum,roomOrderNo,checkInName,roomStatus);
					successMessage.add("成功退房-房間編號："+rnum +" ，待打掃人員清潔中。");
					
					}
					//==========================更新房間狀態===================================
					getAllRoomNum(roomnumService, req, res);
				}
				// 改變房間狀態-打掃完成==================================
				if ("cleanup".equals(action)) {
					String page = req.getParameter("page");
					int currentPage = (page == null) ? 1 : Integer.parseInt(page);
					//傳送錯誤訊息
					List<String> errorMessage = new LinkedList<String>();
					req.setAttribute("errorMessage", errorMessage);
					//傳送成功訊息
					List<String> successMessage = new LinkedList<String>();
					req.setAttribute("successMessage", successMessage);
					// ★★★★★★
					// ========================更新房間狀態=================================
					// 1表示已清掃完成，可加入分配房間的清單中，此時狀態為可入住
					String rnumParam = req.getParameter("rnum");
					System.out.println(action+"清掃-房間號碼："+rnumParam);
					Integer rnum;
					if (rnumParam != null && !rnumParam.isEmpty()) {
					    rnum = Integer.valueOf(rnumParam.trim());					  
					//Integer rnum = Integer.valueOf(req.getParameter("rnum").trim());
					Integer roomOrderNo = null;
					String checkInName = "";
					int status = 1; // 在這直接將status狀態值改變為1，清掃完成將狀態改變為可訂房
					Byte roomStatus = null;
					roomStatus = (byte) status;
					RoomNumServiceImpl roomnumSvc = new RoomNumServiceImpl();
					//更新房間狀態-將訂單編號、房客姓名、房間狀態清空
					roomnumSvc.updateRoomNumStatus(rnum, roomOrderNo, checkInName, roomStatus);					
					successMessage.add("清掃完成-房間編號："+rnum +" ，已清潔完畢可安排入住。");
					}
					//==========================更新房間狀態===================================
					/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
					
					getAllRoomNum(roomnumService, req, res);
				}
		// 房間新增、修改、刪除
		if ("roomNumModify".equals(action)) { // 來自index.jsp	
			//設定房型下拉選單
			RoomTypeServiceImpl roomTypeService = new RoomTypeServiceImpl();
			List<RoomTypeVO> roomTypeList = roomTypeService.getAll();
			req.setAttribute("roomTypeList", roomTypeList);
			
			String page = req.getParameter("page");
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);		
			List<RoomNumVO> roomnumList = roomnumService.getAllRoomNums(currentPage);
			if (req.getSession().getAttribute("roomnumPageQty") == null) {
				int roomnumPageQty = roomnumService.getPageTotal();
				req.getSession().setAttribute("roomnumPageQty", roomnumPageQty);
				}
		    System.out.print("=====================currentPage:"+currentPage);
		    req.setAttribute("roomTypeList", roomTypeList);
			req.setAttribute("roomnumList", roomnumList);
			req.setAttribute("currentPage", currentPage);	
			String url = "/back-end/roomnum/listRoomNumDel.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
			successView.forward(req, res);
			//=====================
			List<String> errorMessage = new LinkedList<String>();		
			req.setAttribute("errorMessage", errorMessage);			
			
		}
//		================新增房間=================
		if ("addRoomNum".equals(action)) { // 來自addEmp.jsp的請求
			//設定房型下拉選單
			RoomTypeServiceImpl roomTypeService = new RoomTypeServiceImpl();
			List<RoomTypeVO> roomTypeList = roomTypeService.getAll();
			req.setAttribute("roomTypeList", roomTypeList);
			
			String page = req.getParameter("page");
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);
			
			List<String> errorMessage = new LinkedList<String>();
			req.setAttribute("errorMessage", errorMessage);
			List<String> successMessage = new LinkedList<String>();
			req.setAttribute("successMessage", successMessage);
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/

			// 取得房間編號
			String rnumStr = req.getParameter("roomNum");
			Integer rnum = null;
			if (rnumStr == null || rnumStr.isEmpty()) {
				errorMessage.add("房間編號不能空白");
				CRUDupdatePage(roomnumService, currentPage, req, res);
			} else {
				try {
					rnum = Integer.valueOf(rnumStr.trim());

				} catch (NumberFormatException e) {

					errorMessage.add("房間編號請填數字.");
					CRUDupdatePage(roomnumService, currentPage, req, res);
				}
			}
			// 取得房型編號
			String roomTypeNoStr = req.getParameter("TypeNo");
			Integer roomTypeNo = null;
			if (roomTypeNoStr == null || roomTypeNoStr.isEmpty()) {
				errorMessage.add("房型編號不能空白");
				CRUDupdatePage(roomnumService, currentPage, req, res);
			} else {
				try {
					roomTypeNo = Integer.valueOf(roomTypeNoStr.trim());
				} catch (NumberFormatException e) {
					errorMessage.add("房型編號請填數字.");
					CRUDupdatePage(roomnumService, currentPage, req, res);
				}
			}
			Byte roomStatus = null;
			int status = 1; // 在這直接將status狀態值改變為1表示可以排房
			roomStatus = (byte) status;
			// 取出指定房型的房間數量-roomNumVO★★★★★★
			int count = roomnumService.getTotal(roomTypeNo).intValue();
			System.out.println("roomNum數量：" + count);

			RoomTypeServiceImpl roomTypeSvc = new RoomTypeServiceImpl();
			// 取出房型設定的房間數量-roomTypeVO★★★★★★
			Integer totalInt = roomTypeSvc.getTotal(roomTypeNo); // totalInt:為了要能判斷null所以轉成Integer

			// 檢查是否有重覆的房間號碼
			RoomNumVO roomNumVO = roomnumService.getById(rnum);
			if (roomNumVO != null) {
				Integer id = roomNumVO.getRnum();
				if (id != null) {
					errorMessage.add("您輸入的房間號碼：" + rnum + "，已重覆請重新輸入。");
					CRUDupdatePage(roomnumService, currentPage, req, res);
				}
			}
			// =================================================================================
			// 將前端收集的資料存到roomNumVO物件內
			

//			// 檢查新增的資料是否有重覆新增
//			if (totalInt == null) {
//				errorMessage.add("目前沒有設定，房型編號：" + roomTypeNo + "，無法新增請重新輸入別的房型編號。");
//				CRUDupdatePage(roomnumService, currentPage, req, res);
//			}
			int total = totalInt.intValue();			
			
			//房間數量已超過房型資料表中定義的房間總數則無法再新增房間
			if (count >= total) {
				errorMessage.add("房型名稱:" + findRoomTypeName(roomTypeList,roomTypeNo) + "，設定房間數為" + total + "間已超過設定數量，無法新增房間編號："+rnum+"。");
				CRUDupdatePage(roomnumService, currentPage, req, res);
			}

			if (!errorMessage.isEmpty()) {
				// 若輸入錯誤資料將頁面轉回原來新增的頁面
				CRUDupdatePage(roomnumService, currentPage, req, res);
			}
			/*************************** 2.開始新增資料 ***************************************/
			// 要更新房間資料必須符合房間數量(count)小於房型(total)且房型(totalInt:為了要能判斷null所以轉成Integer)必須不能為空值
			if (totalInt != null) {
				if (count < total) {
					// 新增1筆房間資料
					roomnumService.addRoomNum(rnum, roomTypeNo, roomStatus);
					successMessage.add(
							"成功新增-房間編號：" + rnum + "，房型名稱:" + findRoomTypeName(roomTypeList,roomTypeNo) + "，總共有" + total + "間，已增加" + (count + 1) + "間");
					// 取得比自已房間編號小的總筆數，使新增時能計算跳到那個分頁
					Long addPage = roomnumService.getAddPage(rnum);
					//跳到新增資料的那一頁
					if (addPage != null && addPage >= 0) {
						int newPage = (addPage.intValue() / PAGE_MAX_RESULT)
								+ ((addPage.intValue() % PAGE_MAX_RESULT) > 0 ? 1 : 0);
						// 使用 newPage 进行跳转，addPage + 1 是因为新增后需要算上新增的数据
						
		     /*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
						CRUDupdatePage(roomnumService, newPage, req, res);
					}
				}
			}
		}
		//刪除房間資料
		if ("delRoomNum".equals(action)) { // 來自listRoomNumDel.jsp	
			
			//設定房型下拉選單-顯示房型編號使用
			RoomTypeServiceImpl roomTypeService = new RoomTypeServiceImpl();
			List<RoomTypeVO> roomTypeList = roomTypeService.getAll();
			req.setAttribute("roomTypeList", roomTypeList);
			
			String page = req.getParameter("page");
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);	
			List<String> successMessage = new LinkedList<String>();
			req.setAttribute("successMessage", successMessage);
			/*************************** 1.接收請求參數 ***************************************/
			Integer rnum = Integer.valueOf(req.getParameter("rnum"));
			/*************************** 2.開始刪除資料 ***************************************/
			RoomNumServiceImpl roomnumSvc = new RoomNumServiceImpl();
			roomnumSvc.deleteRoomNum(rnum);
			successMessage.add("成功刪除-房間編號："+rnum);
			/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
			CRUDupdatePage(roomnumService,currentPage, req, res);
		}
		//更新房間資料
		if ("updateRoomNum".equals(action)) { // 來自listRoomNumDel.jsp
			
			//設定房型下拉選單
			RoomTypeServiceImpl roomTypeService = new RoomTypeServiceImpl();
			List<RoomTypeVO> roomTypeList = roomTypeService.getAll();
			req.setAttribute("roomTypeList", roomTypeList);
			
			String page = req.getParameter("page");
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);
			List<String> errorMessage = new LinkedList<String>();
			req.setAttribute("errorMessage", errorMessage);
			List<String> successMessage = new LinkedList<String>();
			req.setAttribute("successMessage", successMessage);
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			//取得房間編號
			String rnumStr = req.getParameter("rnum");
			Integer rnum = null;
			if(rnumStr!=null) {
				try {
					rnum = Integer.valueOf(rnumStr.trim());
				} catch (NumberFormatException e) {
					rnum = 0;
					errorMessage.add("房間編號請填數字.");
					CRUDupdatePage(roomnumService, currentPage, req, res);
				}
			}		
			//取得房型編號
			String roomTypeNoStr = req.getParameter("roomTypeNo");
			Integer roomTypeNo = null;
			if (roomTypeNoStr != null && !roomTypeNoStr.isEmpty()) {
				try {
					roomTypeNo = Integer.valueOf(roomTypeNoStr.trim());
				} catch (NumberFormatException e) {					
					errorMessage.add("房型編號請填數字.");
					CRUDupdatePage(roomnumService, currentPage, req, res);
				}
			}
			//取得訂單編號
			String roomOrderNoStr = req.getParameter("roomOrderNo");
			Integer roomOrderNo = null;
			if (roomOrderNoStr != null && !roomOrderNoStr.isEmpty()) {
				try {
					roomOrderNo = Integer.valueOf(roomOrderNoStr.trim());
				} catch (NumberFormatException e) {					
					errorMessage.add("訂單編號請填數字.");
					CRUDupdatePage(roomnumService, currentPage, req, res);
				}
			}		
			// 說明：\\s表示可以輸入空白 ，\\d表示可以輸入數字
			String checkInNameReg = "^[(\\s\\d\u4e00-\u9fa5)(a-zA-Z)]{2,30}$";		
			//取得住房人姓名
			String checkInNameStr = req.getParameter("checkInName");
			String checkInName = null;			
			if (checkInNameStr != null && !checkInNameStr.isEmpty()) {
				checkInName = checkInNameStr.trim();
				if (!checkInName.matches(checkInNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMessage.add("住房姓名: 只能是中、英文字母 , 且長度必需在2到10之間======");
					CRUDupdatePage(roomnumService, currentPage, req, res);
				}		
			}
			
			byte roomStatus = Byte.valueOf(req.getParameter("roomStatus").trim());
			
			
			/*************************** 2.開始修改資料 *****************************************/		
			//================★★★★★★修改前先確認指定的房型的房間count要小於房型的total才能新增
			//取出修改房型的房間count★★★★★★
			
			System.out.println("這是房型"+roomTypeNo);
			int count =roomnumService.getTotal(roomTypeNo,rnum).intValue();
			System.out.println("roomNum數量："+ count);
			//取出房型的total★★★★★★			
			RoomTypeServiceImpl roomTypeSvc = new RoomTypeServiceImpl();
			System.out.println("這是房型"+roomTypeNo);		
			Integer totalInt =roomTypeSvc.getTotal(roomTypeNo); //totalInt:為了要能判斷null所以轉成Integer	

			//=================================================================================
			//將前端收集的資料存到roomNumVO物件內
			// 要更新房間資料必須符合房間數量(count)小於房型(total)且房型(totalInt:為了要能判斷null所以轉成Integer)必須不能為空值
			if (totalInt != null) {
				int total = totalInt.intValue();
				if (count < total) {
					System.out.println("roomType數量：" + total);
					RoomNumVO roomNumVO = new RoomNumVO();
					roomNumVO.setRnum(rnum);
					roomNumVO.setRoomTypeNo(roomTypeNo);
					roomNumVO.setRoomOrderNo(roomOrderNo);
					roomNumVO.setCheckInName(checkInName);
					roomNumVO.setRoomStatus(roomStatus);
					roomnumService.updateRoomNum(roomNumVO);					
					successMessage.add("成功更新-房間號碼："+rnum+" , 房型名稱："+findRoomTypeName(roomTypeList,roomTypeNo)+" , 訂單編號："+roomOrderNo+" , 住房姓名："+checkInName);
				}
				else {
					
					errorMessage.add("房型名稱:"+findRoomTypeName(roomTypeList,roomTypeNo)+"，設定房間數量為"+total+"間，已超過設定的房間數量無法將【房間編號："+rnum+"】修改為【"+findRoomTypeName(roomTypeList,roomTypeNo)+"】。");
					CRUDupdatePage(roomnumService, currentPage, req, res);
				}
			}
			/*************************** 3.修改完成,準備轉交(Send the Success view) *************/

			CRUDupdatePage(roomnumService, currentPage, req, res);
		}
	}
	//房間管理系統
	public void getAllRoomNum(RoomNumServiceImpl roomnumService, HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		RoomTypeServiceImpl roomtypeService = new RoomTypeServiceImpl();
		RoomOrderServiceImpl roomOrderService = new RoomOrderServiceImpl();
		String page = req.getParameter("page");
		int currentPage = (page == null) ? 1 : Integer.parseInt(page);
		List<RoomNumVO> roomnumList = roomnumService.getAllRoomNums(currentPage);
		List<RoomTypeVO> roomtypeList = roomtypeService.getAll();
		List<RoomOrderVO> roomOrderList = roomOrderService.getAllOrd();
		if (req.getSession().getAttribute("roomnumPageQty") == null) {
			int roomnumPageQty = roomnumService.getPageTotal();
			req.getSession().setAttribute("roomnumPageQty", roomnumPageQty);
		}
		req.setAttribute("roomOrderList", roomOrderList);
		req.setAttribute("roomtypeList", roomtypeList);
		req.setAttribute("roomnumList", roomnumList);
		req.setAttribute("currentPage", currentPage);
		String url = "/back-end/roomnum/listAllRoomNums.jsp";
		RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listAllRoomNums.jsp
		successView.forward(req, res);
	}

//在進行新增修改刪除時都能停留在原頁面或新增跳轉到新增筆數的頁面
	public void getAllRoomNumPage(RoomNumServiceImpl roomnumService, int currentPage, HttpServletRequest req,
			HttpServletResponse res) throws ServletException, IOException {
		
		// String page = req.getParameter("page");
		// int currentPage = (page == null) ? 1 : Integer.parseInt(page);
		// 計算總頁數
		int roomnumPageQty = roomnumService.getPageTotal();
		req.getSession().setAttribute("roomnumPageQty", roomnumPageQty);
		// 新增時跳到新增的頁面將第幾頁的頁數填入getAllRoomNums(),會取出該面的集合資料
		List<RoomNumVO> roomnumList = roomnumService.getAllRoomNums(currentPage);
		
		req.setAttribute("roomnumList", roomnumList);
		req.setAttribute("currentPage", currentPage);
		String url = "/back-end/roomnum/listRoomNums.jsp";
		RequestDispatcher successView = req.getRequestDispatcher(url);
		successView.forward(req, res);
	}
	

//在進行新增修改刪除時都能停留在原頁面或新增跳轉到新增筆數的頁面
	public void CRUDupdatePage(RoomNumServiceImpl roomnumService, int currentPage, HttpServletRequest req,
			HttpServletResponse res) throws ServletException, IOException {
		// String page = req.getParameter("page");
		// int currentPage = (page == null) ? 1 : Integer.parseInt(page);
		// 計算總頁數
		int roomnumPageQty = roomnumService.getPageTotal();
		req.getSession().setAttribute("roomnumPageQty", roomnumPageQty);
		// 新增時跳到新增的頁面將第幾頁的頁數填入getAllRoomNums(),會取出該面的集合資料
		List<RoomNumVO> roomnumList = roomnumService.getAllRoomNums(currentPage);
		req.setAttribute("roomnumList", roomnumList);
		req.setAttribute("currentPage", currentPage);
		String url = "/back-end/roomnum/listRoomNumDel.jsp";
		RequestDispatcher successView = req.getRequestDispatcher(url);
		successView.forward(req, res);
	}

//計算插入數據後的新頁面的輔助方法
	private int calculateNewPageAfterInsertion(RoomNumServiceImpl roomnumService, int currentPage) {
		int totalRows = roomnumService.getPageTotal(); // 獲取總行數
		int pageSize = PAGE_MAX_RESULT; // 獲取每頁顯示的行數
		// 根據總行數和每頁顯示的行數計算新頁面
		int newPage = (int) Math.ceil((double) totalRows / pageSize);
		return (newPage > 0) ? newPage : 1;
	}
	public String findRoomTypeName(List<RoomTypeVO> roomTypeList,int roomTypeNo ) {
		String TypeName="";
		for (RoomTypeVO roomType : roomTypeList) {
			// 在這裡可以使用 roomType 物件的屬性或方法		    
		    if(roomTypeNo== roomType.getRoomTypeno()) {
		    	TypeName= roomType.getRoomName();
		    }		    
		}
		return TypeName;
	}
}
