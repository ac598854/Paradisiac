package com.paradisiac.roomorder.service;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.paradisiac.roomorder.model.RoomOrderDTO;
import com.paradisiac.roomorder.model.RoomOrderVO;
import com.paradisiac.roomtype.model.RoomTypeVO;

public interface RoomOrderService {
	
	
	int addorder(Timestamp roomOrderDate, Date checkinDate, Date checkoutDate,Integer roomTypeNo,Integer memNo,Integer roomAmount,Integer price,byte paymentMethod,byte payStatus,byte orderStatus);
//
	int updateorder(Integer roomOrderNo ,Timestamp roomOrderDate, Date checkinDate, Date checkoutDate,Integer roomTypeNo,Integer memNo,Integer roomAmount,Integer price,byte paymentMethod,byte payStatus,byte orderStatus);
//
    int updateOrderStatus(Integer roomOrderNo, byte orderStatus);
//	
	List<RoomOrderVO> getAllOrd();
	
	RoomOrderVO findByorderNo(Integer roomOrderNo);
	
	List<RoomOrderDTO> findByCheckInDate(Map<String, String[]> map);
	
	List<RoomOrderDTO> getAllCheckIn();
	
	RoomOrderDTO getbyOneCheckIn(Integer id);
	
	}
