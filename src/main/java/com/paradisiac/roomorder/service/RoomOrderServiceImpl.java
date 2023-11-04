package com.paradisiac.roomorder.service;


import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.paradisiac.roomorder.dao.RoomOrderDAO;
import com.paradisiac.roomorder.dao.RoomOrderDAOImpl;
import com.paradisiac.roomorder.entity.roomOrderVO;
import com.paradisiac.util.HibernateUtil;

public class RoomOrderServiceImpl implements RoomOrderService{
	private RoomOrderDAO dao;

	
	public RoomOrderServiceImpl() {
		dao = new RoomOrderDAOImpl(HibernateUtil.getSessionFactory());
	}
	
	@Override
	public List<roomOrderVO> getAllOrd() {
		
		 return dao.getAll();
	}
	
	
}
