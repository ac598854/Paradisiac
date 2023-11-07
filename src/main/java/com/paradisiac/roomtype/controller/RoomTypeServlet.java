package com.paradisiac.roomtype.controller;

import java.io.IOException;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.paradisiac.roomtype.model.RoomTypeVO;
import com.paradisiac.roomtype.service.RoomTypeService;
import com.paradisiac.roomtype.service.RoomTypeServiceImpl;

@WebServlet("/RoomType.do")

	public class RoomTypeServlet extends HttpServlet {
		// 一個 servlet 實體對應一個 service 實體
		private RoomTypeService roomtypeService;

		@Override
		public void init() throws ServletException {
			roomtypeService = new RoomTypeServiceImpl();			
		}

		@Override
		protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
			req.setCharacterEncoding("UTF-8");
			String action = req.getParameter("action");
			String forwardPath = "";
			switch (action) {
				case "getAll":
					forwardPath = getAllRoomTypes(req, res);
					break;
				case "compositeQuery":
					forwardPath = getCompositeRoomTypesQuery(req, res);
					break;
				default:
					forwardPath = "/index.jsp";
			}
			
			res.setContentType("text/html; charset=UTF-8");
			RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
			dispatcher.forward(req, res);
		}

		private String getAllRoomTypes(HttpServletRequest req, HttpServletResponse res) throws  IOException {
			req.setCharacterEncoding("UTF-8");
			
			String page = req.getParameter("page");
			
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);
			
			System.out.print("Servlet: call --> getAllRoomTypesVOs()");
			
			List<RoomTypeVO> roomtypeList = roomtypeService.getAllRoomTypeVOs(currentPage);
			
			res.setContentType("text/html; charset=UTF-8");
			
			//roomtypeService.getAllRoomTypeVOs(currentPage);
			
			if (req.getSession().getAttribute("roomtypePageQty") == null) {
				
				int roomtypePageQty = roomtypeService.getPageTotal();
				
				req.getSession().setAttribute("roomtypePageQty", roomtypePageQty);
				
			}
			
			req.setAttribute("roomtypeList", roomtypeList);
			req.setAttribute("currentPage", currentPage);
			
			return "/front-end/roomtype/listAllRoomTypes.jsp";
		}		
		
		private String getCompositeRoomTypesQuery(HttpServletRequest req, HttpServletResponse res) throws IOException {
			req.setCharacterEncoding("UTF-8");
			Map<String, String[]> map = req.getParameterMap();
			
			if (map != null) {
				List<RoomTypeVO> roomtypeList = roomtypeService.getRoomTypeVOsByCompositeQuery(map);
				System.out.print(roomtypeList);
				res.setContentType("text/html; charset=UTF-8");
				req.setAttribute("roomtypeList", roomtypeList);
			} else {
				return "/index.jsp";
			}
			return "/front-end/roomtype/listCompositeQueryRoomTypes.jsp";
		}		
		
		@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
			doPost(req, res);
		}
	}

