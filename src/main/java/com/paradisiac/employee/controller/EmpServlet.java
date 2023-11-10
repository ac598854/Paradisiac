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

import com.paradisiac.department.model.DeptVO;
import com.paradisiac.employee.model.EmpVO;
import com.paradisiac.employee.service.*;

/**
 * Servlet implementation class EmpServlet
 */
@WebServlet("/emp.do") //或是在web.xml註冊
public class EmpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// doGet = doPost
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		doPost(req, res);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		// 查單筆======================================================================
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.萬一有錯誤, 把錯誤訊息存在陣列中
			req.setAttribute("errorMsgs", errorMsgs); //key是errorMsgs

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			String str = req.getParameter("empno"); //送出請求key為empno把value存在str
			if (str == null || (str.trim()).length() == 0) { //去掉空格
				errorMsgs.add("請輸入員工編號");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/emp/select_page.jsp");/*"/emp/select_page.jsp"*/
				failureView.forward(req, res);
				return;// 程式中斷
			}

			Integer empno = null;
			try {
				empno = Integer.valueOf(str); //把字串轉成Integer
			} catch (Exception e) {
				errorMsgs.add("員工編號格式不正確");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/emp/select_page.jsp");//有錯跳回查詢頁面
				failureView.forward(req, res);
				return;// 程式中斷
			}
				
			EmpService empSvc = new EmpService();
			EmpVO empVO = empSvc.getOneEmp(empno);//自行輸入員工編號, 可能有空值 or 錯誤填寫
			if (empVO == null) {
				errorMsgs.add("查無資料");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/emp/select_page.jsp");
				failureView.forward(req, res);
				return;//程式中斷
			}
			/***************************3.查詢完成,準備轉交(Send the Success view)*************/
			req.setAttribute("empVO", empVO); // 資料庫取出的empVO物件,存入req
			String url = "/back-end/emp/listOneEmp.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
			successView.forward(req, res);

		}//查單筆
		
		// 修改(先找PK再forward(req, res)出去===============================================
		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
				/***************************1.接收請求參數****************************************/
				Integer empno = Integer.valueOf(req.getParameter("empno"));
				
				/***************************2.開始查詢資料****************************************/
				EmpService empSvc = new EmpService();
				EmpVO empVO = empSvc.getOneEmp(empno);//用PK找出是哪一筆要更新
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("empVO", empVO);         // 資料庫取出的empVO物件,存入req
				String url = "/back-end/emp/update_emp_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
		}//更新(先找PK再forward(req, res)出去
		
		// 修改(from update_emp_input.jsp===============================================
		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			Integer empno = Integer.valueOf(req.getParameter("empno").trim());
			
			String empName = req.getParameter("empName");
			String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
			if (empName == null || empName.trim().length() == 0) {
				errorMsgs.add("員工姓名: 請勿空白");
			} else if(!empName.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
            }
			Integer deptno = Integer.valueOf(req.getParameter("deptno").trim());//	.trim()
			
			Integer empStatus = Integer.valueOf(req.getParameter("empStatus").trim());
			Integer empGender = Integer.valueOf(req.getParameter("empGender").trim());
			String empMail = req.getParameter("empMail").trim();
			if (empMail == null || empMail.trim().length() == 0) {
				errorMsgs.add("信箱請勿空白");
			}
			String empAccount = req.getParameter("empAccount").trim();
			if (empAccount == null || empAccount.trim().length() == 0) {
				errorMsgs.add("帳號請勿空白");
			}
			String empPass = req.getParameter("empPass").trim();
			if (empPass == null || empPass.trim().length() == 0) {
				errorMsgs.add("密碼請勿空白");
			}
			String empPhone = req.getParameter("empPhone").trim();
			if (empPhone == null || empPhone.trim().length() == 0) {
				errorMsgs.add("電話請勿空白");
			}
			
			EmpVO empVO = new EmpVO(); //把修改的員工資料放進各屬性中
			
			DeptVO deptVO = new DeptVO();//聯合映射
			deptVO.setDeptNo(deptno);
			
			empVO.setEmpno(empno);
			empVO.setDeptVO(deptVO);			
			//empVO.setDeptno(deptno);
			empVO.setEmpStatus(empStatus);
			empVO.setEmpName(empName);
			empVO.setEmpMail(empMail);
			empVO.setEmpAccount(empAccount);
			empVO.setEmpPass(empPass);
			empVO.setEmpGender(empGender);
			empVO.setEmpPhone(empPhone);		
			
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("empVO", empVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/emp/update_emp_input.jsp");
				failureView.forward(req, res);
				return; //程式中斷
			}
			
			/***************************2.開始修改資料*****************************************/
			EmpService empSvc = new EmpService();
			empVO = empSvc.updateEmp(empno, deptVO, empStatus, empName, empMail, empAccount, empPass, empGender, empPhone);
			
			/***************************3.修改完成,準備轉交(Send the Success view)*************/
			req.setAttribute("empVO", empVO); // 資料庫update成功後,正確的的empVO物件,存入req
			
			String url = "/back-end/emp/listOneEmp.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
			successView.forward(req, res);

			
		}//修改(from update_emp_input.jsp
		
		// 新增======================================================================
		if ("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			Integer empno = null;
			try {
				empno = Integer.valueOf(req.getParameter("empno").trim());
			}catch(Exception e){
				errorMsgs.add("員工編號請勿空白");
			}
		
			String empName = req.getParameter("empName");
			String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
			if (empName == null || empName.trim().length() == 0) {
				errorMsgs.add("員工姓名: 請勿空白");
			} else if(!empName.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
            }
			
			Integer deptno = null;
			try {
				deptno = Integer.valueOf(req.getParameter("deptno"));
			}catch(Exception e){
				errorMsgs.add("請選擇部門");
			}		

			Integer empStatus = null;
			try {
				empStatus = Integer.valueOf(req.getParameter("empStatus").trim());
			}catch(Exception e){
				errorMsgs.add("請選擇員工狀態");
			}
			
			Integer empGender = null;
			try {
				empGender = Integer.valueOf(req.getParameter("empGender").trim());
			}catch(Exception e){
				errorMsgs.add("請選擇性別");
			}
			
			String empMail = req.getParameter("empMail").trim();
			if (empMail == null || empMail.trim().length() == 0) {
				errorMsgs.add("信箱請勿空白");
			}
			String empAccount = req.getParameter("empAccount").trim();
			if (empAccount == null || empAccount.trim().length() == 0) {
				errorMsgs.add("帳號請勿空白");
			}
			String empPass = req.getParameter("empPass").trim();
			if (empPass == null || empPass.trim().length() == 0) {
				errorMsgs.add("密碼請勿空白");
			}
			String empPhone = req.getParameter("empPhone").trim();
			if (empPhone == null || empPhone.trim().length() == 0) {
				errorMsgs.add("電話請勿空白");
			}
			
			EmpVO empVO = new EmpVO();
			DeptVO deptVO = new DeptVO();//聯合映射
			deptVO.setDeptNo(deptno);
			
			empVO.setEmpno(empno);
			empVO.setDeptVO(deptVO);
			//empVO.setDeptno(deptno);
			empVO.setEmpStatus(empStatus);
			empVO.setEmpName(empName);
			empVO.setEmpMail(empMail);
			empVO.setEmpAccount(empAccount);
			empVO.setEmpPass(empPass);
			empVO.setEmpGender(empGender);
			empVO.setEmpPhone(empPhone);
			
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("empVO", empVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/emp/addEmp.jsp");
				failureView.forward(req, res);
				return;
			}
			/***************************2.開始新增資料***************************************/
			EmpService empSvc = new EmpService();
			empVO = empSvc.addEmp(empno, deptVO, empStatus, empName, empMail, empAccount, empPass, empGender, empPhone);
			
			/***************************3.新增完成,準備轉交(Send the Success view)***********/
			String url = "/back-end/emp/listAllEmp.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
			successView.forward(req, res);
			
		}//新增
	
	}//doPost


}
