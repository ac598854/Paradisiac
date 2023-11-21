package com.paradisiac.actorder.model;

import java.util.List;

import com.paradisiac.actattendees.model.ActAttendees;
import com.paradisiac.schd.model.SchdVO;

public interface ActOrder_interface {

	int insert(ActOrder actOrder);
	int update(ActOrder actOrder);
	ActOrder getOneByActOrderNo(Integer actOrderNo);
	List<ActOrder> getAll();
	int modifyStatus(SchdVO schdVO, Integer orderStatus);
	ActOrder insert_Whith_ActAttendees(ActOrder actOrder, List<ActAttendees> list);
	
}
