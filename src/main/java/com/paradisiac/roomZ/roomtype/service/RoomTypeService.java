package com.paradisiac.roomZ.roomtype.service;

import java.util.List;

import com.paradisiac.roomZ.roomtype.entity.RoomTypeeVO;

public interface RoomTypeService {
	
	int addFaq(String roomName, String rtype, Integer roomTotal,Integer price,Integer normalPrice,Integer holidayPrice,Integer bridgeHolidayPrice,String notice,String facility,boolean rTypeStatus);
//
	int updateFaq(Integer roomTypeNo ,String roomName, String rtype, Integer roomTotal,Integer price,Integer normalPrice,Integer holidayPrice,Integer bridgeHolidayPrice,String notice,String facility,boolean rTypeStatus);
//

//	
	List<RoomTypeeVO> getAllOrd();
	
	RoomTypeeVO findByFaqNo(Integer roomTypeNo);

	
	List<RoomTypeeVO> getAllOne();
	List<RoomTypeeVO> getAllTwo();
	List<RoomTypeeVO> getAllFour();
	List<RoomTypeeVO> getAllEight();
	
	}
