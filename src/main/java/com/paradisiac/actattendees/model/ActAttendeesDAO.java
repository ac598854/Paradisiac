package com.paradisiac.actattendees.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class ActAttendeesDAO implements ActAttendees_interface {
	private SessionFactory factory;

	public ActAttendeesDAO(SessionFactory factory) {
		this.factory = factory;
	}

	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override
	public int insert(ActAttendees actAttendees) {
		// TODO Auto-generated method stub
		return (int) getSession().save(actAttendees);
	}

	@Override
	public int update(ActAttendees actAttendees) {
		// TODO Auto-generated method stub
		getSession().update(actAttendees);
		try {
			return 1;// 是否為1更新成功
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public ActAttendees getOneByAtnNo(Integer atnNo) {
		// TODO Auto-generated method stub
		return getSession().get(ActAttendees.class, atnNo);// 回傳該類的PK
	}

	@Override
	public List<ActAttendees> getAll() {
		// TODO Auto-generated method stub
		return getSession().createQuery("from ActAttendees", ActAttendees.class).list();
		// "from ActAttendees"為HQL，抓VO(視為一個物件)，自動轉型

//		getSession().createNativeQuery("FROM ActAttendees").addEntity(xx.class).list();//等同41行
//		getSession().createSQLQuery("select * FROM ActAttendees").addEntity(xx.class).list();//等同41行 
	}

}
