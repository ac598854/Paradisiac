package com.paradisiac.cart;

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

@WebServlet("/Carta")
public class Cart extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		HttpSession session = request.getSession();
		
		Object memnoObject = session.getAttribute("memno");// 什麼都可以存所以是object
		String memno = (String)memnoObject;
		
		String cartDataString = (String) session.getAttribute("cart");;
		
		String action = request.getParameter("action");
// ==========是會員從redis內取得並且要取得session內的資料加在一起並且送出去=================================
		if (memno == null) {//是會員
			if(cartDataString != null) {//session內有資料
				if ("shoppingCart".equals(action) || "loadCart".equals(action)) {
					
					Jedis jedis = new Jedis("localhost", 6379);
					String redisData = jedis.get("guest1");// 之後改成memno
					
					JSONObject redisDataJSON = new JSONObject(redisData);
					int redisquantity = 0;
					Object redisObject = null;
					
					JSONObject sessionData = new JSONObject(cartDataString);
					int sessionquantity = 0;
					Object productObject = null;
					
					for (String key : sessionData.keySet()) {
					    productObject = sessionData.getJSONObject(key);
					    sessionquantity = ((JSONObject) productObject).getInt("quantity");
//					    System.out.println(key + " sessionQuantity: " + sessionquantity);

					    if (redisDataJSON.has(key)) {
					        redisObject = redisDataJSON.getJSONObject(key);
					        redisquantity = ((JSONObject) redisObject).getInt("quantity");
//					        System.out.println(key + " redisQuantity: " + redisquantity);
					        int total =  sessionquantity + redisquantity;
					        ((JSONObject) redisObject).put("quantity", total);
					        System.out.println("更新後redis內數量:"+redisObject);
					    }
					    else {    //redis沒有該商品
					    	((JSONObject) redisObject).put("quantity",sessionquantity);
					    	redisDataJSON.put(key, redisObject);
					    	System.out.println(sessionquantity);
					    	System.out.println("redis內沒有該商品session有最後redis內的商品:"+redisObject);
					    }
					}
					
					jedis.set("guest1", redisDataJSON.toString());
//					session.removeAttribute("cart");
					
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					//讓伺服器不要快取
//					response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
//					response.setHeader("Expires", "0");
					response.getWriter().write(redisDataJSON.toString());
					jedis.close();
				}
			}
		}
// ==========不是會員從session內取得=================================
		if (memno != null) {
			if ("shoppingCart".equals(action)  || "loadCart".equals(action)) {
//				Object cartObject = session.getAttribute("cart");// 沒有的話會是空值
				if (cartDataString != null) {
					JSONObject cart = new JSONObject (cartDataString);
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
		// 取得json內的資料有action跟data
		String action = jsonData.getString("action");
		String data = jsonData.getString("cartData");// 購物車資訊
		JSONObject jsonObject = new JSONObject(data);
		
		// 取得session內的會員資料
		HttpSession session = request.getSession();
		String memno = (String) session.getAttribute("memno");// session什麼都可以存所以是object

		if (memno == null) {
			if ("checkout".equals(action)) {

				// 解析请求体中的 JSON 数据
				String jsonData2 = jsonObject.toString();// 可以存json但必須得是字串
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
		if(memno != null) {
			if ("checkout".equals(action)) {
					session.setAttribute("cart",data);
					System.out.println(data);
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					JSONObject addResponse = new JSONObject();
					addResponse.put("add", "已加入購物車");
					response.getWriter().write(addResponse.toString());
				}
			}
		}
	}


