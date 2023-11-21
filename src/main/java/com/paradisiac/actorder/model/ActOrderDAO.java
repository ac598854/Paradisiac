package com.paradisiac.actorder.model;


import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.paradisiac.schd.model.SchdVO;


public class ActOrderDAO implements ActOrder_interface{
	
	private SessionFactory factory;
	
	public ActOrderDAO(SessionFactory factory) {
		this.factory = factory;
	}
	
	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override
	public int inert(ActOrder actOrder) {
	
		return (int) getSession().save(actOrder);
	}

	@Override
	public int update(ActOrder actOrder) {
		
		getSession().update(actOrder);
		try {
			return 1;				
		}catch(Exception e) {
			e.printStackTrace();
			return 0;	
		}	
	}
		

	@Override
	public ActOrder getOneByActOrderNo(Integer actOrderNo) {
		return getSession().get(ActOrder.class, actOrderNo);
	}

	@Override
	public List<ActOrder> getAll() {
		return getSession().createQuery("from ActOrder",ActOrder.class).list();
	}

	@Override
	public int modifyStatus(SchdVO schdVO, Integer orderStatus) {
		String hql="update ActOrder set orderStatus=:orderStatus Where schdVO=:schdVO";
		Query query = getSession().createQuery(hql);//hql語法
		
		query.setParameter("orderStatus", orderStatus);
		query.setParameter("schdVO", schdVO);
		int result = query.executeUpdate();
		
		return result;
	}



	
}
