package com.paradisiac.schd.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import com.paradisiac.act.model.ActVO;
import com.paradisiac.act.service.ActServiceImpl;
import com.paradisiac.actorder.model.ActOrder;
import com.paradisiac.actorder.service.ActOrderService;
import com.paradisiac.schd.model.SchdVO;
import com.paradisiac.schd.service.SchdServiceImpl;


@WebServlet("/schd.do")
public class SchdServlet extends HttpServlet {
	
	private SchdServiceImpl schdSvc; 
	private ActServiceImpl actSvc;
	private ActOrderService actorderSvc;
	
	public void init() throws ServletException{
		schdSvc = new SchdServiceImpl();
		actSvc = new ActServiceImpl();
		actorderSvc = new ActOrderService();
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String forwardPath = "";
		
		switch (action) {
//		case "getAll":
//			forwardPath = getAllActs(req, res);
//			break;
		case "insert":		
			try {
				forwardPath = insertOrUpdate(req, res);
			} catch (ParseException e) {
				e.printStackTrace();
			}			
			break;
		case "getOne_For_Display": //前端-報名檔期
			getOneForDisplay(req, res);
			res.sendRedirect(req.getContextPath() + "/front-end/actorder/ActCheckOut.jsp");
			break;
//		case "getOneSchdAllOrders":
//			getOneForDisplay(req, res);
//			forwardPath = "/back-end/act/list_act_schd.jsp";
//			break;
		case "getOne_For_Update":
			getOneForDisplay(req, res);
			forwardPath = "/back-end/schd/update_schd.jsp";
			break;
		case "update":
			try {
				forwardPath = insertOrUpdate(req, res);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			break;
		//測試新增與取消訂單, 修改檔期報名人數
		case "add_atn":
			addatn(req, res);
			forwardPath = "/back-end/schd/update_schd.jsp";
			break;
		case "reduce_atn":
			reduceatn(req, res);
			forwardPath = "/back-end/schd/update_schd.jsp";
			break;
		default:
			forwardPath = "/front-end/act_schd/Test_order_schd.jsp";
	}
		res.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
		dispatcher.forward(req, res);
		
	}//doPost
	
	//新增或修改
	public String insertOrUpdate(HttpServletRequest req, HttpServletResponse res) throws ParseException {
		List<String> errorMsgs = new LinkedList<String>();
		Integer schdNo = null;		
		Integer actNo = Integer.valueOf(req.getParameter("actNo"));
		Integer unitPrice = Integer.valueOf(req.getParameter("unitPrice"));		
		Timestamp ancDate = convertTmp(req.getParameter("ancDate"));  
		Timestamp drpoSchdDate = convertTmp(req.getParameter("drpoSchdDate"));
		Timestamp holdDate = convertTmp(req.getParameter("holdDate"));
		Timestamp aplyTime = convertTmp(req.getParameter("aplyTime"));
		Timestamp cutTime = convertTmp(req.getParameter("cutTime"));
		Integer applStatus = Integer.valueOf(req.getParameter("applStatus"));//1:報名中 2:成團 3:未成團 4:因故取消
		SchdVO schdVO = null;
		
		//修改呼叫物件(活動編號 檔期編號不可更新), 新增new物件
		if(req.getParameter("schdNo") != null && req.getParameter("schdNo").length() != 0) {
			schdNo = Integer.valueOf(req.getParameter("schdNo"));
			schdVO = schdSvc.getSchdBySchdno(schdNo);
			schdVO.setUnitPrice(unitPrice);
			schdVO.setAncDate(ancDate);
			schdVO.setDrpoSchdDate(drpoSchdDate);
			schdVO.setHoldDate(holdDate);		
			schdVO.setCuttime(cutTime);
			schdVO.setAplytime(aplyTime);
			schdVO.setApplStatus(applStatus);;
			
		}else {
			ActVO act = actSvc.getActByActno(actNo);
			schdVO = new SchdVO(act, unitPrice, holdDate, aplyTime, cutTime, applStatus);			
		}	
		
		//錯誤處理
//		if(lowNum > highNum) {
//			errorMsgs.add("成團人數須小於上限人數");
//		}
		
		//開始打包 (建構子沒有上下架日期跟付款人/未付款人,如果有要裝進去)
		if(req.getParameter("ancDate") != null) {
			schdVO.setAncDate(ancDate);
		}
		
		if(req.getParameter("drpoSchdDate") != null) {
			schdVO.setDrpoSchdDate(drpoSchdDate);
		}

		
		//如果有錯誤處理輸出
		if (!errorMsgs.isEmpty()) {
			req.setAttribute("errorMsgs", errorMsgs); // 含有輸入格式錯誤的物件,也存入req
			req.setAttribute("schdVO", schdVO);
			if(req.getParameter("schdNo") != null && req.getParameter("schdNo").length() != 0) {
				return "/back-end/schd/update_schd.jsp"; //導回修改檔期
			}else {
				return "/back-end/schd/add_schd.jsp"; //導回新增檔期
			}
			
		}
		//如果檔期狀態改成3-取消 (新增訂單狀態固定為1-報名中)
		//set訂單狀態取消 1 -> 0
		if(applStatus == 3) {
			actorderSvc.modifyStatus(schdNo, 0);
			
		}
		
		//開始新增或修改檔期物件
		schdSvc.addOrUpdateSchd(schdVO);
		req.setAttribute("schdVO", schdVO);
		
		Set<SchdVO> actSchdSet = actSvc.getSchdByActno(actNo);
		req.setAttribute("actSchdSet", actSchdSet);		
		ActVO actVO = actSvc.getActByActno(actNo);
		
		req.setAttribute("actVO", actVO);
		return "/back-end/act/list_act_schd.jsp";
	

	}
	//查單筆
	public SchdVO getOneForDisplay(HttpServletRequest req, HttpServletResponse res) {
		Integer schdNo = Integer.valueOf(req.getParameter("schdNo"));
		SchdVO schdVO = schdSvc.getSchdBySchdno(schdNo);
		req.setAttribute("schdVO", schdVO);
		//--供前端活動訂單取用session
		HttpSession session = req.getSession();
		session.setAttribute("schdVO", schdVO);
System.out.println("存入sesion檔期"+schdVO.getSchdNo());	
		return schdVO;
	}
	
	
	
	//轉換日期的方法
	public static Timestamp convertTmp(String inputDate) throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm"); //格式
		Date dateUtil = (Date) sdf.parse(inputDate); //input 是 util.Date (bootstrap)	
		java.sql.Date dateSQL = new java.sql.Date(dateUtil.getTime());//轉成SQL 
		return new Timestamp(dateSQL.getTime());
	}
	//測試新增訂單增加檔期付款人數
	public void addatn(HttpServletRequest req, HttpServletResponse res) {
		Integer schdno = Integer.valueOf(req.getParameter("schdNo"));
		Integer num = Integer.valueOf(req.getParameter("num"));
		try {
			System.out.println("本來"+schdSvc.getSchdBySchdno(schdno).getPaidNum());
			//把訂單參加人加到檔期報名人數
			schdSvc.generateNewOrder(schdno, num);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//測試取消訂單減少檔期付款人數
	public void reduceatn(HttpServletRequest req, HttpServletResponse res) {
		Integer schdno = Integer.valueOf(req.getParameter("schdNo"));
		Integer num = Integer.valueOf(req.getParameter("num"));
		try {
			System.out.println("本來"+schdSvc.getSchdBySchdno(schdno).getPaidNum());
			//把訂單參加人扣掉檔期報名人數
			schdSvc.cancelOrder(schdno, num);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	



}//class
