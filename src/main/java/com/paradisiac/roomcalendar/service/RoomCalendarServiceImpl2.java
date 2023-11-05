package com.paradisiac.roomcalendar.service;

import java.util.List;

import org.hibernate.Session;

import com.paradisiac.roomcalendar.model.CalAllDTO;
import com.paradisiac.roomcalendar.model.RoomCalendarDAO;
import com.paradisiac.util.HibernateUtil;

public class RoomCalendarServiceImpl2 implements RoomCalendarService{
	private RoomCalendarDAO dao;

	@Override
	public String getCalAllDTOs() {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		String jsonStr="";
		try {
			session.beginTransaction();
			jsonStr = dao.getAll();
			session.getTransaction().commit();
			
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();			
		}
		return jsonStr;
	}

	@Override
	public String getCalSingleDTOs(int roomTypeno) {		
		return dao.getSingleForType(roomTypeno);
	}

	@Override
	public String getCalSingleDTOsForDay(String day) {
		// TODO Auto-generated method stub
		return null;
	}
}
