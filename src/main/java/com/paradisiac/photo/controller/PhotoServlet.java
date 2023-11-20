package com.paradisiac.photo.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.paradisiac.photo.model.PhoWithAlbDTO;
import com.paradisiac.photo.model.PhotoVO;
import com.paradisiac.photo.service.PhotoService;
import com.paradisiac.photo.service.PhotoServiceImpl;
import com.paradisiac.photoAlbum.model.PhotoAlbumDAO_interface;
import com.paradisiac.photoAlbum.model.PhotoAlbumHibernateDAO;
import com.paradisiac.photoAlbum.model.PhotoAlbumVO;
import com.paradisiac.photoAlbum.service.PhotoAlbumServiceImpl;
import com.paradisiac.photoAlbum.service.PhotoAlbumService_interface;
import com.paradisiac.util.HibernateUtil;


@WebServlet("/pho.do")
@MultipartConfig
public class PhotoServlet extends HttpServlet {
	private PhotoService photoSvc;
	//private PhotoAlbumService phaSvc;
	// 一個 servlet 實體對應一個 service 實體
	public void init() throws ServletException {
		photoSvc = new PhotoServiceImpl();
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String forwardPath = "";
		
		//新增相片
		if("insert".equals(action)) {
			//錯誤處理
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			Date photoDate = null;
			try {
				photoDate =  java.sql.Date.valueOf(req.getParameter("photoDate").trim());
			}catch(IllegalArgumentException e) {//Date.valueOf
				errorMsgs.add("請選擇相片日期");
			}
						
			String photoName1 = req.getParameter("photoName1").trim();
			String photoName2 = req.getParameter("photoName2").trim();
			String photoName3 = req.getParameter("photoName3").trim();
			//至少選一個檔案
			if(photoName1.length() == 0 && photoName2.length() ==0 && photoName3.length() == 0) {
				errorMsgs.add("請選擇一張照片");
			}
					
			/***************************1.接收請求參數****************************************/
			Integer albNo = Integer.valueOf(req.getParameter("albNo"));
			photoDate =  java.sql.Date.valueOf(req.getParameter("photoDate"));
			List<PhotoVO> photoList = new ArrayList<PhotoVO>();//ArrayList長度動態改變
			
			//有選到檔案才需要轉成byte並加到陣列中
			if(photoName1.length() != 0) {				
				Part part1 = req.getPart("photo1");
				byte[] photo1 = transPhoto(part1);
				
				PhotoVO photoVO1 = new PhotoVO(albNo, photoDate);
				photoVO1.setPhotoName(photoName1);
				photoVO1.setPhoto(photo1);
				photoList.add(photoVO1);
			}
			
			if(photoName2.length() != 0) {				
				Part part2 = req.getPart("photo2");
				byte[] photo2 = transPhoto(part2);
				
				PhotoVO photoVO2 = new PhotoVO(albNo, photoDate);
				photoVO2.setPhotoName(photoName2);
				photoVO2.setPhoto(photo2);
				photoList.add(photoVO2);
			}
			
			if(photoName3.length() != 0) {				
				Part part3 = req.getPart("photo3");
				byte[] photo3 = transPhoto(part3);
				
				PhotoVO photoVO3 = new PhotoVO(albNo, photoDate);
				photoVO3.setPhotoName(photoName3);
				photoVO3.setPhoto(photo3);
				photoList.add(photoVO3);
			}

			/***************************2.開始新增資料***************************************/
			photoSvc.addPhoto(photoList);
			
			/***************************3.新增完成,準備轉交(Send the Success view)***********/
			forwardPath = "/back-end/photo/addPhoto.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(forwardPath); // 新增成功後轉交
			successView.forward(req, res);
			
		}//新增相片
		//刪除相片======================================================================
		if("delete".equals(action)) {
			String[] selectedPhotos = null;
			String albNo = req.getParameter("albNo");
			selectedPhotos = req.getParameterValues("photoNo"); //用Values取得有打勾的陣列
	        photoSvc.deletePhoto(selectedPhotos);
	        
	        String page = req.getParameter("page");//網址列會有page=空(第一頁) or 第幾頁
			int currentPage = (page == null) ? 1 : Integer.parseInt(page); //如果第一次跳轉則page會是空值, 把1存進currentPage
			
			PhotoAlbumDAO_interface phaDAO = new PhotoAlbumHibernateDAO(HibernateUtil.getSessionFactory());
			List<PhoWithAlbDTO> list = phaDAO.searchAllPhoto(Integer.valueOf(albNo), currentPage);
	        
			int phoPageQty = phaDAO.getTotalQty(Integer.valueOf(albNo));
			req.getSession().setAttribute("phoPageQty", phoPageQty);
			
			req.setAttribute("list", list);
			req.setAttribute("currentPage", currentPage);

			forwardPath = "/back-end/pha/listOnePha.jsp";
			res.setContentType("text/html; charset=UTF-8");
			RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
			dispatcher.forward(req, res);

		}//刪除相片
		
		
		
	}//dopost
	
	//轉換成圖片的方法
	private byte[] transPhoto(Part part) throws IOException {
		InputStream is = part.getInputStream();
		byte[] photo = new byte[is.available()];
		is.read(photo);
		is.close();
		return photo;
		
	}

	

}
