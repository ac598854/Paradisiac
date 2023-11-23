package com.paradisiac.act.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.paradisiac.schd.model.SchdVO;

import java.util.Set;

@Entity
@Table(name = "act")
public class ActVO  implements java.io.Serializable{
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)//自增主鍵
	@Column(name = "act_no", updatable = false)
	private Integer actNo;
	@Column(name = "act_name")
	private String actName;
	@Column(name = "unit_price")
	private Integer unitPrice;
	@Column(name = "act_status")
	private boolean actStatus;
	@Column(name = "act_content")
	private String actContent;
	@Column(name = "act_photo1", columnDefinition = "mediumblobtext")
	private byte[] actPho1;
	@Column(name = "act_photo2", columnDefinition = "mediumblobtext")
	private byte[] actPho2;
	
//==============================
	@OneToMany(mappedBy = "act", cascade = CascadeType.ALL)
	@OrderBy("schd_no asc")
	private Set<SchdVO> schds;
	
	public Set<SchdVO> getSchds() {
		return schds;
	}

	public void setSchds(Set<SchdVO> schds) {
		this.schds = schds;
	}
//==============================	
	public ActVO() {
		super();
	}
	
	public ActVO(String actName, Integer unitPrice, boolean actStatus,
			String actContent) {
		super();
		this.actName = actName;
		this.unitPrice = unitPrice;
		this.actStatus = actStatus;
		this.actContent = actContent;

	}

	public Integer getActNo() {
		return actNo;
	}

	public void setActNo(Integer actNo) {
		this.actNo = actNo;
	}

	public String getActName() {
		return actName;
	}

	public void setActName(String actName) {
		this.actName = actName;
	}

	public Integer getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
	}

	public boolean isActStatus() {
		return actStatus;
	}

	public void setActStatus(boolean actStatus) {
		this.actStatus = actStatus;
	}

	public String getActContent() {
		return actContent;
	}

	public void setActContent(String actContent) {
		this.actContent = actContent;
	}

	public byte[] getActPho1() {
		return actPho1;
	}

	public void setActPho1(byte[] actPho1) {
		this.actPho1 = actPho1;
	}

	public byte[] getActPho2() {
		return actPho2;
	}

	public void setActPho2(byte[] actPho2) {
		this.actPho2 = actPho2;
	}




	
	

}
