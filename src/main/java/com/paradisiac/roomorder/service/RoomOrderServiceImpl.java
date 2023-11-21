package com.paradisiac.roomorder.service;


import java.sql.Date;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
//import org.springframework.transaction.annotation.Transactional;

import com.paradisiac.roomorder.model.RoomOrderDAO;
import com.paradisiac.roomorder.model.RoomOrderDAOImpl;
import com.paradisiac.roomorder.model.RoomOrderDTO;
import com.paradisiac.roomorder.model.RoomOrderVO;
import com.paradisiac.util.HibernateUtil;

@Service
@Transactional
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

	public List<RoomOrderDTO> findByCheckInDate(Map<String, String[]> map){
		Map<String, String> query = new HashMap<>();
		// Map.Entry即代表一組key-value
		Set<Map.Entry<String, String[]>> entry = map.entrySet();
		
		for (Map.Entry<String, String[]> row : entry) {
			String key = row.getKey();
			// 因為請求參數裡包含了action，做個去除動作
			if ("action".equals(key)) {
				continue;
			}
			// 若是value為空即代表沒有查詢條件，做個去除動作
			String value = row.getValue()[0]; // getValue拿到一個String陣列, 接著[0]取得第一個元素檢查
			if (value == null || value.isEmpty()) {
				continue;
			}
			query.put(key, value);
		}
		
		System.out.println(query);
		return dao.findByCheckInDate(query);
	}


	@Override
	public List<RoomOrderDTO> getAllCheckIn() {
		
		return dao.getAllCheckIn();
	}


	@Override
	public RoomOrderDTO getbyOneCheckIn(Integer id) {
		
		return dao.getbyOneCheckIn(id);
	}

	

	@Override
	public int updateOrderStatus(Integer roomOrderNo, byte orderStatus) {
		// TODO Auto-generated method stub
		return dao.updateOrderStatus(roomOrderNo, orderStatus);
	}

	@Override
	public List<RoomOrderVO> getmemOrd(Integer memno) {
		return dao.getmemOrd(memno);
	}

	
}
