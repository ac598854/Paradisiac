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
	protected int successLogin(String memaccount, String mempass, boolean memstatus) {
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

		if (!membersVO.getMemstatus()) {
			System.out.println("帳號凍結，3");
			return 3;
		}

		// 檢查帳號+密碼
		if (membersVO.getMemaccount().equals(memaccount) && membersVO.getMempass().equals(mempass)) {
			System.out.println("成功登入，4");
			return 4;
		} else {
			System.out.println("密碼錯誤，5");
			return 5;
		}

	}

//	// 註冊檢查-帳號是否存在
//	protected int successAccount(String memaccount, String memcaptcha) {
//		MembersVO membersVO = null;
//		MembersService membersSvc = new MembersService();
//
//		// 檢查會員帳號
//		if (membersVO.getMemaccount().equals(memaccount)) {
//			System.out.println("已有相同帳號，6");
//			return 6;
//		} else {
//			System.out.println("沒有相同帳號，7");
//			return 7;
//		}
//
//	}

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
			// 取前一個登入位置
			HttpSession session = req.getSession();
//			String location = (String) session.getAttribute("location");// loginLocation紀錄登入前位置(從哪裡登入)
			String location = session.getAttribute("location") != null ? (String) session.getAttribute("location") : "";
			System.out.println("Location=" + location);

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/members/LoginError.jsp");
				failureView.forward(req, res);
				return;
			}

			// 檢查會員帳號、密碼、狀態，可以登入者賦予session會員編號(驗證是否登入會員)
			if (successLogin(memaccount, mempass, false) == 1) {
				String URL = req.getContextPath() + "/front-end/members/login.jsp?error=noAccount";
				System.out.println("無帳號轉址" + URL);
				res.sendRedirect(URL);
				System.out.println("沒有帳號");
				return;
			} else if (successLogin(memaccount, mempass, false) == 5) {
				String URL = req.getContextPath() + "/front-end/members/login.jsp?error=noAccount";
				res.sendRedirect(URL);
				System.out.println("密碼錯誤轉址");
				return;
			} else if (successLogin(memaccount, mempass, false) == 3) {
				String URL = req.getContextPath() + "/front-end/members/Login.jsp?error=noAccount";
				res.sendRedirect(URL);
				System.out.println("帳號凍結轉址");
				return;
			} else {
				//帳號、密碼、帳號狀態都OK=可以登入
				MembersService membersSvc = new MembersService();
				MembersVO membersVO = null;
				membersVO = membersSvc.getOneBymemaccount(memaccount);
				// 可以登入，賦予Session會員編號
				HttpSession session2 = req.getSession();
				System.out.println("【session】=" + session);
				session.setAttribute("memno", membersVO.getMemno());// 給session memno屬性(標示為會員)
				Integer memno = (Integer) session.getAttribute("memno");// 測試用(取得存在session會員編號)
				System.out.println("測試取得放入session的會員編號" + memno);// 測試用
				System.out.println("從哪裡登入" + location);
// ================使用者可以登入，設定當【location】為特定頁面:購物購物車、訂房訂購頁、活動訂購頁，則轉到結帳頁，否則
				if (location != "") {// 特例：如果上一個登入位置為空狀況下，在那些頁面特定頁面
					System.out.println(location);
					// 如果是活動訂購頁()
					String actorderpage = req.getContextPath() + "/front-end/actorder/ActOder.jsp";
					if (location.equals(actorderpage)) {//來源網站如果是等於活動預定頁
						System.out.println(actorderpage);// 確認活動預定頁
						res.sendRedirect(req.getContextPath() + "/front-end/actorder/ActCheckOut.jsp");//則可以進入結帳頁面
						return;
					}
					res.sendRedirect(req.getContextPath() + "/front-end/homepage.jsp");// 如果沒有特定的loginLocation(例如:最新消息)，則將使用者導向到首頁。
					return;
//	=================待填購物、訂房=========================================================
				}
				try {// 如果不是從登入頁登入，則移除登入狀態，重導回上一頁
					System.out.println("移除登入狀態");
					if (location != "") {// 如果位置不等於null則移除session中位置，並重新導向位置
						System.out.println("location=" + location);
						session.removeAttribute("location"); // 移除掉【  //*工作2: 看看有無來源網頁 (-->如有來源網頁:則重導至來源網頁)】
						res.sendRedirect(req.getContextPath() + "/front-end/homepage.jsp");
						return;
					}
				} catch (Exception ignored) {
					System.out.println(ignored.getMessage());
				}
//				res.sendRedirect(req.getContextPath() + "/front-end/homepage.jsp");// 成功登入轉至首頁

				// 測試用
				// res.sendRedirect(req.getContextPath() +"/front-end/members/MembersUpdate.jsp");

				MembersService membersService = new MembersService();
				MembersVO membersVO1 = membersService.getOneBymemno(memno);// 取152行memno
				req.setAttribute("membersVO", membersVO1);
				String url = "/front-end/members/MembersUpdate.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

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

			if (successLogin(memaccount, memcaptcha, false) == 1) {
				// 登入不成功
				System.out.println("沒有此帳號");
				String URL = req.getContextPath() + "/front-end/member/MemberCaptcha.jsp?error=noId";
				res.sendRedirect(URL);
				return;
			} else if (successLogin(memaccount, memcaptcha, false) == 4) {
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

	}

}
