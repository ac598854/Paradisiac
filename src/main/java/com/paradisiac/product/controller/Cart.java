package com.paradisiac.product.controller;

import java.io.BufferedReader;

import java.io.IOException;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mysql.cj.x.protobuf.MysqlxCrud.Delete;

import redis.clients.jedis.Jedis;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;


@WebServlet("/Cart")
public class Cart extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession();
		Integer memno = (Integer) session.getAttribute("memno");

		String sessionDataString = (String) session.getAttribute("cart");

		Object redisObject = null;
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		// ==========是會員從redis內取得=================================
		if (memno != null) {
			System.out.println("是會員從redis取");
			Jedis jedis = new Jedis("localhost", 6379);
			String redisDataString = jedis.get("guest" + memno);
//			System.out.println(redisDataString);
			if (redisDataString != null  && sessionDataString == null) {
				System.out.println("redis有,session沒有");
			    JSONObject redisDataJSON = new JSONObject(redisDataString);
			    response.getWriter().write(redisDataJSON.toString());
			    jedis.close();
				return;
			}
			if(redisDataString == null && sessionDataString == null) {
				System.out.println("redis沒有,session沒有");
				JSONObject emptyCartJSON = new JSONObject();
				response.getWriter().write(emptyCartJSON.toString());
				jedis.close();
				return;
			}
			if(redisDataString == null && sessionDataString != null) {
				System.out.println("redis沒有,session有");
				JSONObject sessionDataJSON = new JSONObject(sessionDataString);
				jedis.set("guest" + memno, sessionDataJSON.toString());
				session.removeAttribute("cart");
				response.getWriter().write(sessionDataJSON.toString());
				
				jedis.close();
				return;
			}

			if (redisDataString != null) {
				JSONObject redisDataJSON = new JSONObject(redisDataString);//必須要不是空值的地方才可以轉
				if (sessionDataString != null) {
					JSONObject sessionDataJSON = new JSONObject(sessionDataString);
					System.out.println("session內有,redis也有");
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
		// ==========不是會員從session內取得=================================
		if (memno == null) {
				System.out.println("不是會員從session取得");
				if (sessionDataString != null) {
					response.getWriter().write(sessionDataString);
				} else {
					System.out.println("不是會員且session是空的");
					JSONObject errorResponse = new JSONObject();
					errorResponse.put("error", "購物車為空");
					response.getWriter().write(errorResponse.toString());
				}
		}
		return;
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
		System.out.println("post進來的數據:"+stringBuilder);
		// 取得json內的資料
		String action = jsonData.getString("action");
		String data = jsonData.getString("cartData");// 購物車資訊

		// 取得session內的會員資料
		HttpSession session = request.getSession();
		Integer memno = (Integer) session.getAttribute("memno");// session什麼都可以存所以是object
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		if (memno != null) {
			if ("checkout".equals(action)) {
				System.out.println("是會員存redis");
				Jedis jedis = new Jedis("localhost", 6379);
				jedis.set("guest" + memno, data);// 改memno

				// 返回响应（例如，可以返回处理结果的 JSON 响应）
				JSONObject addResponse = new JSONObject();
				addResponse.put("add", "已加入購物車");
				response.getWriter().write(addResponse.toString());
				jedis.close();
			}
			if ("delete".equals(action)) {
				delete("guest" + memno, data);
				JSONObject deleteResponse = new JSONObject();
				deleteResponse.put("delete", "已刪除商品");
				response.getWriter().write(deleteResponse.toString());
			}
			if("deleteAll".equals(action)) {
				Jedis jedis = new Jedis("localhost", 6379);
				jedis.del("guest" + memno);
				jedis.close();
			}
			if("changeQuantity".equals(action)) {
				changeQuantity("guest" + memno, data);
				JSONObject changeResponse = new JSONObject();
				changeResponse.put("change", "已更改商品數量");
				response.getWriter().write(changeResponse.toString());
			}
		}

		if (memno == null) {
			if ("checkout".equals(action)) {
				System.out.println("不是會員存入session");
				session.setAttribute("cart", data);
				JSONObject addResponse = new JSONObject();
				addResponse.put("add", "已加入購物車");
				response.getWriter().write(addResponse.toString());
			}
		}
	}

	
	
	
	public void delete(String guest, String data) {
		Jedis jedis = new Jedis("localhost", 6379);
		String jsonString = jedis.get(guest);
		Gson gson = new Gson();
		Map<String, Product> redisdata = gson.fromJson(jsonString, new TypeToken<Map<String, Product>>(){}.getType());
		//TypeToken 來指定泛型型別，確保 JSON 資料正確轉換為 Map<String, Product>	

		JSONObject jsonObject = new JSONObject(data);
        String productName = jsonObject.getString("productName");
		
        redisdata.remove(productName);
		
		// 將修改後的 Map 轉換回 JSON 字串
		String updatedJsonString = gson.toJson(redisdata);
		System.out.println(updatedJsonString);
		// 將更新後的 JSON 字串設置回 Redis
		jedis.set(guest, updatedJsonString);
		jedis.close();
	}
	
	public void changeQuantity(String guest, String productData) {
		Jedis jedis = new Jedis("localhost", 6379);
		Gson gson = new Gson();
		String jsonString = jedis.get(guest);
		Map<String, Product> radisdata = gson.fromJson(jsonString, new TypeToken<Map<String, Product>>(){}.getType());
		
		
		
		JSONObject productDataJson = new JSONObject(productData);
		String productName = productDataJson.getString("productName");
		Integer productQuantity =productDataJson.getInt("quantity");
		
	    
	    Product redisProduct = radisdata.get(productName);
	    redisProduct.setQuantity(productQuantity);
	    System.out.println(redisProduct);

		// 將修改後的 Map 轉換回 JSON 字串
		String updatedJsonString = gson.toJson(radisdata);
		System.out.println(updatedJsonString);

		// 將更新後的 JSON 字串設置回 Redis
		jedis.set(guest, updatedJsonString);
		jedis.close();
	}

	class Product {
	    private Integer productId;
	    private Integer price;
	    private Integer quantity;
	    private String 	description;
	    private Integer stock;
	    
		@Override
		public String toString() {
			return "Product [productId=" + productId + ", price=" + price + ", quantity=" + quantity + ", description="
					+ description + ", stock=" + stock + "]";
		}
		public Integer getproductId() {
			return productId;
		}
		public void setId(Integer productId) {
			this.productId = productId;
		}
		public Integer getPrice() {
			return price;
		}
		public void setPrice(Integer price) {
			this.price = price;
		}
		public Integer getQuantity() {
			return quantity;
		}
		public void setQuantity(Integer quantity) {
			this.quantity = quantity;
		}
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
		public Integer getStock() {
			return stock;
		}
		public void setStock(Integer stock) {
			this.stock = stock;
		}

	  

	}
}
