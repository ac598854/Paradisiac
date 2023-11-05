package com.paradisiac.roompicture.model;

import java.util.List;
import java.util.Map;

import com.paradisiac.roompicture.model.RoomPictureVO;

public interface roomPictureDAO {
	int insert(RoomPictureVO entity);

	int update(RoomPictureVO entity);
	
	int delete(Integer id);
	 
	RoomPictureVO getById(Integer id);
	
	List<RoomPictureVO> getAll();
	
	List<RoomPictureVO> getByCompositeQuery(Map<String, String> map);
	
	List<RoomPictureVO> getAll(int currentPage);
	
	long getTotal();
}
