package com.paradisiac.productphoto.controller;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Base64;
import java.util.Collection;
import javax.servlet.RequestDispatcher;
import com.google.gson.JsonObject;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import com.paradisiac.productphoto.service.ProductPhotoService;
import com.paradisiac.promotion.model.PromotionVO;
import com.paradisiac.promotion.service.PromotionService;
import com.paradisiac.productphoto.model.ProductPhotoVO;
@WebServlet("/ProductPhotoServlet")
public class ProductPhotoServlet extends HttpServlet {
	private ProductPhotoService productPhotoService;

	@Override
	public void init() throws ServletException {
		productPhotoService = new ProductPhotoService();
	}

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		req.setCharacterEncoding("UTF-8");
		
		String productId = req.getParameter("productId");
		Integer productno = null ;
		productno = Integer.valueOf(productId);
		//service搜尋
		ProductPhotoVO photoVO = productPhotoService.getByNo(productno);
		//取得結果
		Integer photoId = photoVO.getPhotono();
		byte[] imageBytes = productPhotoService.getByNo(productno).getPicture();

         // 将照片编号和照片数据作为JSON响应返回
		JsonObject responseJson = new JsonObject();
         responseJson.addProperty("photoId", photoId);
         responseJson.addProperty("photoData", Base64.getEncoder().encodeToString(imageBytes));
         res.setContentType("application/json");
         res.setCharacterEncoding("UTF-8");
         res.getWriter().write(responseJson.toString());
}
		
	
		
		
		
		
		

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
//		if ("insert".equals(action)) {
//
////			List<String> errorMsgs = new LinkedList<String>();
////			req.setAttribute("errorMsgs", errorMsgs);
//
//			/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
//			Integer productno = null;
//			productno = Integer.valueOf(req.getParameter("productno").trim());
//
//			Integer photono = null;
//			photono = Integer.valueOf(req.getParameter("photono").trim());
//
//			Collection<Part> parts = req.getParts(); // Servlet3.0新增了Part介面，讓我們方便的進行檔案上傳處理
//			byte[] picture;
//			for (Part part : parts) {
//				String filename = part.getSubmittedFileName();
//				if (filename != null && filename.length() != 0 && part.getContentType() != null) {
//					InputStream in = part.getInputStream();
//					picture = new byte[in.available()]; // byte[] buf = in.readAllBytes(); // Java 9 的新方法
//					in.read(picture);
//					ProductPhotoVO proVO = new ProductPhotoVO();
//					proVO.setProductno(productno);
//					proVO.setPhotono(photono);
//					proVO.setPicture(picture);
////						開始新增
////					ProductPhotoService proSvc = new ProductPhotoService();
//					proVO = productPhotoService.insert(proVO);
////===============================開始傳送=============================
//					req.setAttribute("proVO", proVO);
//					String url = "/back-end/productphoto/listOne.jsp";
//					RequestDispatcher successView = req.getRequestDispatcher(url);
//					successView.forward(req, res);
//					in.close();
//				}
//			}
//		}
	}

