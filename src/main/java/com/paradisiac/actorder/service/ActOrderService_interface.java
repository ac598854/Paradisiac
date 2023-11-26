package com.paradisiac.actorder.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.paradisiac.act.model.ActVO;
import com.paradisiac.actattendees.model.ActAttendees;
import com.paradisiac.actorder.model.ActOrder;
import com.paradisiac.employee.model.EmpVO;
import com.paradisiac.schd.model.SchdVO;


public interface ActOrderService_interface {
	//增刪改
	int addActOrder(Integer memNo, SchdVO schdVO, EmpVO empVO, Timestamp orderTime, Integer aAtnNum,
			Integer orderStatus, Integer orderAmount, Set<ActAttendees> actAttendees);
	
	int updateActOrder(Integer actOrderNo,Integer memNo,SchdVO schdVO,EmpVO empVO,Timestamp orderTime,Integer aAtnNum,
			Integer orderStatus,Integer orderAmount,Set<ActAttendees> actAttendees);
	
	int updateOrderStatus(Integer actOrderNo,Integer orderStatus); 
	
	
	
	// 後臺取消活動，取消所有訂單
	int cancelAct(Integer schdNO);//該檔期下所有訂單狀態改變
	int modifyStatus(Integer schdNo, Integer orderStatus);//確認訂單狀態
	

	// 單一查詢
	public ActOrder getOneByActOrderNo(Integer actOrderNo);
	public List<ActOrder> getAllByMemnoSer(Integer memNo);
	
	// 取全部分頁、不分頁
	public List<ActOrder> getAll();
	
	
	// 後臺備用
	public List<ActOrder> getAll(int currentPage);
	int getTotal();//總筆數
//	int getPageActOrderTotal();//
	int getPageActOrderTotal(Integer memNo);
	List<ActOrder> getAllByStatusPage(int currentPage);//符合條件查詢頁數
	//後臺複合查詢
	public List<ActOrder> getAllByBackSearchSer(String hql , String first);
	
	
	
	//前台會員取全部
	public List<ActOrder> getAllOrderFront(int currentPage,Integer memNo);
	public List<ActOrder> getAllByFrontSearchSer(String hql , String first);

	

	
	
	
	
}
