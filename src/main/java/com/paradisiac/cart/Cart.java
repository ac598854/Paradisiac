package com.paradisiac.cart;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import redis.clients.jedis.Jedis;

@WebServlet("/Cart")
public class Cart extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		Object memnoObject = session.getAttribute("memno");// 什麼都可以存所以是object
		String memno = (String)memnoObject;
		String action = request.getParameter("action");
		// ==========是會員從redis內取得=================================
		if (memno != null) {
			if ("shoppingCart".equals(action) || "loadCart".equals(action)) {
				Jedis jedis = new Jedis("localhost", 6379);
				String items = jedis.get("guest1");// 之後改成memno
				JSONObject cartData = new JSONObject(items);

				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(cartData.toString());
				jedis.close();
			}
		}
		// ==========不是會員從session內取得=================================
		if (memno == null) {
			if ("shoppingCart".equals(action)  || "loadCart".equals(action)) {
				Object cartObject = session.getAttribute("cart");// 沒有的話會是空值
				if (cartObject != null) {
					JSONObject cart = (JSONObject) cartObject;
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					response.getWriter().write(cart.toString());
				} else {
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					JSONObject errorResponse = new JSONObject();
					errorResponse.put("error", "購物車為空");
					response.getWriter().write(errorResponse.toString());
				}
			}
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 解析post過來的json格式
		StringBuilder stringBuilder = new StringBuilder();
		BufferedReader bufferedReader = request.getReader();
		String line;
		while ((line = bufferedReader.readLine()) != null) {
			stringBuilder.append(line);
		}
		JSONObject jsonData = new JSONObject(stringBuilder.toString());
		// 取得json內的資料
		String action = jsonData.getString("action");
		JSONObject data = jsonData.getJSONObject("data");// 購物車資訊
		// 取得session內的會員資料
		HttpSession session = request.getSession();
		String memno = (String) session.getAttribute("memno");// session什麼都可以存所以是object

		if (memno != null) {
			if ("checkout".equals(action)) {

				// 解析请求体中的 JSON 数据
				String jsonData2 = data.toString();// 可以存json但必須得是字串
				Jedis jedis = new Jedis("localhost", 6379);
				jedis.set("guest1", jsonData2);//改memno
				jedis.close();

				// 返回响应（例如，可以返回处理结果的 JSON 响应）
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				JSONObject addResponse = new JSONObject();
				addResponse.put("add", "已加入購物車");
				response.getWriter().write(addResponse.toString());
			}
		}
		if(memno == null) {
			if ("checkout".equals(action)) {
					session.setAttribute("cart",data);
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					JSONObject addResponse = new JSONObject();
					addResponse.put("add", "已加入購物車");
					response.getWriter().write(addResponse.toString());
				}
			}
		}
	}


