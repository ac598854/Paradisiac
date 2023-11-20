package com.paradisiac.promotionlist.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class PromotionListJDBCDAO implements PromotionListDAO_interface{
	private SessionFactory factory;

	public PromotionListJDBCDAO(SessionFactory factory) {
		this.factory = factory;
	}
	
	// Session 為 not thread-safe，所以此方法在各個增刪改查方法裡呼叫
	// 以避免請求執行緒共用了同個 Session
	private Session getSession() {
		return factory.getCurrentSession();
	}
	
	
	public Integer addPromotionList(PromotionVO proVO) {
		return 1;
	}

	public void updatePromotionList() {
		
	}

	public List<PromotionListVO> getProductList(Integer promotion) {
		
		return null;
	}

	public List<PromotionListVO> getPrmotionList(Integer product) {
		
		return null;
	}
	
}
