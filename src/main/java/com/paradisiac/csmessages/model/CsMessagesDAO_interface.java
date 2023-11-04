package com.paradisiac.csmessages.model;

import java.util.List;

public interface CsMessagesDAO_interface {
	public void insert(CsMessagesVO CsVO);
	public CsMessagesVO  get_one_bycamsgno(Integer CsVO);
	public List<CsMessagesVO> getAll();
	// 萬用複合查詢(傳入參數型態Map)(回傳 List)
	// public List<ChatVO> getAll(Map<String, String[]> map);

}
