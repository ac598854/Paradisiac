package com.paradisiac.members.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.paradisiac.members.model.MembersVO;
import com.paradisiac.members.service.MembersService;

@MultipartConfig
public class LoginHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginHandler() {
		super();
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	// 檢查密碼、帳號
	protected int successLogin(String memaccount, String mempass) {
		MembersVO membersVO = null;
		MembersService membersSvc = new MembersService();

		// 檢查帳號
		if (membersSvc.getOneBymemaccount(memaccount) == null) {
			System.out.println("沒有此帳號，1");
			return 1;
		} else {
			membersVO = membersSvc.getOneBymemaccount(memaccount);
			System.out.println("有此帳號，2");
		}

		// 檢查帳號+密碼
		if (membersVO.getMemaccount().equals(memaccount) && membersVO.getMempass().equals(mempass)) {
			System.out.println("成功登入，3");
			return 3;
		} else {
			System.out.println("密碼錯誤，4");
			return 4;
		}

	}

	// 註冊檢查-帳號是否存在【不用AJAX?】
	protected int successAccount(String memaccount, String memcaptcha) {
		MembersVO membersVO = null;
		MembersService membersSvc = new MembersService();

		// 檢查會員帳號
		if (membersVO.getMemaccount().equals(memaccount)) {
			System.out.println("已有相同帳號，5");
			return 5;
		} else {
			System.out.println("沒有相同帳號，6");
			return 6;
		}

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		// 1.登出狀態
		// 2.會員登入狀態，檢查(滿足帳號、密碼)、會員登入後可用頁面
		// 3.會員註冊檢查(帳號是否已有)【AJAX】
		// 4.寄送生成驗證碼、寄送驗證信
		// 5.會員註冊驗證碼確認【AJAX】

		// 1.會員登出狀態
		if ("stateLogout".equals(action)) {
			HttpSession session = req.getSession();
			session.removeAttribute("memno");
			res.sendRedirect(req.getContextPath() + "/front-end/homepage.jsp?state=logout");
		}

		// 2.會員登入狀態，檢查(滿足帳號、密碼、非凍結)、會員登入可用頁面
		if ("loginCheck".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			String memaccount = req.getParameter("memaccount");
			String mempass = req.getParameter("mempass");
			if (memaccount != null) {
				memaccount = memaccount.trim();

			}
			System.out.println(memaccount);
			if (mempass != null) {
				mempass = mempass.trim();
			}
			String loginLocation = req.getParameter("loginLocation");// loginLocation紀錄登入前位置(從哪裡登入)
			System.out.println("loginLocation=" + loginLocation);

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/members/LoginError.jsp");
				failureView.forward(req, res);
				return;
			}

			// 檢查會員帳號、密碼、狀態，可以登入者賦予session會員編號(驗證是否登入會員)
			if (successLogin(memaccount, mempass) == 1) {
				String URL = req.getContextPath() + "/front-end/members/login.jsp?error=noAccount";
				System.out.println("無帳號轉址" + URL);
				res.sendRedirect(URL);
				System.out.println("沒有帳號");
				return;
			} else if (successLogin(memaccount, mempass) == 4) {
				String URL = req.getContextPath() + "/front-end/members/login.jsp?error=noAccount";
				res.sendRedirect(URL);
				System.out.println("密碼錯誤轉址");
				return;
			}else {
				MembersService membersSvc = new MembersService();
				MembersVO membersVO = null;
				membersVO = membersSvc.getOneBymemaccount(memaccount);
				// 帳號凍結
				if (!(membersVO.getMemstatus())) {// 帳號凍結
					res.sendRedirect(req.getContextPath() + "/front-end/members/Login.jsp?state=notEnabled&requestURI="
							+ loginLocation);
					return;
				}

// 帳號、密碼、帳號狀態都OK=可以登入
				HttpSession session = req.getSession();
				System.out.println("【session】=" + session);
				session.setAttribute("memno", membersVO.getMemno());// 給session memno屬性(標示為會員)
				Integer memno = (Integer) session.getAttribute("memno");// 測試用
				System.out.println("測試取得放入session的會員編號"+memno);// 測試用

				System.out.println("從哪裡登入" + loginLocation);// 不是從登入會面近來有location

// ================設定當【loginLocation】為特定頁面:購物購物車、訂房訂購頁、活動訂購頁，則轉到結帳頁

				if (loginLocation != "") {// 如果上一個登入位置不等於空，則可以進入結帳頁面)
					System.out.println(loginLocation);

					// 如果是活動訂購頁()
					String actorderpage = req.getContextPath() + "/front-end/actorder/ActOder.jsp";
					if (loginLocation.equals(actorderpage)) {
						System.out.println(actorderpage);// 確認購物頁
						res.sendRedirect(req.getContextPath() + "/shop/actorder.do?action=toActCheckOut");
						return;
					}
					res.sendRedirect(req.getContextPath() + "/front-end/homepage.jsp");// 如果沒有特定的
																						// loginLocation，則將使用者導向到首頁。
					return;
//	=================待填購物、訂房=========================================================
				}
				try {// 如果不是從登入頁登入，則移除登入狀態，重導回上一頁
					String location = (String) session.getAttribute("location");
					if (location != null) {// 如果位置不等於null則移除session中位置，並重新導向位置
						System.out.println("location=" + location);
						session.removeAttribute("location"); // 移除掉
						res.sendRedirect(location);
						return;
					}

				} catch (Exception ignored) {
					System.out.println(ignored.getMessage());

				}
				res.sendRedirect(req.getContextPath() + "/front-end/homepage.jsp");// 成功登入轉至首頁

				// ======測試用跳轉至會員專區
////				res.sendRedirect(req.getContextPath() + "/front-end/MembersUpdate.jsp");
//				MembersService membersSvc1 = new MembersService();
//				MembersVO membersVO1 = null;
//				membersVO1 = membersSvc1.getOneBymemaccount(memaccount);
//				System.out.println(membersVO1);
//				req.setAttribute("membersVO", membersVO1); // 資料庫update成功後,正確的的empVO物件,存入req
//				String url = "/front-end/members/MembersUpdate.jsp";
//				System.out.println("CP頁路徑：" + url);
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
//				System.out.println("RES:"+res+"REQ:"+req);
//				successView.forward(req, res);
			}

		}

		if ("update-Front".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
			String memname = req.getParameter("memname");
			String memmail = req.getParameter("memmail");
			String mempass = req.getParameter("mempass");
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
			}
		}
		if ("email-Confirm".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			String memaccount = req.getParameter("memaccount");
			if (memaccount == null || memaccount.trim().length() == 0) {
				errorMsgs.add("會員帳號：請勿空白");
			}
			String memcaptcha = req.getParameter("memcaptcha");
			System.out.println("會員輸入驗證碼" + memcaptcha);
			if (memcaptcha == null || memcaptcha.trim().length() == 0) {
				errorMsgs.add("註冊驗證碼：請勿空白");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/member/MemberCaptcha.jsp?error=space");
				failureView.forward(req, res);
				return;
			}

			if (successLogin(memaccount, memcaptcha) == 1) {
				// 登入不成功
				System.out.println("沒有此帳號");
				String URL = req.getContextPath() + "/front-end/member/MemberCaptcha.jsp?error=noId";
				res.sendRedirect(URL);
				return;
			} else if (successLogin(memaccount, memcaptcha) == 4) {
				// 登入不成功
				System.out.println("驗證碼錯誤");
				String URL = req.getContextPath() + "/front-end/member/MemberCaptcha.jsp?error=wrongNum";
				res.sendRedirect(URL);
				return;
			} else {

				MembersService MemsSvc = new MembersService();
				MembersVO membersVO = MemsSvc.getOneBymemaccount(memaccount);
				System.out.println("取得帳號" + membersVO);
				MemsSvc.updateBackStatus(membersVO.getMemno(), true);

				res.sendRedirect(req.getContextPath() + "/front-end/member/MemberCaptcha.jsp?error=success");

			}

		}

//	// 會員註冊檢查(帳號重複?)【AJAX】
//	if("AccountCheck".equals(action)){
//		JSONObject output = new JSONObject();
//		String inputId=req.getParameter("inputId");
//		MemberService memberSvc=new MemberService();
//		MemberVO memberVO=null;
//		memberVO=memberSvc.getfindOnePK(inputId);
//		
//		try {
//	        output.put("available", ((memberVO==null)?"Y":"N"));
//	    } catch (JSONException e) {
//	        // TODO Auto-generated catch block
//	        e.printStackTrace();
//	    }
//	    res.setContentType("text/plain");
//	    PrintWriter out = res.getWriter();
//	    System.out.println(output);
//	    out.write(output.toString());
//	    out.flush();
//	    out.close();
//	}

		// 4.寄驗證碼

//		String email = request.getParameter("email");
//
//        // 在此處理寄送驗證碼的邏輯，例如生成驗證碼、寄送郵件
//
//        // 假設驗證碼為 "123456"
//        String verificationCode = "123456";
//
//        response.getWriter().write("驗證碼已寄送至您的郵件: " + email);

		// 5.會員註冊驗證碼確認【AJAX】
//
//		 String email = request.getParameter("email");
//	        String verificationCode = request.getParameter("verificationCode");

		// 在此處理驗證碼檢查的邏輯，確認驗證碼是否正確

//	        // 假設驗證碼為 "123456"
//	        if (verificationCode.equals("123456")) {
//	            response.getWriter().write("驗證成功");
//	        } else {
//	            response.getWriter().write("驗證失敗");
//	        }
//	    }

	}

}
