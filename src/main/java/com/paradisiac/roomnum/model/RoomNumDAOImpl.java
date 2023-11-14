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

import org.hibernate.LockMode;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.paradisiac.roomcalendar.model.CalSingleDTO;
import com.paradisiac.roomnum.model.RoomNumVO;
import com.paradisiac.util.HibernateUtil;
import com.paradisiac.roomtype.model.*;
public class RoomNumDAOImpl implements RoomNumDAO{
	
		
	// SessionFactory 為 thread-safe，可宣告為屬性讓請求執行緒們共用	
	private SessionFactory factory;
	
	public RoomNumDAOImpl() {
		super();
		// TODO Auto-generated constructor stub
	}
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
	public Integer insert(Integer rnum,Integer roomTypeNo,Byte roomStatus) {
		 try {
		        RoomNumVO room = new RoomNumVO(rnum, roomTypeNo, null, null, roomStatus);
		        getSession().save(room);
		        return 1; // 表示插入成功
		    } catch (Exception e) {
		        e.printStackTrace();
		        return -1; // 表示插入失败
		    }
	}
	//更新房間資料
	@Override	
	public int update(RoomNumVO entity) {

		//新增的房間的房型必須小=房型設定的總數
	
			try {
				getSession().update(entity);  //若entity物件內有含主鍵則進行更新，若無主鍵則進行新增
				return 1;
			}catch (NullPointerException e) {
			    // 处理NullPointerException的逻辑
			    e.printStackTrace(); // 或者记录异常信息到日志
			    return -1;
			} catch (Exception e) {
				return -1;
			}
		
	}
	
	//取得指定房型的房間數量-insert時使用
		@Override		
		public Long getTotal(int roomTypeNo) {				 			
			return (Long)getSession().createQuery("select count(*) from RoomNumVO where roomTypeNo = :roomTypeNo")
					.setParameter("roomTypeNo", roomTypeNo)
			        .uniqueResult();			
		}
		
	
	//取得指定房型的房間數量(不含自已房型的房間)-update時使用
	@Override		
	public Long getTotal(int roomTypeNo,int rnum) {				 			
		return (Long)getSession().createQuery("select count(*) from RoomNumVO where roomTypeNo = :roomTypeNo and rnum != :rnum")
				.setParameter("roomTypeNo", roomTypeNo)
		        .setParameter("rnum", rnum)
		        .uniqueResult();			
	}
	
	//新增房間時取得比新增資料小的資料有幾筆，以此來新增資料時切換到該頁面
	@Override
	public Long getAddPage(int rnum) {
		return (Long)getSession().createQuery("select count(*) from RoomNumVO where rnum <= :rnum")
		        .setParameter("rnum", rnum)
		        .uniqueResult();	
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
	//取得指定房型的房號並且roomStatus為1(1表示未入住的資料)
	public List<RoomNumVO> getRoomNums(int roomTypeNo){
		return  getSession()
			    .createQuery("from RoomNumVO c where c.roomTypeNo = :roomTypeNo and roomStatus = 1", RoomNumVO.class)
			    .setParameter("roomTypeNo", roomTypeNo)
			    .list();		
	}
	//取得總筆數做分頁時使用
	@Override
	public long getTotal() {		
		return getSession().createQuery("select count(*) from RoomNumVO", Long.class).uniqueResult();
	}
	@Override
	public List<RoomNumVO> getAll(int currentPage) {
		
		int first = ( currentPage -1) * PAGE_MAX_RESULT;
		return getSession().createQuery("from RoomNumVO", RoomNumVO.class)
				.setFirstResult(first)   //當currentPage=1時first=3, ,first=(1-1)*3,
				.setMaxResults(PAGE_MAX_RESULT)
				.list();
	}
	
	public int updateRoomNumStatus(Integer rnum,Integer roomOrderNo,String checkInName,byte roomStatus) {
		try {
			Query query = getSession().createQuery("update RoomNumVO set roomOrderNo =:roomOrderNo, checkInName =:checkInName ,roomStatus=:roomStatus where id =:rnum")
						.setParameter("rnum", rnum)
						.setParameter("roomOrderNo", roomOrderNo)
						.setParameter("checkInName", checkInName)
						.setParameter("roomStatus", roomStatus);
			  int result = query.executeUpdate();
		        return result > 0 ? 1 : 0; // Return 1 if the update was successful, otherwise return 0
		} catch (Exception e) {
			return -1;
		}
	}

}
