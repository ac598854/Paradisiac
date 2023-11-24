package com.paradisiac.actorder.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Set;

import com.paradisiac.act.model.ActVO;
import com.paradisiac.actattendees.model.ActAttendees;
import com.paradisiac.actorder.model.ActOrder;
import com.paradisiac.employee.model.EmpVO;
import com.paradisiac.schd.model.SchdVO;

public interface ActOrderService_interface {
	//資料庫11欄
	int addActOrder(Integer memNo, SchdVO schdVO, EmpVO empVO, Timestamp orderTime, Integer aAtnNum,
			Integer orderStatus, Integer orderAmount, Set<ActAttendees> actAttendees);

	//更新
	int cancelAct(Integer schdNO);//該檔期下所有訂單狀態改變

	int modifyStatus(Integer schdNo, Integer orderStatus);//確認訂單狀態
	
	
	int updateActOrder(Integer actOrderNo,Integer memNo,SchdVO schdVO,EmpVO empVO,Timestamp orderTime,Integer aAtnNum,
			Integer orderStatus,Integer orderAmount,Set<ActAttendees> actAttendees);

	
	//查詢
	public ActOrder getOneByActOrderNo(Integer actOrderNo);
	
	public List<ActOrder> getAll();
	public List<ActOrder> getAllByMemnoSer(Integer memNo);
	public List<ActOrder> getAllByBackSearchSer(String hql , String first);
	public List<ActOrder> getAll(int currentPage);
	int getTotal();//總筆數
	
	int getPageActOrderTotal();//

	List<ActOrder> getAllByStatusPage(int currentPage);//符合條件查詢頁數



	
	
	
	
}
