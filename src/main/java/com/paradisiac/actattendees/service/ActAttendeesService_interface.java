package com.paradisiac.actattendees.service;

import java.util.List;

import com.paradisiac.actattendees.model.ActAttendees;
import com.paradisiac.actorder.model.ActOrder;

public interface ActAttendeesService_interface {

	int addActAttendees(ActOrder actOrder,String atnName,String atnIdNumber,String atnTel);
	
	int updateActAttendees(Integer atnNo,ActOrder actOrder,String atnName,String atnIdNumber,String atnTel);
	
	ActAttendees getOneByAtnNo(Integer atnNo);
	
	List<ActAttendees> getAll();
	
}


