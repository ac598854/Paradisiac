package com.paradisiac.promotionlist.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class ProductJDBCDAO implements ProductDAO_interface{
	
	
	private SessionFactory factory;

	public ProductJDBCDAO(SessionFactory factory) {
		this.factory = factory;
	}
	
	// Session 為 not thread-safe，所以此方法在各個增刪改查方法裡呼叫
	// 以避免請求執行緒共用了同個 Session
	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override
	public List<ProductVO> getAll() {
		return getSession().createQuery("from ProductVO", ProductVO.class).list();
	}

}
