package com.paradisiac.roomtype.model;

import java.util.List;
import java.util.Map;

import com.paradisiac.roomtype.model.RoomTypeVO;

public interface RoomTypeDAO {

	int insert(RoomTypeVO entity);
	
	int update(RoomTypeVO entity);
	
	int delete(Integer id);
	
	RoomTypeVO getByteId(Integer id);
	
	List<RoomTypeVO> getAll();
	
	List<RoomTypeVO> getByCompositeQuery(Map<String, String> map);
	
	List<RoomTypeVO> getAll(int currentPage);
	
	long getTotal();
	
	//取得指定房型的total數量
	Integer getTotal(int roomTypeno);
}
