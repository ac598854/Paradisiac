package com.paradisiac.roomtype.service;
import java.util.List;
import java.util.Map;
import com.paradisiac.roomtype.model.RoomTypeVO;


public interface RoomTypeService {

	RoomTypeVO addRoomTypeVO(RoomTypeVO rtvo);
	
	RoomTypeVO updateRoomTypeVO(RoomTypeVO rtvo);
	
	void deleteRoomTypeVO(Integer rtvono);
	
	RoomTypeVO getOneRoomType(Integer rtvono);
	
	List<RoomTypeVO> getAllRoomTypeVOs(int currentPage);
	
	List<RoomTypeVO> getAll();
	int getPageTotal();
	
	List<RoomTypeVO> getRoomTypeVOsByCompositeQuery(Map<String, String[]> map);
	
	//取得房型的roomTotal(房間總數)
	Integer getTotal(int roomTypeNo);
	
}
