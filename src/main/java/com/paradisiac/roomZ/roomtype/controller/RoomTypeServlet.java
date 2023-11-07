	package com.paradisiac.roomZ.roomtype.controller;
	
	
	import java.io.IOException;
	import java.sql.Connection;
	import java.sql.PreparedStatement;
	import java.sql.SQLException;
	import java.util.List;
	import java.util.Map;
	
	import javax.servlet.RequestDispatcher;
	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.HttpServlet;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;
	import javax.sql.DataSource;
	
	import org.hibernate.Session;
	import org.hibernate.SessionFactory;
	
	import com.paradisiac.roomZ.roomtype.entity.RoomTypeVO;
	import com.paradisiac.roomZ.roomtype.service.RoomTypeService;
	import com.paradisiac.roomZ.roomtype.service.RoomTypeServiceImpl;
	import com.paradisiac.util.HibernateUtil;
	
	@WebServlet("/type/type.do")
	public class RoomTypeServlet extends HttpServlet{
		
		private RoomTypeServiceImpl roomtypeService;
		
		@Override
		public void init() throws ServletException {
			roomtypeService = new RoomTypeServiceImpl();
		}
	
		@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
			doPost(req, res);
		}
		
		@Override
		public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			req.setCharacterEncoding("UTF-8");
			String action = req.getParameter("action");
			String forwardPath = "";
			
			switch (action) {
	
			case "getAll":
				forwardPath = getAll(req, resp);
				break;
			case "addtype":
				forwardPath = addtype(req, resp);
				break;

			case "updatetype":
				forwardPath = updatetype(req, resp);
				break;

	
				
			default:
				forwardPath = "/index2.jsp";
			}
	
			resp.setContentType("text/html; charset=UTF-8");
			RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
			dispatcher.forward(req, resp);
	
		}
		
		private String getAll(HttpServletRequest req, HttpServletResponse resp) {
	
			List<RoomTypeVO> all = roomtypeService.getAllOrd();
			req.setAttribute("all", all);
	
			return "/back-end/roomtype/getAll.jsp";
		}
		
		private String addtype(HttpServletRequest req, HttpServletResponse resp) {

			String roomName = req.getParameter("roomName");
			String rtype = req.getParameter("rtype");
			String roomTotal = req.getParameter("roomTotal");
			String price = req.getParameter("price");
			String normalPrice = req.getParameter("normalPrice");
			String holidayPrice = req.getParameter("holidayPrice");
			String bridgeHolidayPrice = req.getParameter("bridgeHolidayPrice");
			String notice = req.getParameter("notice");
			String facility = req.getParameter("facility");
			String rTypeStatus = req.getParameter("rTypeStatus");

			// 将字符串参数解析为整数
			Integer roomTotalInt = null;
			Integer priceInt = null;
			Integer normalPriceInt = null;
			Integer holidayPriceInt = null;
			Integer bridgeHolidayPriceInt = null;
			boolean rTypeStatusBool = Boolean.parseBoolean(rTypeStatus);


			try {
				roomTotalInt = Integer.parseInt(roomTotal);
			    priceInt = Integer.parseInt(price);
			    normalPriceInt = Integer.parseInt(normalPrice);
			    holidayPriceInt = Integer.parseInt(holidayPrice);
			    bridgeHolidayPriceInt = Integer.parseInt(bridgeHolidayPrice);
			} catch (NumberFormatException e) {
			    
			}

			// 如果有確定進入資料庫會有流水編號，再去找流水編號的值，顯示在jsp
			int saved = roomtypeService.addFaq(roomName, rtype, roomTotalInt, priceInt, normalPriceInt, holidayPriceInt, bridgeHolidayPriceInt, notice, facility, rTypeStatusBool);
			var result = roomtypeService.findByFaqNo(saved);

			if (saved > 0) {
//			    return 1; // 添加成功
		        System.out.println("新增成功");
		    } else {
//		        return -1; // 添加失败
		        System.out.println("新增失敗");
		    }
			
			req.setAttribute("result", result);
			
			return "/back-end/roomtype/typefirst.jsp";
		}	

		private String updatetype(HttpServletRequest req, HttpServletResponse resp) {

			String roomTypeNo = req.getParameter("roomTypeNo");
			String roomName = req.getParameter("roomName");
			String rtype = req.getParameter("rtype");
			String roomTotal = req.getParameter("roomTotal");
			String price = req.getParameter("price");
			String normalPrice = req.getParameter("normalPrice");
			String holidayPrice = req.getParameter("holidayPrice");
			String bridgeHolidayPrice = req.getParameter("bridgeHolidayPrice");
			String notice = req.getParameter("notice");
			String facility = req.getParameter("facility");
			String rTypeStatus = req.getParameter("rTypeStatus");

			// 将字符串参数解析为整数
			Integer roomTypeNoInt = null;
			Integer roomTotalInt = null;
			Integer priceInt = null;
			Integer normalPriceInt = null;
			Integer holidayPriceInt = null;
			Integer bridgeHolidayPriceInt = null;
			boolean rTypeStatusBool = Boolean.parseBoolean(rTypeStatus);


			try {
				roomTypeNoInt = Integer.parseInt(roomTypeNo);
				roomTotalInt = Integer.parseInt(roomTotal);
			    priceInt = Integer.parseInt(price);
			    normalPriceInt = Integer.parseInt(normalPrice);
			    holidayPriceInt = Integer.parseInt(holidayPrice);
			    bridgeHolidayPriceInt = Integer.parseInt(bridgeHolidayPrice);
			} catch (NumberFormatException e) {
			    System.out.println("ERROR");
			}

			int result = roomtypeService.updateFaq(roomTypeNoInt,roomName, rtype, roomTotalInt, priceInt, normalPriceInt, holidayPriceInt, bridgeHolidayPriceInt, notice, facility, rTypeStatusBool);		
			

			if (result > 0) {
				System.out.println("更新成功");
			} else {
				System.out.println("更新失敗");
				System.out.println(result);
			}
			
			resp.setContentType("application/json;charset=UTF-8");
			return "/back-end/roomtype/typefirst.jsp";
		}

	
		
	}