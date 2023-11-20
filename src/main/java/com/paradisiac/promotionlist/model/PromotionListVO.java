package com.paradisiac.promotionlist.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name = "promotion_product_detail")
public class PromotionListVO {
	
	 	@Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY) // 使用資料庫的自增機制
	    @Column(name = "product_promotion")
	 	private int id;//Long比較適合自增主鍵
	 	
	 	@ManyToOne
		@JoinColumn(name = "product_no", referencedColumnName = "product_id")
		private ProductVO product;
		
		// fetch 預設為 EAGER
		@ManyToOne
		@JoinColumn(name = "promotion_no", referencedColumnName = "promotion_no")
		private PromotionVO promotion;

		public ProductVO getProduct() {
			return product;
		}

		public void setProduct(ProductVO product) {
			this.product = product;
		}

		public PromotionVO getPromotion() {
			return promotion;
		}

		public void setPromotion(PromotionVO promotion) {
			this.promotion = promotion;
		}
	 	
		
	 	
	 	
	 	
}	
