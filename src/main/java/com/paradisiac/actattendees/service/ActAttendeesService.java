package com.paradisiac.actattendees.service;

import java.util.List;

import com.paradisiac.actattendees.model.ActAttendees;
import com.paradisiac.actattendees.model.ActAttendeesDAO;
import com.paradisiac.actorder.model.ActOrder;
import com.paradisiac.util.HibernateUtil;


public class ActAttendeesService implements ActAttendeesService_interface{
	private ActAttendeesDAO dao;
	
	public ActAttendeesService() {
		dao = new ActAttendeesDAO(HibernateUtil.getSessionFactory());
	}
	
	
	@Override
	public int addActAttendees(ActOrder actOrder, String atnName, String atnIdNumber, String atnTel) {
		ActAttendees AttVO=new ActAttendees ();
		AttVO.setActOrder(actOrder);
		AttVO.setAtnName(atnName);
		AttVO.setAtnIdNumber(atnIdNumber);
		AttVO.setAtnTel(atnTel);
			
		return dao.insert(AttVO);
	}

	@Override
	public int updateActAttendees(Integer atnNo, ActOrder actOrder, String atnName, String atnIdNumber, String atnTel) {
		
		ActAttendees AttVO=new ActAttendees ();
		AttVO.setAtnNo(atnNo);
		AttVO.setActOrder(actOrder);
		AttVO.setAtnName(atnName);
		AttVO.setAtnIdNumber(atnIdNumber);
		AttVO.setAtnTel(atnTel);
		
		return dao.update(AttVO);
	}

	@Override
	public ActAttendees getOneByAtnNo(Integer atnNo) {
	
		return dao.getOneByAtnNo(atnNo);
	}

	@Override
	public List<ActAttendees> getAll() {

		return dao.getAll();
	}
	
	
	

}
