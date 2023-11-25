package com.paradisiac.roomZ.roompicture.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.*;

import com.paradisiac.roomZ.roompicture.entity.RoomPictureeVO;
import com.paradisiac.roomZ.roompicture.service.RoomPictureService;
import com.paradisiac.roomZ.roomtype.entity.RoomTypeeVO;

@WebServlet("/roompic/roompic.do")
@MultipartConfig

public class RoomPictureServlet extends HttpServlet{

	
	    public void doGet(HttpServletRequest req, HttpServletResponse res)
	            throws ServletException, IOException {
	        doPost(req, res);
	    }

	    public void doPost(HttpServletRequest req, HttpServletResponse res)
	            throws ServletException, IOException {

	        req.setCharacterEncoding("UTF-8");
	        String action = req.getParameter("action");
	        String forwardPath = "";
		        switch (action) {
		        case "insert":
					forwardPath = insertpic(req, res);
					break;
		        case "getAll":
					forwardPath = getAll(req, res);
					break;
					
		        
				default:
					forwardPath = "/index2.jsp";
				}
		        // 在這裡轉發，而不是在每個 case 內部
		        if (forwardPath != null) {
		            RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
		            dispatcher.forward(req, res);
		        }
	        }
	    private String insertpic(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
	        // 检查请求的内容类型是否为multipart/form-data
	        String contentType = req.getContentType();
	        if (contentType != null && contentType.toLowerCase().startsWith("multipart/form-data")) {
	            System.out.println("成功進insertPIC");

	            /***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
	            String roomtypeNo = req.getParameter("roomTypeNo");
	            Integer roomtypeNoInt = Integer.parseInt(roomtypeNo);
	            // 圖片
	            Part image = null;
	            try {
	                Collection<Part> parts = req.getParts();
	                for (Part part : parts) {
	                    if ("image".equals(part.getName())) {
	                        image = part;
	                        break; // 找到第一个图像字段后退出循环
	                    }
	                }
	            } catch (IllegalArgumentException e) {
	                e.printStackTrace();
	            }

	            // 检查是否存在图像字段
	            if (image != null) {
	                byte[] Pic = null;
	                try (InputStream inputStream = image.getInputStream()) {
	                    Pic = inputStream.readAllBytes();
	                    inputStream.close();
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }

	                /***************************2.開始新增資料***************************************/
	                RoomPictureService roompicSvc = new RoomPictureService();
	                roompicSvc.addpic(roomtypeNoInt, Pic);

	                /***************************3.新增完成,準備轉交(Send the Success view)***********/
	                String url = "/back-end/roompicture/addpic.jsp";
	                RequestDispatcher successView = req.getRequestDispatcher(url);
	                req.setAttribute("roomTypeNo", roomtypeNoInt);
	                req.setAttribute("pic", Pic);
	                successView.forward(req, resp);
	            }
	        }
	        return "index2.jsp";
	    }
		private String getAll(HttpServletRequest req, HttpServletResponse resp) {

			
			  // 假設你有一個名為 roomPictureService 的服務類別用於獲取所有圖片
		    RoomPictureService roomPictureService = new RoomPictureService();
		    List<RoomPictureeVO> pictures = roomPictureService.getAllpic();

		    // 將圖片列表存儲在 request 屬性中
		    req.setAttribute("pictures", pictures);

		    // 轉發到 JSP 頁面
		    RequestDispatcher dispatcher = req.getRequestDispatcher("/back-end/roompicture/picview.jsp"); // 替換成你的 JSP 檔案名稱
		    try {
				dispatcher.forward(req, resp);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	
			return "/back-end/roompicture/picview.jsp";
		}
	   
//
//        if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
//        	System.out.println("成功進update");
//            Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
//            req.setAttribute("errorMsgs", errorMsgs);
//
//            /***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//            String adminName = req.getParameter("adminName");
//            String adminNameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
//            if (adminName == null || adminName.trim().length() == 0) {
//                errorMsgs.put("adminName", "姓名請勿空白");
//            } else if (!adminName.trim().matches(adminNameReg)) { //以下練習正則(規)表示式(regular-expression)
//                errorMsgs.put("adminName", "不得特殊符號且長度2~10");
//            }
//            
//            Integer adminNo = Integer.valueOf(req.getParameter("adminNo").trim());
//
////            Integer adminNo = null;
////            try {
////                adminNo = Integer.valueOf(req.getParameter("adminNo").trim());
////            } catch (NumberFormatException e) {
////                errorMsgs.put("adminNo", "請填數字");
////            }
//
//            String adminAccount = req.getParameter("adminAccount").trim();
//            String adminAccountReg = "[a-zA-Z0-9_]+";
//            String adminAccoutReg2 = "^[(a-zA-Z0-9_)]{6,12}$";
//            if (adminAccount == null || adminAccount.trim().length() == 0) {
//                errorMsgs.put("adminAccount", "帳號請勿空白");
//            } else if (!adminAccount.trim().matches(adminAccountReg)) {
//                errorMsgs.put("adminAccount", "只能是英文、數字和_");
//            } else if (!adminAccount.trim().matches(adminAccoutReg2)) {
//                errorMsgs.put("adminAccount", "長度需在6到12之間");
//            }
//
//            String adminPassword = req.getParameter("adminPassword").trim();
//            String adminPasswordReg = "^[a-zA-Z0-9!@]+$";
//            String adminPasswordReg2 = "^[a-zA-Z0-9!@]{8,16}$";
//
//            if (adminPassword == null || adminPassword.length() == 0) {
//                errorMsgs.put("adminPassword", "密碼請勿空白");
//            } else if (!adminPassword.matches(adminPasswordReg)) {
//                errorMsgs.put("adminPassword", "只能是英文、數字、@、!");
//            } else if (!adminPassword.matches(adminPasswordReg2)) {
//                errorMsgs.put("adminPassword", "長度需在8到16之間");
//            }
//
//
//            Date createDate = null;
//            try {
//                createDate = java.sql.Date.valueOf(req.getParameter("createDate").trim());
//            } catch (IllegalArgumentException e) {
//                errorMsgs.put("createDate", "請輸入日期");
//            }
//            
//            Integer adminStat = Integer.valueOf(req.getParameter("adminStat").trim());
//
////            Integer adminStat = null;
////            try {
////                adminStat = Integer.valueOf(req.getParameter("adminStat").trim());
////            } catch (NumberFormatException e) {
////                errorMsgs.put("adminStat", "請填數字");
////            }
//
//            String adminEmail = req.getParameter("adminEmail").trim();
//            if (adminEmail == null || adminEmail.trim().length() == 0) {
//                errorMsgs.put("adminEmail", "信箱請勿空白");
//            }
//
//            String adminPhone = req.getParameter("adminPhone").trim();
//            if (adminPhone == null || adminPhone.trim().length() == 0) {
//                errorMsgs.put("adminPhone", "電話請勿空白");
//            }
//            
//            Part image = null;
//            try {
//                Collection<Part> parts = req.getParts();
//                for (Part part : parts) {
//                    if ("image".equals(part.getName())) image = part;
//                }
//            } catch (IllegalArgumentException e){
//                e.printStackTrace();
//            }
//            
//            AdminService adminSvc = new AdminService();
//            byte[] adminPic = null;
//            int length = image.getInputStream().available() ;
//            if(length != 0){
//                try (InputStream inputStream = image.getInputStream()){
//                    adminPic = inputStream.readAllBytes();
//                    inputStream.close();
//                } catch (IOException e){
//                    e.printStackTrace();
//                }
//            }else {
//            	adminPic=adminSvc.getOneAdmin(adminNo).getAdminPic();
//            }
//
//            // Send the use back to the form, if there were errors
//            if (!errorMsgs.isEmpty()) {
//                RequestDispatcher failureView = req
//                        .getRequestDispatcher("/admin/updateAdminNew.jsp");
//                failureView.forward(req, res);
//                return; //程式中斷
//            }
//
//            /***************************2.開始修改資料*****************************************/
//           
//            AdminVO adminVO = adminSvc.updateAdmin(adminNo,adminAccount,adminPassword,adminName,createDate,adminStat, adminEmail,adminPhone,adminPic);
//
//            /***************************3.修改完成,準備轉交(Send the Success view)*************/
//            req.setAttribute("AdminVO", adminVO); // 資料庫update成功後,正確的的AdminVO物件,存入req
//            String url = "/admin/listOneAdminNew.jsp";
//            RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneAdmin.jsp
//            successView.forward(req, res);
//        }


	    }

	