package com.paradisiac.product.controller;

import java.io.BufferedReader;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import redis.clients.jedis.Jedis;

@WebServlet("/Cart")
public class Cart extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		HttpSession session = request.getSession();
		Integer memno = (Integer) session.getAttribute("memno");
		
		String sessionDataString = (String) session.getAttribute("cart");
		
		Object redisObject = null;
		String action = request.getParameter("action");
		// ==========是會員從redis內取得=================================
		if (memno != null) {
			if ("shoppingCart".equals(action) || "loadCart".equals(action)) {
				System.out.println("是會員從redis取");
				Jedis jedis = new Jedis("localhost", 6379);
				String redisDataString = jedis.get("guest2");// 之後改成memno
				JSONObject redisDataJSON = new JSONObject(redisDataString);
				if(sessionDataString != null) {
					JSONObject sessionDataJSON = new JSONObject(sessionDataString);
//					System.out.println("session內有:"+sessionDataJSON);
					for (String key : sessionDataJSON.keySet()) {
					    Object productObject = sessionDataJSON.getJSONObject(key);
					    int sessionquantity = ((JSONObject) productObject).getInt("quantity");
					    	if (redisDataJSON.has(key)) {
					    			redisObject = redisDataJSON.getJSONObject(key);
					    			int redisquantity = ((JSONObject) redisObject).getInt("quantity");
							        int total =  sessionquantity + redisquantity;
							        ((JSONObject) redisObject).put("quantity", total);
							        System.out.println("更新後redis內數量:"+redisObject);
					    	}else {
					    		((JSONObject) redisObject).put("quantity",sessionquantity);
						    	redisDataJSON.put(key, redisObject);
					    	}
					    
					}
				}
				jedis.set("guest2", redisDataJSON.toString());
				session.removeAttribute("cart");
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(redisDataJSON.toString());
				jedis.close();
			}
		}
		// ==========不是會員從session內取得=================================
		if (memno == null) {
			if ("shoppingCart".equals(action)  || "loadCart".equals(action)) {
					System.out.println("不是會員從session取得");
				if (sessionDataString != null) {
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					response.getWriter().write(sessionDataString);
				} else {
					System.out.println("不是會員且session是空的");
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
		System.out.println(stringBuilder);
		// 取得json內的資料
		String action = jsonData.getString("action");
		String data = jsonData.getString("cartData");// 購物車資訊
		
		// 取得session內的會員資料
		HttpSession session = request.getSession();
		Integer memno = (Integer) session.getAttribute("memno");// session什麼都可以存所以是object

		if (memno != null) {
			if ("checkout".equals(action)) {
				System.out.println("是會員存redis");
				// 解析请求体中的 JSON 数据
//				String jsonData2 = jsonObject.toString();// 可以存json但必須得是字串
				Jedis jedis = new Jedis("localhost", 6379);
				jedis.set("guest2", data);//改memno
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
					System.out.println("不是會員存入session");
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


