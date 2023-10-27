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
import com.paradisiac.members.model.*;
import com.paradisiac.members.service.*;
import com.paradisiac.util.jedispool.JedisUtil;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

@WebServlet("/back-end/members/members.do")
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
		System.out.println("str" + str);
		long endTime = System.nanoTime(); // 獲取結束時間
		System.out.println("程式執行時間： " + (endTime - startTime) / Math.pow(10, 9) + "s");
		return str;
	}

	public String insertCode(String memno) {
		String code = getAuthCode();
		JedisUtil.set(memno, code);
		JedisPool pool = JedisUtil.getJedisPool();
		System.out.println("測試jedis-code：" + code);
		JedisUtil.shutdownJedisPool();
		return code;
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		System.out.println("現在action：" + action);

		if ("getOne_For_Memno".equals(action)) { // 來自select_page.jsp的請求

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
				return;// 程式中斷
			}

			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("getOne_For_Memno_SA", membersVOlist); // // 資料庫取出的empVO物件,存入req
			String url = "/back-end/members/MembersLPB.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
			successView.forward(req, res);
		}

		if ("getOne_For_Account".equals(action)) { // 來自select_page.jsp的請求

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
				return;// 程式中斷
			}

			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("getOne_For_Account_SA", membersVOlist); // // 資料庫取出的empVO物件,存入req
			String url = "/back-end/members/MembersLPB.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
			successView.forward(req, res);
		}

		if ("getAll_For_Status".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			String str = req.getParameter("memstatus");
			if (str == null || str.trim().isEmpty()) {
				errorMsgs.add("請選擇帳號狀態");
			}

			if ("3".equals(str)) {
				MembersService membersService = new MembersService();
				List<MembersVO> list = membersService.getAll();
				req.setAttribute("getAll_For_Status", list); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/members/MembersLPB.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);
			}

			// Send the use back to the form, if there were errors

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/backe-end/members/MembersLPB.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			Boolean memstatus = null;
			try {
				memstatus = Boolean.valueOf(str);
			} catch (Exception e) {
				errorMsgs.add("狀態不正確");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/members/MembersLPB.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			/*************************** 2開始查詢資料 *****************************************/
			MembersService MemsSvc = new MembersService();
			List<MembersVO> list = MemsSvc.getAllBystatus(memstatus);
			if (list == null) {
				errorMsgs.add("查無資料");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/members/MembersLPB.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("getAll_For_Status_SA", list); // // 資料庫取出的empVO物件,存入req
			String url = "/back-end/members/MembersLPB.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
			successView.forward(req, res);
		}

		if ("get_all_back".equals(action)) { // 來自update_emp_input.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數(取值) - 輸入格式的錯誤處理 **********************/

			Integer memno = Integer.valueOf(req.getParameter("memno"));// 以編號查詢修改
			MembersService membersService = new MembersService();
			MembersVO membersVO = membersService.getOneBymemno(memno);

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				// req.setAttribute("MembersVO", MembersVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/members/MembersCPB.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
			req.setAttribute("membersVO", membersVO); // 資料庫update成功後,正確的的empVO物件,存入req
			String url = "/back-end/members/MembersCPB.jsp";
			System.out.println("CP頁路徑：" + url);
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
			successView.forward(req, res);
		}

		if ("update_Back_Status".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
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
			membersVO.setMemstatus(memstatus);

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("membersVO", membersVO); // 含有輸入格式錯誤的membersVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/members/update_mem_input.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2.開始查詢資料 ****************************************/
			MembersService memsSvc = new MembersService();
			membersVO = memsSvc.updateBackStatus(memno, memstatus);
			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("MembersVO", membersVO); // 資料庫取出的empVO物件,存入req
			String url = "/back-end/members/MembersLPB.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
			successView.forward(req, res);
		
		}

		if ("get_all_front".equals(action)) { // 來自update_emp_input.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數(取值) - 輸入格式的錯誤處理 **********************/

			String memaccount = req.getParameter("memaccount");// 以編號查詢修改
			MembersService membersService = new MembersService();
			MembersVO membersVO = membersService.getOneBymemaccount(memaccount);

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				// req.setAttribute("MembersVO", MembersVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/members/MembersUpdate.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
			req.setAttribute("membersVO", membersVO); // 資料庫update成功後,正確的的empVO物件,存入req
			String url = "/front-end/members/MembersUpdate.jsp";
			System.out.println("CP頁路徑：" + url);
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
			successView.forward(req, res);
			
		}

		if ("update-Front".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
			String memname = req.getParameter("memname");
			String memmail = req.getParameter("memmail");
			String mempass = req.getParameter("mempass");
			String memstatus = req.getParameter("memstatus");
			Integer memgender = Integer.valueOf(req.getParameter("memgender"));
			String memid = req.getParameter("memid");
			java.sql.Date membir = java.sql.Date.valueOf(req.getParameter("membir"));
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

				if (mempicturePart == null) {

					// 建構webapp絕對路徑
					String webappPath = getServletContext().getRealPath("/");

					// 建構相對路徑
					String relativeImagePath = "front-end/images/no-picture-taking.png";
					String absoluteImagePath = webappPath + relativeImagePath;

					File defaultImageFile = new File(absoluteImagePath);

//					String defaultImagePath = "/front-end/images/no-picture-taking.png";
//					// 使用ServletContext获取资源流
//					InputStream defaultImageStream = getServletContext().getResourceAsStream(defaultImagePath);
					if (defaultImageFile.exists()) {
						// 成功获取资源流，您可以继续处理
						// ...
					} else {
						// 资源不存在，处理错误
						System.out.println("默认图像文件不存在");
					}
				}
//==
//			Part mempicturePart = req.getPart("mempicture"); // 获取上传的文件部分
//			InputStream mempictureStream = mempicturePart.getInputStream(); // 获取输入流以读取文件内容
//
//			byte[] buffer = new byte[1024]; // 缓冲区大小，您可以根据需要调整
//			int bytesRead;
//			ByteArrayOutputStream output = new ByteArrayOutputStream();
//
//			while ((bytesRead = mempictureStream.read(buffer)) != -1) {
//				output.write(buffer, 0, bytesRead);
//			}
//
//			byte[] mempicture = output.toByteArray(); // 获取二进制数据

				// 现在您可以使用 mempicture 这个 byte[] 来处理上传的图像数据

				// ======
				Integer memno = Integer.valueOf(req.getParameter("memno"));

				// Send the use back to the form, if there were errors
//			if (!errorMsgs.isEmpty()) {
//				req.setAttribute("update-Front", MembersVO); // 含有輸入格式錯誤的memVO物件,也存入req
//				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/members/update.jsp");
//				failureView.forward(req, res);
//				return;
//			}

				/*************************** 2.開始新增資料 ***************************************/
				MembersService MemsSvc = new MembersService();
				MembersVO membersvo = MemsSvc.updateFront(memname, memmail, mempass, memgender, memid, membir, memphone,
						memaddress, mempictureData, memno);
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("memberVO", membersvo);
				String url = "/back-end/members/MembersCPB.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
			}
		}
		if ("insert".equals(action)) { // 來自addEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
			String memname = req.getParameter("memname");
			String memmail = req.getParameter("memmail");
			String memaccount = req.getParameter("memaccount");
			String mempass = req.getParameter("mempass");
			Integer memgender = Integer.valueOf(req.getParameter("memgender"));
			String memid = req.getParameter("memid");

			java.sql.Date membir = null;
			String membirString = req.getParameter("membir");
			if (membirString != null && !membirString.isEmpty()) {
				try {
					membir = java.sql.Date.valueOf(membirString);
				} catch (IllegalArgumentException e) {

					membir = java.sql.Date.valueOf("1970-01-01");
				}
			} else {

				membir = java.sql.Date.valueOf("1970-01-01");
			}
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
					buffer.close();
				} catch (IOException e) {

					e.printStackTrace();
				}

				if (mempicturePart == null) {

					// 获取webapp目录的绝对路径
					String webappPath = getServletContext().getRealPath("/");

					// 构建相对路径
					String relativeImagePath = "front-end/images/no-picture-taking.png";
					String absoluteImagePath = webappPath + relativeImagePath;

					File defaultImageFile = new File(absoluteImagePath);

//					String defaultImagePath = "/front-end/images/no-picture-taking.png";
//					// 使用ServletContext获取资源流
//					InputStream defaultImageStream = getServletContext().getResourceAsStream(defaultImagePath);
					if (defaultImageFile.exists()) {
						// 成功获取资源流，您可以继续处理
						// ...
					} else {
						// 资源不存在，处理错误
						System.out.println("默认图像文件不存在");
					}
				}
				String memcaptcha = getAuthCode();
				System.out.println("驗證碼：" + memcaptcha);
				/*************************** 2.開始新增資料 ***************************************/
				MembersService MemsSvc = new MembersService();
				MembersVO membersvo = MemsSvc.Insertmember(memname, memmail, memaccount, mempass, memgender, memid,
						membir, memphone, memaddress, memcaptcha, mempictureData);
				req.setAttribute("membersVO", membersvo);
				String subject = "啟用會員驗證信";
				String ch_name = membersvo.getMemname();
				String ch_account = membersvo.getMemaccount();
				String messageText = "Hello! " + ch_name + "\n" + "歡迎加入Paradise bay會員" + "\n" + "您的註冊帳號:" + ch_account
						+ " 註冊驗證碼: " + "\n" + memcaptcha + "\n" + "請至該網址輸入驗證碼 " + "\n" + "http://localhost:8081"
						+ req.getContextPath() + "/front-end/member/MemberCaptcha.jsp";
				MailService mail = new MailService();
				mail.sendMail(memmail, subject, messageText);
				System.out.println("寄信成功");
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front-end/members/MemberCaptcha.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
				System.out.println("新增成功");
			}
		}

//			if ("delete".equals(action)) { // 來自listAllEmp.jsp
//				Map<String, String> errorMsgs1 = new LinkedHashMap<String, String>();
//				req.setAttribute("errorMsgs", errorMsgs1);
//
//				/*************************** 1.接收請求參數 ***************************************/
//				Integer memno = Integer.valueOf(req.getParameter("memno"));
//
//				/*************************** 2.開始刪除資料 ***************************************/
//				MembersService memsSvc = new MembersService();
//				memsSvc.deleteMember(memno);
//
//				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
//				String url = "/back-end/members/listAllMem.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
//				successView.forward(req, res);
//			}
	}
}
