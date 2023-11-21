package com.paradisiac.actorder.service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

import com.paradisiac.actattendees.model.ActAttendees;
import com.paradisiac.actorder.model.ActOrder;
import com.paradisiac.actorder.model.ActOrderDAO;
import com.paradisiac.employee.model.EmpVO;
import com.paradisiac.schd.model.SchdVO;
import com.paradisiac.util.HibernateUtil;
import java.time.LocalDateTime;

public class ActOrderService implements ActOrderService_interface {
	private ActOrderDAO dao;

	public ActOrderService() {
		dao = new ActOrderDAO(HibernateUtil.getSessionFactory());
	}

	@Override
	public int addActOrder(Integer memNo, SchdVO schdVO, EmpVO empVO, LocalDateTime orderTime, Integer aAtnNum,
			Integer orderStatus, Integer orderAmount, Set<ActAttendees> actAttendees) {

		ActOrder ActOderVO = new ActOrder();

		ActOderVO.setMemNo(memNo);
		ActOderVO.setSchdVO(schdVO);
		ActOderVO.setEmpVO(empVO);
		ActOderVO.setOrderTime(LocalDateTime.now());
		ActOderVO.setaAtnNum(aAtnNum);
		ActOderVO.setOrderStatus(orderStatus);
		ActOderVO.setOrderAmount(orderAmount);
		ActOderVO.setActAttendees(actAttendees);

		return dao.insert(ActOderVO);
	}

	@Override
	public int updateActOrder(Integer actOrderNo, Integer memNo, SchdVO schdVO, EmpVO empVO, LocalDateTime orderTime,
			Integer aAtnNum, Integer orderStatus, Integer orderAmount, Set<ActAttendees> actAttendees) {

		ActOrder ActOderVO = new ActOrder();
		ActOderVO.setActOrderNo(actOrderNo);
		ActOderVO.setMemNo(memNo);
		ActOderVO.setSchdVO(schdVO);
		ActOderVO.setEmpVO(empVO);
		ActOderVO.setOrderTime(LocalDateTime.now());
		ActOderVO.setaAtnNum(aAtnNum);
		ActOderVO.setOrderStatus(orderStatus);
		ActOderVO.setOrderAmount(orderAmount);
		ActOderVO.setActAttendees(actAttendees);

		return dao.update(ActOderVO);
	}

	@Override
	public int cancelAct(SchdVO schdVO) {
		// 官方取消活動利用 檔期PK 、改變訂單狀態
		return 1;
	}

	@Override
	public ActOrder getOneByActOrderNo(Integer actOrderNo) {

		return dao.getOneByActOrderNo(actOrderNo);
	}

	@Override
	public List<ActOrder> getAll() {

		return dao.getAll();
	}

	@Override
	public int modifyStatus(SchdVO schdNo, Integer orderStatus) {
		return dao.modifyStatus(schdNo, orderStatus);
	}
	
	
//	@Override
//	public List<ActOrder> insert_Whith_ActAttendees(ActOrder actOrder, List<ActAttendees> list) {
//		ActOrder actOrder ,
//		List<ActAttendees> list) {
//		 dao.ActOrder insert_Whith_ActAttendees(actOrder,list);
//	}
	
	}
	
	


	
	

