package com.paradisiac.roomcalendar.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.*;
import javax.servlet.http.*;
import com.paradisiac.roomcalendar.model.RoomCalendarDAO;
import com.paradisiac.roomcalendar.model.CalAllDTO;
import com.paradisiac.roomcalendar.service.*;
@WebServlet("/calender.do")
public class RoomCalendarServlet  extends HttpServlet {
	// 一個 servlet 實體對應一個 service 實體
		private RoomCalendarService rcservice;

		@Override
		public void init() throws ServletException {
			rcservice = new RoomCalendarServiceImpl();
		}

		@Override
		protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
			System.out.println("doPost:=======");
			req.setCharacterEncoding("UTF-8");
			res.setContentType("text/html; charset=UTF-8");
			String action = req.getParameter("action");
			String forwardPath = "";
			switch (action) {
				case "getAll":
					System.out.println("action:getAll=======");
					forwardPath = getAllCalenders(req, res);
					break;
				case "getSingle":
					forwardPath = getSingleCalenders(req, res);
					break;
				default:
					forwardPath = "/index.jsp";
			}			
	
			RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
			dispatcher.forward(req, res);
		}

		private String getAllCalenders(HttpServletRequest req, HttpServletResponse res) throws IOException {
			req.setCharacterEncoding("UTF-8");
			String jsonStr="";	
			System.out.println("controller:call service->getCalAllDTOs()");
		    jsonStr = rcservice.getCalAllDTOs();					
		    res.setContentType("text/html; charset=UTF-8");    //<---★★★★★★Servlet P58一下要在out之前否則會變成西歐語系★★★★★★
		    PrintWriter out = res.getWriter();  //將後端資料傳到前端的ajax
				out.print(jsonStr);         //一定要送出一個資料完成一次通訊
			//System.out.println(jsonStr);  //測試Json有沒有資料
		    //	out.close();	
			return "/front-end/roomcalendar/calAll.jsp";
		}		
		private String getSingleCalenders(HttpServletRequest req, HttpServletResponse res) throws IOException {
			req.setCharacterEncoding("UTF-8");
			String jsonStr="";
			int dropdownValue = Integer.parseInt(req.getParameter("dropdown"));
		    jsonStr = rcservice.getCalSingleDTOs(dropdownValue);			    
		    PrintWriter out = res.getWriter();  
		    req.setAttribute("jsonStr", jsonStr);
	//			out.print(jsonStr);        
		  
			res.setContentType("text/html; charset=UTF-8");
			return "/front-end/roomcalendar/calSingle.jsp";
			//return "/index.jsp";   //測試上一行才是才正確的
		}			
		
		@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
			doPost(req, res);
			System.out.println("doGet:=======");
		}
}
