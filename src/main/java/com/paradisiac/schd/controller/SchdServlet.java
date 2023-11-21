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

import com.paradisiac.act.model.ActVO;
import com.paradisiac.act.service.ActServiceImpl;
import com.paradisiac.schd.model.SchdVO;
import com.paradisiac.schd.service.SchdServiceImpl;


@WebServlet("/schd.do")
public class SchdServlet extends HttpServlet {
	
	private SchdServiceImpl schdSvc;
	private ActServiceImpl actSvc;
	
	public void init() throws ServletException{
		schdSvc = new SchdServiceImpl();
		actSvc = new ActServiceImpl();
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
//		case "getOne_For_Display":
//			getOneForDisplay(req, res);
//			forwardPath = "/back-end/act/list_one_act.jsp";
//			break;
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
		default:
			forwardPath = "/back-end/schd/add_schd.jsp";
	}
		res.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
		dispatcher.forward(req, res);
		
	}//doPost
	
	//新增或修改
	public String insertOrUpdate(HttpServletRequest req, HttpServletResponse res) throws ParseException {
		List<String> errorMsgs = new LinkedList<String>();
		Integer schdNo = null;
		//修改
		if(req.getParameter("schdNo") != null && req.getParameter("schdNo").length() != 0) {
			schdNo = Integer.valueOf(req.getParameter("schdNo"));	
		}	
		Integer actNo = Integer.valueOf(req.getParameter("actNo"));
		Integer unitPrice = Integer.valueOf(req.getParameter("unitPrice"));
		Integer lowNum = Integer.valueOf(req.getParameter("lowNum"));
		Integer highNum= Integer.valueOf(req.getParameter("highNum"));
//		Integer unpaidNum = Integer.valueOf(req.getParameter("unpaidNum"));
//		Integer paidNum = Integer.valueOf(req.getParameter("paidNum"));
		
		Timestamp ancDate = convertTmp(req.getParameter("ancDate"));  
		Timestamp drpoSchdDate = convertTmp(req.getParameter("drpoSchdDate"));
		Timestamp holdDate = convertTmp(req.getParameter("holdDate"));
		Timestamp aplyTime = convertTmp(req.getParameter("aplyTime"));
		Timestamp cutTime = convertTmp(req.getParameter("cutTime"));
		Integer applStatus = Integer.valueOf(req.getParameter("applStatus"));
		
		ActVO act = actSvc.getActByActno(actNo);
		SchdVO schdVO = new SchdVO(act, unitPrice, lowNum, highNum, holdDate, aplyTime, cutTime, applStatus);
		
		//錯誤處理
		if(lowNum > highNum) {
			errorMsgs.add("成團人數須小於上限人數");
		}
		
		//開始打包 (建構子沒有上下架日期跟付款人/未付款人,如果有要裝進去)
		if(req.getParameter("ancDate") != null) {
			schdVO.setAncDate(ancDate);
		}
		
		if(req.getParameter("drpoSchdDate") != null) {
			schdVO.setDrpoSchdDate(drpoSchdDate);
		}
		
		if(req.getParameter("schdNo") != null && req.getParameter("schdNo").length() != 0) {
			schdVO.setSchdNo(schdNo);
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
		//開始新增或修改
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
		return schdVO;
	}
	
	
	
	//轉換日期的方法
	public static Timestamp convertTmp(String inputDate) throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm"); //格式
		Date dateUtil = (Date) sdf.parse(inputDate); //input 是 util.Date (bootstrap)	
		java.sql.Date dateSQL = new java.sql.Date(dateUtil.getTime());//轉成SQL 
		return new Timestamp(dateSQL.getTime());
	}
	
	



}//class
