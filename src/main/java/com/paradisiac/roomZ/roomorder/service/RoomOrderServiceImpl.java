package com.paradisiac.roomZ.roomorder.service;


import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.paradisiac.roomZ.roomorder.dao.RoomOrderDAO;
import com.paradisiac.roomZ.roomorder.dao.RoomOrderDAOImpl;
import com.paradisiac.roomZ.roomorder.entity.RoomOrderVO;
import com.paradisiac.util.HibernateUtil;

public class RoomOrderServiceImpl implements RoomOrderService{
	private RoomOrderDAO dao;

	
	public RoomOrderServiceImpl() {
		dao = new RoomOrderDAOImpl(HibernateUtil.getSessionFactory());
	}


	@Override
	public int addorder(Timestamp roomOrderDate, Date checkinDate, Date checkoutDate, Integer roomTypeNo, Integer memNo,
			Integer roomAmount, Integer price, byte paymentMethod, byte payStatus, byte orderStatus) {
		RoomOrderVO ord = new RoomOrderVO();
		ord.setRoomOrderDate(roomOrderDate);
		ord.setCheckinDate(checkinDate);
		ord.setCheckoutDate(checkoutDate);
		ord.setRoomTypeNo(roomTypeNo);
		ord.setMemNo(memNo);
		ord.setRoomAmount(roomAmount);
		ord.setPrice(price);
		ord.setPaymentMethod(paymentMethod);
		ord.setPayStatus(payStatus);
		ord.setOrderStatus(orderStatus);
		
		return dao.insert(ord);
	}


	@Override
	public int updateorder(Integer roomOrderNo, Timestamp roomOrderDate, Date checkinDate, Date checkoutDate,
			Integer roomTypeNo, Integer memNo, Integer roomAmount, Integer price, byte paymentMethod, byte payStatus,
			byte orderStatus) {
		RoomOrderVO ord = new RoomOrderVO();
		ord.setRoomOrderNo(roomOrderNo);
		ord.setRoomOrderDate(roomOrderDate);
		ord.setCheckinDate(checkinDate);
		ord.setCheckoutDate(checkoutDate);
		ord.setRoomTypeNo(roomTypeNo);
		ord.setMemNo(memNo);
		ord.setRoomAmount(roomAmount);
		ord.setPrice(price);
		ord.setPaymentMethod(paymentMethod);
		ord.setPayStatus(payStatus);
		ord.setOrderStatus(orderStatus);
		
		return dao.update(ord);
	}


	@Override
	public List<RoomOrderVO> getAllOrd() {
		return dao.getAll();
	}


	@Override
	public RoomOrderVO findByorderNo(Integer roomOrderNo) {
		
		return dao.findByorderNo(roomOrderNo);
	}



	

	
}
