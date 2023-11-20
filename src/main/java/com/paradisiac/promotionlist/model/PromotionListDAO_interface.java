package com.paradisiac.promotionlist.model;

import java.util.List;

public interface PromotionListDAO_interface {
	public Integer addPromotionList(PromotionVO proVO);
	public void updatePromotionList();
	public List<PromotionListVO> getProductList(Integer promotion);
	public List<PromotionListVO> getPrmotionList(Integer product);
}
