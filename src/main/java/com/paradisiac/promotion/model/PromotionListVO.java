package com.paradisiac.promotion.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "promotion_product_detail")
public class PromotionListVO {
	
	 	@Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY) // 使用資料庫的自增機制
	    @Column(name = "product_promotion")
	 	private Long id;//Long比較適合自增主鍵
	 	
	 	
	 	@Column(name = "product_no")
	 	private Integer productNo;
	 	
	 	@Column(name = "promotion_no")
	 	private Integer promotionNo;
	 	
	 	
		@Override
		public String toString() {
			return "ProductListVO [商品編號=" + productNo + ", 促銷編號=" + promotionNo + "]";
		}
		
		public Integer getProductNo() {
			return productNo;
		}
		public void setProductNo(Integer productNo) {
			this.productNo = productNo;
		}
		public Integer getPromotionNo() {
			return promotionNo;
		}
		public void setPromotionNo(Integer promotionNo) {
			this.promotionNo = promotionNo;
		}
	 	
	 	
	 	
}	
