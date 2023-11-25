package com.paradisiac.actorder.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.json.JSONObject;


import com.paradisiac.actattendees.model.ActAttendees;
import com.paradisiac.actattendees.service.ActAttendeesService;
import com.paradisiac.actorder.model.ActOrder;
import com.paradisiac.actorder.service.ActOrderService;
import com.paradisiac.members.model.MembersVO;
import com.paradisiac.members.service.MailService;
import com.paradisiac.members.service.MembersService;
import com.paradisiac.schd.model.SchdVO;
import com.paradisiac.schd.service.SchdServiceImpl;
import com.paradisiac.util.HibernateUtil;

public class ActOrderServlet extends HttpServlet {

	private ActOrderService actOrderServ;
	private SchdServiceImpl schdSvc;

	public void init() throws ServletException {
		actOrderServ = new ActOrderService();
		schdSvc = new SchdServiceImpl();
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		JSONObject jsonObject = new JSONObject();
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String forwardPath = "";
		System.out.println("現在action:" + action);

		switch (action) {
		case "insert":
			insert(req, res);
			return;
		case "getOne_For_ActOrderNo_Back":
			getOne_For_ActOrderNo_Back(req, res);
			return;
		case "getOne_For_ActOrderNo_Front":
			getOne_For_ActOrderNo_Front(req, res);
			return;
		case "updateStatus":
			updateFront(req, res);
			return;
		case "updateStatusBack":
			updateBack(req, res);
			return;
		default:
			forwardPath = "front-end/index/index2.jsp";
		}
		res.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
		dispatcher.forward(req, res);
	}

	private void insert(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
		try {

			HttpSession session = req.getSession();
			Integer memNo = (Integer) session.getAttribute("memno");
			SchdVO SchdVO = (SchdVO) session.getAttribute("schdVO");

			Integer schdNo = ((SchdVO) SchdVO).getSchdNo();
			Integer unitPrice = ((SchdVO) SchdVO).getUnitPrice();
			System.out.println("印出" + schdNo);

			Integer aAtnNum = Integer.valueOf(req.getParameter("aAtnNum"));// 人數
			Integer orderStatus = Integer.valueOf(1);
			Integer orderAmount = Integer.valueOf(req.getParameter("orderAmount"));
			Timestamp orderTime = new Timestamp(System.currentTimeMillis());
			System.out.println("orderTime" + orderTime);

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
			Integer actOrderNo = actOrderServ.addActOrder(memNo, SchdVO, null, orderTime, aAtnNum, orderStatus,
					orderAmount, null);// 抓訂單編號
			ActOrder actOrder = actOrderServ.getOneByActOrderNo(actOrderNo);// 把訂單編號塞進物件(明細的Service編號是物件)
			for (ActAttendees actAttendees : list) {
				ActAttendeesService actAttendeesSer = new ActAttendeesService();
				actAttendeesSer.addActAttendees(actOrder, actAttendees.getAtnName(), actAttendees.getAtnIdNumber(),
						actAttendees.getAtnTel());
			}

			/*************************** 3.增加報名人數 ***************************************/
			schdSvc.generateNewOrder(schdNo, aAtnNum);

			/*************************** 4.寄信 ***************************************/
			MembersService memsSvc = new MembersService();
			MembersVO membersVO = memsSvc.getOneBymemno(memNo);// 查詢資料庫是否對應
			String memmail = membersVO.getMemmail();
			String subject = "Paradise bay活動訂單成立通知";
			String messageText = "Hello! Paradise bay會員您好" + "\n" + "訂單編號：" + actOrderNo + "\n" + "訂單總金額：" + orderAmount
					+ "\n" + "感謝您的訂購Paradise bay活動，我們會盡速處理";
			MailService mail = new MailService();
			mail.sendMail(memmail, subject, messageText, res);
			/*************************** 5.交結果 ***************************************/
//			res.sendRedirect(req.getContextPath() + "/front-end/index/index2.jsp");

//			String url = "/front-end/index/index2.jsp";
//			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneOrder_master.jsp
//			successView.forward(req, res);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("活動訂單例外錯誤");
		}
	}

	private void updateFront(HttpServletRequest req, HttpServletResponse res) throws IOException {
		res.setContentType("text/html;charset=UTF-8");
		Integer orderStatus = Integer.valueOf(req.getParameter("orderStatus"));
		Integer schdNO = Integer.valueOf(req.getParameter("schdNo"));
		Integer aAtnNum = Integer.valueOf(req.getParameter("aAtnNum"));
		Integer actOrderNo = Integer.valueOf(req.getParameter("actOrderNo"));
		Integer memNo = (Integer) req.getSession(false).getAttribute("memno");
		/*************************** 3.減少報名人數 ***************************************/
		if (orderStatus == 0) {// 訂單取消
			schdSvc.cancelOrder(schdNO, aAtnNum);
		}
		/*************************** 4.存回訂單狀態 ***************************************/
		actOrderServ.updateOrderStatus(actOrderNo, orderStatus);
		/*************************** 4.寄信 ***************************************/
		MembersService memsSvc = new MembersService();
		MembersVO membersVO = memsSvc.getOneBymemno(memNo);// 查詢資料庫是否對應
		String memmail = membersVO.getMemmail();
		String subject = "Paradise bay活動訂單取消成功通知";
		String messageText = "Hello! Paradise bay會員您好" + "\n" + "訂單編號：" + actOrderNo + "\n"
				+ "訂單已成功取消，如需重新預定，請再前往官網重新下訂" + "\n" + "期待您再次參加Paradise bay活動";
		new MailService().sendMail(memmail, subject, messageText, res);
	}
	private void updateBack(HttpServletRequest req, HttpServletResponse res) throws IOException {
		res.setContentType("text/html;charset=UTF-8");
		Integer orderStatus = Integer.valueOf(req.getParameter("orderStatus"));
		Integer schdNO = Integer.valueOf(req.getParameter("schdNo"));
		Integer aAtnNum = Integer.valueOf(req.getParameter("aAtnNum"));
		Integer actOrderNo = Integer.valueOf(req.getParameter("actOrderNo"));
		Integer memNo = Integer.valueOf(req.getParameter("memNo"));
		/*************************** 3.減少報名人數 ***************************************/
		if (orderStatus == 0) {// 訂單取消
			schdSvc.cancelOrder(schdNO, aAtnNum);
		}
		/*************************** 4.存回訂單狀態 ***************************************/
		actOrderServ.updateOrderStatus(actOrderNo, orderStatus);
		/*************************** 4.寄信 ***************************************/
		MembersService memsSvc = new MembersService();
		MembersVO membersVO = memsSvc.getOneBymemno(memNo);// 查詢資料庫是否對應
		String memmail = membersVO.getMemmail();
		String subject = "Paradise bay活動訂單取消成功通知";
		String messageText = "Hello! Paradise bay會員您好" + "\n" + "訂單編號：" + actOrderNo + "\n"
				+ "訂單已成功取消，如需重新預定，請再前往官網重新下訂" + "\n" + "期待您再次參加Paradise bay活動";
		new MailService().sendMail(memmail, subject, messageText, res);
	}

	

	private void getOne_For_ActOrderNo_Back(HttpServletRequest req, HttpServletResponse res)
			throws IOException, ServletException {
		res.setContentType("text/html;charset=UTF-8");
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			String actOrderNoStr = req.getParameter("actOrderNo");

			if (actOrderNoStr == null || actOrderNoStr.trim().length() == 0) {
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
			// 從訂單主檔查詢關聯的明細資料
			Set<ActAttendees> actAttendesslist = actorder.getActAttendees();
			req.setAttribute("list", actAttendesslist);
//			System.out.println("後端抓檔期編號:"+actorder.getSchdVO().getSchdNo() + " /schdNo");
//			System.out.println("後端抓訂單:"+actorder);
			req.setAttribute("actOrder", actorder);
			String url = "/back-end/actorder/ActCPB.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneOrder_master.jsp
			successView.forward(req, res);
		} catch (Exception e) {
			String URL = req.getContextPath() + "/back-end/actorder/ActLPB.jsp?error=ExceptionError";
			res.sendRedirect(URL);
			return;
		}

	}

	private void getOne_For_ActOrderNo_Front(HttpServletRequest req, HttpServletResponse res)
			throws IOException, ServletException {
		res.setContentType("text/html;charset=UTF-8");
		try {
			String actOrderNoStr = req.getParameter("actOrderNo");

			if (actOrderNoStr == null || actOrderNoStr.trim().length() == 0) {
				String URL = req.getContextPath() + "/front-end/actorder/ActLPF.jsp?error=noActOrder";
				res.sendRedirect(URL);
				System.out.println("沒有輸入訂單編號");
				return;
			}
			Integer actOrderNo = null;
			try {
				actOrderNo = Integer.valueOf(actOrderNoStr);
			} catch (Exception e) {
				String URL = req.getContextPath() + "/front-end/actorder/ActLPF.jsp?error=ErrorFormat";
				res.sendRedirect(URL);
				System.out.println("訂單編號格式錯誤");
				return;
			}
			/*************************** 2.開始查詢資料 *****************************************/
			ActOrderService actOrderServ = new ActOrderService();// 抓訂單編號
			ActOrder actorder = actOrderServ.getOneByActOrderNo(actOrderNo);
			if (actorder == null) {
				String URL = req.getContextPath() + "/front-end/actorder/ActLPF.jsp?error=noData";
				res.sendRedirect(URL);
				System.out.println("無資料");
				return;
			}
			Set<ActAttendees> actAttendesslist = actorder.getActAttendees();
			req.setAttribute("list", actAttendesslist);
			req.setAttribute("actOrder", actorder);
			String url = "/front-end/actorder/ActCPF.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneOrder_master.jsp
			successView.forward(req, res);
		} catch (Exception e) {
			String URL = req.getContextPath() + "/front-end/actorder/ActLPF.jsp?error=ExceptionError";
			res.sendRedirect(URL);
			return;
		}

	}

}
