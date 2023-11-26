package com.paradisiac.promotionlist.model;

import java.util.List;

public interface PromotionListDAO_interface {
	public Integer addPromotionList(PromotionVO proVO,String selectedProducts);
	public Integer updatePro(PromotionVO proVO,String selectedProducts);
	public Integer addOrUpdatePromotionList(PromotionVO proVO, String selectedProducts);
	public List<PromotionListVO> getProductList(Integer promotion);
	public List<PromotionVO> getAll();
	public List<Integer> getProductnoFromView(Integer promotionNO);
	public PromotionVO getById(Integer promotionNO);
}
