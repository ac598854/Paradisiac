package com.paradisiac.roomtype.model;

import static com.paradisiac.util.Constants.PAGE_MAX_RESULT;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Map;

import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.paradisiac.roomtype.model.RoomTypeVO;
import com.paradisiac.util.HibernateUtil;

public class RoomTypeDAOImpl implements RoomTypeDAO{
	// SessionFactory 為 thread-safe，可宣告為屬性讓請求執行緒們共用
		private SessionFactory factory;
		Transaction tx = null;
		public RoomTypeDAOImpl() {
			factory = HibernateUtil.getSessionFactory();
		}
		
		// Session 為 not thread-safe，所以此方法在各個增刪改查方法裡呼叫
		// 以避免請求執行緒共用了同個 Session
		private Session getSession() {
			return factory.getCurrentSession();
		}
	@Override
	public int insert(RoomTypeVO entity) {
		
		return (Integer) getSession().save(entity);
	}

	@Override
	public int update(RoomTypeVO entity) {
		try {
			getSession().update(entity);
			return 1;
		} catch (Exception e) {
			return -1;
		}
	}

	@Override
	public int delete(Integer id) {
		
		RoomTypeVO revo = getSession().get(RoomTypeVO.class, id);

		if (revo != null) {
			getSession().delete(revo);
			// 回傳給 service，1代表刪除成功
			return 1;
		} else {
			// 回傳給 service，-1代表刪除失敗
			return -1;
		}
	}

	@Override
	public RoomTypeVO getByteId(Integer id) {
		return getSession().get(RoomTypeVO.class, id);
	}

	@Override
	public List<RoomTypeVO> getAll() {
		System.out.print("RoomTypeDAOImpl: call --> getSession()");
		return getSession().createQuery("from RoomTypeVO", RoomTypeVO.class).list();
	
	}

	@Override
	public List<RoomTypeVO> getByCompositeQuery(Map<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<RoomTypeVO> getAll(int currentPage) {
		int first = (currentPage - 1) * PAGE_MAX_RESULT;
		return getSession().createQuery("from RoomTypeVO", RoomTypeVO.class)
				.setFirstResult(first)
				.setMaxResults(PAGE_MAX_RESULT)
				.list();
		
	}

	@Override
	public long getTotal() {
		return getSession().createQuery("select count(*) from RoomTypeVO", Long.class).uniqueResult();
	}
	

}
