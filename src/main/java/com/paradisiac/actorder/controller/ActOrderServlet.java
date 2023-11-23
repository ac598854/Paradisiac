package com.paradisiac.actorder.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.persistence.metamodel.SetAttribute;
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
import com.paradisiac.act.service.ActServiceImpl;
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

	private ActOrderService actOrderServ;

	public void init() throws ServletException {
		actOrderServ = new ActOrderService();
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		JSONObject jsonObject = new JSONObject();
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		HttpSession session = req.getSession();
		String forwardPath = "";

		switch (action) {
		case "insert":
			insert(req, res);
			return;
		case "getOne_For_ActOrderNo":
			getOne_For_ActOrderNo(req, res);
			return;
		case "getAll":
			forwardPath = getAllListPage(req, res);
			break;
		default:
			break;
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
//			String schdNoStr=req.getParameter("schdNo");
			SchdVO schdVO = new SchdVO();
			schdVO.setSchdNo(1);

			Integer aAtnNum = Integer.valueOf(req.getParameter("aAtnNum"));// 人數
			Integer orderStatus = Integer.valueOf(1);
			Integer orderAmount = Integer.valueOf(req.getParameter("orderAmount"));
			Timestamp orderTime = new Timestamp(System.currentTimeMillis());
		    System.out.println("orderTime"+orderTime);

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
			Integer actOrderNo = actOrderServ.addActOrder(memNo, schdVO, null, orderTime, aAtnNum, orderStatus, orderAmount,
					null);// 抓訂單編號
			System.out.println(actOrderNo);
			ActOrder actOrder = actOrderServ.getOneByActOrderNo(actOrderNo);// 把訂單編號塞進物件(明細的Service編號是物件)
			for (ActAttendees actAttendees : list) {
				ActAttendeesService actAttendeesSer = new ActAttendeesService();
				actAttendeesSer.addActAttendees(actOrder, actAttendees.getAtnName(), actAttendees.getAtnIdNumber(),
						actAttendees.getAtnTel());
			}
//			======寄信	
			MembersService memsSvc = new MembersService();
			MembersVO membersVO = memsSvc.getOneBymemno(memNo);// 查詢資料庫是否對應
			String memmail = membersVO.getMemmail();
			String subject = "Paradise bay活動訂單成立通知";
			String messageText = "Hello! Paradise bay會員您好" + "\n" + "訂單編號：" + actOrderNo + "\n" + "訂單總金額：" + orderAmount
					+ "\n" + "感謝您的訂購Paradise bay活動，我們會盡速處理";
			MailService mail = new MailService();
			mail.sendMail(memmail, subject, messageText, res);
			res.sendRedirect(req.getContextPath() + "/front-end/index/index2.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("活動訂單例外錯誤");
		}
	}

	private void updateFront(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
//取消訂單=>訂單狀態:取消=>已繳費人數-(報名人數)
		Integer orderStatus = Integer.valueOf(req.getParameter("orderStatus"));
		Integer schdNO = Integer.valueOf(req.getParameter("schdNO"));
		Integer aAtnNum=Integer.valueOf(req.getParameter("aAtnNum"));

		if (orderStatus == 0) {//訂單取消
			ActOrderService actOrderServ = new ActOrderService();
			actOrderServ.modifyStatus(schdNO,orderStatus);
		//改變檔期人數
			
		
		} 
		

	}

	private void getOne_For_ActOrderNo(HttpServletRequest req, HttpServletResponse res)
			throws IOException, ServletException {
		res.setContentType("text/html;charset=UTF-8");

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
			System.out.println(actorder.getSchdVO().getSchdNo() + " /schdNo");
			System.out.println(actorder + " /actorder");
			req.setAttribute("actOrder", actorder);
			String url = "/back-end/actorder/ActCP.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneOrder_master.jsp
			successView.forward(req, res);
		} catch (Exception e) {
			String URL = req.getContextPath() + "/back-end/actorder/ActLPB.jsp?error=ExceptionError";
			res.sendRedirect(URL);
			System.out.println("無法取得資料");
			return;
		}

	}

//	分頁
	private String getAllListPage(HttpServletRequest req, HttpServletResponse res) {
		String page = req.getParameter("page");
		int currentPage = (page == null) ? 1 : Integer.parseInt(page);

		List<ActOrder> orderList = actOrderServ.getAllByStatusPage(currentPage);

		if (req.getSession().getAttribute("actPageQty") == null) {
			int actPageQty = actOrderServ.getPageActOrderTotal();
			req.getSession().setAttribute("actPageQty", actPageQty);
		}

		req.setAttribute("orderList", orderList);
		req.setAttribute("currentPage", currentPage);

		return "/back-end/actorder/ActLPB.jsp";
	}
//
//	private String getAllLP(HttpServletRequest req, HttpServletResponse res) {
//		List<ActOrder> orderList = actOrderServ.getAll();
//		req.setAttribute("orderList", orderList);
//		return "/back-end/actorder/ActLPB.jsp";
//	}

}
