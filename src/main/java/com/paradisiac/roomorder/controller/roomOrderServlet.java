package com.paradisiac.roomorder.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.paradisiac.roomorder.entity.roomOrderVO;
import com.paradisiac.roomorder.service.roomOrderService;
import com.paradisiac.roomorder.service.roomOrderServiceImpl;


public class roomOrderServlet extends HttpServlet{
	private roomOrderService roomorderService;
	
	@Override
	public void init() throws ServletException {
		roomorderService = new roomOrderServiceImpl();
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String forwardPath = "";
		switch (action) {
			case "getAll":
				forwardPath = getAllOrd(req, res);
				break;
			case "compositeQuery":
				forwardPath = getCompositeOrdQuery(req, res);
				break;
			default:
				forwardPath = "/index2.jsp";
		}
		
		res.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
		dispatcher.forward(req, res);
	}

	private String getAllOrd(HttpServletRequest req, HttpServletResponse res) {
		String page = req.getParameter("page");
		int currentPage = (page == null) ? 1 : Integer.parseInt(page);
		
		List<roomOrderVO> ordList = roomorderService.getAllOrds(currentPage);

		if (req.getSession().getAttribute("ordPageQty") == null) {
			int ordPageQty = roomorderService.getPageTotal();
			req.getSession().setAttribute("ordPageQty", ordPageQty);
		}
		
		req.setAttribute("ordList", ordList);
		req.setAttribute("currentPage", currentPage);
		
		return "/listallroomord.jsp";
	}
	
	private String getCompositeOrdQuery(HttpServletRequest req, HttpServletResponse res) {
		Map<String, String[]> map = req.getParameterMap();
		if (map != null) {
			List<roomOrderVO> ordList = roomorderService.getOrdsByCompositeQuery(map);
			req.setAttribute("ordList", ordList);
		} else {
			return "/index2.jsp";
		}
		return "/quroomorder.jsp";
	}
	
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}
	
	
}