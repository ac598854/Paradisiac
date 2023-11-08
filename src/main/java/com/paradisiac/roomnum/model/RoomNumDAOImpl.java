package com.paradisiac.roomnum.model;

import static  com.paradisiac.util.Constants.PAGE_MAX_RESULT;
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

import com.paradisiac.roomcalendar.model.CalSingleDTO;
import com.paradisiac.roomnum.model.RoomNumVO;
import com.paradisiac.util.HibernateUtil;

public class RoomNumDAOImpl implements RoomNumDAO{
	//宣告分頁每頁10筆
	
	// SessionFactory 為 thread-safe，可宣告為屬性讓請求執行緒們共用	
	private SessionFactory factory;
	
	public RoomNumDAOImpl(SessionFactory factory) {
		this.factory = factory;
	}
	// Session 為 not thread-safe，所以此方法在各個增刪改查方法裡呼叫
	// 以避免請求執行緒共用了同個 Session
	private Session getSession() {
		return factory.getCurrentSession();
	}
	//新增資料
	@Override
	public int insert(RoomNumVO entity) {		
		// 回傳給 service 剛新增成功的自增主鍵值
		System.out.println("這是rnum："+entity.getRnum());
		System.out.println("這是room_type："+entity.getRoomTypeNo());
		System.out.println("這是room_Order_No："+entity.getRoomOrderNo());
		System.out.println("這是checkin_name："+entity.getCheckInName());
		System.out.println("這是room_status："+entity.getRoomStatus());
		return (Integer) getSession().save(entity);
	}
	//更新資料
	@Override
	public int update(RoomNumVO entity) {
		try {
			getSession().update(entity);
			return 1;
		} catch (Exception e) {
			return -1;
		}
	}
	//刪除資料
	@Override
	public int delete(Integer id) {
		RoomNumVO rn = getSession().get(RoomNumVO.class, id);
		if (rn != null) {
			getSession().delete(rn);
			// 回傳給 service，1代表刪除成功
			return 1;
		} else {
			// 回傳給 service，-1代表刪除失敗
			return -1;
		}
		
	}
	//傳回單筆資料
	@Override
	public RoomNumVO getById(Integer id) {
		return getSession().get(RoomNumVO.class, id);
	}
	//查詢全部資料
	@Override
	public List<RoomNumVO> getAll() {
		System.out.println("DAO:getAll()-->ready");
		//from RoomNumVO (★★★注意這裡的RoomNum指的是類別名稱而不是資料庫名稱)
		return getSession().createQuery("from RoomNumVO",RoomNumVO.class).list();
	}	
	//取得指定房型的房號
	public List<RoomNumVO> getRoomNums(int roomTypeNo){
		return  getSession()
			    .createQuery("from RoomNumVO c where c.roomTypeNo = :roomTypeNo and roomStatus = 1", RoomNumVO.class)
			    .setParameter("roomTypeNo", roomTypeNo)
			    .list();		
	}

	@Override
	public List<RoomNumVO> getAll(int currentPage) {
		System.out.println("RoomNumDAO:getAll(currentPage====>)");
		int first = ( currentPage -1) * PAGE_MAX_RESULT;
		return getSession().createQuery("from RoomNumVO", RoomNumVO.class)
				.setFirstResult(first)   //當currentPage=1時first=3, ,first=(1-1)*3,
				.setMaxResults(PAGE_MAX_RESULT)
				.list();
	}

	@Override
	public long getTotal() {		
		return getSession().createQuery("select count(*) from RoomNumVO", Long.class).uniqueResult();
	}

}
