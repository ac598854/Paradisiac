package com.paradisiac.roomorder.dao;

import static com.paradisiac.util.Constants.PAGE_MAX_RESULT;

import java.math.BigDecimal;
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
import org.hibernate.Transaction;

import com.paradisiac.roomorder.entity.roomOrderVO;

public class roomOrderDAOImpl implements roomOrderDAO {
	private SessionFactory factory;
	
	public roomOrderDAOImpl(SessionFactory factory) {
		this.factory = factory;
	}
	
	private Session getSession() {
		return factory.getCurrentSession();
	}

	

	@Override
	public int insert(roomOrderVO entity) {
		// TODO Auto-generated method stub
		return (Integer) getSession().save(entity);
	}



	@Override
	public int update(roomOrderVO entity) {
		try {
			getSession().update(entity);
			return 1;
		} catch (Exception e) {
			return -1;
		}
		
	}

	@Override
	public int delete(Integer id) {
		roomOrderVO roomordervo = getSession().get(roomOrderVO.class, id);
		if (roomordervo != null) {
			getSession().delete(roomordervo);
			// 回傳給 service，1代表刪除成功
			return 1;
		} else {
			// 回傳給 service，-1代表刪除失敗
			return -1;
		}
	}

	@Override
	public roomOrderVO getById(Integer id) {
		return getSession().get(roomOrderVO.class, id);
	}

	@Override
	public List<roomOrderVO> getAll() {
	    Session session = getSession();
	    Transaction tx = null;
	    List<roomOrderVO> roomOrders = null;
	    
	    try {
	        tx = session.beginTransaction();
	        roomOrders = session.createQuery("from roomOrderVO", roomOrderVO.class).list();
	        tx.commit();
	    } catch (Exception e) {
	        if (tx != null) {
	            tx.rollback();
	        }
	        e.printStackTrace();
	    } finally {
	        session.close();
	    }

	    return roomOrders;
	}
	

	@Override
	public List<roomOrderVO> getByCompositeQuery(Map<String, String> map) {
	    if (map.size() == 0) {
	        return getAll();
	    }
	    CriteriaBuilder builder = getSession().getCriteriaBuilder();
	    CriteriaQuery<roomOrderVO> criteria = builder.createQuery(roomOrderVO.class);
	    Root<roomOrderVO> root = criteria.from(roomOrderVO.class);

	    List<Predicate> predicates = new ArrayList<>();

	    for (Map.Entry<String, String> entry : map.entrySet()) {
	        String key = entry.getKey();
	        String value = entry.getValue();

	        if ("roomTypeNo".equals(key)) {
	            predicates.add(builder.equal(root.get(key), Integer.parseInt(value)));
	        } else if ("checkinDate".equals(key) || "checkoutDate".equals(key)) {
	            // Parse the input date string to a Date object
	            Date dateValue = Date.valueOf(value);

	            if ("checkinDate".equals(key)) {
	                predicates.add(builder.equal(root.get("checkinDate"), dateValue));
	            } else if ("checkoutDate".equals(key)) {
	                predicates.add(builder.equal(root.get("checkoutDate"), dateValue));
	            }
	        }
	    }

	    criteria.where(builder.and(predicates.toArray(new Predicate[predicates.size()])));
	    criteria.orderBy(builder.asc(root.get("roomOrderNo")));
	    TypedQuery<roomOrderVO> query = getSession().createQuery(criteria);

	    return query.getResultList();
	}


	@Override
	public List<roomOrderVO> getAll(int currentPage) {
		int first = (currentPage - 1) * PAGE_MAX_RESULT;
		return getSession().createQuery("from roomOrderVO", roomOrderVO.class)
				.setFirstResult(first)
				.setMaxResults(PAGE_MAX_RESULT)
				.list();
	}

	@Override
	public long getTotal() {
		return getSession().createQuery("select count(*) from roomOrderVO", Long.class).uniqueResult();
	}
}
