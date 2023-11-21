package com.paradisiac.roomcalendar.service;

import static com.paradisiac.util.Constants.PAGE_MAX_RESULT;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.paradisiac.roomcalendar.model.RoomCalendarVO;
import com.paradisiac.roomcalendar.model.RoomCalendarDAO;
import com.paradisiac.roomcalendar.model.RoomCalendarDAOImpl;
import com.paradisiac.roomcalendar.model.CalAllDTO;
import com.paradisiac.util.HibernateUtil;

public class RoomCalendarServiceImpl implements RoomCalendarService
{
	private RoomCalendarDAO dao;
	
	
	public RoomCalendarServiceImpl() {
		dao = new RoomCalendarDAOImpl(HibernateUtil.getSessionFactory());
	}


	@Override
	public int addUpdate(Integer roomTypenoInt, Date cDate, Integer roomTotalInt, Integer roomBookingInt,boolean available) {
		RoomCalendarVO cal = new RoomCalendarVO();
		cal.setRoomTypeno(roomTypenoInt);
		cal.setcDate(cDate);
		cal.setRoomTotal(roomTotalInt);
		cal.setRoomBooking(roomBookingInt);
		cal.setAvailable(available);
		return dao.insert(cal);
	}	
	
	@Override
	public int Update(Integer calendarNo,Integer roomTypenoInt, Date cDate, Integer roomTotalInt, Integer roomBookingInt,boolean available) {
		RoomCalendarVO cal = new RoomCalendarVO();
		cal.setCalendarNo(calendarNo);
		cal.setRoomTypeno(roomTypenoInt);
		cal.setcDate(cDate);
		cal.setRoomTotal(roomTotalInt);
		cal.setRoomBooking(roomBookingInt);
		cal.setAvailable(available);
		return dao.update(cal);
	}	
	@Override
	public String getCalAllDTOs() {
		System.out.println("Service:call DAO.getCalAllDTOs -->ready");
		return dao.getAll();
		
	}

	@Override
	public String getCalSingleDTOs(int roomTypeno) {
		System.out.println("Service:call DAO.getCalSingleDTOs -->ready");
		return dao.getSingleForType(roomTypeno);
	}

	@Override
	public String getCalSingleDTOsForDay(String day) {
		System.out.println("Service:call DAO.getCalSingleDTOsForDay -->ready");
		return dao.getSingleForDay(day);
	}


	@Override
	public RoomCalendarVO findBycalNo(Integer calendarNo) {
		
		return dao.findBycalNo(calendarNo);
	}

	@Override
	public List<RoomCalendarVO> findByDate(Date targetDate, Integer roomTypenoInt) {
		return dao.findByDate(targetDate,roomTypenoInt);
	}
	@Override
	public List<RoomCalendarVO> getOne() {
		return dao.getOne();
	}


}
