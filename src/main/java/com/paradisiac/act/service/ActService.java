package com.paradisiac.act.service;

import java.util.List;
import java.util.Set;

import com.paradisiac.act.model.ActVO;
import com.paradisiac.schd.model.SchdVO;

public interface ActService {
	Integer addAct(ActVO act);
	
	ActVO updateAct(ActVO act);
	
	Set<SchdVO> getSchdByActno(Integer actno);
	
	ActVO getActByActno(Integer actno);

	List<ActVO> getAllActs(int currentPage);
	
	List<ActVO> getAllActs();//下拉選單

	int getPageTotal();
}
