package com.paradisiac.act.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.paradisiac.act.model.ActVO;
import com.paradisiac.act.service.ActService;
import com.paradisiac.act.service.ActServiceImpl;
import com.paradisiac.department.model.DeptVO;

@WebServlet("/act.do")
public class ActServlet extends HttpServlet{
	
	private ActService actSvc;
	
	public void init() throws ServletException{
		actSvc = new ActServiceImpl();
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String forwardPath = "";
		
		switch (action) {
		case "getAll":
			forwardPath = getAllActs(req, res);
			break;
//		case "getOne_For_Display":
//			forwardPath = getOne_For_Display(req, res);
//			break;
//		case "insert":
//			forwardPath = insert(req, res);
//			break;
//		case "update":
//			forwardPath = update(req, res);
//			break;
//		default:
//			forwardPath = "/back-end/dept/listOneDept.jsp";
	}	
	res.setContentType("text/html; charset=UTF-8");
	RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
	dispatcher.forward(req, res);
		
		
	}//doPost
	
	private String getAllActs(HttpServletRequest req, HttpServletResponse res) {
		String page = req.getParameter("page"); 
		int currentPage = (page == null) ? 1 : Integer.parseInt(page); 
		
		List<ActVO> actList = actSvc.getAllActs(currentPage);

		if (req.getSession().getAttribute("actPageQty") == null) {
			int actPageQty = actSvc.getPageTotal();
			req.getSession().setAttribute("actPageQty", actPageQty);
		}
		
		req.setAttribute("actList", actList);
		req.setAttribute("currentPage", currentPage);

		return "/back-end/act/select_act.jsp";
	}
	
	

}//class
