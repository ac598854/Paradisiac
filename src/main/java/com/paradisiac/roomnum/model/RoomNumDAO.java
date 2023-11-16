package com.paradisiac.roomnum.model;

import java.util.List;
import java.util.Map;

public interface RoomNumDAO {
	
	Integer insert(Integer rnum,Integer roomTypeNo,Byte roomStatus);
	
	int update(RoomNumVO entity);
	
	int delete(Integer id);
	
	RoomNumVO getById(Integer id);
		
	List<RoomNumVO> getAll();
	
	List<RoomNumVO> getAll(int currentPage);	
	
	List<RoomNumVO> getRoomNums(int roomTypeNo);
	
	//取得指定房型的房間數量-insert時使用
	Long getTotal(int roomTypeNO);
	
	//取得指定房型的房間數量(不含自已房型的房間)-update時使用
	Long getTotal(int roomTypeNO,int rnum);
	
	//計算總頁數-分頁使用
	long getTotal();
	
	//更新房間資料listAllRoomNums.jsp在排房時要更新
	int updateRoomNumStatus(Integer rnum,Integer roomOrderNo,String checkInName,byte roomStatus);
	
	//新增房間時取得比新增資料小的資料有幾筆，以此來新增資料時切換到該頁面
	Long getAddPage(int rnum);
}

