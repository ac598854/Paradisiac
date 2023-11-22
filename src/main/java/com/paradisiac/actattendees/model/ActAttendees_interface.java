package com.paradisiac.actattendees.model;

import java.util.List;

public interface ActAttendees_interface {
	
	int insert (ActAttendees actAttendees);//新增回傳PK
	int update(ActAttendees actAttendees);//更新回傳改變數量
	
	ActAttendees getOneByAtnNo(Integer atnNo);
	List<ActAttendees> getAll();
	
}
