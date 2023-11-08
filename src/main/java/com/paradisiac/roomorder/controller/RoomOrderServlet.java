package com.paradisiac.roomorder.controller;

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
import com.paradisiac.roomnum.model.RoomNumVO;
import com.paradisiac.roomnum.service.RoomNumServiceImpl;
import com.paradisiac.roomorder.model.RoomOrderDTO;

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

		int result = roomOrderService.updateorder(roomOrderNoInt, roomOrderDatedt, checkinDatedt, checkoutDatedt,
				roomTypeNoInt, memNoInt, roomAmountInt, priceInt, paymentMethod, payStatusBool, orderStatus);

		if (result > 0) {
			System.out.println("更新成功");
		} else {
			System.out.println("更新失敗");
			System.out.println(result);
		}

		resp.setContentType("application/json;charset=UTF-8");
		return "/back-end/roomorder/orderfirst.jsp";
	}
	
	//查詢會員訂房記錄，並傳回list給前端selectChekInData.jsp
	private String checkInData(HttpServletRequest req, HttpServletResponse resp) {
		RoomNumServiceImpl roomnumSvc = new RoomNumServiceImpl();
		Map<String, String[]> map = req.getParameterMap();
		if (map != null) {
			// RoomOrderDTO checkInData = roomOrderService.findByCheckInDate(map); //查詢單筆
			List<RoomOrderDTO> checkInData = roomOrderService.findByCheckInDate(map);
			System.out.println("===============測試================");
			for (RoomOrderDTO roomOrder : checkInData) {
				System.out.println("roomOrderNo: " + roomOrder.getRoomOrderNo());
				System.out.println("roomOrderDate: " + roomOrder.getRoomOrderDate());
				System.out.println("memName: " + roomOrder.getMemName());
				System.out.println("memId: " + roomOrder.getMemId());
				System.out.println("memPhone: " + roomOrder.getMemPhone());
				System.out.println("roomTypeNo: " + roomOrder.getRoomTypeNo());
				System.out.println("roomName: " + roomOrder.getRoomName());
				System.out.println("roomAmount: " + roomOrder.getRoomAmount());
				System.out.println("price: " + roomOrder.getPrice());
				System.out.println("checkInDate: " + roomOrder.getCheckInDate());
				System.out.println("checkOutDate: " + roomOrder.getCheckOutDate());
				System.out.println("orderStatus: " + roomOrder.getOrderStatus());
			}
			System.out.println("===============================");
			List<RoomNumVO> getAll =roomnumSvc.getAllRoomNums();
			req.setAttribute("checkInData", checkInData);
			req.setAttribute("getAll", getAll);
		} else {
			// 若找不到資料則回到搜尋頁面
			return "/selectCheckInData.jsp";
		}
		return "/back-end/roomnum/listAllCheckInData.jsp";
	}

}