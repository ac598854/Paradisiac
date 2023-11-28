package com.paradisiac.promotionlist.model;

import java.util.*;

import org.hibernate.Session;
import java.sql.Date;

import com.paradisiac.util.HibernateUtil;


public class CreatPromotionListTest {

	public static void main(String[] args) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();

			ProductVO productVO1 = session.get(ProductVO.class, 1);
			ProductVO productVO2 = session.get(ProductVO.class, 2);
			
			
			Date currentDate = new Date(System.currentTimeMillis());

			// 建立要新增的訂單主檔
			PromotionVO promotion = new PromotionVO();
			promotion.setProname("xxx");
			promotion.setProdes("xxx促銷");
			promotion.setStartdate(currentDate);
			promotion.setEnddate(currentDate);
			promotion.setDiscount(0.8);
			promotion.setStatus(true);
			// 接著建立明細
			PromotionListVO proList = new PromotionListVO();
			
			proList.setProduct(productVO1);
			proList.setPromotion(promotion);

			PromotionListVO proList2 = new PromotionListVO();
					
			proList2.setProduct(productVO2);
			proList2.setPromotion(promotion);
			
			List<PromotionListVO> details = new ArrayList<>();
			details.add(proList);
			details.add(proList2);
			// 此訂單要新增時，跟著要一起新增的書本明細們 (明細物件裡也都有關聯的書本資訊)
			promotion.setPromotionLists(details);

			session.save(promotion);

			session.getTransaction().commit();

		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} finally {
			HibernateUtil.shutdown();
		}

	}
}
