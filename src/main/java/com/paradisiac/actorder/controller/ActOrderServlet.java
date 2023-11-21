package com.paradisiac.actorder.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.fasterxml.jackson.annotation.JacksonInject.Value;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.paradisiac.act.model.ActVO;
import com.paradisiac.actattendees.model.ActAttendees;
import com.paradisiac.actattendees.service.ActAttendeesService;
import com.paradisiac.actorder.model.ActOrder;
import com.paradisiac.actorder.service.ActOrderService;
import com.paradisiac.employee.model.EmpVO;
import com.paradisiac.members.model.MembersVO;
import com.paradisiac.members.service.MailService;
import com.paradisiac.members.service.MembersService;
import com.paradisiac.schd.model.SchdVO;

public class ActOrderServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		JSONObject jsonObject = new JSONObject();
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		HttpSession session = req.getSession();
		switch (action) {
		case "insert":
			insert(req, res);
			break;
		case "test":
			test(req, res);
			break;
		case "getOne_For_ActOrderNo":
			getOne_For_ActOrderNo(req, res);
			break;
		default:
			break;
		}

	}

	private void test(HttpServletRequest req, HttpServletResponse res) throws IOException {

		String aAtnNum = req.getParameter("aAtnNum");
		List<ActAttendees> list = new LinkedList<>();
		for (int i = 0; i < Integer.parseInt(aAtnNum); i++) {
			ActAttendees actAttendees = new ActAttendees();
			actAttendees.setAtnName(req.getParameter("atnName[" + i + "]"));
			actAttendees.setAtnIdNumber(req.getParameter("atnIdNumber[" + i + "]"));
			actAttendees.setAtnTel(req.getParameter("atnTel[" + i + "]"));

			list.add(actAttendees);
		}

		for (ActAttendees actAttendees : list) {
			System.out.println(actAttendees);
		}
		res.getWriter().write("ok");
	}

	private void insert(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
		try {
			HttpSession session = req.getSession();
			Integer memNo = (Integer) session.getAttribute("memno");
//			String schdNoStr=req.getParameter("schdNo");
			SchdVO schdVO = new SchdVO(11, null, null, null, null, null, null, null, null, null, null, null, null);// 假資料待刪

			Integer aAtnNum = Integer.valueOf(req.getParameter("aAtnNum"));// 人數
			Integer orderStatus = Integer.valueOf(1);
			Integer orderAmount = Integer.valueOf(req.getParameter("orderAmount"));

			// 新增參加者(明細)
			List<ActAttendees> list = new LinkedList<>();
			for (int i = 0; i < aAtnNum; i++) {
				ActAttendees actAttendees = new ActAttendees();
				String atnName = req.getParameter("atnName[" + i + "]");
				actAttendees.setAtnName(atnName);
				String atnIdNumber = req.getParameter("atnIdNumber[" + i + "]");
				actAttendees.setAtnIdNumber(atnIdNumber);
				String atnTel = req.getParameter("atnTel[" + i + "]");
				actAttendees.setAtnTel(atnTel);
				list.add(actAttendees);
			}
			/*************************** 2.開始新增訂單 ***************************************/
			ActOrderService actOrderServ = new ActOrderService();
			Integer actOrderNo = actOrderServ.addActOrder(memNo, schdVO, null, null, aAtnNum, orderStatus, orderAmount,
					null);// 抓訂單編號

			ActOrder actOrder = actOrderServ.getOneByActOrderNo(actOrderNo);// 把訂單編號塞進物件(明細的Service編號是物件)
			for (ActAttendees actAttendees : list) {
				ActAttendeesService actAttendeesSer = new ActAttendeesService();
				actAttendeesSer.addActAttendees(actOrder, actAttendees.getAtnName(), actAttendees.getAtnIdNumber(),
						actAttendees.getAtnTel());
			}
//			======寄信	
			MembersService memsSvc = new MembersService();
			MembersVO membersVO = memsSvc.getOneBymemno(memNo);// 查詢資料庫是否對應	
			String memmail=membersVO.getMemmail();
			String subject = "Paradise bay活動訂單成立通知";
			String messageText = "Hello! Paradise bay會員您好" + "\n" +"訂單編號："+actOrderNo+"\n"+"訂單總金額："+orderAmount+ "\n" +"感謝您的訂購Paradise bay活動，我們會盡速處理" ;
			MailService mail = new MailService();
			mail.sendMail(memmail, subject, messageText, res);
			res.sendRedirect(req.getContextPath() + "/front-end/index/index2.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void getOne_For_ActOrderNo(HttpServletRequest req, HttpServletResponse res)
			throws IOException, ServletException {
		try {
			String actOrderNoStr = req.getParameter("actOrderNo");

			if (actOrderNoStr == null || (actOrderNoStr.trim()).length() == 0) {
				String URL = req.getContextPath() + "/back-end/actorder/ActLPB.jsp?error=noActOrder";
				res.sendRedirect(URL);
				System.out.println("沒有輸入訂單編號");
				return;
			}
			Integer actOrderNo = null;
			try {
				actOrderNo = Integer.valueOf(actOrderNoStr);
			} catch (Exception e) {
				String URL = req.getContextPath() + "/back-end/actorder/ActLPB.jsp?error=ErrorFormat";
				res.sendRedirect(URL);
				System.out.println("訂單編號格式錯誤");
				return;
			}
			/*************************** 2.開始查詢資料 *****************************************/
			ActOrderService actOrderServ = new ActOrderService();// 抓訂單編號
			ActOrder actorder = actOrderServ.getOneByActOrderNo(actOrderNo);
			if (actorder == null) {
				String URL = req.getContextPath() + "/back-end/actorder/ActLPB.jsp?error=noData";
				res.sendRedirect(URL);
				System.out.println("無資料");
				return;
			}
			req.setAttribute("Actorder", actorder);
			String url = "/back-end/actorder/ActLPB.jsp.";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneOrder_master.jsp
			successView.forward(req, res);
		} catch (Exception e) {
			String URL = req.getContextPath() + "/back-end/actorder/ActLPB.jsp?error=ExceptionError";
			res.sendRedirect(URL);
			System.out.println("無法取得資料");
			return;
		}
	}

}
