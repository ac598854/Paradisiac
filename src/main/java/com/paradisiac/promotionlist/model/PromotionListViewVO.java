package com.paradisiac.promotionlist.model;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;


import java.io.Serializable;
import java.util.Date;
import java.util.Objects;

@Entity
@Table(name = "promotion_details") // 如果視圖名稱與表名稱不同，請修改此處
public class PromotionListViewVO {
	
	@EmbeddedId
	private PromotionDetail detailKey;
	
	@Embeddable
	public static class PromotionDetail implements Serializable{
		private static final long serialVersionUID = 1L;
		@Column(name = "promotion_no")
	    private Integer promotionNo;
		@Column(name = "product_no")
	    private Integer productNo;
		
		public PromotionDetail() {
			super();
		}
		public PromotionDetail(Integer promotionNo,Integer productNo) {
			super();
			this.promotionNo = promotionNo;
			this.productNo = productNo;
		}
		public Integer getPromotionNo() {
			return promotionNo;
		}
		public void setPromotionNo(Integer promotionNo) {
			this.promotionNo = promotionNo;
		}
		public Integer getProductNo() {
			return productNo;
		}
		public void setProductNo(Integer productNo) {
			this.productNo = productNo;
		}
		@Override
		public int hashCode() {
			return Objects.hash(productNo, promotionNo);
		}
		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (obj == null)
				return false;
			if (getClass() != obj.getClass())
				return false;
			PromotionDetail other = (PromotionDetail) obj;
			return Objects.equals(productNo, other.productNo) && Objects.equals(promotionNo, other.promotionNo);
		}

	}
	@Column(name = "promotion_name")
    private String promotionName;
	@Column(name = "promotion_describition")
    private String promotionDescription;
	@Column(name = "promotion_start_date")
    private Date promotionStartDate;
	@Column(name = "promotion_end_date")
    private Date promotionEndDate;
	@Column(name = "promotion_discount", columnDefinition = "decimal(10,2)")
    private Double promotionDiscount;
	@Column(name = "promotion_status")
    private Boolean promotionStatus;
	

    public PromotionListViewVO() {
    }


	public PromotionDetail getDetailKey() {
		return detailKey;
	}


	public void setDetailKey(PromotionDetail detailKey) {
		this.detailKey = detailKey;
	}


	public String getPromotionName() {
		return promotionName;
	}


	public void setPromotionName(String promotionName) {
		this.promotionName = promotionName;
	}


	public String getPromotionDescription() {
		return promotionDescription;
	}


	public void setPromotionDescription(String promotionDescription) {
		this.promotionDescription = promotionDescription;
	}


	public Date getPromotionStartDate() {
		return promotionStartDate;
	}


	public void setPromotionStartDate(Date promotionStartDate) {
		this.promotionStartDate = promotionStartDate;
	}


	public Date getPromotionEndDate() {
		return promotionEndDate;
	}


	public void setPromotionEndDate(Date promotionEndDate) {
		this.promotionEndDate = promotionEndDate;
	}


	public Double getPromotionDiscount() {
		return promotionDiscount;
	}


	public void setPromotionDiscount(Double promotionDiscount) {
		this.promotionDiscount = promotionDiscount;
	}


	public Boolean getPromotionStatus() {
		return promotionStatus;
	}


	public void setPromotionStatus(Boolean promotionStatus) {
		this.promotionStatus = promotionStatus;
	}
    

}