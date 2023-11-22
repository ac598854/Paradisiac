package com.paradisiac.actorder.model;

import java.util.List;

import com.paradisiac.act.model.ActVO;
import com.paradisiac.actattendees.model.ActAttendees;
import com.paradisiac.schd.model.SchdVO;

public interface ActOrder_interface {

	int insert(ActOrder actOrder);//依訂單編號新增
	int update(ActOrder actOrder);//訂單編號修改
	ActOrder getOneByActOrderNo(Integer actOrderNo);
	
	int modifyStatus(SchdVO schdVO, Integer orderStatus);
//	ActOrder insert_Whith_ActAttendees(ActOrder actOrder, List<ActAttendees> list);

	//取全部分頁、不分頁
	public List<ActOrder> getAll();//取全部不分頁	
	List<ActOrder> getAllStatus(int currentPage);//取全部分頁	
	
	
	//頁數選擇器
	long getTotal();//資料總比數
	
	//前台
	long getOrderStatusTotal();//符合特定訂單【狀態】條件的記錄總數
	public List<ActOrder> getOrderStatusCount(int currentPage);//符合條件查詢頁數
	
	
}
