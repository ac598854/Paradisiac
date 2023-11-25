package com.paradisiac.actorder.service;

import static com.paradisiac.department.service.Constants.PAGE_MAX_RESULT;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.Session;

import com.paradisiac.act.model.ActVO;
import com.paradisiac.actattendees.model.ActAttendees;
import com.paradisiac.actorder.model.ActOrder;
import com.paradisiac.actorder.model.ActOrderDAO;
import com.paradisiac.employee.model.EmpVO;
import com.paradisiac.schd.model.SchdVO;
import com.paradisiac.util.HibernateUtil;


public class ActOrderService implements ActOrderService_interface {
	private ActOrderDAO dao;

	public ActOrderService() {
		dao = new ActOrderDAO(HibernateUtil.getSessionFactory());
	}

	//增改查
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
	public int updateOrderStatus(Integer actOrderNo, Integer orderStatus) {
		ActOrder ActOderVO = new ActOrder();
		ActOderVO.setActOrderNo(actOrderNo);
		ActOderVO.setOrderStatus(orderStatus);
		
		return dao.updateOrderStatus(ActOderVO);
	}

	//後臺取消活動，取消所有訂單
	@Override
	public int modifyStatus(Integer schdNO, Integer orderStatus) {	// 官方取消活動利用 檔期PK 、改變訂單狀態
		return dao.modifyStatus(schdNO, orderStatus);
	}
	
	@Override
	public int cancelAct(Integer schdNo) {
		return 1;
	}

	//單一查詢
	@Override
	public ActOrder getOneByActOrderNo(Integer actOrderNo) {

		return dao.getOneByActOrderNo(actOrderNo);
	}
	
	@Override
	public List<ActOrder> getAllByMemnoSer(Integer memNo) {	
		return dao.getAllBymemNO(memNo);
	}
	
	//===========================後臺備用=======================
	
	@Override
	public List<ActOrder> getAllByBackSearchSer(String hql , String first) {
		return dao.getAllByBackSearch(hql , first);
	}
	@Override
	public List<ActOrder> getAll(int currentPage) {//所有資料分頁
		return dao.getAllStatus(currentPage);
	}
	
	@Override
	public List<ActOrder> getAllByStatusPage(int currentPage){//分頁
		return dao.getOrderStatusCount(currentPage);//設置訂單狀況
		
	}
	
	@Override
	public List<ActOrder> getAll() {//所有資料無分頁
		return dao.getAll();
	}
	
	@Override
	public int getTotal() {//總頁數
		long total = dao.getTotal();
		int pageQty = (int)(total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT) : (total / PAGE_MAX_RESULT + 1));
		return pageQty;
	}
	
	// ==========================前台會員===========================
	//前台會員複合查詢
	@Override
	public List<ActOrder> getAllByFrontSearchSer(String hql , String first) {
		return dao.getAllByBackSearch(hql , first);
	}
	

	//會員列表
	@Override
	public List<ActOrder> getAllOrderFront(int currentPage, Integer memNo) {
		return dao.getOrderMenNoCount(currentPage,memNo);
	}
	
	@Override
	public int getPageActOrderTotal(Integer memNo) {//資料總比數
		long total = dao.getOrderFrontTotal(memNo);
		int pageQty = (int)(total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT) : (total / PAGE_MAX_RESULT + 1));
		return pageQty;
	}


	


	}
	
	


	
	

