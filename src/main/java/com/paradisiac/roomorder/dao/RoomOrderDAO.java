package com.paradisiac.roomorder.dao;

import java.util.List;
import java.util.Map;

import com.paradisiac.roomorder.entity.roomOrderVO;

public interface RoomOrderDAO {
	
	
	List<roomOrderVO> getAll();
	
	
	long getTotal();
}
