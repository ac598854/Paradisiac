package com.paradisiac.roomcalendar.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.paradisiac.roomcalendar.model.CalAllDTO;
import com.paradisiac.roomcalendar.model.RoomCalendarVO;

public interface RoomCalendarService {
	String getCalAllDTOs();	
	String getCalSingleDTOs(int roomTypeno);	
	String getCalSingleDTOsForDay(String day);
	int addUpdate(Integer roomTypenoInt,Date cDate,Integer roomTotalInt,Integer roomBookingInt,boolean available);
	int Update(Integer calendarNo,Integer roomTypenoInt,Date cDate,Integer roomTotalInt,Integer roomBookingInt,boolean available);
	RoomCalendarVO findBycalNo(Integer calendarNo);
	List<RoomCalendarVO> getOne();
	List<RoomCalendarVO> findByDate(Date targetDate, Integer roomTypenoInt);
}
