package com.paradisiac.fuc.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class FucDAOImpl implements FucDAO_Interface{
	
	private SessionFactory factory;
	
	public FucDAOImpl(SessionFactory factory) {
		this.factory = factory;
	}
	
	private Session getSession() {
		return factory.getCurrentSession();
	}
	
	@Override
	public FucVO findByPrimaryKey(Integer fucNo) {
		return getSession().get(FucVO.class, fucNo);
	}
	
	
	

	@Override
	public void insert(FucVO fucVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(FucVO fucVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(Integer fucNo) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public List<FucVO> getAll() {
		// TODO Auto-generated method stub
		return null;
	}
	

}
