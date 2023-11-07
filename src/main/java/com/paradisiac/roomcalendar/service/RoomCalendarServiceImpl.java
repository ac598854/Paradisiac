package com.paradisiac.roomcalendar.service;

import static com.paradisiac.util.Constants.PAGE_MAX_RESULT;

import java.util.List;
import java.util.Map;

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

}
