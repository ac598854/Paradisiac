package com.paradisiac.act.model;

import java.util.List;
import java.util.Set;

import com.paradisiac.schd.model.SchdVO;


public interface ActDAO_interface {
	
    public int insert(ActVO actVO);
    
    public ActVO update(ActVO actVO);
    
    public ActVO findByPrimaryKey(Integer actNo);
    //查所有檔期
    public Set<SchdVO> findByPrimaryKeyS(Integer actNo);
    
    public List<ActVO> getAll(); //下拉選單用
	
    public List<ActVO> getAll(int currentPage);
	
	long getTotal();
	
	public ActVO insertOrUpdate(ActVO actVO);
	
	
	
}
