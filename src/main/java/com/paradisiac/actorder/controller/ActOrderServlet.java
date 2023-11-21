package com.paradisiac.actorder.controller;

import java.io.IOException;
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

import com.fasterxml.jackson.annotation.JacksonInject.Value;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.paradisiac.actattendees.model.ActAttendees;
import com.paradisiac.actattendees.service.ActAttendeesService;
import com.paradisiac.actorder.model.ActOrder;
import com.paradisiac.actorder.service.ActOrderService;
import com.paradisiac.schd.model.SchdVO;



public class ActOrderServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req,HttpServletResponse res) 
			throws ServletException, IOException{
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		HttpSession session = req.getSession();
			
		switch(action) {
			case "insert":
				addOrder(req ,res);
				break;
			case "test":
				test(req,res);
				break;
			default:
				break;
		}
		
	}

	private void test(HttpServletRequest req, HttpServletResponse res) throws IOException {
		// TODO Auto-generated method stub
		
		String aatnnum = req.getParameter("aatnnum");
		
		
		List<ActAttendees> list = new LinkedList<>();
		for(int i = 0 ; i < Integer.parseInt(aatnnum) ; i++) {
			ActAttendees actAttendees = new ActAttendees();
			actAttendees.setAtnName(req.getParameter("memName["+i+"]")); 
			actAttendees.setAtnIdNumber(req.getParameter("snn["+i+"]")); 
			actAttendees.setAtnTel(req.getParameter("tel["+i+"]"));
			
			list.add(actAttendees);
		}		
		
		for(ActAttendees actAttendees : list) {
			System.out.println(actAttendees);
		}
		res.getWriter().write("ok");
	}

	private void addOrder(HttpServletRequest req, HttpServletResponse res) {
		// TODO Auto-generated method stub
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
			try {				
//				Integer memNo = (Integer) session.getAttribute("memno");
				Object schdVOStr=req.getParameter("schdVO");				
				SchdVO schdVO= (SchdVO) schdVOStr;
				Object empVO=null;
				Integer aAtnNum=Integer.valueOf(req.getParameter("aAtnNum"));//人數
				Integer unitPrice=Integer.valueOf(req.getParameter("unitPrice"));
				Integer orderStatus=Integer.valueOf(1);
				Integer orderAmount=unitPrice*aAtnNum;
			
				String actAttendeesJson = req.getParameter("actAttendees");
//				Set<ActAttendees> actAttendees = 
				new ActAttendeesService().getAll();
				    
				
				if (!errorMsgs.isEmpty()) {
					// 錯誤停留在註冊頁
					System.out.println("錯誤停留在購物頁");
					String url = "/front-end/actorder/ActCheckOut.jsp";
					RequestDispatcher errorView = req.getRequestDispatcher(url);
					errorView.forward(req, res);
					/***************************2.開始新增資料***************************************/
				} else {
					ActOrderService actOrderSer=new ActOrderService();
//					int actOrder=actOrderSer.addActOrder(memNo, schdVO, null, null, aAtnNum, orderStatus, orderAmount, actAttendees);
					/***************************3.新增完成,準備轉交(Send the Success view)***********/
					String url = "/front-end/actorder/TestAct.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllOrder_master.jsp
					successView.forward(req, res);							
				}
				
			}catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/order_master/addOrder_master.jsp");
//				failureView.forward(req, res);
			}finally {

			}
	}
}
