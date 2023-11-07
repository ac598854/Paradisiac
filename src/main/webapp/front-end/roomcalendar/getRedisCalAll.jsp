<%@page contentType="text/html;charset=utf-8"  language="java" import="java.sql.*" errorPage="" pageEncoding="UTF-8"%>

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
	        // 從 Redis 中取得資料庫（CalAll）中的資料
	        String jsonData = jedis.get("CalAll");

	        // 將 JSON 數據解析為 Java 對象或數組
	        JSONArray jsonArray = new JSONArray(jsonData);
			
	        // 將數據轉換為要返回給前端的格式
	        JSONArray result = new JSONArray();
	        for (int i = 0; i < jsonArray.length(); i++) {
	            JSONObject item = jsonArray.getJSONObject(i);
	            JSONObject newItem = new JSONObject();
	            newItem.put("vdate", item.getString("vdate"));
	            newItem.put("tRoom", item.getInt("tRoom"));
	            newItem.put("bRoom", item.getInt("bRoom"));
	            newItem.put("lRoom", item.getInt("lRoom"));
	            newItem.put("aStatus", item.getString("aStatus"));
	            result.put(newItem);	            
	        }
			
	out.print(result); // 返回 JSON 格式的數據
//--------------------------------------------取得前端送來的資料
	request.setCharacterEncoding("UTF-8");
	//--------------------------------------------回應訊息

%>   


