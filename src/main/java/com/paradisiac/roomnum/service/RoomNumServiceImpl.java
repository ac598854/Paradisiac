package com.paradisiac.roomnum.service;



import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.paradisiac.roomnum.model.RoomNumVO;
import com.paradisiac.roomtype.model.RoomTypeDAO;
import com.paradisiac.roomtype.model.RoomTypeDAOImpl;
import com.paradisiac.roomnum.model.RoomNumDAO;
import com.paradisiac.roomnum.model.RoomNumDAOImpl;
import com.paradisiac.util.HibernateUtil;

import static com.paradisiac.util.Constants.PAGE_MAX_RESULT;
public class RoomNumServiceImpl implements RoomNumService {
	// 一個 service 實體對應一個 dao 實體
	private RoomNumDAO dao;	
	public RoomNumServiceImpl() {
		dao = new RoomNumDAOImpl(HibernateUtil.getSessionFactory());
	}
	//新增資料時先判斷資料庫內是否已經有資料了
	 public boolean isRoomNumExists(Integer rnum) {
	       
	        RoomNumVO existingRoom = dao.getById(rnum);
	        System.out.print("判斷資料庫內是否有重覆資料："+existingRoom != null);
	        return existingRoom != null;
	    }
	
	@Override
	public Integer addRoomNum(Integer rnum,Integer roomTypeNo,Byte roomStatus) {	
		if(isRoomNumExists(rnum)) {
			Integer isnull = -1;
			
			return isnull;
		}		
		return dao.insert(rnum,roomTypeNo,roomStatus);
	}

	@Override
	public int updateRoomNum(RoomNumVO roomnum) {		
		return dao.update(roomnum);
	}

	@Override
	public int deleteRoomNum(Integer rnum) {
		 return dao.delete(rnum);
	}

	@Override
	public RoomNumVO getRoomNumByRoomNumno(Integer rumn) {
		
		return null;
	}

	@Override
	public List<RoomNumVO> getAllRoomNums(int currentPage) {
		return dao.getAll(currentPage);
	}

	
	@Override
	public int getPageTotal() {
		long total = dao.getTotal();
		// 計算RoomNum數量每頁3筆的話總共有幾頁
		int pageQty = (int)(total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT) : (total / PAGE_MAX_RESULT + 1));
		return pageQty;
	}

	@Override//取得指定房型的房號
	public List<RoomNumVO> getSerivceRoomNums(int roomTypeNo) {		
		List<RoomNumVO> roomNums = dao.getRoomNums(roomTypeNo);	
		return roomNums;
	}

	@Override
	public List<RoomNumVO> getAllRoomNums() {
		
		return dao.getAll();
	}

	@Override
	public int updateRoomNumStatus(Integer rnum, Integer roomOrderNo, String checkInName, byte roomStatus) {
		
		return dao.updateRoomNumStatus(rnum, roomOrderNo, checkInName, roomStatus);
	}
	
	//取得指定房型的房間數量-insert時使用
		@Override
		public Long getTotal(int roomTypeNO) {		
			return dao.getTotal(roomTypeNO);
		}
	
	
	//取得指定房型的房間數量(不含自已房型的房間)-update時使用
	@Override
	public Long getTotal(int roomTypeNO,int rnum) {		
		return dao.getTotal(roomTypeNO, rnum);
	}

	@Override
	public RoomNumVO getById(Integer id) {
		// TODO Auto-generated method stub
		return dao.getById(id);
	}
	
	//新增房間時取得比新增資料小的資料有幾筆，以此來新增資料時切換到該頁面
	@Override
	public Long getAddPage(int rnum) {		
		return dao.getAddPage(rnum);
	}



}
