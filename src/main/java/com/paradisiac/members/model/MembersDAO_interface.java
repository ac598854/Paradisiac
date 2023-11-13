package com.paradisiac.members.model;

import java.util.*;


public interface MembersDAO_interface {
	
	  	public void insert(MembersVO mVO);
	    public void updateAll(MembersVO mVO);
	    public void updateBackStatus(MembersVO mVO);
	    public void updateFront(MembersVO mVO);
	    public void updatePass(MembersVO mVO);
//	    public void update_mem_captcha(MembersVO mVO);//不需要
	    public List<MembersVO> getAll();
	    public List<MembersVO> getAllBystatus(Boolean memstatus);
	    public MembersVO getOneBymemno(Integer memno);
	    public MembersVO getOneBymemaccount(String memaccount);
	    public void delete(Integer memno);
	  
	  //萬用複合查詢(傳入參數型態Map)(回傳 List)

}

