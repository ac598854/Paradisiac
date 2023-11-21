package com.paradisiac.promotionlist.model;


import java.sql.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;


@Entity
@Table(name = "promotion")
public class PromotionVO {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "promotion_no", updatable = false)
	private Integer prono;
	@Column(name = "promotion_name")
	private String proname;
	@Column(name = "promotion_describition")
	private String prodes;
	@Column(name = "promotion_start_date")
	private Date startdate;
	@Column(name = "promotion_end_date")
	private Date enddate;
	@Column(name = "promotion_discount", columnDefinition = "decimal(10,2)")
	private Double discount;
	@Column(name = "promotion_status")
	private Boolean status;


	public PromotionVO() {
		
	}

	
	@OneToMany(mappedBy = "promotion", cascade = CascadeType.ALL)
	@OrderBy("promotion_no")
	private Set<PromotionListVO> promotionLists;
	
	

	public void setPromotionLists(Set<PromotionListVO> promotionLists) {
		this.promotionLists = promotionLists;
	}

	public Integer getProno() {
		return prono;
	}

	public void setProno(Integer prono) {
		this.prono = prono;
	}

	public String getProname() {
		return proname;
	}

	public void setProname(String proname) {
		this.proname = proname;
	}

	public String getProdes() {
		return prodes;
	}

	public void setProdes(String prodes) {
		this.prodes = prodes;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public Double getDiscount() {
		return discount;
	}

	public void setDiscount(Double discount) {
		this.discount = discount;
	}

	public  Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}
	
	
	

}
