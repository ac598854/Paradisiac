package com.paradisiac.roomnum.service;

import static com.paradisiac.util.Constants.PAGE_MAX_RESULT;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.paradisiac.roomnum.model.RoomNumVO;
//import com.paradisiac.roomnum.RoomNumJDBCDAO;
import com.paradisiac.roomnum.model.RoomNumDAO;
import com.paradisiac.roomnum.model.RoomNumDAOImpl;
import com.paradisiac.util.HibernateUtil;


public class RoomNumServiceImpl implements RoomNumService {
	// 一個 service 實體對應一個 dao 實體
	private RoomNumDAO dao;
	
	public RoomNumServiceImpl() {
		dao = new RoomNumDAOImpl(HibernateUtil.getSessionFactory());
	}
	
	@Override
	public RoomNumVO addRoomNum(RoomNumVO roomnum) {

		
		dao.insert(roomnum);
		return null;
	}

	@Override
	public int updateRoomNum(RoomNumVO roomnum) {
		
		return dao.update(roomnum);
	}

	@Override
	public void deleteRoomNum(Integer rnum) {
				
	}

	@Override
	public RoomNumVO getRoomNumByRoomNumno(Integer rumn) {
		
		return null;
	}

	@Override
	public List<RoomNumVO> getAllRoomNums(int currentPage) {
		System.out.println("Service:getAllRoomNums(currentPage)--->RoomNumDAO:getAll(currentPage)"+currentPage);
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
		System.out.println("Content of roomNums: " + roomNums);
		return roomNums;
	}

	@Override
	public List<RoomNumVO> getAllRoomNums() {
		
		return dao.getAll();
	}

}
