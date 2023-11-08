package com.paradisiac.roomnum.service;

import java.util.List;
import java.util.Map;

import com.paradisiac.roomnum.model.RoomNumVO;


public interface RoomNumService {

	RoomNumVO addRoomNum(RoomNumVO roomnum);
	
	int updateRoomNum(RoomNumVO roomnum);
	
	void deleteRoomNum(Integer rnum);
	
	RoomNumVO getRoomNumByRoomNumno(Integer rnum);
	
	List<RoomNumVO> getAllRoomNums(int currentPage);
	
	List<RoomNumVO> getSerivceRoomNums(int roomTypeNo);
	
	List<RoomNumVO> getAllRoomNums();
	int getPageTotal();
	
	
	
}
