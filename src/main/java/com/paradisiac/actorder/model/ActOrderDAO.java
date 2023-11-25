package com.paradisiac.actorder.model;


import static com.paradisiac.department.service.Constants.PAGE_MAX_RESULT;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.paradisiac.actorder.model.ActOrder;
import com.paradisiac.actattendees.model.ActAttendees;
import com.paradisiac.schd.model.SchdVO;


public class ActOrderDAO implements ActOrder_interface{
	
	private SessionFactory factory;
	
	public ActOrderDAO(SessionFactory factory) {
		this.factory = factory;
	}
	
	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override
	public int insert(ActOrder actOrder) {
	
		return (int) getSession().save(actOrder);
	}

	@Override
	public int update(ActOrder actOrder) {
		
		getSession().update(actOrder);
		try {
			return 1;				
		}catch(Exception e) {
			e.printStackTrace();
			return 0;	
		}	
	}
	
	@Override
	public int updateOrderStatus(ActOrder actOrder) {		
		getSession().update(actOrder);
		try {
			return 1;				
		}catch(Exception e) {
			e.printStackTrace();
			return 0;	
		}	
	}
	

	@Override
	public ActOrder getOneByActOrderNo(Integer actOrderNo) {
		return getSession().get(ActOrder.class, actOrderNo);
	}
	
	@Override
	public ActOrder insert_Whith_ActAttendees(ActOrder actOrder, List<ActAttendees> list) {
		// TODO Auto-generated method stub
		return null;
	}
	

	@Override
	public int modifyStatus(Integer schdNo, Integer orderStatus) {
		String hql="update ActOrder set orderStatus=:orderStatus Where schdVO.schdNo=:schdNo";
		Query query = getSession().createQuery(hql);//hql語法
		
		query.setParameter("orderStatus", orderStatus);
		query.setParameter("schdNo", schdNo);
		int result = query.executeUpdate();
		
		return result;
	}

	//取全部分頁、不分頁
	@Override
	public List<ActOrder> getAll() {//取全部不分頁	
		return getSession().createQuery("from ActOrder ORDER BY act_order_no DESC",ActOrder.class).list();
	}
	
	@Override
	public List<ActOrder> getAllBymemNO(Integer memNo) {
		return getSession().createQuery("from ActOrder where memNo=:memNo ORDER BY act_order_no DESC",ActOrder.class)
		.setParameter("memNo", memNo)
		.list();
	}
	
	@Override
	public List<ActOrder> getAllByBackSearch(Integer memNO, Integer actOrderNo, Integer schdNo, Integer orderStatus) {
//		return getSession().createQuery("from ActOrder where memNo=:memNo ORDER BY act_order_no DESC",ActOrder.class)
//		.setParameter("memNo",memNO)
//		.setParameter("actOrderNo", actOrderNo)
//		.setParameter("schdNoo", schdNo)
//		.setParameter("orderStatus", orderStatus)
//		.list();
		
		  StringBuilder hql = new StringBuilder("FROM ActOrder WHERE 1 = 1");

		    // 條件：會員編號
		    if (memNO != null) {
		        hql.append(" AND memNO = :memNO");
		    }
		    
		    // 條件：訂單編號
		    if (actOrderNo != null) {
		        hql.append(" AND actOrderNo = :actOrderNo");
		    }

		    // 條件：檔期編號
		    if (schdNo != null) {
		        hql.append(" AND schdNo = :schdNo");
		    }

		    // 條件：訂單狀態
		    if (orderStatus != null) {
		        hql.append(" AND orderStatus = :orderStatus");
		    }

		    // 構建查詢
		    Query<ActOrder> query = getSession().createQuery(hql.toString(), ActOrder.class);

		    // 設置條件的參數值
		    if (memNO != null) {
		        query.setParameter("memNO", memNO);
		    }
		    if (actOrderNo != null) {
		    	query.setParameter("actOrderNo", actOrderNo);
		    }
		    if (schdNo  != null) {
		        query.setParameter("schdNo", schdNo);
		    }
		    if (orderStatus != null) {
		        query.setParameter("orderStatus", orderStatus);
		    }
		    // 返回查詢結果
		    return query.list();
	}

	
	
	@Override
	public List<ActOrder> getAllStatus(int currentPage) {//取全部分頁
		int first = (currentPage - 1) * PAGE_MAX_RESULT;
		return getSession().createQuery("from ActOrder", ActOrder.class)
				.setFirstResult(first)//第一筆符合即開始
				.setMaxResults(PAGE_MAX_RESULT)
				.list();
	}
	
	//頁數選擇器
	@Override
	public long getTotal() {//資料總比數
		return getSession().createQuery("select count(*) from ActOrder", Long.class).uniqueResult();
	}

	@Override
	public long getOrderStatusTotal() {
		return getSession().createQuery("select count(*) from ActOrder where orderStatus=:status", Long.class)
				.setParameter("status", true)
				.uniqueResult();
	}

	@Override
	public List<ActOrder> getOrderStatusCount(int currentPage) {
		int first = (currentPage - 1) * PAGE_MAX_RESULT; //布林
		return getSession().createQuery("from ActOrder where orderStatus=:status", ActOrder.class)
				.setParameter("status", true)
				.setFirstResult(first)
				.setMaxResults(PAGE_MAX_RESULT)
				.list();
	}



	






	
}
