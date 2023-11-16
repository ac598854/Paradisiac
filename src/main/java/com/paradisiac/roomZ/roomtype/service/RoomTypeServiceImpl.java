package com.paradisiac.roomZ.roomtype.service;


import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.paradisiac.roomZ.roomtype.dao.RoomTypeDAO;
import com.paradisiac.roomZ.roomtype.dao.RoomTypeDAOImpl;
import com.paradisiac.roomZ.roomtype.entity.RoomTypeeVO;
import com.paradisiac.util.HibernateUtil;

public class RoomTypeServiceImpl implements RoomTypeService{
	private RoomTypeDAO dao;

	
	public RoomTypeServiceImpl() {
		dao = new RoomTypeDAOImpl(HibernateUtil.getSessionFactory());
	}
	
	@Override
	public List<RoomTypeeVO> getAllOrd() {
		
		 return dao.getAll();
	}

	@Override
	public List<RoomTypeeVO> getAllOne() {return dao.getOne();}
	
	@Override
	public List<RoomTypeeVO> getAllTwo() {return dao.getTwo();}
	
	@Override
	public List<RoomTypeeVO> getAllFour() {return dao.getFour();}
	
	@Override
	public List<RoomTypeeVO> getAllEight() {return dao.getEight();}

	public int addFaq(String roomName, String rtype, Integer roomTotal,Integer price,Integer normalPrice,Integer holidayPrice,Integer bridgeHolidayPrice,String notice,String facility,boolean rTypeStatus) {
		RoomTypeeVO type = new RoomTypeeVO();
		type.setRoomName(roomName);
		type.setRtype(rtype);
		type.setRoomTotal(roomTotal);
		type.setPrice(price);
		type.setNormalPrice(normalPrice);
		type.setHolidayPrice(holidayPrice);
		type.setBridgeHolidayPrice(bridgeHolidayPrice);
		type.setNotice(notice);
		type.setFacility(facility);
		type.setrTypeStatus(rTypeStatus);
		
		return dao.insert(type);
	}

	@Override
	public RoomTypeeVO findByFaqNo(Integer roomTypeNo) {
		
		return dao.findByFaqNo(roomTypeNo);
	}

	@Override
	public int updateFaq(Integer roomTypeNo,String roomName, String rtype, Integer roomTotal, Integer price, Integer normalPrice,
			Integer holidayPrice, Integer bridgeHolidayPrice, String notice, String facility, boolean rTypeStatus) {
		RoomTypeeVO type = new RoomTypeeVO();
		type.setRoomTypeNo(roomTypeNo);
		type.setRoomName(roomName);
		type.setRtype(rtype);
		type.setRoomTotal(roomTotal);
		type.setPrice(price);
		type.setNormalPrice(normalPrice);
		type.setHolidayPrice(holidayPrice);
		type.setBridgeHolidayPrice(bridgeHolidayPrice);
		type.setNotice(notice);
		type.setFacility(facility);
		type.setrTypeStatus(rTypeStatus);
		
		return dao.update(type);
	}


	


//	@Override
//	public int updateFaq(Integer faqNo, String faqClass, String faqTitle, String faqContent) {
//		Faq faq = new Faq();
//		faq.setFaqNo(faqNo);
//		faq.setFaqClass(faqClass);
//		faq.setFaqTitle(faqTitle);
//		faq.setFaqContent(faqContent);
//		
//		return dao.update(faq);
//	}
//
//	@Override
//	public int deleteFaq(Integer faqNo) {
//		
//		  return dao.delete(faqNo);
//	}
//
//

}
