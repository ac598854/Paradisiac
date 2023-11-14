package com.paradisiac.product.controller;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import redis.clients.jedis.Jedis;

public class CartTest {
	public class Cart extends HttpServlet {

		private static final long serialVersionUID = 1L;

		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
			HttpSession session = request.getSession();
			Integer memno = (Integer) session.getAttribute("memno");

			String sessionDataString = (String) session.getAttribute("cart");

			Object redisObject = null;
			String action = request.getParameter("action");

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			if (memno != null) {
					System.out.println("是會員從redis取");
					Jedis jedis = new Jedis("localhost", 6379);
					String redisDataString = jedis.get("guest" + memno);
//					System.out.println(redisDataString);
					if (redisDataString != null  && sessionDataString == null) {
					    JSONObject redisDataJSON = new JSONObject(redisDataString);
					    response.getWriter().write(redisDataJSON.toString());
					    jedis.close();
						return;
					}
					if(redisDataString == null && sessionDataString == null) {
						JSONObject emptyCartJSON = new JSONObject();
						response.getWriter().write(emptyCartJSON.toString());
						jedis.close();
						return;
					}
					if(redisDataString == null && sessionDataString != null) {
						JSONObject sessionDataJSON = new JSONObject(sessionDataString);
						jedis.set("guest" + memno, sessionDataJSON.toString());
						jedis.close();
						return;
					}

					if (redisDataString != null) {
						JSONObject redisDataJSON = new JSONObject(redisDataString);//必須要不是空值的地方才可以轉
						if (sessionDataString != null) {
							JSONObject sessionDataJSON = new JSONObject(sessionDataString);
//							System.out.println("session內有:"+sessionDataJSON);
							for (String key : sessionDataJSON.keySet()) {
								Object productObject = sessionDataJSON.getJSONObject(key);
								int sessionquantity = ((JSONObject) productObject).getInt("quantity");
								if (redisDataJSON.has(key)) {
									redisObject = redisDataJSON.getJSONObject(key);
									int redisquantity = ((JSONObject) redisObject).getInt("quantity");
									int total = sessionquantity + redisquantity;
									((JSONObject) redisObject).put("quantity", total);
									System.out.println("更新後redis內數量:" + redisObject);
								} else {
									((JSONObject) productObject).put("quantity", sessionquantity);
									redisDataJSON.put(key, redisObject);
								}
							}
						}
						jedis.set("guest" + memno, redisDataJSON.toString());
						session.removeAttribute("cart");
						response.getWriter().write(redisDataJSON.toString());
						jedis.close();
					}
				}
		}
	}
}
