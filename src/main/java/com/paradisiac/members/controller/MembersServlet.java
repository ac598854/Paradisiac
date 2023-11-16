package com.paradisiac.members.controller;

import java.io.*;
import java.nio.Buffer;
import java.sql.Date;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.catalina.connector.Response;

import com.paradisiac.members.model.*;
import com.paradisiac.members.service.*;
import com.paradisiac.members.controller.*;
import com.paradisiac.util.jedispool.JedisUtil;


import redis.clients.jedis.JedisPool;


@MultipartConfig
public class MembersServlet<Session> extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public static String getAuthCode() {
		long startTime = System.nanoTime();
		boolean tmp = true;
		StringBuilder strArr = null;
		String str = "";

		while (tmp) {
			boolean flag1 = false;
			boolean flag2 = false;
			boolean flag3 = false;
			int Arr[] = new int[8];
			for (int i = 0; i < 8; i++) {
				int r = (int) (Math.random() * 62 + 1);
				// 介於0-9
				if ((1 <= r) && (r <= 10)) {
					Arr[i] = r + 47;
					flag1 = true;
				}
				// 介於A-Z
				if ((11 <= r) && (r <= 36)) {
					Arr[i] = r + 54;
					flag2 = true;
				}
				// 介於a-z
				if ((37 <= r) && (r <= 62)) {
					Arr[i] = r + 60;
					flag3 = true;
				}
			}
			if (flag1 && flag2 && flag3) {
				for (int i = 0; i < 8; i++) {
//					System.out.print((char)Arr[i]);
					str += String.valueOf(((char) Arr[i]));

				}
				tmp = false;
			}
		}
		System.out.println("驗證碼str=" + str);
		long endTime = System.nanoTime();
		System.out.println("程式執行時間： " + (endTime - startTime) / Math.pow(10, 9) + "s");
		return str;
	}


	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		System.out.println("現在action：" + action);

		if ("getOne_For_Memno".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			String str = req.getParameter("memno");
			if (str == null || (str.trim()).length() == 0) {
				errorMsgs.add("請輸入會員編號");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/backe-end/members/MembersLPB.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			Integer memno = null;
			try {
				memno = Integer.valueOf(str);
			} catch (Exception e) {
				RequestDispatcher failureView = req.getRequestDispatcher("/backe-end/members/MembersLPB.jsp");
				errorMsgs.add("會員編號格式不正確");
			}

			/*************************** 2開始查詢資料 *****************************************/
			MembersService MemsSvc = new MembersService();
			MembersVO MembersVO = MemsSvc.getOneBymemno(memno);
			List<MembersVO> membersVOlist = new ArrayList<>();
			membersVOlist.add(MembersVO);

			if (MembersVO == null) {
				errorMsgs.add("查無資料");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/members/MembersLPB.jsp");
				failureView.forward(req, res);
				return;
			}

			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("getOne_For_Memno_SA", membersVOlist); 
			String url = "/back-end/members/MembersLPB.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); 
			successView.forward(req, res);
		}

		if ("getOne_For_Account".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			String str = req.getParameter("memaccount");
			System.out.println("str是" + str);
			if (str == null || (str.trim()).length() == 0) {
				errorMsgs.add("請輸入會員帳號");
			}

			String memaccount = null;
			try {
				memaccount = str;
			} catch (Exception e) {
				errorMsgs.add("輸入不正確");
			}
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/members/MembersLPB.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			/*************************** 2開始查詢資料 *****************************************/
			MembersService MemsSvc = new MembersService();
			MembersVO MembersVO = MemsSvc.getOneBymemaccount(memaccount);
			List<MembersVO> membersVOlist = new ArrayList<>();
			membersVOlist.add(MembersVO);
			if (MembersVO == null) {
				errorMsgs.add("查無資料");
			}
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/members/MembersLPB.jsp");
				failureView.forward(req, res);
				return;
			}

			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("getOne_For_Account_SA", membersVOlist); 
			String url = "/back-end/members/MembersLPB.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("getAll_For_Status".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			String str = req.getParameter("memstatus");
			if (str == null || str.trim().isEmpty()) {
				errorMsgs.add("請選擇帳號狀態");
			}

			if ("3".equals(str)) {
				MembersService membersService = new MembersService();
				List<MembersVO> list = membersService.getAll();
				req.setAttribute("getAll_For_Status", list); 
				String url = "/back-end/members/MembersLPB.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/backe-end/members/MembersLPB.jsp");
				failureView.forward(req, res);
				return;
			}

			Boolean memstatus = null;
			try {
				memstatus = Boolean.valueOf(str);
			} catch (Exception e) {
				errorMsgs.add("狀態不正確");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/members/MembersLPB.jsp");
				failureView.forward(req, res);
				return;
			}

			/*************************** 2開始查詢資料 *****************************************/
			MembersService MemsSvc = new MembersService();
			List<MembersVO> list = MemsSvc.getAllBystatus(memstatus);
			if (list == null) {
				errorMsgs.add("查無資料");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/members/MembersLPB.jsp");
				failureView.forward(req, res);
				return;
			}

			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("getAll_For_Status_SA", list); 
			String url = "/back-end/members/MembersLPB.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); 
			successView.forward(req, res);
		}

		if ("get_all_back".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數(取值) - 輸入格式的錯誤處理 **********************/
			Integer memno = Integer.valueOf(req.getParameter("memno"));
			MembersService membersService = new MembersService();
			MembersVO membersVO = membersService.getOneBymemno(memno);

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/members/MembersCPB.jsp");
				failureView.forward(req, res);
				return; 
			}

			/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
			req.setAttribute("membersVO", membersVO); 
			String url = "/back-end/members/MembersCPB.jsp";
			System.out.println("CP頁路徑：" + url);
			RequestDispatcher successView = req.getRequestDispatcher(url); 
			successView.forward(req, res);
		}

		if ("update_Back_Status".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 ****************************************/
			Integer memno = Integer.valueOf(req.getParameter("memno").trim());
			Boolean memstatus = Boolean.valueOf(req.getParameter("memstatus"));
			if (req.getParameter("memstatus") == null) {
				errorMsgs.add("帳號狀態請勿不點選");
			} else {
				memstatus = Boolean.parseBoolean(req.getParameter("memstatus"));
			}

			MembersVO membersVO = new MembersVO();
		
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("membersVO", membersVO); 
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/members/update_mem_input.jsp");
				failureView.forward(req, res);
				return;
			}

			/*************************** 2.開始查詢資料 ****************************************/
			MembersService memsSvc = new MembersService();
			membersVO = memsSvc.updateBackStatus(memno, memstatus);
			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("MembersVO", membersVO); 
			String url = "/back-end/members/MembersLPB.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
		}

		if ("update-Front".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
			Integer memno = Integer.valueOf(req.getParameter("memno"));
			String memname = req.getParameter("memname");
			String memmail = req.getParameter("memmail");
			String mempass = req.getParameter("mempass");
			Integer memgender = Integer.valueOf(req.getParameter("memgender"));
			String memid = req.getParameter("memid");
			java.sql.Date membir = null;
			System.out.println(req.getParameter("membir"));
			if (req.getParameter("membir") != null && req.getParameter("membir").toString().length() > 0) {
				membir = java.sql.Date.valueOf(req.getParameter("membir"));
			}
			String memphone = req.getParameter("memphone");
			String memaddress = req.getParameter("memaddress");
			Part mempicturePart = req.getPart("mempicture");
			byte[] mempictureData = null;
			if (mempicturePart != null) {
				// 圖片上傳部分不為空，處理上傳的圖片
				try (InputStream is = mempicturePart.getInputStream()) {
					ByteArrayOutputStream buffer = new ByteArrayOutputStream();
					int bytesRead;
					byte[] data = new byte[1024];
					while ((bytesRead = is.read(data)) != -1) {
						buffer.write(data, 0, bytesRead);
					}
					mempictureData = buffer.toByteArray();
					buffer.close();
				} catch (IOException e) {

					e.printStackTrace();
				}
			}

			/*************************** 2.開始查詢資料 ****************************************/
			MembersVO membersVO = new MembersVO();
			MembersService memsSvc = new MembersService();
			memsSvc.updateFront(memname, memmail, mempass, memgender, memid, membir, memphone, memaddress,
					mempictureData, memno);
			membersVO = memsSvc.getOneBymemno(memno);// 呈現更新後畫面，用memno取回所有更新資料
			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("membersVO", membersVO); 
			String url = "/front-end/members/MembersUpdate.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			System.out.println("更新後台會員狀態，後導頁至："+successView );
			successView.forward(req, res);
		}

		if ("insert".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			// 1. 格式錯誤處理
			String memname = req.getParameter("memname");
			String memmail = req.getParameter("memmail");
			String memaccount = req.getParameter("memaccount");
			String mempass = req.getParameter("mempass");
			Integer memgender = Integer.valueOf(req.getParameter("memgender"));
			String memid = req.getParameter("memid");
			String membirString = req.getParameter("membir");
			java.sql.Date membir = null;
			if (membirString != null && !membirString.isEmpty()) {
				try {
					membir = java.sql.Date.valueOf(membirString);
				} catch (IllegalArgumentException e) {
					// 日期無效
					membir = java.sql.Date.valueOf("1970-01-01");
				}
			} else {
				// 日期為空
				membir = java.sql.Date.valueOf("1970-01-01");
			}
			String memcaptcha = req.getParameter("memcaptcha");
			String memphone = req.getParameter("memphone");
			String memaddress = req.getParameter("memaddress");
			Part mempicturePart = req.getPart("mempicture");
			byte[] mempictureData = null;
			if (mempicturePart != null) {
				try (InputStream is = mempicturePart.getInputStream()) {
					ByteArrayOutputStream buffer = new ByteArrayOutputStream();
					int bytesRead;
					byte[] data = new byte[1024];
					while ((bytesRead = is.read(data)) != -1) {
						buffer.write(data, 0, bytesRead);
					}
					mempictureData = buffer.toByteArray();
				} catch (IOException e) {
					e.printStackTrace();
					errorMsgs.add("圖片上傳失敗");
				}
			} else {
				//處理圖片為空補充
			}
			;

			if (!errorMsgs.isEmpty()) {
				// 錯誤停留在註冊頁
				System.out.println("錯誤停留在註冊頁");
				String url = "/front-end/members/Signin.jsp";
				RequestDispatcher errorView = req.getRequestDispatcher(url);
				errorView.forward(req, res);
			} else {
				// 3.新增完成,準備轉交(Send the Success view)
				MembersService memsSvc = new MembersService();
				MembersVO membersVO = memsSvc.Insertmember(memname, memmail, memaccount, mempass, memgender, memid,
						membir, memphone, memaddress, memcaptcha, mempictureData);
				req.setAttribute("membersVO", membersVO);
				String url = "/front-end/members/Login.jsp"; 
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				System.out.println("新增成功");
			}
		}

		if ("getAuthCode".equals(action)) {
			String memmail = req.getParameter("memmail");
			String memcaptcha = getAuthCode();
			JedisUtil.getJedisPool();// 開池
			JedisUtil.set(memmail, memcaptcha);//原始
			System.out.println("1取得產生的驗證碼=" + memcaptcha);// 取得產生的驗證碼
			System.out.println("2從redis取回驗證碼=" + JedisUtil.get(memmail));// 從redis取回驗證碼
//			======寄信			
			MembersVO membersVO = new MembersVO();			
			membersVO.setMemmail(memmail);
			membersVO.setMemcaptcha(memcaptcha);
			req.setAttribute("membersVO", membersVO);
			String subject = "啟用會員驗證信";	
			String messageText = "Hello! " + "\n" + "歡迎加入Paradise bay會員" + "\n"+"如無申請Paradise bay會員請忽略此信" + "\n" 
					+ "您的註冊驗證碼: " + "\n" + memcaptcha + "\n";
			MailService mail = new MailService();
			mail.sendMail(memmail, subject, messageText);
			System.out.println("寄信成功");
			res.getWriter().write("OK");

		}

		if ("checkAccount".equals(action)) {
			String memaccount = req.getParameter("memaccount");
			MembersService memsSvc = new MembersService();
			MembersVO membersVO = null;
			Boolean responseMessage = null;

			try {
				membersVO = memsSvc.getOneBymemaccount(memaccount);
			} catch (Exception e) {
				e.printStackTrace();
				// 處理異常
			}

			if (membersVO != null && membersVO.getMemaccount().equals(memaccount)) {
				responseMessage = false;
				System.out.println("帳號已存在，帳號不可使用");
			} else {
				responseMessage = true;
				System.out.println("無此帳號，帳號可用");
			}

			// 回傳JSON
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");

			// 使用 PrintWriter 回傳JSON
			PrintWriter out = res.getWriter();
			out.print("{\"message\": \"" + responseMessage + "\"}");
			out.flush();
		}

		if ("checkCaptcha".equals(action)) {
			// 取email、輸入驗證碼
			String memcaptcha = req.getParameter("memcaptcha");
			String memmail = req.getParameter("memmail");
			JedisUtil.getJedisPool();// 開池
			Integer responseMessage = null;
			try {

			} catch (Exception e) {
				e.printStackTrace();
				// 處理異常
			}
			// 開池驗證
			String tempAuth = JedisUtil.get(memmail);
//			String tempAuth = MailHander.get(memmail);
			if (memcaptcha == null) {// 驗證碼輸入不為空
				responseMessage = 1;
				System.out.println("連結信已逾時，請重新申請");
			} else if (memcaptcha.equals(tempAuth)) {
				responseMessage = 2;
				System.out.println("驗證成功!");
			} else {
				responseMessage = 3;
				System.out.println("驗證碼錯誤，請重新輸入");
			}			
			res.setContentType("text/plain");
			res.setCharacterEncoding("UTF-8");

			PrintWriter out = res.getWriter();
			out.print(responseMessage);
			out.flush();
		}
		
		//6.首頁會員狀態判斷
		if ("indexLogin".equals(action)) {
			
			HttpSession session = req.getSession();
			Object memno = session.getAttribute("memno");
			System.out.println("indexLogin(首頁有會員編號嗎?)"+memno);
			Integer responseMessage = null;
			if(memno != null && !String.valueOf(memno).isEmpty()) {
				responseMessage = 1;
				System.out.println("首頁會員");				
			}else {
				responseMessage = 0;
				System.out.println("首頁非會員");
			}
			PrintWriter out = res.getWriter();
			out.print(responseMessage);
			System.out.println(responseMessage);
			out.flush();
		}

	}
}
