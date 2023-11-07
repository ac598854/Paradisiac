package com.paradisiac.roomorder.dao;

import static com.paradisiac.util.Constants.PAGE_MAX_RESULT;


import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.paradisiac.roomorder.entity.roomOrderVO;

public class RoomOrderDAOImpl implements RoomOrderDAO {
	private SessionFactory factory;
	
	public RoomOrderDAOImpl(SessionFactory factory) {
		this.factory = factory;
	}
	
	private Session getSession() {
		return factory.getCurrentSession();
	}



	@Override
	public List<roomOrderVO> getAll() {
//		return getSession().createQuery("FROM roomOrderVO", roomOrderVO.class).list();
		
	    Session session = getSession();
	    Transaction transaction = session.beginTransaction();
	    List<roomOrderVO> resultList = session.createQuery("FROM roomOrderVO", roomOrderVO.class).list();
	    transaction.commit();
	    return resultList;
	}
	


	@Override
	public long getTotal() {
		return getSession().createQuery("select count(*) from roomOrderVO", Long.class).uniqueResult();
	}
}
