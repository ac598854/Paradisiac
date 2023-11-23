package com.paradisiac.photoAlbum.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.paradisiac.members.model.MembersVO;
import com.paradisiac.members.service.MembersService;
import com.paradisiac.photo.model.PhoWithAlbDTO;
import com.paradisiac.photoAlbum.model.PhotoAlbumDAO_interface;
import com.paradisiac.photoAlbum.model.PhotoAlbumHibernateDAO;
import com.paradisiac.photoAlbum.model.PhotoAlbumVO;
import com.paradisiac.photoAlbum.service.PhotoAlbumServiceImpl;
import com.paradisiac.photoAlbum.service.PhotoAlbumService_interface;
import com.paradisiac.util.HibernateUtil;

/**
 * Servlet implementation class phaService
 */
@WebServlet("/pha.do")
@MultipartConfig
public class PhaServlet extends HttpServlet {
	
	private PhotoAlbumService_interface phaSvc; 
	
	public void init() throws ServletException{
		phaSvc = new PhotoAlbumServiceImpl();
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String forwardPath = "";

		
		if("getAll".equals(action)) {
			forwardPath = getAllPha(req, res);
			res.setContentType("text/html; charset=UTF-8");
			RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
			dispatcher.forward(req, res);
		}

		//新增相簿
		if("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			Integer albNo = null;
			try {
				albNo = Integer.valueOf(req.getParameter("albNo").trim());
			}catch(Exception e) {
				errorMsgs.add("相簿編號請勿空白");
			}
			
			Integer memNo = null;
			try {
				memNo = Integer.valueOf(req.getParameter("memNo").trim());
			}catch(Exception e) {
				errorMsgs.add("會員編號請勿空白");
			}
			
			String albName = req.getParameter("albName").trim();
			if(albName == null || albName.trim().length() == 0) {
				errorMsgs.add("相簿名稱請勿空白");
			}

			java.sql.Date albDate = null;
			try {
				albDate = java.sql.Date.valueOf(req.getParameter("albDate").trim());
			}catch(Exception e) {
				errorMsgs.add("相簿建立日期請勿空白");
			}
			//開始打包成物件
			PhotoAlbumVO phaVO = new PhotoAlbumVO();
			phaVO.setAlbNo(albNo);
			phaVO.setMemNo(memNo);
			phaVO.setAlbName(albName);
			phaVO.setAlbDate(albDate);
			
			//圖片需轉換成byte
			byte[] albPhoto = null;
			Part part = req.getPart("albPhoto");
			InputStream is = part.getInputStream();
			albPhoto = new byte[is.available()];
			is.read(albPhoto);
			is.close();
			phaVO.setAlbPhoto(albPhoto);
			
			
			//如果有錯誤處理輸出
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("phaVO", phaVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/pha/select_phoalb.jsp");
				failureView.forward(req, res);
				return;
			}
			/***************************2.開始新增資料***************************************/
			phaSvc.addPha(phaVO);

			/***************************3.新增完成,準備轉交(Send the Success view)***********/
			forwardPath = getAllPha(req, res);
			RequestDispatcher successView = req.getRequestDispatcher(forwardPath); // 新增成功後轉交
			successView.forward(req, res);
		}
		//新增相片(先找相本PK再forward(req, res)出去
		if("insertPhoto".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			/***************************1.接收請求參數****************************************/
			Integer albNo = Integer.valueOf(req.getParameter("albNo"));
			/***************************2.開始查詢資料****************************************/
			PhotoAlbumVO phaVO = phaSvc.getPhaByPK(albNo);
			/***************************3.查詢完成,準備轉交(Send the Success view)************/
			req.setAttribute("phaVO", phaVO);
			forwardPath = "/back-end/photo/addPhoto.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(forwardPath);// 成功轉交
			successView.forward(req, res);
		}
		//刪除相片
		if("delete".equals(action)) {
			/***************************1.接收請求參數****************************************/
			Integer albNo = Integer.valueOf(req.getParameter("albNo"));

			/***************************2.開始查詢資料****************************************/
			PhotoAlbumVO phaVO = phaSvc.getPhaByPK(albNo);
		}
		//查單筆相簿(含所有照片)
		if("getOne_For_Display".equals(action)) {			
			forwardPath = getAllPho(req, res);
			res.setContentType("text/html; charset=UTF-8");
			RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
			dispatcher.forward(req, res);

		}
		//修改相簿(找PK)
		if("getOne_For_Update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			/***************************1.接收請求參數****************************************/
			Integer albNo = Integer.valueOf(req.getParameter("albNo"));
			/***************************2.開始查詢資料****************************************/
			PhotoAlbumVO phaVO = phaSvc.getPhaByPK(albNo);
			/***************************3.查詢完成,準備轉交(Send the Success view)************/
			req.setAttribute("phaVO", phaVO);
			forwardPath = "/back-end/pha/updateOnePha.jsp";//updateOnePha.jsp
			RequestDispatcher successView = req.getRequestDispatcher(forwardPath);// 成功轉交
			successView.forward(req, res);
		}
		//修改相簿內容
		if("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			Integer albNo = Integer.valueOf(req.getParameter("albNo"));
			Integer memNo = Integer.valueOf(req.getParameter("memNo"));			
			String albName = req.getParameter("albName").trim();
			if(albName == null || albName.trim().length() == 0) {
				errorMsgs.add("相簿名稱請勿空白");
			}
			java.sql.Date albDate = null;
			try {
				albDate = java.sql.Date.valueOf(req.getParameter("albDate").trim());
			}catch(Exception e) {
				errorMsgs.add("相簿建立日期請勿空白");
			}
			//開始打包
			PhotoAlbumVO phaVO = new PhotoAlbumVO(albNo, memNo, albName, albDate);
			//圖片需轉換成byte
			byte[] albPhoto = null;
			Part part = req.getPart("albPhoto");
			InputStream is = part.getInputStream();
			albPhoto = new byte[is.available()];
			is.read(albPhoto);
			is.close();
			phaVO.setAlbPhoto(albPhoto);
			
			//如有錯誤則將填寫的資料保留傳回更新頁面
			if(!errorMsgs.isEmpty()) {
				req.setAttribute("phaVO", phaVO);
				forwardPath = "/back-end/pha/updateOnePha.jsp";
				RequestDispatcher failureView = req.getRequestDispatcher(forwardPath);
				failureView.forward(req, res);
				return;
			}
			//無錯誤, 修改並轉交
			phaSvc.updatePha(phaVO);
			req.setAttribute("phaVO", phaVO);
			forwardPath = "/back-end/pha/select_phoalb.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(forwardPath);// 成功轉交
			successView.forward(req, res);

		}
		
		
	}//doPost
	
	//查全部可瀏覽的頁數===========================================================
	private String getAllPha(HttpServletRequest req, HttpServletResponse res) { //從ListAll請求
		String page = req.getParameter("page"); //網址列會有page=空(第一頁) or 第幾頁
		int currentPage = (page == null) ? 1 : Integer.parseInt(page); //如果第一次跳轉則page會是空值, 把1存進currentPage
		
		List<PhotoAlbumVO> phaList = phaSvc.getAllPha(currentPage);

		if (req.getSession().getAttribute("phaPageQty") == null) {
			int phaPageQty = phaSvc.getPageTotal();
			req.getSession().setAttribute("phaPageQty", phaPageQty);
		}
		
		req.setAttribute("phaList", phaList);
		req.setAttribute("currentPage", currentPage);

		return "/back-end/pha/listAllPha.jsp";
	}
	//查相簿的所有照片=============================================================
	private String getAllPho(HttpServletRequest req, HttpServletResponse res) {

		Integer albNo = null;
		Integer memno = null;
		//從session取得會員編號
		Object memnoInt = (Integer)req.getSession(false).getAttribute("memno");
		
		if(memnoInt instanceof Integer) {
			System.out.println("輸入是Integer");
		}else if(memnoInt instanceof String) {
			System.out.println("輸入是String");
		}
		
		System.out.println("有取得會員編號"+memnoInt);
				
		//會員查詢相簿 & 後台員工查詢相簿
		if(memnoInt != null) {
			albNo = phaSvc.getPhaByMem((Integer) memnoInt);	
			System.out.println(memnoInt + "取得相簿編號: "+albNo);
			req.setAttribute("albNo", albNo);
		}else {
			albNo = Integer.valueOf(req.getParameter("albNo"));
			System.out.println("後台取得相簿編號: "+albNo);
		}
	
		String page = req.getParameter("page");//網址列會有page=空(第一頁) or 第幾頁
		int currentPage = (page == null) ? 1 : Integer.parseInt(page); //如果第一次跳轉則page會是空值, 把1存進currentPage
		
		PhotoAlbumDAO_interface phaDAO = new PhotoAlbumHibernateDAO(HibernateUtil.getSessionFactory());
		List<PhoWithAlbDTO> list = phaDAO.searchAllPhoto(albNo, currentPage);
		
		int phoPageQty = phaDAO.getTotalQty(albNo);
		req.getSession().setAttribute("phoPageQty", phoPageQty);
		
		req.setAttribute("list", list);
		req.setAttribute("currentPage", currentPage);
		
		if(memnoInt != null) {
			albNo = phaSvc.getPhaByMem(memno);
			req.setAttribute("albNo", albNo);		
			return "/front-end/members/listOnePha_mem.jsp";
		}else {
			return "/back-end/pha/listOnePha.jsp";
		}
			
	}

		

}//class
