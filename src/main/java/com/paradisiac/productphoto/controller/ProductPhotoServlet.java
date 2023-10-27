package com.paradisiac.productphoto.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.Base64;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.paradisiac.productphoto.service.ProductPhotoService;
import com.paradisiac.productphoto.model.ProductPhotoVO;



public class ProductPhotoServlet extends HttpServlet{
	private ProductPhotoService ProductPhotoService;

	@Override
	public void init() throws ServletException {
		ProductPhotoService = new ProductPhotoService();
	}
	
	private static final long serialVersionUID = 1L;
 	public void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException ,ServletException{
		doPost(req, res);
	}
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException,ServletException{
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String forwardPath = "";
		if ("insert".equals(action)) {  
			
//			List<String> errorMsgs = new LinkedList<String>();
//			req.setAttribute("errorMsgs", errorMsgs);

				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				Integer productno= null;
				productno = Integer.valueOf(req.getParameter("productno").trim());
				
				Integer photono = null;
				photono = Integer.valueOf(req.getParameter("photono").trim());
				
				byte[] picture = null;
				req.getPart("upfile1").write(getServletContext().getRealPath("/images_uploaded")+"/file.gif");

				ProductPhotoVO proVO = new ProductPhotoVO();
				proVO.setProductno(productno);
				proVO.setPhotono(photono);
				proVO.setPicture(picture);
				
//				開始新增
				ProductPhotoService proSvc = new ProductPhotoService();
				proVO = proSvc.insert(proVO);
//				開始傳送
				String url = "/view/listall.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);				
		}
		
	
	
	}
		

	
	

}
