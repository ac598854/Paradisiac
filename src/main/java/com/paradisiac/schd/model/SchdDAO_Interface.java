package com.paradisiac.schd.model;

import java.util.List;
import java.util.Set;

import com.paradisiac.schd.model.SchdVO;

public interface SchdDAO_Interface {
//    public int insert(SchdVO schdVO);
//    
//    public SchdVO update(SchdVO schdVO);
    
    public SchdVO findByPrimaryKey(Integer schdNO);
    
    public List<SchdVO> getAll(); //下拉選單用
	
    public List<SchdVO> getAll(int currentPage);
	
	long getTotal();
	
	public SchdVO insertOrUpdate(SchdVO schdVO);
}
