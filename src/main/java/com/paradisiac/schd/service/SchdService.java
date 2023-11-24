package com.paradisiac.schd.service;

import java.util.List;
import java.util.Set;

import com.paradisiac.schd.model.SchdVO;

public interface SchdService {
//	Integer addSchd(SchdVO schd);
//	
//	SchdVO updateSchd(SchdVO schd);
	
	SchdVO getSchdBySchdno(Integer schdno);

	List<SchdVO> getAllSchds(int currentPage);
	
	List<SchdVO> getAllSchds();//下拉選單

	int getPageTotal();
	
	SchdVO addOrUpdateSchd(SchdVO schd);
	
	void generateNewOrder(Integer schdNo, Integer aAtnNum);
	
	void cancelOrder(Integer schdNo, Integer aAtnNum);

}
