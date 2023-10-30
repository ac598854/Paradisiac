package com.paradisiac.productphoto.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.paradisiac.util.HibernateUtil;



public class ProductPhotoDAO implements ProductPhotoDAO_interface{
	
	private SessionFactory factory;

	public ProductPhotoDAO(SessionFactory factory) {
		this.factory = factory;
	}
	
	// Session 為 not thread-safe，所以此方法在各個增刪改查方法裡呼叫
	// 以避免請求執行緒共用了同個 Session
	private Session getSession() {
		return factory.getCurrentSession();
	}
	public ProductPhotoVO insert(ProductPhotoVO prophoVO) {
		return (ProductPhotoVO)getSession().save(prophoVO);
	};
	public int update(ProductPhotoVO prophoVO) {
		try {
			getSession().update(prophoVO);
			return 1;
		} catch (Exception e) {
			return -1;
		}
	}
	
	public int delete(Integer prophono) {
		ProductPhotoVO prophoVO = getSession().get(ProductPhotoVO.class, prophono);
		if (prophoVO != null) {
			getSession().delete(prophoVO);
			// 回傳給 service，1代表刪除成功
			return 1;
		} else {
			// 回傳給 service，-1代表刪除失敗
			return -1;
		}
	}
	public ProductPhotoVO getById(Integer prophono) {
//		Transaction tx = getSession().beginTransaction();
//		ProductPhotoVO pvo ;
//		try {
//			pvo = getSession().get(ProductPhotoVO.class, prophono);
//			tx.commit();
//		} catch (Exception e) {
//		    tx.rollback();
//		    throw e;
//		}
//		return pvo;
		return getSession().get(ProductPhotoVO.class, prophono);
	}
	public List<ProductPhotoVO> getAll() {
		return getSession().createQuery("from ProductPhotoVO", ProductPhotoVO.class).list();
	}
	
	//==================貼到getById內給main方法測試用================================
//	Transaction tx = getSession().beginTransaction();
//	ProductPhotoVO pvo ;
//	try {
//		pvo = getSession().get(ProductPhotoVO.class, prophono);
//		tx.commit();
//	} catch (Exception e) {
//	    tx.rollback();
//	    throw e;
//	}
//	return pvo;

	
//	public static void main(String[] args) {
//		ProductPhotoDAO photoHibernate = new ProductPhotoDAO(HibernateUtil.getSessionFactory());
//		
//		System.out.println(photoHibernate.getById(1));
//	}
	
}
