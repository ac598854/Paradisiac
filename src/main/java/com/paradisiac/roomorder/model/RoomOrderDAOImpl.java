package com.paradisiac.roomorder.model;

import static com.paradisiac.util.Constants.PAGE_MAX_RESULT;


import java.util.List;
import java.util.Map;
import java.util.ArrayList;


import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.paradisiac.roomorder.model.RoomOrderVO;




public class RoomOrderDAOImpl implements RoomOrderDAO {
	private SessionFactory factory;
	
	public RoomOrderDAOImpl(SessionFactory factory) {
		this.factory = factory;
	}
	
	private Session getSession() {
		return factory.getCurrentSession();
	}
	

	@Override
	public int insert(RoomOrderVO roomOrderVO) {
		return (Integer) getSession().save(roomOrderVO);
	}

	@Override
	public int update(RoomOrderVO roomOrderVO) {
		try {
			getSession().update(roomOrderVO);
			return 1;
		} catch (Exception e) {
			return -1;
		}
	}

	@Override
	public List<RoomOrderVO> getAll() {
		return getSession().createQuery("FROM RoomOrderVO", RoomOrderVO.class).list();

//	    Session session = getSession();
//	    Transaction transaction = session.beginTransaction();
//	    List<RoomTypeVO> resultList = session.createQuery("FROM RoomTypeVO", RoomTypeVO.class).list();
//	    transaction.commit();
//	    return resultList;
	}

	@Override
	public long getTotal() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public RoomOrderVO findByorderNo(Integer roomOrderNo) {
		return getSession().get(RoomOrderVO.class, roomOrderNo);
	}
	
	public RoomOrderDTO getbyOneCheckIn(Integer id) {
		return getSession().get(RoomOrderDTO.class, id);
	}
	
	public List<RoomOrderDTO> getAllCheckIn(){
		return getSession().createQuery("from RoomOrderDTO",RoomOrderDTO.class).list();
	}
	
	@Override
	public List<RoomOrderDTO> findByCheckInDate(Map<String, String> map) {
		if (map.size() == 0)
			return getAllCheckIn();
		CriteriaBuilder builder = getSession().getCriteriaBuilder();
		CriteriaQuery<RoomOrderDTO> criteria = builder.createQuery(RoomOrderDTO.class);
		Root<RoomOrderDTO> root = criteria.from(RoomOrderDTO.class);

	//	Predicate condition = null;
		List<Predicate> predicates = new ArrayList<>();
		for (Map.Entry<String, String> row : map.entrySet()) {

			// 查詢會員姓名
			if ("memName".equals(row.getKey())) {				
				predicates.add(builder.like(root.get("memName"), "%"+row.getValue()+"%"));
			}
			// 查詢身份證字號
			if ("memId".equals(row.getKey())) {					
				predicates.add(builder.like(root.get("memId"), "%"+row.getValue()+"%"));	
			}
			// 查詢會員電話
			if ("memPhone".equals(row.getKey())) {					
				predicates.add(builder.like(root.get("memPhone"), "%"+row.getValue()+"%"));	
			}
			// 查詢訂單編號
			if ("roomOrderNo".equals(row.getKey())) {					
				predicates.add(builder.equal(root.get("roomOrderNo"), Integer.valueOf(row.getValue())));	
			}			
		}
		
		criteria.where(builder.and(predicates.toArray(new Predicate[predicates.size()])));
		criteria.orderBy(builder.asc(root.get("roomOrderNo")));
		TypedQuery<RoomOrderDTO> query = getSession().createQuery(criteria);
		//return getSession().createQuery(criteria).getSingleResult();
		return query.getResultList();
	}
}
