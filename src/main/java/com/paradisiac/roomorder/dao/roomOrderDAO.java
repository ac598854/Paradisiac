package com.paradisiac.roomorder.dao;

import java.util.List;
import java.util.Map;

import com.paradisiac.roomorder.entity.roomOrderVO;

public interface roomOrderDAO {
	
	int insert(roomOrderVO entity);

	int update(roomOrderVO entity);
	
	int delete(Integer id);
	 
	roomOrderVO getById(Integer id);
	
	List<roomOrderVO> getAll();
	
	List<roomOrderVO> getByCompositeQuery(Map<String, String> map);
	
	List<roomOrderVO> getAll(int currentPage);
	
	long getTotal();
}
