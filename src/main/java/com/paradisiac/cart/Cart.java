package com.paradisiac.cart;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import redis.clients.jedis.Jedis;

@WebServlet("/Cart")
public class Cart extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String action = request.getParameter("action");

		if ("shoppingCart".equals(action)) {
			Jedis jedis = new Jedis("localhost", 6379);
			String items = jedis.get("guest1");
			JSONObject cartData = new JSONObject(items);
			
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(cartData.toString());

			jedis.close();
		}
	}
	
//	public static void main(String[] args) {
//		Jedis jedis = new Jedis("localhost", 6379);
//		String items = jedis.get("guest1");
//		JSONObject cartData = new JSONObject(items);
//		System.out.println(cartData.toString());
//	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		StringBuilder stringBuilder = new StringBuilder();
		BufferedReader bufferedReader = request.getReader();
		String line;
		while ((line = bufferedReader.readLine()) != null) {
			stringBuilder.append(line);
		}
		JSONObject jsonData = new JSONObject(stringBuilder.toString());

		String action = jsonData.getString("action");
		JSONObject data = jsonData.getJSONObject("data");
		if ("checkout".equals(action)) {
		

		// 解析请求体中的 JSON 数据
		String jsonData2 = data.toString();
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.set("guest1", jsonData2);
		jedis.close();

		// 返回响应（例如，可以返回处理结果的 JSON 响应）
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write("{\"message\": \"Checkout successful\"}");
	}
	}
}
