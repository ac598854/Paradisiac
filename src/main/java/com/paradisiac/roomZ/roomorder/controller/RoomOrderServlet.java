package com.paradisiac.roomZ.roomorder.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.paradisiac.roomorder.model.RoomOrderVO;
import com.paradisiac.roomorder.service.RoomOrderService;
import com.paradisiac.roomorder.service.RoomOrderServiceImpl;
import java.text.SimpleDateFormat;

@WebServlet("/order/order.do")
public class RoomOrderServlet extends HttpServlet{
	
	private RoomOrderServiceImpl roomOrderService;
	
	@Override
	public void init() throws ServletException {
		roomOrderService = new RoomOrderServiceImpl();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String forwardPath = "";
		
		switch (action) {

		case "getAll":
			forwardPath = getAll(req, resp);
			break;
		case "getmemord":
			forwardPath = getmemord(req, resp);
			break;
		case "buyorder":
			forwardPath = buytype(req, resp);
			break;
			
		case "addorder":
			forwardPath = addtype(req, resp);
			break;

		case "updateorder":
			forwardPath = updatetype(req, resp);
			break;


			
		default:
			forwardPath = "/index2.jsp";
		}

		resp.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
		dispatcher.forward(req, resp);

	}
	
//	private String getmemord(HttpServletRequest req, HttpServletResponse resp) {
//
//		String memNo = req.getParameter("memNo");
//		Integer memNoInt = Integer.parseInt(memNo);
//		List<RoomOrderVO> mord = roomOrderService.getmemOrd(memNoInt);
//		req.setAttribute("mord", mord);
//
//		return "/back-end/roomorder/memvieword.jsp";
//	}
	private String getmemord(HttpServletRequest req, HttpServletResponse resp) {
	    String memNo = req.getParameter("memNo");
	    Integer memNoInt = Integer.parseInt(memNo);
	    // 添加檢查以確保 memNo 不為 null 且不為空
	    if (memNo != null && !memNo.isEmpty()) {
	    	System.out.println("isnotnull");
	        try {
	            List<RoomOrderVO> mord = roomOrderService.getmemOrd(memNoInt);
	            req.setAttribute("mord", mord);
	        } catch (NumberFormatException e) {
	            // 處理數字格式異常
	            e.printStackTrace();
	            // 或者您可以返回一個錯誤頁面，提醒用戶輸入有效的數字
	            return "/back-end/roomorder/memvieword.jsp";
	        }
	    } else {
	        // 處理 memNo 為 null 或空的情況
	        // 或者您可以返回一個錯誤頁面，提醒用戶輸入 memNo
	    	System.out.println("NULLLLL");
            List<RoomOrderVO> mord = roomOrderService.getmemOrd(memNoInt);
            req.setAttribute("mord", mord);
	    	 return "/back-end/roomorder/memvieword.jsp";
	    }

	    return "/back-end/roomorder/memvieword.jsp";
	}
	private String getAll(HttpServletRequest req, HttpServletResponse resp) {

		List<RoomOrderVO> all = roomOrderService.getAllOrd();
		req.setAttribute("all", all);

		return "/back-end/roomorder/getAllder.jsp";
	}
	private String buytype(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String roomOrderDate = req.getParameter("roomOrderDate");
//		String checkinDate = req.getParameter("checkinDate");
//		String checkoutDate = req.getParameter("checkoutDate");
		String roomTypeNo = req.getParameter("roomTypeNo");
		String memNo = req.getParameter("memNo");
		String roomAmount = req.getParameter("roomAmount");
		String price = req.getParameter("price");
		//paymentMethod
//		String payStatus = req.getParameter("payStatus");
		//orderStatus

		Timestamp roomOrderDatedt = null;
		Timestamp roomOrderDatenow =  new Timestamp(System.currentTimeMillis());
		Date checkinDatedt = null;
		Date checkoutDatedt = null;
		
		Integer roomTypeNoInt = null;
		Integer memNoInt = null;
		Integer roomAmountInt = null;
		Integer priceInt = null;
		
//		roomOrderDatedt = java.sql.Timestamp.valueOf(req.getParameter("roomOrderDate").trim());
		checkinDatedt = java.sql.Date.valueOf(req.getParameter("checkinDate").trim());
		checkoutDatedt = java.sql.Date.valueOf(req.getParameter("checkoutDate").trim());

		
		
		byte payStatusBool = Byte.parseByte(req.getParameter("payStatus").trim());
		byte paymentMethod = Byte.parseByte(req.getParameter("paymentMethod").trim());
		byte orderStatus = Byte.parseByte(req.getParameter("orderStatus").trim());

		try {
			roomTypeNoInt = Integer.parseInt(roomTypeNo);
			memNoInt = Integer.parseInt(memNo);
			roomAmountInt = Integer.parseInt(roomAmount);
			priceInt = Integer.parseInt(price);
		  
		} catch (NumberFormatException e) {
		    
		}


		int saved = roomOrderService.addorder(roomOrderDatenow, checkinDatedt, checkoutDatedt, roomTypeNoInt, memNoInt, roomAmountInt, priceInt, paymentMethod, payStatusBool,orderStatus);
		var result = roomOrderService.findByorderNo(saved);

		if (saved > 0) {

	        System.out.println("新增成功");

	    } else {

	        System.out.println("新增失敗");
	    }
	
		req.setAttribute("result", result);

		return "/back-end/roomorder/calcheck.jsp";
	}
	private String addtype(HttpServletRequest req, HttpServletResponse resp) {

//		String roomOrderDate = req.getParameter("roomOrderDate");
//		String checkinDate = req.getParameter("checkinDate");
//		String checkoutDate = req.getParameter("checkoutDate");
		String roomTypeNo = req.getParameter("roomTypeNo");
		String memNo = req.getParameter("memNo");
		String roomAmount = req.getParameter("roomAmount");
		String price = req.getParameter("price");
		//paymentMethod
//		String payStatus = req.getParameter("payStatus");
		//orderStatus

		Timestamp roomOrderDatedt = null;
		Timestamp roomOrderDatenow =  new Timestamp(System.currentTimeMillis());
		Date checkinDatedt = null;
		Date checkoutDatedt = null;
		
		Integer roomTypeNoInt = null;
		Integer memNoInt = null;
		Integer roomAmountInt = null;
		Integer priceInt = null;
		
//		roomOrderDatedt = java.sql.Timestamp.valueOf(req.getParameter("roomOrderDate").trim());
		checkinDatedt = java.sql.Date.valueOf(req.getParameter("checkinDate").trim());
		checkoutDatedt = java.sql.Date.valueOf(req.getParameter("checkoutDate").trim());

		
		
		byte payStatusBool = Byte.parseByte(req.getParameter("payStatus").trim());
		byte paymentMethod = Byte.parseByte(req.getParameter("paymentMethod").trim());
		byte orderStatus = Byte.parseByte(req.getParameter("orderStatus").trim());

		try {
			roomTypeNoInt = Integer.parseInt(roomTypeNo);
			memNoInt = Integer.parseInt(memNo);
			roomAmountInt = Integer.parseInt(roomAmount);
			priceInt = Integer.parseInt(price);
		  
		} catch (NumberFormatException e) {
		    
		}


		int saved = roomOrderService.addorder(roomOrderDatenow, checkinDatedt, checkoutDatedt, roomTypeNoInt, memNoInt, roomAmountInt, priceInt, paymentMethod, payStatusBool,orderStatus);
		var result = roomOrderService.findByorderNo(saved);

		if (saved > 0) {

	        System.out.println("新增成功");
	    } else {

	        System.out.println("新增失敗");
	    }
	
		req.setAttribute("result", result);
		
		return "/back-end/roomorder/orderfirst.jsp";
	}	

	private String updatetype(HttpServletRequest req, HttpServletResponse resp) {
		String roomOrderNo = req.getParameter("roomOrderNo");
		String roomTypeNo = req.getParameter("roomTypeNo");
		String memNo = req.getParameter("memNo");
		String roomAmount = req.getParameter("roomAmount");
		String price = req.getParameter("price");
//		String payStatus = req.getParameter("payStatus");

		Integer roomOrderNoInt = null;

		Timestamp roomOrderDatedt = java.sql.Timestamp.valueOf(req.getParameter("roomOrderDate").trim());
		Date checkinDatedt = java.sql.Date.valueOf(req.getParameter("checkinDate").trim());
		Date checkoutDatedt = java.sql.Date.valueOf(req.getParameter("checkoutDate").trim());
		
		
		Integer roomTypeNoInt = null;
		Integer memNoInt = null;
		Integer roomAmountInt = null;
		Integer priceInt = null;

		byte payStatusBool = Byte.parseByte(req.getParameter("payStatus").trim());
		byte paymentMethod = Byte.parseByte(req.getParameter("paymentMethod").trim());
		byte orderStatus = Byte.parseByte(req.getParameter("orderStatus").trim());

		try {
			
			roomOrderNoInt = Integer.parseInt(roomOrderNo);
			roomTypeNoInt = Integer.parseInt(roomTypeNo);
			memNoInt = Integer.parseInt(memNo);
			roomAmountInt = Integer.parseInt(roomAmount);
			priceInt = Integer.parseInt(price);
		  
		} catch (NumberFormatException e) {
			System.out.println("ERROR");

		}

		// 如果有確定進入資料庫會有流水編號，再去找流水編號的值，顯示在jsp

		int result = roomOrderService.updateorder(roomOrderNoInt,roomOrderDatedt, checkinDatedt, checkoutDatedt, roomTypeNoInt, memNoInt, roomAmountInt, priceInt, paymentMethod, payStatusBool,orderStatus);

		if (result > 0) {
			System.out.println("更新成功");
		} else {
			System.out.println("更新失敗");
			System.out.println(result);
		}
		
		resp.setContentType("application/json;charset=UTF-8");
		return "/back-end/roomorder/orderfirst.jsp";
	}


	

	
}