package com.paradisiac.roomZ.roomtype.dao;

import java.util.List;
import java.util.Map;

import com.paradisiac.roomZ.roomtype.entity.RoomTypeeVO;


public interface RoomTypeDAO {
	
	int insert(RoomTypeeVO roomTypeVO);

	int update(RoomTypeeVO roomTypeVO);

	
	RoomTypeeVO findByFaqNo(Integer RoomTypeNo);
	
	
	List<RoomTypeeVO> getAll();
	
	List<RoomTypeeVO> getOne();
	List<RoomTypeeVO> getTwo();
	List<RoomTypeeVO> getFour();
	List<RoomTypeeVO> getEight();
	
	
	long getTotal();
}
