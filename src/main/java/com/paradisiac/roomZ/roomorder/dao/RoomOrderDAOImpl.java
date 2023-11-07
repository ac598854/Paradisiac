package com.paradisiac.roomZ.roomorder.dao;

import static com.paradisiac.util.Constants.PAGE_MAX_RESULT;


import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.paradisiac.roomZ.roomorder.entity.RoomOrderVO;


public class RoomOrderDAOImpl implements RoomOrderDAO {
	private SessionFactory factory;
	
	public RoomOrderDAOImpl(SessionFactory factory) {
		this.factory = factory;
	}
	
	private Session getSession() {
		return factory.getCurrentSession();
	}
	

	@Override
	public int insert(RoomOrderVO roomOrderVO) {
		return (Integer) getSession().save(roomOrderVO);
	}

	@Override
	public int update(RoomOrderVO roomOrderVO) {
		try {
			getSession().update(roomOrderVO);
			return 1;
		} catch (Exception e) {
			return -1;
		}
	}



	@Override
	public List<RoomOrderVO> getAll() {
		return getSession().createQuery("FROM RoomOrderVO", RoomOrderVO.class).list();

//	    Session session = getSession();
//	    Transaction transaction = session.beginTransaction();
//	    List<RoomTypeVO> resultList = session.createQuery("FROM RoomTypeVO", RoomTypeVO.class).list();
//	    transaction.commit();
//	    return resultList;
	}

	@Override
	public long getTotal() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public RoomOrderVO findByorderNo(Integer roomOrderNo) {
		return getSession().get(RoomOrderVO.class, roomOrderNo);
	}




}
