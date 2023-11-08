package com.paradisiac.roomcalendar.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import redis.clients.jedis.Jedis;
public class RoomCalendarDAOImpl implements RoomCalendarDAO {

	//SessionFactory物件，用於取得與資料庫的連線Session。
	private SessionFactory factory;

	// factory 用於建立與資料庫的連線的SessionFactory物件
	public RoomCalendarDAOImpl(SessionFactory factory) {
		this.factory = factory;
	}

	// 取得與當前資料庫的連線Session。
	private Session getSession() {
		return factory.getCurrentSession();
	}
	//查出單一房型每日資料
	public String getSingleForType(int roomTypeno) {
		System.out.println("CalSingleDAO:getSingle()-->ready");
		String jsonStr = "";
		List<CalSingleDTO> list = getSession()
			    .createQuery("from CalSingleDTO c where c.roomTypeNo = :roomTypeNo", CalSingleDTO.class)
			    .setParameter("roomTypeNo", roomTypeno)
			    .list();
		Gson gson = new Gson();
		jsonStr = gson.toJson(list);
		return jsonStr;
	}
	//查出每日所有房型資料
	@Override
	public String getSingleForDay(String day) {
		System.out.println("CalSingleDAO:getSingleForDay("+day+")-->ready");
		String jsonStr = "";	
		List<CalSingleDTO> list = getSession()
			    .createQuery("from CalSingleDTO c where vDate = :vDate", CalSingleDTO.class)
			    .setParameter("vDate", java.sql.Date.valueOf(day))
			    .list();
		//Gson可以指定日期格式
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		jsonStr = gson.toJson(list);
		System.out.println("================getDB:"+jsonStr);
		return jsonStr;
	}
	@Override
	public String getAll() {
		
		System.out.println("DAO:getAll()-->ready");
		Session session = getSession();
		Transaction tx = null;
		String jsonStr = "";
	//	tx = session.beginTransaction();
		//因為已將資料庫
		List<CalAllDTO> list = getSession().createQuery("from CalAllDTO", CalAllDTO.class).list(); // 使用view產生新的查詢資料表，再透過view的資料表去建立CalenderDTO
	//	tx.commit();
		JSONArray jsonArray = new JSONArray();
		for (CalAllDTO dto : list) {
			JSONObject CalAll = new JSONObject();
			// 處理CalenderDTO對象的數據			
			CalAll.put("vdate", dto.getVdata());
			CalAll.put("tRoom", dto.getlRoom());
			CalAll.put("bRoom", dto.getbRoom());
			CalAll.put("lRoom", dto.getlRoom());
			CalAll.put("aStatus", dto.getaStatus());
			jsonArray.put(CalAll);
			//System.out.println(CalAll);

			jsonStr = jsonArray.toString(); // 把JsonArray轉成字串
			//System.out.print(jsonStr);
			Jedis jedis = new Jedis("localhost", 6379);
			jedis.select(3); // 選擇第3個DB
			jedis.set("CalAll", jsonStr);
			jedis.close(); // Close the connection

		}
		return jsonStr;
	}

	
}
