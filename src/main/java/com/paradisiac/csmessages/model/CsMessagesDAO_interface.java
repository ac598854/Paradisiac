package com.paradisiac.csmessages.model;

import java.sql.Timestamp;
import java.util.List;

public interface CsMessagesDAO_interface {
	public void insertFront(CsMessagesVO CsVO);
	public CsMessagesVO  getOneByCsmsgno(Integer CsVO);
	public List<CsMessagesVO> getAll();
	List<CsMessagesVO> getAllByEmpno(Integer empno);
	public List<CsMessagesVO> getAllBystatus(StringBuffer whereCodition,String keyword);
	//判斷有無員工編號為是否處理狀態
	public List<CsMessagesVO> getAllBycscontent(String keyword,Integer whereMemno);
	public void  updateBack(CsMessagesVO CsVO);
	// 萬用複合查詢(傳入參數型態Map)(回傳 List)
	// public List<ChatVO> getAll(Map<String, String[]> map);
	

}
