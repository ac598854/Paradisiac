package com.paradisiac.roomZ.roomtype.service;

import java.util.List;

import com.paradisiac.roomZ.roomtype.entity.RoomTypeVO;

public interface RoomTypeService {
	
	int addFaq(String roomName, String rtype, Integer roomTotal,Integer price,Integer normalPrice,Integer holidayPrice,Integer bridgeHolidayPrice,String notice,String facility,boolean rTypeStatus);
//
	int updateFaq(Integer roomTypeNo ,String roomName, String rtype, Integer roomTotal,Integer price,Integer normalPrice,Integer holidayPrice,Integer bridgeHolidayPrice,String notice,String facility,boolean rTypeStatus);
//

//	
	List<RoomTypeVO> getAllOrd();
	
	RoomTypeVO findByFaqNo(Integer roomTypeNo);

	
	List<RoomTypeVO> getAllOne();
	List<RoomTypeVO> getAllTwo();
	List<RoomTypeVO> getAllFour();
	List<RoomTypeVO> getAllEight();
	
	}
