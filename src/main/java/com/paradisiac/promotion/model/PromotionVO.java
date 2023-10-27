package com.paradisiac.promotion.model;

import java.io.Serializable;
import java.sql.Date;
 
public class PromotionVO implements Serializable{
/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//	促銷編號 促銷專案名稱 促銷專案描述 促銷專案開始日期
//	促銷專案結束日期 促銷專案折扣 促銷專案狀態
	private Integer prono;
	private String proname;
	private String prodes;
	private Date startdate;
	private Date enddate;
	private Double discount;
	private Integer status;
	
	public PromotionVO() {
		
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

	public  Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
	

}
