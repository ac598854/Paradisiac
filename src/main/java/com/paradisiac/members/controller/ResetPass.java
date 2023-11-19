package com.paradisiac.members.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.paradisiac.members.model.*;
import com.paradisiac.members.service.*;
import com.paradisiac.util.jedispool.JedisUtil;

import org.json.JSONObject;
import org.mindrot.jbcrypt.BCrypt;

public class ResetPass extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		System.out.println("action=" + action);
		JSONObject jsonObject = new JSONObject();

		if ("sendRestPass".equals(action)) {
			try {
				String memaccount = req.getParameter("memaccount").trim();
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				if (memaccount == null || memaccount.trim().length() == 0) {
					jsonObject.put("error", "帳號: 請勿空白");
				}
				if (jsonObject.has("error")) {
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.print(jsonObject.toString());
					return;
				}
				MembersService memsSvc = new MembersService();
				MembersVO membersVO = memsSvc.getOneBymemaccount(memaccount);// 查詢資料庫是否對應
				if (membersVO == null || !(membersVO.getMemaccount().equals(memaccount))) {
					jsonObject.put("error", "沒有此帳號!");
				}
				if (jsonObject.has("error")) {
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.print(jsonObject.toString());
					return;
				}
				/*********************** 3.暫時驗證碼存取 *************************/
				String TempCaptcha = MembersServlet.getAuthCode();
				System.out.println("暫時驗證碼" + TempCaptcha);
				JedisUtil.getJedisPool();// 開池
				JedisUtil.RestPwdset(TempCaptcha, memaccount);// 放進Redis
//				System.out.println("1取得帳號=" + memaccount);// 取得產生的暫時密碼
//				System.out.println("2從redis取回帳號=" + JedisUtil.RestPwdget(TempCaptcha));// 從redis取回暫時密碼

				/*********************** 3.寄信 *************************/
				String memmail = membersVO.getMemmail();
				MailService mail = new MailService();
				String subject = "變更密碼通知信";
				String messageText = "Hello! Paradise bay會員 " + "\n" + "這是您的暫時密碼:" + TempCaptcha + "\n"
						+ "如無申請變更密碼請忽略此信" + "\n" + "請用此驗證連結" + "http://localhost:8081" + req.getContextPath()
						+ "/front-end/members/ForgetPass2.jsp" + "，並登錄驗證碼後再變更您的密碼! " + "\n" + "請點選此連結";
				mail.sendMail(memmail, subject, messageText,res);
//				System.out.println("寄信成功");
//				// 在成功處理後
//				jsonObject.put("success", "我們已成功寄送新的密碼到您的信箱");
//				res.setContentType("application/json;charset=UTF-8");
//				PrintWriter out = res.getWriter();
//				out.println(jsonObject.toString());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if ("restPassCaptcha".equals(action)) {
			// 取輸入暫時驗證碼
			String memcaptcha = req.getParameter("memcaptcha").trim();
			JedisUtil.getJedisPool();// 開池

			// 開池驗證
			String memaccount = JedisUtil.RestPwdget(memcaptcha);// 從輸入驗證碼取得帳號
			System.out.println("從Redis取回帳號" + memaccount);
			System.out.println(memcaptcha);
			if (memcaptcha == null || memcaptcha.trim().length() == 0) {// 驗證碼輸入不為空
				jsonObject.put("error", "驗證碼: 請勿空白");
			}
			if (jsonObject.has("error")) {
				res.setContentType("application/json;charset=UTF-8");
				PrintWriter out = res.getWriter();
				out.print(jsonObject.toString());
				return;
			}
			System.out.println(memaccount);
			if (memaccount == null) {
				jsonObject.put("error", "驗證碼：錯誤，請重新輸入");
			}

			if (jsonObject.has("error")) {
				res.setContentType("application/json;charset=UTF-8");
				PrintWriter out = res.getWriter();
				out.print(jsonObject.toString());
				return;
			}

			if (memaccount != null) {// 從redis透過驗證碼取到信箱
				jsonObject.put("success", "驗證成功");
				HttpSession session = req.getSession();
				session.setAttribute("memaccount", memaccount);// 將從redis取到的帳號set到session
				Object sessionMemaccount = session.getAttribute("memaccount");
				System.out.println("忘記密碼把從redis取道的帳號放在sesssion=" + sessionMemaccount);
				res.setContentType("application/json;charset=UTF-8");
				PrintWriter out = res.getWriter();
				out.println(jsonObject.toString());
			}
		}

		if ("restPass".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
			HttpSession session = req.getSession();
			String memaccount = (String) session.getAttribute("memaccount");
			String UnSlatmempass = req.getParameter("mempass").trim();
			if (UnSlatmempass == null || UnSlatmempass.trim().length() == 0) {// 驗證碼輸入不為空
				jsonObject.put("error", "密碼: 請勿空白");
			}
			if (jsonObject.has("error")) {
				res.setContentType("application/json;charset=UTF-8");
				PrintWriter out = res.getWriter();
				out.print(jsonObject.toString());
				return;
			}
		    String salt = BCrypt.gensalt();
		    String mempass = BCrypt.hashpw(UnSlatmempass, salt);	
		    System.out.println("忘記密碼加密後:"+mempass);
			/*************************** 2.開始查詢資料 ****************************************/
			MembersVO membersVO = new MembersVO();
			MembersService memsSvc = new MembersService();
			membersVO = memsSvc.updatePass(mempass, memaccount);
			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("MembersVO", membersVO);			
			jsonObject.put("success", "更新密碼成功");
			res.setContentType("application/json;charset=UTF-8");
			PrintWriter out = res.getWriter();
			out.println(jsonObject.toString());

		}
	}
}
