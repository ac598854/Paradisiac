package com.paradisiac.roompicture.model;

import static com.paradisiac.util.Constants.PAGE_MAX_RESULT;

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

import com.paradisiac.roompicture.model.RoomPictureVO;

public class RoomPictureDAOImpl implements roomPictureDAO {
	private SessionFactory factory;
	
	public RoomPictureDAOImpl(SessionFactory factory) {
		this.factory = factory;
	}
	
	private Session getSession() {
		return factory.getCurrentSession();
	}

	

	@Override
	public int insert(RoomPictureVO entity) {
		// TODO Auto-generated method stub
		return (Integer) getSession().save(entity);
	}

	@Override
	public int update(RoomPictureVO entity) {
		try {
			getSession().update(entity);
			return 1;
		} catch (Exception e) {
			return -1;
		}
		
	}

	@Override
	public int delete(Integer id) {
		RoomPictureVO roompicturevo = getSession().get(RoomPictureVO.class, id);
		if (roompicturevo != null) {
			getSession().delete(roompicturevo);
			// 回傳給 service，1代表刪除成功
			return 1;
		} else {
			// 回傳給 service，-1代表刪除失敗
			return -1;
		}
	}
	
	
	
	@Override
	public RoomPictureVO getById(Integer id) {
		return getSession().get(RoomPictureVO.class, id);
	}

	@Override
	public List<RoomPictureVO> getAll() {
	    Session session = getSession();
	    Transaction tx = null;
	    List<RoomPictureVO> roompics = null;
	    
	    try {
	        tx = session.beginTransaction();
	        roompics = session.createQuery("from RoomPictureVO", RoomPictureVO.class).list();
	        tx.commit();
	    } catch (Exception e) {
	        if (tx != null) {
	            tx.rollback();
	        }
	        e.printStackTrace();
	    } finally {
	        session.close();
	    }

	    return roompics;
	}
	

	@Override
	public List<RoomPictureVO> getByCompositeQuery(Map<String, String> map) {
	    if (map.size() == 0) {
	        return getAll();
	    }
	    CriteriaBuilder builder = getSession().getCriteriaBuilder();
	    CriteriaQuery<RoomPictureVO> criteria = builder.createQuery(RoomPictureVO.class);
	    Root<RoomPictureVO> root = criteria.from(RoomPictureVO.class);

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
	    TypedQuery<RoomPictureVO> query = getSession().createQuery(criteria);

	    return query.getResultList();
	}


	@Override
	public List<RoomPictureVO> getAll(int currentPage) {
		int first = (currentPage - 1) * PAGE_MAX_RESULT;
		return getSession().createQuery("from RoomPictureVO", RoomPictureVO.class)
				.setFirstResult(first)
				.setMaxResults(PAGE_MAX_RESULT)
				.list();
	}

	@Override
	public long getTotal() {
		return getSession().createQuery("select count(*) from RoomPictureVO", Long.class).uniqueResult();
	}
}
