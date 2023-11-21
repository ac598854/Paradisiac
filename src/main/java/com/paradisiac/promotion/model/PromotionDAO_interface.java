package com.paradisiac.promotion.model;

import java.util.List;

 
public interface PromotionDAO_interface {
	public Integer insert(PromotionVO proVO);
    public void update(PromotionVO proVO);
    public void delete(Integer prono);
    public PromotionVO findByPrimaryKey(Integer prono);
    public List<PromotionVO> getAll();
}
