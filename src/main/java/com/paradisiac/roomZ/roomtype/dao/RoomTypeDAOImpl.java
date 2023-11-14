package com.paradisiac.roomZ.roomtype.dao;

import static com.paradisiac.util.Constants.PAGE_MAX_RESULT;


import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.paradisiac.roomZ.roomtype.entity.RoomTypeeVO;

public class RoomTypeDAOImpl implements RoomTypeDAO {
	private SessionFactory factory;
	
	public RoomTypeDAOImpl(SessionFactory factory) {
		this.factory = factory;
	}
	
	private Session getSession() {
		return factory.getCurrentSession();
	}
	

	@Override
	public int insert(RoomTypeeVO roomTypeVO) {
		return (Integer) getSession().save(roomTypeVO);
	}

	@Override
	public int update(RoomTypeeVO roomTypeVO) {
		try {
			getSession().update(roomTypeVO);
			return 1;
		} catch (Exception e) {
			return -1;
		}
	}


	@Override
	public RoomTypeeVO findByFaqNo(Integer roomTypeNo) {
		return getSession().get(RoomTypeeVO.class, roomTypeNo);
	}

	@Override
	public List<RoomTypeeVO> getAll() {
		return getSession().createQuery("FROM RoomTypeeVO", RoomTypeeVO.class).list();

//	    Session session = getSession();
//	    Transaction transaction = session.beginTransaction();
//	    List<RoomTypeVO> resultList = session.createQuery("FROM RoomTypeVO", RoomTypeVO.class).list();
//	    transaction.commit();
//	    return resultList;
	}
	
	@Override
	public List<RoomTypeeVO> getOne() {
		return getSession().createQuery("FROM RoomTypeeVO WHERE rtype = '單人房' ", RoomTypeeVO.class).list();

	}
	
	@Override
	public List<RoomTypeeVO> getTwo() {
		return getSession().createQuery("FROM RoomTypeeVO WHERE rtype = '二人房' ", RoomTypeeVO.class).list();

	}
	
	@Override
	public List<RoomTypeeVO> getFour() {
		return getSession().createQuery("FROM RoomTypeeVO WHERE rtype = '四人房' ", RoomTypeeVO.class).list();

	}
	
	@Override
	public List<RoomTypeeVO> getEight() {
		return getSession().createQuery("FROM RoomTypeVO WHERE rtype = '八人房' ", RoomTypeeVO.class).list();

	}
	@Override
	public long getTotal() {
		return getSession().createQuery("select count(*) from RoomTypeVO", Long.class).uniqueResult();
	}




}
