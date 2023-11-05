package com.paradisiac.roomtype.service;
import java.util.List;
import java.util.Map;
import com.paradisiac.roomtype.model.RoomTypeVO;


public interface RoomTypeService {

	RoomTypeVO addRoomTypeVO(RoomTypeVO rtvo);
	
	RoomTypeVO updateRoomTypeVO(RoomTypeVO rtvo);
	
	void deleteRoomTypeVO(Integer rtvono);
	
	RoomTypeVO getRoomTypeVOByRoomTypeVOno(Integer rtvono);
	
	List<RoomTypeVO> getAllRoomTypeVOs(int currentPage);
	
	int getPageTotal();
	
	List<RoomTypeVO> getRoomTypeVOsByCompositeQuery(Map<String, String[]> map);
		
}
