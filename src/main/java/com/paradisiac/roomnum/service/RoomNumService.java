package com.paradisiac.roomnum.service;

import java.util.List;
import java.util.Map;

import com.paradisiac.roomnum.model.RoomNumVO;


public interface RoomNumService {
	
	Integer addRoomNum(Integer rnum,Integer roomTypeNo,Byte roomStatus);
	
	int updateRoomNum(RoomNumVO roomnum);
	
	int deleteRoomNum(Integer rnum);
	
	RoomNumVO getRoomNumByRoomNumno(Integer rnum);
	
	List<RoomNumVO> getAllRoomNums(int currentPage);
	
	List<RoomNumVO> getSerivceRoomNums(int roomTypeNo);
	
	List<RoomNumVO> getAllRoomNums();
	
	int getPageTotal();
	
	//在checkIn時更新房間狀態
	int updateRoomNumStatus(Integer rnum,Integer roomOrderNo,String checkInName,byte roomStatus);
	
	//取得指定房型的房間數量-insert時使用
	Long getTotal(int roomTypeNO);
		
	//取得指定房型的房間數量(不含自已房型的房間)-update時使用
	Long getTotal(int roomTypeNO,int rnum);
	
	//新增資料時判斷是否有重覆的id
	RoomNumVO getById(Integer id);
	
	//新增房間時取得比新增資料小的資料有幾筆，以此來新增資料時切換到該頁面
	Long getAddPage(int rnum);
}
