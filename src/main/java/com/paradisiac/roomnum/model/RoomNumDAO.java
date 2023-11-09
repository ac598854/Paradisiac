package com.paradisiac.roomnum.model;

import java.util.List;
import java.util.Map;

public interface RoomNumDAO {
	
	int insert(RoomNumVO entity);
	
	int update(RoomNumVO entity);
	
	int delete(Integer id);
	
	RoomNumVO getById(Integer id);
		
	List<RoomNumVO> getAll();
	
	List<RoomNumVO> getAll(int currentPage);	
	
	List<RoomNumVO> getRoomNums(int roomTypeNo);
	
	long getTotal();
	
}

