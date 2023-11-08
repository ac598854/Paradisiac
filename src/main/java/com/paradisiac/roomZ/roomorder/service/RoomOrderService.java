package com.paradisiac.roomZ.roomorder.service;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import com.paradisiac.roomZ.roomorder.entity.RoomOrderVO;

public interface RoomOrderService {
	
	
	int addorder(Timestamp roomOrderDate, Date checkinDate, Date checkoutDate,Integer roomTypeNo,Integer memNo,Integer roomAmount,Integer price,byte paymentMethod,boolean payStatus,byte orderStatus);
//
	int updateorder(Integer roomOrderNo ,Timestamp roomOrderDate, Date checkinDate, Date checkoutDate,Integer roomTypeNo,Integer memNo,Integer roomAmount,Integer price,byte paymentMethod,boolean payStatus,byte orderStatus);
//

//	
	List<RoomOrderVO> getAllOrd();
	
	RoomOrderVO findByorderNo(Integer roomOrderNo);
	
	
	}
