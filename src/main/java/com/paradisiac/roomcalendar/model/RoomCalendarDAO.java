package com.paradisiac.roomcalendar.model;

import java.sql.Date;
import java.util.*;

import com.paradisiac.roomZ.roomorder.entity.RoomOrderVO;
import com.paradisiac.roomcalendar.model.RoomCalendarVO;


public interface RoomCalendarDAO {
		
	String getAll();
	String getSingleForType(int roomTypeno);
	String getSingleForDay(String day);
	int insert(RoomCalendarVO roomCalendarVO);
	int update(RoomCalendarVO roomCalendarVO);
	RoomCalendarVO findBycalNo(Integer calendarNo);
	List<RoomCalendarVO> getOne();
	List<RoomCalendarVO> findByDate(Date targetDate, Integer roomTypenoInt);
}
