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
import com.paradisiac.roomorder.service.RoomOrderService;
import com.paradisiac.roomorder.service.RoomOrderServiceImpl;

@WebServlet("/emp/emp.do")
public class RoomOrderServlet extends HttpServlet{
	
	private RoomOrderService roomorderService;
	
	@Override
	public void init() throws ServletException {
		roomorderService = new RoomOrderServiceImpl();
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


		default:
			forwardPath = "/index2.jsp";
		}

		resp.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
		dispatcher.forward(req, resp);

	}
	
	private String getAll(HttpServletRequest req, HttpServletResponse resp) {

		List<roomOrderVO> all = roomorderService.getAllOrd();
		req.setAttribute("all", all);

		return "/back-end/roomorderselect/getAll.jsp";
	}
	
}