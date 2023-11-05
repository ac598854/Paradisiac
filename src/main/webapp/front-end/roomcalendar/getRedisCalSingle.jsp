<%@page contentType="text/html;charset=utf-8"  language="java" import="java.sql.*" errorPage=""%>
<%@page import="java.io.BufferedReader" %>
<%@page import="java.io.InputStreamReader" %>
<%@page import="java.io.IOException" %>
<%@page import="org.json.JSONObject"%>
<%@page import="redis.clients.jedis.Jedis"%>
<%@page import="org.json.JSONArray"%>
<%
//--------------------------------------------Redis連線資訊
 Jedis jedis = new Jedis("localhost", 6379);
		 jedis.select(3);   //選擇第2個DB
	        // 從 Redis 中獲取存儲的數據
	        String jsonData = jedis.get("CalSingle");

	        // 將 JSON 數據解析為 Java 對象或數組
	        JSONArray jsonArray = new JSONArray(jsonData);
			
	        // 將數據轉換為要返回給前端的格式
	        JSONArray result = new JSONArray();
	        for (int i = 0; i < jsonArray.length(); i++) {
	            JSONObject item = jsonArray.getJSONObject(i);
	            JSONObject newItem = new JSONObject();
	            newItem.put("roomTypeNo", item.getInt("roomTypeNo"));                  //房型編號
	            newItem.put("vDate", item.getString("vDate"));                         //日期
	            newItem.put("roomName", item.getString("roomName"));                  //房間名稱
	            newItem.put("rType", item.getString("rType"));                         //幾人房
	            newItem.put("roomTotal", item.getInt("roomTotal"));                   //房間總數
	            newItem.put("price", item.getInt("price"));                           //原價錢
	            newItem.put("normalPrice", item.getInt("normalPrice"));               //平日價錢
	            newItem.put("holiDayPrice", item.getInt("holiDayPrice"));             //假日價錢
	            newItem.put("bridgeHolidayPrice", item.getInt("bridgeHolidayPrice"));
	            newItem.put("notice", item.getString("notice"));
	            newItem.put("facility", item.getString("facility"));
	            newItem.put("rTypeStatus", item.getInt("rTypeStatus"));
	            newItem.put("aStatus", item.getString("aStatus"));
	            result.put(newItem);	 
	        }
			
	out.print(result); // 返回 JSON 格式的數據
//--------------------------------------------取得前端送來的資料
	request.setCharacterEncoding("UTF-8");
	//--------------------------------------------回應訊息

%>   


