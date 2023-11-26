package com.paradisiac.promotionlist.model;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class PromotionListJDBCDAO implements PromotionListDAO_interface {
	private SessionFactory factory;

	public PromotionListJDBCDAO(SessionFactory factory) {
		this.factory = factory;
	}

	// Session 為 not thread-safe，所以此方法在各個增刪改查方法裡呼叫
	// 以避免請求執行緒共用了同個 Session
	private Session getSession() {
		return factory.getCurrentSession();
	}

	public Integer addPromotionList(PromotionVO proVO, String selectedProducts) {
		Integer proVOId = null;

		Set<PromotionListVO> details = new LinkedHashSet<>();
		String[] productIDs = selectedProducts.split(","); // 用逗號分割字串，獲得商品 ID 的字串陣列
		for (String productID : productIDs) {
			int id = Integer.parseInt(productID.trim()); // 將商品 ID 字串轉換為整數
			ProductVO productVO = getSession().get(ProductVO.class, id);
			PromotionListVO proList = new PromotionListVO();

			proList.setProduct(productVO);
			proList.setPromotion(proVO);
			details.add(proList);
		}
		// 此訂單要新增時，跟著要一起新增的書本明細們 (明細物件裡也都有關聯的書本資訊)
		proVO.setPromotionLists(details);

		getSession().save(proVO);
		proVOId = proVO.getProno();
		return proVOId;

	}

	public Integer updatePro(PromotionVO proVO, String selectedProducts) {
		
		Set<PromotionListVO> details = new LinkedHashSet<>();
		String[] productIDs = selectedProducts.split(","); // 用逗號分割字串，獲得商品 ID 的字串陣列
		for (String productID : productIDs) {
			int id = Integer.parseInt(productID.trim()); // 將商品 ID 字串轉換為整數
			ProductVO productVO = getSession().get(ProductVO.class, id);
			PromotionListVO proList = new PromotionListVO();

			proList.setProduct(productVO);
			proList.setPromotion(proVO);
			details.add(proList);
		}
		// 此訂單要新增時，跟著要一起新增的書本明細們 (明細物件裡也都有關聯的書本資訊)
		proVO.setPromotionLists(details);

		getSession().update(proVO);
		return proVO.getProno();
	}

	public List<PromotionVO> getAll() {
		return getSession().createQuery("from PromotionVO", PromotionVO.class).list();
	}

	public List<PromotionListVO> getProductList(Integer promotion) {
		return null;
	}

	@Override
	public Integer addOrUpdatePromotionList(PromotionVO proVO, String selectedProducts) {
		// TODO Auto-generated method stub
		return null;
	}
	public List<Integer> getProductnoFromView(Integer promotionNO) {
	    String hql = "SELECT detailKey.productNo FROM PromotionListViewVO WHERE detailKey.promotionNo = :promotionNo";
		return (List<Integer>)getSession().createQuery(hql, Integer.class).setParameter("promotionNo", promotionNO)
		        .getResultList();
	}
	public PromotionVO getById(Integer promotionNo) {
		return getSession().load(PromotionVO.class,promotionNo);
	}
}
