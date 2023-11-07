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

import com.paradisiac.roomZ.roomorder.entity.RoomOrderVO;
import com.paradisiac.roomZ.roomorder.service.RoomOrderService;
import com.paradisiac.roomZ.roomorder.service.RoomOrderServiceImpl;


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
	
	private String getAll(HttpServletRequest req, HttpServletResponse resp) {

		List<RoomOrderVO> all = roomOrderService.getAllOrd();
		req.setAttribute("all", all);

		return "/back-end/roomorder/getAllder.jsp";
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
		String payStatus = req.getParameter("payStatus");
		//orderStatus

		// 将字符串参数解析为整数
		Timestamp roomOrderDatedt = null;
		Timestamp roomOrderDatenow =  new Timestamp(System.currentTimeMillis());
		Date checkinDatedt = null;
		Date checkoutDatedt = null;
		
		Integer roomTypeNoInt = null;
		Integer memNoInt = null;
		Integer roomAmountInt = null;
		Integer priceInt = null;
		
//		roomOrderDatedt = java.sql.Timestamp.valueOf(req.getParameter("roomOrderDate").trim());
		checkinDatedt = Date.valueOf(req.getParameter("checkinDate").trim());
		checkoutDatedt = Date.valueOf(req.getParameter("checkoutDate").trim());

		
		
		boolean payStatusBool = Boolean.parseBoolean(payStatus);
		byte paymentMethod = Byte.parseByte(req.getParameter("paymentMethod").trim());
		byte orderStatus = Byte.parseByte(req.getParameter("orderStatus").trim());

		try {
			roomTypeNoInt = Integer.parseInt(roomTypeNo);
			memNoInt = Integer.parseInt(memNo);
			roomAmountInt = Integer.parseInt(roomAmount);
			priceInt = Integer.parseInt(price);
		  
		} catch (NumberFormatException e) {
		    
		}

		// 如果有確定進入資料庫會有流水編號，再去找流水編號的值，顯示在jsp
		int saved = roomOrderService.addorder(roomOrderDatenow, checkinDatedt, checkoutDatedt, roomTypeNoInt, memNoInt, roomAmountInt, priceInt, paymentMethod, payStatusBool,orderStatus);
		var result = roomOrderService.findByorderNo(saved);

		if (saved > 0) {
//		    return 1; // 添加成功
	        System.out.println("新增成功");
	    } else {
//	        return -1; // 添加失败
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
		//paymentMethod
		String payStatus = req.getParameter("payStatus");
		//orderStatus


		
		Integer roomOrderNoInt = null;

		// 将字符串参数解析为整数
		Timestamp roomOrderDatedt = null;
		Date checkinDatedt = null;
		Date checkoutDatedt = null;
		
		Integer roomTypeNoInt = null;
		Integer memNoInt = null;
		Integer roomAmountInt = null;
		Integer priceInt = null;
		
		roomOrderDatedt = java.sql.Timestamp.valueOf(req.getParameter("roomOrderDate").trim());
		checkinDatedt = java.sql.Date.valueOf(req.getParameter("checkinDate").trim());
		checkoutDatedt = java.sql.Date.valueOf(req.getParameter("checkoutDate").trim());

		boolean payStatusBool = Boolean.parseBoolean(payStatus);
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