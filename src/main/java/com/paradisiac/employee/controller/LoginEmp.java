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
import com.paradisiac.employee.service.*;
import com.paradisiac.department.model.DeptVO;
import com.paradisiac.employee.model.*;

@WebServlet("/loginemp.do")
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
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/emp/loginEmp.jsp");//有錯跳回查詢頁面
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
					errorMsgs.add("密碼有誤");
					break;
			}
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/emp/loginEmp.jsp");//有錯跳回查詢頁面
				failureView.forward(req, res);
				return;// 程式中斷
			}

			// 登入成功, 導入各部門的功能首頁
			DeptVO deptVO = empSvc.getOneEmp(empno).getDept();
			Integer deptNo = deptVO.getDeptNo();
			switch (deptNo) {
			case 101: // 業務部,相簿管理
				forwardPath = req.getContextPath() + "/back-end/pha/select_phoalb.jsp";
				break;
			case 103: // 人資部,員工管理
				forwardPath = req.getContextPath() + "/back-end/emp/select_page.jsp";
				break;
			}
			res.sendRedirect(forwardPath);

		} // login

	}//post
	
	protected int loginTest(Integer empno, String empPass) {
			//驗證帳號
			EmpService empSvc = new EmpService();
			if(empSvc.getOneEmp(empno) == null) {
				System.out.println("查無此帳號");
				return -1;
			}else { //收到回傳的物件, 接著檢查密碼
				if(empSvc.getOneEmp(empno).getEmpPass().equals(empPass)) {
					System.out.println("成功登入");		
					return 1;
				}else {
					System.out.println("密碼有誤");
					return -2;
				}
			}
	}



}//
