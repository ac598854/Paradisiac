package com.paradisiac.roomcalendar.model;

import static com.paradisiac.util.Constants.PAGE_MAX_RESULT;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.lang.reflect.Type;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.json.JSONArray;
import org.json.JSONObject;

import com.paradisiac.roomcalendar.model.CalAllDTO;
import com.paradisiac.util.HibernateUtil;

import redis.clients.jedis.Jedis;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
		Gson gson = new Gson();
		jsonStr = gson.toJson(list);
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
			// 例如，您可以訪問對象的屬性並進行相應的操作
			CalAll.put("vdate", dto.getVdata());
			CalAll.put("tRoom", dto.getlRoom());
			CalAll.put("bRoom", dto.getbRoom());
			CalAll.put("lRoom", dto.getlRoom());
			CalAll.put("aStatus", dto.getaStatus());
			jsonArray.put(CalAll);
			//System.out.println(CalAll);

			jsonStr = jsonArray.toString(); // 把array轉成字串
			//System.out.print(jsonStr);
			Jedis jedis = new Jedis("localhost", 6379);
			jedis.select(3); // 選擇第3個DB
			jedis.set("CalAll", jsonStr);
			jedis.close(); // Close the connection

		}
		return jsonStr;
	}

	
}
