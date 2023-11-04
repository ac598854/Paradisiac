package com.paradisiac.csmessages.model;

import java.sql.Timestamp;
import java.util.List;

public interface CsMessagesDAO_interface {
	public void insertFront(CsMessagesVO CsVO);
	public CsMessagesVO  getOneByCsmsgno(Integer CsVO);
	public List<CsMessagesVO> getAll();
	List<CsMessagesVO> getAllByEmpno(Integer empno);
	public List<CsMessagesVO> getAllBycsredate(Timestamp csredate);
	public List<CsMessagesVO> getAllBycscontent(String cscontent);
	public void  updateBack(CsMessagesVO CsVO);
	// 萬用複合查詢(傳入參數型態Map)(回傳 List)
	// public List<ChatVO> getAll(Map<String, String[]> map);
	

}
