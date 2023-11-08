package com.paradisiac.roomcalendar.controller;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import com.paradisiac.roomcalendar.service.RoomCalendarService;
import com.paradisiac.roomcalendar.service.RoomCalendarServiceImpl;
import com.paradisiac.roomcalendar.service.*;
@WebServlet("/roominfo.do/*")
public class getCalendarInfoServlet extends HttpServlet {
	// 一個 servlet 實體對應一個 service 實體
	private RoomCalendarService rcservice;

	@Override
	public void init() throws ServletException {
		rcservice = new RoomCalendarServiceImpl();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8"); // <---★★★★★★Servlet P58一下要在out之前否則會變成西歐語系★★★★★★
		
		//取得路徑資訊fetch('/cha103g2/roominfo.do/firstGet'
		String pathInfo = request.getPathInfo();
		
		System.out.println("Request pathInfo: " + pathInfo);
		//cal.jsp在點選行曆日期後取得每日房型資訊
		if (pathInfo.equals("/firstGet")) {
			StringBuilder buffer = new StringBuilder();
			String roomTypeInfojsonStr ="";
			
			//讀取前端資料body: JSON.stringify(data)由request.getReader()逐一讀取
			BufferedReader reader = request.getReader();
			String line;
			while ((line = reader.readLine()) != null) {
				buffer.append(line);
			}			
			String data = buffer.toString();			
			
			// 解析 JSON 數據
			JSONObject jsonObject = new JSONObject(data);
			String selectDay = jsonObject.getString("selectDay");
			System.out.println("接收前端資料："+selectDay);
//			String age = jsonObject.getString("age");
			// 後端控制台輸出結果
			
			roomTypeInfojsonStr = rcservice.getCalSingleDTOsForDay(selectDay);
			// 將資料回傳給前端網頁
			//System.out.println("first data: "+roomTypeInfojsonStr );
			response.getWriter().write(roomTypeInfojsonStr);
		//第2個Get
		}else if (pathInfo.equals("/Second")) {
			StringBuilder buffer = new StringBuilder();
			BufferedReader reader = request.getReader();
			String line;
			while ((line = reader.readLine()) != null) {
				buffer.append(line);
			}
			String data = buffer.toString();

			// 解析 JSON 數據
			JSONObject jsonObject = new JSONObject(data);
			String name = jsonObject.getString("name");
			String age = jsonObject.getString("age");

			System.out.println("Second data: " + name + ", " + age);

			// 將資料回傳給前端網頁
			response.getWriter().write("Second data: " + name + ", " + age);

		} else { // 若沒有匹配的URL，返回錯誤
			 response.sendError(HttpServletResponse.SC_NOT_FOUND); }		

	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
		System.out.println("doGet:=======");
	}
}
