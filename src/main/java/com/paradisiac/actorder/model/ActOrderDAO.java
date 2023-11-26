package com.paradisiac.actorder.model;



import java.sql.Date;
import java.util.ArrayList;

import java.util.List;
import java.util.Map;

import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.paradisiac.actorder.model.ActOrder;
import com.paradisiac.actattendees.model.ActAttendees;
import com.paradisiac.schd.model.SchdVO;



public class ActOrderDAO implements ActOrder_interface {
	public final int PAGE_MAX_RESULT = 30;

	private SessionFactory factory;

	public ActOrderDAO(SessionFactory factory) {
		this.factory = factory;
	}

	private Session getSession() {
		return factory.getCurrentSession();
	}

	// 增刪改
	@Override
	public int insert(ActOrder actOrder) {

		return (int) getSession().save(actOrder);
	}

	@Override
	public ActOrder insert_Whith_ActAttendees(ActOrder actOrder, List<ActAttendees> list) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(ActOrder actOrder) {

		getSession().update(actOrder);
		try {
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	// 後臺取消活動，取消所有訂單
	@Override
	public int updateOrderStatus(ActOrder actOrder) {
		getSession().update(actOrder);
		try {
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int modifyStatus(Integer schdNo, Integer orderStatus) {
		String hql = "update ActOrder set orderStatus=:orderStatus Where schdVO.schdNo=:schdNo";
		Query query = getSession().createQuery(hql);// hql語法

		query.setParameter("orderStatus", orderStatus);
		query.setParameter("schdNo", schdNo);
		int result = query.executeUpdate();

		return result;
	}

	// 單一查詢
	@Override
	public ActOrder getOneByActOrderNo(Integer actOrderNo) {
		return getSession().get(ActOrder.class, actOrderNo);
	}
	
	@Override
	public List<ActOrder> getAllBymemNO(Integer memNo) {// 取特定會員編號訂單
		return getSession().createQuery("from ActOrder where memNo=:memNo ORDER BY act_order_no DESC", ActOrder.class)
				.setParameter("memNo", memNo).list();
	}

	// 取全部分頁、不分頁
	@Override
	public List<ActOrder> getAll() {// 取全部不分頁
		return getSession().createQuery("from ActOrder ORDER BY act_order_no DESC", ActOrder.class).list();
	}



	// 後臺備用
	@Override
	public long getTotal() {// 資料總筆數
		return getSession().createQuery("select count(*) from ActOrder", Long.class).uniqueResult();
	}

	@Override
	public List<ActOrder> getAllStatus(int currentPage) {// 取全部分頁
		int first = (currentPage - 1) * PAGE_MAX_RESULT;
		return getSession().createQuery("from ActOrder", ActOrder.class).setFirstResult(first)// 第一筆符合即開始
				.setMaxResults(PAGE_MAX_RESULT).list();
	}

	@Override
	public long getOrderStatusTotal() {
		return getSession().createQuery("select count(*) from ActOrder where orderStatus=:status", Long.class)
				.setParameter("status", true).uniqueResult();
	}

	@Override
	public List<ActOrder> getOrderStatusCount(int currentPage) {
		// TODO Auto-generated method stub
		return null;
	}

	// 後臺複合查詢
	@Override
	public List<ActOrder> getAllByBackSearch(String hql, String first) {
		System.out.print("Service HQL"+hql);

		StringBuilder conditional = new StringBuilder("FROM ActOrder");
		if (hql.length() > 0) {
			conditional.append(" WHERE ");
			conditional.append(hql);
			conditional.append(" ORDER BY actOrderNo DESC ");
		}else {
			conditional.append(" ORDER BY actOrderNo DESC ");
		}

		Query<ActOrder> query = getSession().createQuery(conditional.toString(), ActOrder.class);
		return query.setFirstResult(Integer.valueOf(first)).setMaxResults(PAGE_MAX_RESULT).list();
	}

	// ========================================前台會員===========================
	// 該會員訂單總比數
	@Override
	public long getOrderFrontTotal(Integer memNo) {
		return getSession().createQuery("select count(*) from ActOrder WHERE memNo=:memNo", Long.class)
				.setParameter("memNo", memNo).uniqueResult();
	}

	// 會員訂單列表資料數
	@Override
	public List<ActOrder> getOrderMenNoCount(int currentPage, Integer memNo) {
		int first = (currentPage - 1) * PAGE_MAX_RESULT; // 布林
		return getSession().createQuery("from ActOrder where memNo=:memNo", ActOrder.class)
				.setParameter("memNo", memNo)
				.setFirstResult(first).
				setMaxResults(PAGE_MAX_RESULT)
				.list();
	}
	

	// 前台複合查詢
	@Override
	public List<ActOrder> getByAllByFrontSearch(String hql, String first) {
		System.out.print(hql);

		StringBuilder conditional = new StringBuilder("FROM ActOrder ");
		if (hql.length() > 0) {
			conditional.append(" WHERE ");
			conditional.append(hql);
		}

		Query<ActOrder> query = getSession().createQuery(conditional.toString(), ActOrder.class);
		return query.setFirstResult(Integer.valueOf(first)).setMaxResults(PAGE_MAX_RESULT).list();
	}
	

	// 全部不分頁
	@Override
	public List<ActOrder> getAllFront() {
		return getSession().createQuery("from ActOrder ORDER BY act_order_no DESC WHERE memNo=:memNo", ActOrder.class)
				.list();
	}

}
