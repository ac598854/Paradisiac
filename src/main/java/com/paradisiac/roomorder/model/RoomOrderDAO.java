package com.paradisiac.roomorder.model;

import java.util.List;
import java.util.Map;

import com.paradisiac.roomorder.model.RoomOrderVO;
import com.paradisiac.roomorder.model.RoomOrderDTO;

public interface RoomOrderDAO {
		
	int insert(RoomOrderVO roomOrderVO);

	int update(RoomOrderVO roomOrderVO);
	
	RoomOrderVO findByorderNo(Integer roomOrderNo);	
	
	List<RoomOrderVO> getAll();	
	
	long getTotal();
	
	List<RoomOrderDTO> findByCheckInDate(Map<String, String> map);
	
	List<RoomOrderDTO> getAllCheckIn();
	
	RoomOrderDTO getbyOneCheckIn(Integer id);
	
}
