package com.paradisiac.roomcalendar.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
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
import com.paradisiac.roomcalendar.model.RoomCalendarVO;
import com.paradisiac.roomcalendar.model.CalAllDTO;
import com.paradisiac.roomcalendar.service.*;
@WebServlet("/calender.do")
public class RoomCalendarServlet  extends HttpServlet {
	// 一個 servlet 實體對應一個 service 實體
		private RoomCalendarService rcservice;
		private RoomCalendarServiceImpl roomCalendarService;
		@Override
		public void init() throws ServletException {
			rcservice = new RoomCalendarServiceImpl();
			roomCalendarService = new RoomCalendarServiceImpl();
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
				case "saveUpdate":
					forwardPath = addUpdate(req, res);
					break;
				case "Update":
					forwardPath = Update(req, res);
					break;
				default:
					forwardPath = "/index.jsp";
			}			
	
			RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
			dispatcher.forward(req, res);
		}
		//接收orderbuy.jsp的資料做saveupdate
				private String addUpdate(HttpServletRequest req, HttpServletResponse resp) {


					String roomTypeno = req.getParameter("roomTypeno");
					Date cDate = null;
					cDate = java.sql.Date.valueOf(req.getParameter("cDate").trim());
					String roomTotal = req.getParameter("roomTotal");
					String roomBooking = req.getParameter("roomBooking");

					Integer roomTypenoInt = null;
					Integer roomTotalInt = null;
					Integer roomBookingInt = null;
					
					boolean available = Boolean.parseBoolean(req.getParameter("available").trim());

					try {
						roomTypenoInt = Integer.parseInt(roomTypeno);
						roomTotalInt = Integer.parseInt(roomTotal);
						roomBookingInt = Integer.parseInt(roomBooking);

					  
					} catch (NumberFormatException e) {
					    
					}

					List<RoomCalendarVO> resultList1 = roomCalendarService.findByDate(cDate, roomTypenoInt);
					System.out.println(resultList1);
					if (resultList1.isEmpty()) {
					    System.out.println("未找到符合條件的 RoomCalendarVO 物件 進行新增");
					    int saved = roomCalendarService.addUpdate(roomTypenoInt, cDate, roomTotalInt, roomBookingInt, available);
					    var resave = roomCalendarService.findBycalNo(saved);
						if (saved > 0) {

					        System.out.println("新增成功");
					    } else {
					    	System.out.println(roomTypenoInt);
					    	System.out.println(cDate);
					    	System.out.println(roomTotalInt);
					    	System.out.println(roomBookingInt);
					    	System.out.println(available);
					        System.out.println("新增失敗");
					    }
						if (resave == null){
							System.out.println("No為空");
						}
						
					    List<RoomCalendarVO> resultList = roomCalendarService.findByDate(cDate, roomTypenoInt);
					    System.out.println(resultList);
						req.setAttribute("resultList", resultList);
					
					} 
					else {
					req.setAttribute("roomBooking", roomBookingInt);
					req.setAttribute("resultList", resultList1);
					}
					return "/back-end/roomorder/calcheck.jsp";

				}	
				
				//接收orderbuy.jsp的資料做saveupdate
				private String Update(HttpServletRequest req, HttpServletResponse resp) {

					String calendarNo = req.getParameter("calendarNo");
					
					Date cDate = null;
					cDate = java.sql.Date.valueOf(req.getParameter("cDate").trim());
					String roomTypeno = req.getParameter("roomTypeno");
					String roomTotal = req.getParameter("roomTotal");
					String roomBooking = req.getParameter("roomBooking");

					Integer calendarNoInt = null;
					Integer roomTypenoInt = null;
					Integer roomTotalInt = null;
					Integer roomBookingInt = null;
					
					boolean available = Boolean.parseBoolean(req.getParameter("available").trim());

					try {
						calendarNoInt = Integer.parseInt(calendarNo);
						roomTypenoInt = Integer.parseInt(roomTypeno);
						roomTotalInt = Integer.parseInt(roomTotal);
						roomBookingInt = Integer.parseInt(roomBooking);

					  
					} catch (NumberFormatException e) {
					    
					}

						 System.out.println("找到符合條件的 RoomCalendarVO 物件 進行修改	");

					      
					        
					        int sa2 = roomCalendarService.Update(calendarNoInt,roomTypenoInt, cDate, roomTotalInt, roomBookingInt, available);
					        if (sa2 > 0) {

						        System.out.println("修改成功");
						    } else {
						    	System.out.println(calendarNoInt);
						    	System.out.println(roomTypenoInt);
						    	System.out.println(cDate);
						    	System.out.println(roomTotalInt);
						    	System.out.println(roomBookingInt);
						    	System.out.println(available);
						        System.out.println("修改失敗");
						        System.out.println(sa2);
						    }
					        req.setAttribute("sa2", sa2);
					        resp.setContentType("application/json;charset=UTF-8");
					return "/back-end/roomorder/buysuccess.jsp";
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
