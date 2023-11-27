package com.paradisiac.employee.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.paradisiac.department.model.DeptVO;
import com.paradisiac.employee.service.EmpService;


@WebServlet("/loginempN.do")
public class LoginEmp extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String forwardPath="";
		EmpService empSvc = new EmpService();
		
		if("loginEmp".equals(action)) {
			System.out.println("檢查員工帳號");
			//接收參數與錯誤訊息印出
			List<String> errorMsgs = new LinkedList<String>();			
			req.setAttribute("errorMsgs", errorMsgs);
			
			String empnoStr = req.getParameter("empno");	
			String empPass = req.getParameter("empPass");
			Integer empno = null;
			
			if (empnoStr != null && (empnoStr.trim()).length() == 0) { //先判斷字串是否為空
				errorMsgs.add("員工編號請勿空白");
			}else {				
				try {
					empno = Integer.valueOf(empnoStr); //把字串轉成Integer
				} catch (Exception e) {
					errorMsgs.add("員工編號格式不正確");
				}				
			}
			
			if(empPass == null || (empPass.trim()).length() == 0) {
				errorMsgs.add("密碼請勿空白");
			}
			
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/index/loginEmp.jsp");//有錯跳回查詢頁面
				failureView.forward(req, res);
				return;// 程式中斷
			}

			//驗證帳號密碼是否正確
			LoginEmp loginemp = new LoginEmp();
			int result = loginemp.loginTest(empno, empPass);
			switch(result) {
				case -1: 
					errorMsgs.add("查無此員工編號");
					break;
				case -2:
					errorMsgs.add("該員工已凍結");
					break;
				case -3:
					errorMsgs.add("密碼有誤");
					break;					
			}
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/index/loginEmp.jsp");//有錯跳回查詢頁面
				failureView.forward(req, res);
				return;// 程式中斷
			}

			// 登入成功, 導入各部門的功能首頁
			DeptVO deptVO = empSvc.getOneEmp(empno).getDept();
			Integer fucNo = deptVO.getFucNo();
			switch (fucNo) {
			case 101: // 企劃
				forwardPath = req.getContextPath() + "/back-end/pha/select_phoalb.jsp";
				break;
			case 102: // 商城
				forwardPath = req.getContextPath() + "/productsView.html";
				break;
			case 103: // 房務
				forwardPath = req.getContextPath() + "/back-end/pha/select_phoalb.jsp";
				break;
			case 104: // 人資
				forwardPath = req.getContextPath() + "/back-end/pha/select_phoalb.jsp";
				break;
			case 105: // 主管最高權限
				forwardPath = req.getContextPath() + "/back-end/pha/select_phoalb.jsp";
				break;
			}
			HttpSession session = req.getSession();
			session.setAttribute("empno", empSvc.getOneEmp(empno).getEmpno());		
			System.out.println("員工編號:"+empSvc.getOneEmp(empno).getEmpno());
			res.sendRedirect(forwardPath);


		} // login
		
		//登出
		if("logoutEmp".equals(action)) {
			HttpSession session = req.getSession(false);
			Object empno = session.getAttribute("empno");
			Object location = session.getAttribute("location");
			session.removeAttribute("empno");
			System.out.println("登出員工:"+empno);			
			forwardPath = req.getContextPath() + "/back-end/index/loginEmp.jsp";
			res.sendRedirect(forwardPath);
		}

	}//post
	
	protected int loginTest(Integer empno, String empPass) {
			//驗證帳號
			EmpService empSvc = new EmpService();
			if(empSvc.getOneEmp(empno) == null) {
				System.out.println("查無此帳號");
				return -1;
			}else if(empSvc.getOneEmp(empno).getEmpStatus() == 0){ //檢查員工狀態
				System.out.println("該員工已凍結");
				return -2;
			}else if(empSvc.getOneEmp(empno).getEmpPass().equals(empPass)){//檢查密碼
				System.out.println("成功登入");
				return 1;
			}else {
				System.out.println("密碼有誤");
				return -3;
			}				
	}



}//
