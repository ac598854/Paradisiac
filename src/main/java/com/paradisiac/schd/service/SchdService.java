package com.paradisiac.schd.service;

import java.util.List;
import java.util.Set;

import com.paradisiac.schd.model.SchdVO;

public interface SchdService {
//	Integer addSchd(SchdVO schd);
//	
//	SchdVO updateSchd(SchdVO schd);
	
	public SchdVO getSchdBySchdno(Integer schdno);

	public List<SchdVO> getAllSchds(int currentPage);
	
	public List<SchdVO> getAllSchds();//下拉選單

	public int getPageTotal();
	
	public SchdVO addOrUpdateSchd(SchdVO schd);
	
	public void generateNewOrder(Integer schdNo, Integer aAtnNum);
	
	public void cancelOrder(Integer schdNo, Integer aAtnNum);

}
