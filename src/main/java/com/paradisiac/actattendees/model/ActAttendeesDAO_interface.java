package com.paradisiac.actattendees.model;

import java.util.List;
import java.util.Set;



public interface ActAttendeesDAO_interface {

	public void insert(ActAttendeesVO ActAttendeesVO);
	public void update(ActAttendeesVO ActAttendeesVO);
	public ActAttendeesVO get_one_byactorderno_atnno(Integer ActOderNo,Integer AtnNo);
	public List<ActAttendeesVO> getAll();

    //同時新增訂單主檔與訂單明細//throws ClassNotFoundException??
	public void insertWhenOrder_ActOrderInsert(ActAttendeesVO ActAttendeesVO , java.sql.Connection con) throws ClassNotFoundException;
	//查詢某訂單主檔的訂單明細(一對多)(回傳 Set)
	public Set<ActAttendeesVO> get_ActAttendees_ByActOderNo_inSet(Integer ActOderNo);
	public List<ActAttendeesVO> get_ActAttendees_ByActOderNo(Integer ActOderNo);

	
	
}
