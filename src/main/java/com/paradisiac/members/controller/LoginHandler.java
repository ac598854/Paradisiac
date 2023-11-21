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
import javax.servlet.ServletRequest;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.springframework.web.bind.support.SessionStatus;

import com.paradisiac.members.model.MembersVO;
import com.paradisiac.members.service.MembersService;

import org.mindrot.jbcrypt.BCrypt;
import org.json.JSONObject;

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
		String storedHashedPassword=membersVO.getMempass();
//	    if (BCrypt.checkpw(mempass, storedHashedPassword)) {
//
//	    } else {
//
//	    }			
		// 檢查帳號+密碼
		if (membersVO.getMemaccount().equals(memaccount) && BCrypt.checkpw(mempass, storedHashedPassword)) {
			 // 使用正确密码验证密码是否正确
	        boolean flag = BCrypt.checkpw(mempass, storedHashedPassword);
	        System.out.println("加密比較結果："+flag);			
			System.out.println("成功登入，4");
			return 4;
		} else {
			System.out.println("密碼錯誤，5");
			return 5;
		}

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		JSONObject jsonObject = new JSONObject();
		// 1.登出狀態
		// 2.會員登入狀態，檢查(滿足帳號、密碼)、會員登入後可用頁面
		// 3.會員註冊檢查(帳號是否已有)【AJAX】
		// 4.寄送生成驗證碼、寄送驗證信
		// 5.會員註冊驗證碼確認【AJAX】

		// 1.會員登出狀態
		if ("stateLogout".equals(action)) {
			HttpSession session = req.getSession(false);
			Object memno = session.getAttribute("memno");
			Object location = session.getAttribute("location");
			session.removeAttribute("memno");
			session.removeAttribute("location");
			System.out.println("登出是否還有會員編號"+memno);			
			res.getWriter().write("ok");
		}
		
		// 2.會員登入狀態，檢查(滿足帳號、密碼、非凍結)、會員登入可用頁面
		// (1)會員登入:檢查帳號、密碼、帳號狀態是否正確
		// (2)會員登入後【特定頁面】:如果前一頁時待結帳頁面，導到結帳頁(活動結帳、訂房結帳、購物車結帳)
		// (3)例外判斷
		// (4)會員登入後【非特定頁面】:導到首頁

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
			// 設置位置
			HttpSession session = req.getSession();
			String location = session.getAttribute("location") != null ? (String) session.getAttribute("location") : "";
			System.out.println("LoginFiliter location:" + location);

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/members/LoginError.jsp");
				failureView.forward(req, res);
				return;
			}

// 檢查會員帳號、密碼、狀態，可以登入者賦予session會員編號(驗證是否登入會員)
		
			if (successLogin(memaccount, mempass, false) == 1) {
				System.out.println("無帳號轉址" + location);
				String URL = req.getContextPath() + "/front-end/members/Login.jsp?error=noAccount";
				res.sendRedirect(URL);
				System.out.println("沒有帳號");
				return;
			} else if (successLogin(memaccount, mempass, false) == 5) {
//			 
				System.out.println("密碼錯誤轉址" + location);
				String URL = req.getContextPath() + "/front-end/members/Login.jsp?error=noAccount";
				res.sendRedirect(URL);
				return;
			} else if (successLogin(memaccount, mempass, false) == 3) {
				System.out.println("帳號凍結轉址" + location);
				String URL = req.getContextPath() + "/front-end/members/Login.jsp?error=lockAccount";
				res.sendRedirect(URL);
				return;
			} else {
				// 帳號、密碼、帳號狀態都OK=可以登入
				MembersService membersSvc = new MembersService();
				MembersVO membersVO = null;
				membersVO = membersSvc.getOneBymemaccount(memaccount);
				// 可以登入，賦予Session會員編號
				session.setAttribute("memno", membersVO.getMemno());
	
				Integer memno = (Integer) session.getAttribute("memno");// 測試用(取得存在session會員編號)
				System.out.println("測試取得放入session的會員編號" + memno);// 測試用

// ================會員狀態，設定當【location】為特定頁面:購物車、訂房訂購頁、活動訂購頁
				if(location=="") {
				
					session.setAttribute("location", req.getRequestURI());
					Object location1=session.getAttribute("location");
					System.out.println("正常登入，設定location:"+location1);
					res.sendRedirect(req.getContextPath() + "/front-end/index/index2.jsp");
					return;
					
				}
								
				if (location != "") {// 上一個登入位置不為空狀況下
					System.out.println(location);
					// 如果是活動訂購頁()，要結帳需要會員
					String actorderpage = req.getContextPath() + "/front-end/actorder/ActOder.jsp";
					if (location.equals(actorderpage)) {// 來源網站如果是等於活動預定頁
						res.sendRedirect(req.getContextPath() + "/front-end/actorder/ActCheckOut.jsp");// 則可以進入結帳頁面
						return;
					}

					// 如果在網站任何頁面點選購物車，需要驗證會員(購物車結帳亦為會員狀態)
					String shoppingCart = req.getContextPath() + "/front-end/cart/cart.html";
					if (location.equals(shoppingCart)) {
						System.out.println("購物車登入，進入購物車詳細頁");
						res.sendRedirect(shoppingCart);// 如果是點選購物頁面進入登入，則登入後回購物車詳細頁
						return;
					}
					
					
					//如果訂房點選結帳頁
					String roomorderpage=req.getContextPath() + "/back-end/roomorder/orderbuy.jsp";
					if (location.equals(roomorderpage)) {
						System.out.println("訂房登入，進入結帳頁");
						res.sendRedirect(roomorderpage);
						return;
					}
					

					System.out.println("非特定頁面登入，導回首頁");
					res.sendRedirect(req.getContextPath() + "/front-end/index/index2.jsp");// 如果沒有特定的loginLocation(例如:最新消息)，則將使用者導向到首頁。
					return;

				}

//	=================待填購物、訂房=========================================================
				try {// 例外狀況，路徑有問題，移除錯誤location
					if (location != null) {
						session.removeAttribute("location");// 移除錯誤location
						res.sendRedirect(location); // 如有來源網頁:則重導至來源網頁
						return;
					}
				} catch (Exception ignored) {// 如無來源網頁:則導至首頁
					System.out.println(ignored.getMessage());
					res.sendRedirect(req.getContextPath() + "/front-end/index/index2.jsp");
				}
				res.sendRedirect(req.getContextPath() + "/front-end/index/index2.jsp");// 成功登入轉至首頁

			}

		}

	}

}
