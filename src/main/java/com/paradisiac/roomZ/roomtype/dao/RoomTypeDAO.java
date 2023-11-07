package com.paradisiac.roomZ.roomtype.dao;

import java.util.List;
import java.util.Map;

import com.paradisiac.roomZ.roomtype.entity.RoomTypeVO;


public interface RoomTypeDAO {
	
	int insert(RoomTypeVO roomTypeVO);

	int update(RoomTypeVO roomTypeVO);

	
	RoomTypeVO findByFaqNo(Integer RoomTypeNo);
	
	
	List<RoomTypeVO> getAll();
	
	List<RoomTypeVO> getOne();
	List<RoomTypeVO> getTwo();
	List<RoomTypeVO> getFour();
	List<RoomTypeVO> getEight();
	
	
	long getTotal();
}
