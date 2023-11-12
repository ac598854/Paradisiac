package com.paradisiac.department.controller;

import java.io.IOException;
import java.util.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.paradisiac.department.model.DeptVO;
import com.paradisiac.department.service.DeptService;
import com.paradisiac.department.service.DeptServiceImpl;
import com.paradisiac.employee.model.EmpVO;
import com.paradisiac.employee.service.EmpService;

@WebServlet("/dept.do")
public class DeptServlet extends HttpServlet{
	
	// 一個 servlet 實體對應一個 service 實體
	private DeptService deptSvc;
	private EmpService empSvc;
	
	@Override
	public void init() throws ServletException {
		deptSvc = new DeptServiceImpl();
		empSvc = new EmpService();
	}
	
	//設定doGet = doPost
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String forwardPath = "";
		
		//查單筆或複合查詢
		switch (action) {
			case "getAll":
				forwardPath = getAllDepts(req, res);
				break;
			case "getOne_For_Display":
				forwardPath = getOne_For_Display(req, res);
				break;
			case "insert":
				forwardPath = insert(req, res);
				break;
			default:
				forwardPath = "/back-end/dept/listOneDept.jsp";
		}	
		res.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
		dispatcher.forward(req, res);

	}//doPost
	
	//查全部
	private String getAllDepts(HttpServletRequest req, HttpServletResponse res) {
		String page = req.getParameter("page"); //網址列會有page=空(第一頁) or 第幾頁
		int currentPage = (page == null) ? 1 : Integer.parseInt(page); //如果第一次跳轉則page會是空值, 把1存進currentPage
		
		List<DeptVO> deptList = deptSvc.getAllDepts(currentPage);

		if (req.getSession().getAttribute("deptPageQty") == null) {
			int deptPageQty = deptSvc.getPageTotal();
			req.getSession().setAttribute("deptPageQty", deptPageQty);
		}
		
		req.setAttribute("deptList", deptList);
		req.setAttribute("currentPage", currentPage);

		return "/back-end/dept/listAllDepts.jsp";
	}
	//查單筆
	private String getOne_For_Display(HttpServletRequest req, HttpServletResponse res) {
		/*************************** 1.接收請求參數(取得部門編號PK)**********************/
		Integer deptNo = Integer.valueOf(req.getParameter("deptNo"));
		String deptName = req.getParameter("deptName");

		/***************************2.開始查詢資料***********************************/
		Set<EmpVO> deptEmpSet = deptSvc.getDeptByDeptnoE(deptNo);  //取得員工資料
		DeptVO deptVO = deptSvc.getDeptByDeptno(deptNo); //取得部門資料使用
		/***************************3.查詢完成,準備轉交(Send the Success view)*************/
		req.setAttribute("deptVO", deptVO);
		req.setAttribute("deptEmpSet", deptEmpSet); //回傳set給JSP, JSP再逐一取出
		return "/back-end/dept/listOneDepts.jsp";
	}
	
	private String insert(HttpServletRequest req, HttpServletResponse res) {
		Integer deptNo = Integer.valueOf(req.getParameter("deptNo"));	
		String deptName = req.getParameter("deptName").trim();
		Boolean deptStatus = Boolean.valueOf(req.getParameter("deptStatus"));
		Integer funNo = Integer.valueOf(req.getParameter("fucNo"));	
		String[] empList = req.getParameterValues("empNo");
		List<String> errorMsgs = new LinkedList<String>();
		
		if(empList == null) {
			errorMsgs.add("請至少選擇一名員工");
		}
		
		req.setAttribute("errorMsgs", errorMsgs); 		
		if (!errorMsgs.isEmpty()) {
			return "/back-end/dept/select_dept_page.jsp";//程式中斷
		}		
		
		//建立部門
		DeptVO deptVO = new DeptVO();
		deptVO.setDeptNo(deptNo);
		deptVO.setDeptName(deptName);
		deptVO.setDeptStatus(deptStatus);
		deptVO.setFucNo(funNo);	
		//加入從屬員工

		Set<EmpVO> emps = new LinkedHashSet<>();
		for(String empNO : empList) {
			EmpVO emp = empSvc.getOneEmp(Integer.valueOf(empNO)); //回傳員工物件
			emp.setDeptVO(deptVO);
			emps.add(emp);
		}
		deptVO.setEmps(emps);
		//打包完成送出
		deptSvc.addDept(deptVO);//回傳主鍵PK
		req.setAttribute("deptNO", deptNo);
		return "/back-end/dept/select_dept_page.jsp";
	}
	
	
	

	

}
