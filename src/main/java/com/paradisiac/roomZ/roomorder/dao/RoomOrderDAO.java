package com.paradisiac.roomZ.roomorder.dao;

import java.util.List;
import java.util.Map;

import com.paradisiac.roomZ.roomorder.entity.RoomOrderVO;

public interface RoomOrderDAO {
	
	
	int insert(RoomOrderVO roomOrderVO);

	int update(RoomOrderVO roomOrderVO);

	
	RoomOrderVO findByorderNo(Integer roomOrderNo);
	
	
	List<RoomOrderVO> getAll();
	
//	List<RoomOrderVO> getOne();
//	List<RoomOrderVO> getTwo();
//	List<RoomOrderVO> getFour();
//	List<RoomOrderVO> getEight();
	
	
	long getTotal();
}
