package com.paradisiac.actorder.model;

import java.util.List;
import java.util.Map;

import com.paradisiac.act.model.ActVO;
import com.paradisiac.actattendees.model.ActAttendees;
import com.paradisiac.schd.model.SchdVO;


public interface ActOrder_interface {

	int insert(ActOrder actOrder);//依訂單編號新增
	ActOrder insert_Whith_ActAttendees(ActOrder actOrder, List<ActAttendees> list);
	int update(ActOrder actOrder);//訂單編號修改
	
	//後臺取消活動，取消所有訂單
	int updateOrderStatus(ActOrder actOrder);
	int modifyStatus(Integer schdNo, Integer orderStatus);//
	
	//單一查詢
	ActOrder getOneByActOrderNo(Integer actOrderNo);
	public List<ActOrder> getAllBymemNO(Integer memNo);//取特定會員編號訂單

	//取全部分頁、不分頁
	public List<ActOrder> getAll();//取全部不分頁		

	//後臺備用
	long getTotal();//資料總比數
	List<ActOrder> getAllStatus(int currentPage);//取全部分頁	
	long getOrderStatusTotal();//符合特定訂單【狀態】條件的記錄總數
	List<ActOrder> getOrderStatusCount(int currentPage);//符合條件查詢頁數
	
	//後臺複合查詢
	public List<ActOrder> getAllByBackSearch(String hql , String first);//取特定會員編號訂單(會員編號、訂單編號,檔期編號,訂單狀態)

	//前台會員	
//	long getOrderFrontTotal(String memNo);//該會員訂單總筆數
	long getOrderFrontTotal(Integer memNo);
	List<ActOrder> getOrderMenNoCount(int currentPage, Integer memNo);//會員訂單列表資料數
	List<ActOrder> getByAllByFrontSearch(String hql , String first);//前台複合查詢
	List<ActOrder> getAllFront();//取全部會員不分頁
	

	
	
}
