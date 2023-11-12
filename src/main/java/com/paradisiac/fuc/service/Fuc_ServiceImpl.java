package com.paradisiac.fuc.service;

import com.paradisiac.fuc.model.FucDAOImpl;
import com.paradisiac.fuc.model.FucDAO_Interface;
import com.paradisiac.fuc.model.FucVO;
import com.paradisiac.util.HibernateUtil;

public class Fuc_ServiceImpl implements Fuc_Service{
	private FucDAO_Interface dao;
	
	public Fuc_ServiceImpl() {
		dao = new FucDAOImpl(HibernateUtil.getSessionFactory());
	}
	
	@Override
	public FucVO getFucByFucNo(Integer fucNo) {
		return dao.findByPrimaryKey(fucNo);
	}

}
