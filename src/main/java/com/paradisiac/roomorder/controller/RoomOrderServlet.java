package com.paradisiac.roomorder.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Arrays;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.paradisiac.roomorder.model.RoomOrderVO;
import com.paradisiac.roomorder.service.RoomOrderService;
import com.paradisiac.roomorder.service.RoomOrderServiceImpl;
import com.paradisiac.roomnum.model.RoomNumVO;
import com.paradisiac.roomnum.service.RoomNumServiceImpl;
import com.paradisiac.roomorder.model.RoomOrderDTO;
import redis.clients.jedis.Jedis;

@WebServlet("/order.do")
public class RoomOrderServlet extends HttpServlet {

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

		case "checkInData":
			forwardPath = checkInData(req, resp);
			break;
			
		case "handleCheckIn":
			forwardPath = handleCheckIn(req,resp);
			break;
		default:
			forwardPath = "/index2.jsp";
		}
	//	System.out.println("重導網頁："+forwardPath);
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
		// paymentMethod
		String payStatus = req.getParameter("payStatus");
		// orderStatus

		
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

		byte payStatusBool = Byte.parseByte(payStatus);
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
		int saved = roomOrderService.addorder(roomOrderDatedt, checkinDatedt, checkoutDatedt, roomTypeNoInt, memNoInt,
				roomAmountInt, priceInt, paymentMethod, payStatusBool, orderStatus);
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
		// paymentMethod
		String payStatus = req.getParameter("payStatus");
		// orderStatus

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

		byte payStatusbyte = Byte.parseByte(payStatus);
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
		int result = roomOrderService.updateorder(roomOrderNoInt, roomOrderDatedt, checkinDatedt, checkoutDatedt,
				roomTypeNoInt, memNoInt, roomAmountInt, priceInt, paymentMethod, payStatusbyte, orderStatus);

		if (result > 0) {
			System.out.println("更新成功");
		} else {
			System.out.println("更新失敗");
			System.out.println(result);
		}

		resp.setContentType("application/json;charset=UTF-8");
		return "/back-end/roomorder/orderfirst.jsp";
	}
	
	private String checkInData(HttpServletRequest req, HttpServletResponse resp) {
	    RoomNumServiceImpl roomnumSvc = new RoomNumServiceImpl();
	    //★★★★★★getParameterMap()是無法跨網頁存取資料，但透過new HashMap(req.getParameterMap())將原廠無法跨網頁存取的保護洗掉
	    Map<String, String[]> map1 = new HashMap(req.getParameterMap());  
	    HttpSession session = req.getSession();
	    session.setAttribute("CheckInDataMap1", map1);
	   
	    //storeMapInRedis("CheckInDataMap1", map1);   
	    if (map1 != null) {     
	    	//來自於selectCheckInData的from表單送出的查詢修件來查詢要checkIn的訂單資料,查詢後送到listCheckIndata.jsp顯示
	        List<RoomOrderDTO> checkInData = roomOrderService.findByCheckInDate(map1);
	  
	        //取得房間的間數傳到listCheckInData.jsp的下拉選單
	        List<RoomNumVO> getAll = roomnumSvc.getAllRoomNums();
	       
	        req.setAttribute("checkInData", checkInData);
	        req.setAttribute("getAll", getAll);
	    } else {
	        return "/selectCheckInData.jsp";
	    }
	    return "/back-end/roomnum/listAllCheckInData.jsp";
	}

	private String handleCheckIn(HttpServletRequest req, HttpServletResponse resp) {       
	    RoomNumServiceImpl roomnumSvc = new RoomNumServiceImpl();
	    HttpSession session = req.getSession();
	    //來自RoomOrderServlet.java 205行的checkInData()裡面的210行的session.setAttribute("CheckInDataMap1", map1);
	    Map<String, String[]> map1 = (Map<String, String[]>) session.getAttribute("CheckInDataMap1");
	         
	    if (map1 != null) {
	        List<RoomOrderDTO> checkInData = roomOrderService.findByCheckInDate(map1);	     
	        List<RoomNumVO> getAll = roomnumSvc.getAllRoomNums(); 
	        req.setAttribute("checkInData", checkInData);
	        req.setAttribute("getAll", getAll);
	    } else {
	        return "/selectCheckInData.jsp";
	    }
	    System.out.println("=== handleCheckIn - Redirected Successfully ===");
	    return "/back-end/roomnum/listAllCheckInData.jsp";
	}
}