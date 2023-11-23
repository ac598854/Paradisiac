package com.paradisiac.actorder.service;

import static com.paradisiac.department.service.Constants.PAGE_MAX_RESULT;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

import com.paradisiac.act.model.ActVO;
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
	public int addActOrder(Integer memNo, SchdVO schdVO, EmpVO empVO, Timestamp orderTime, Integer aAtnNum,
			Integer orderStatus, Integer orderAmount, Set<ActAttendees> actAttendees) {

		ActOrder ActOderVO = new ActOrder();

		ActOderVO.setMemNo(memNo);
		ActOderVO.setSchdVO(schdVO);
		ActOderVO.setEmpVO(empVO);
		ActOderVO.setOrderTime(orderTime);
		ActOderVO.setaAtnNum(aAtnNum);
		ActOderVO.setOrderStatus(orderStatus);
		ActOderVO.setOrderAmount(orderAmount);
		ActOderVO.setActAttendees(actAttendees);

		return dao.insert(ActOderVO);
	}
//更新
	@Override
	public int updateActOrder(Integer actOrderNo, Integer memNo, SchdVO schdVO, EmpVO empVO, Timestamp orderTime,
			Integer aAtnNum, Integer orderStatus, Integer orderAmount, Set<ActAttendees> actAttendees) {

		ActOrder ActOderVO = new ActOrder();
		ActOderVO.setActOrderNo(actOrderNo);
		ActOderVO.setMemNo(memNo);
		ActOderVO.setSchdVO(schdVO);
		ActOderVO.setEmpVO(empVO);
		ActOderVO.setOrderTime(orderTime);
		ActOderVO.setaAtnNum(aAtnNum);
		ActOderVO.setOrderStatus(orderStatus);
		ActOderVO.setOrderAmount(orderAmount);
		ActOderVO.setActAttendees(actAttendees);

		return dao.update(ActOderVO);
	}

	@Override
	public int modifyStatus(Integer schdNO, Integer orderStatus) {
		return dao.modifyStatus(schdNO, orderStatus);
	}
	
	@Override
	public int cancelAct(Integer schdNo) {
		// 官方取消活動利用 檔期PK 、改變訂單狀態
		return 1;
	}

//查詢
	@Override
	public ActOrder getOneByActOrderNo(Integer actOrderNo) {

		return dao.getOneByActOrderNo(actOrderNo);
	}
	
	@Override
	public List<ActOrder> getAll() {//所有資料無分頁
		return dao.getAll();
	}
		
	@Override
	public List<ActOrder> getAll(int currentPage) {//所有資料分頁
		return dao.getAllStatus(currentPage);
	}

	@Override
	public int getTotal() {//總頁數
		long total = dao.getTotal();
		int pageQty = (int)(total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT) : (total / PAGE_MAX_RESULT + 1));
		return pageQty;
	}
	
	@Override
	public int getPageActOrderTotal() {//資料總比數
		long total = dao.getTotal();
		int pageQty = (int)(total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT) : (total / PAGE_MAX_RESULT + 1));
		return pageQty;
	}
	
	
	@Override
	public List<ActOrder> getAllByStatusPage(int currentPage){//分頁
		return dao.getOrderStatusCount(currentPage);//設置訂單狀況
	}

	}
	
	


	
	

