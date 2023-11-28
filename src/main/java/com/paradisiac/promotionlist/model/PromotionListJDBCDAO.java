package com.paradisiac.promotionlist.model;

import java.util.*;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

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

		 List<PromotionListVO> details = new  ArrayList<>();
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
		Integer proVOId = null;

			List<PromotionListVO> details = new  ArrayList<>();
		    String[] productIDs = selectedProducts.split(",");
		    Set<Integer> updatedProductIds = new HashSet<>(); // 用於存放更新後的商品 ID

		    // 新的商品關聯
		    for (String productID : productIDs) {
		        int id = Integer.parseInt(productID.trim());
		        updatedProductIds.add(id); // 將更新後的商品 ID 加入集合中
		        ProductVO productVO = getSession().get(ProductVO.class, id);
		        PromotionListVO proList = new PromotionListVO();

		        proList.setProduct(productVO);
		        proList.setPromotion(proVO);
		        details.add(proList);
		    }
		    proVO.setPromotionLists(details);

					getSession().saveOrUpdate(proVO);
					proVOId = proVO.getProno();
					return proVOId;

			}
////		    proVO.setPromotionLists(getProductList(proVO));
//		    proVO = getById(proVO.getProno());
//		    // 比較更新前後的商品關聯，找出被刪除的商品關聯
//		    List<Integer> removedProductIds = new ArrayList<>();
//		    for (PromotionListVO existingDetail : proVO.getPromotionLists()) {
//		        int productId = existingDetail.getProduct().getProductno();
//		        if (!updatedProductIds.contains(productId)) {
//		            removedProductIds.add(productId); // 如果商品被刪除，將其 ID 加入集合中
//		        }
//		    }
//
//		    // 移除被刪除的商品關聯
//		    List<PromotionListVO> remainingDetails = new ArrayList<>();
//		    for (PromotionListVO existingDetail : proVO.getPromotionLists()) {
//		        int productId = existingDetail.getProduct().getProductno();
//		        if (!removedProductIds.contains(productId)) {
//		            remainingDetails.add(existingDetail); // 將未被刪除的商品關聯保留下來
//		        }
//		    }
//
//		    proVO.setPromotionLists(remainingDetails); // 更新 proVO 的商品關聯
//		    getSession().update(proVO);
//		    return 1;

	public List<PromotionVO> getAll() {
		return getSession().createQuery("from PromotionVO", PromotionVO.class).list();
	}

	public List<PromotionListVO> getProductList(PromotionVO promotion) {
	    String hql = "FROM PromotionListVO WHERE promotion = :targetPromotion";
	    Query<PromotionListVO> query = getSession().createQuery(hql, PromotionListVO.class);
	    query.setParameter("targetPromotion", promotion);
	    List<PromotionListVO> list1 = query.list();
	    return list1;
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
	    PromotionVO proVO = getSession().get(PromotionVO.class, promotionNo);
	    proVO.getPromotionLists().size();
	    return proVO;
	}
}
