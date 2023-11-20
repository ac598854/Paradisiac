package com.paradisiac.schd.model;

import java.sql.Timestamp;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.paradisiac.act.model.ActVO;

@Entity
@Table(name = "schd")
public class SchdVO implements java.io.Serializable{

//	private Integer schdNo;
//	private Integer actNo;
//	private Integer unitPrice;
//	private Integer lowNum;
//	private Integer highNum;
//	private Integer unpaidNum;
//	private Integer paidNum;
//	private Timestamp ancDate;  
//	private Timestamp drpoSchdDate;
//	private Timestamp holdDate;
//	private Timestamp aplyTime;
//	private Timestamp cutTime;
//	private Integer applStatus;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "schd_no", updatable = false)
	private Integer schdNo;
	
	//private Integer actNo;
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "act_no", referencedColumnName = "act_no", updatable = false)
	private ActVO act;
	
	@Column(name = "unit_price")
	private Integer unitPrice;
	
	@Column(name = "low_num")
	private Integer lowNum;
	
	@Column(name = "high_num")
	private Integer highNum;
	
	@Column(name = "unpaid_num") //dafault 0
	private Integer unpaidNum = 0;
	
	@Column(name = "paid_num") //dafault 0
	private Integer paidNum = 0;
	
	@Column(name = "anc_date") //null
	private Timestamp ancDate; 
	
	@Column(name = "drop_schd_date") //null
	private Timestamp drpoSchdDate;
	
	@Column(name = "holddate")
	private Timestamp holdDate;
	
	@Column(name = "aplytime")
	private Timestamp aplyTime;
	
	@Column(name = "cuttime")
	private Timestamp cutTime;
	
	@Column(name = "appl_status", columnDefinition = "TINYINT")//1:報名中 2:成團 3:未成團 4:因故取消
	private Integer applStatus;
	
	//建構子
	public SchdVO() {
		
	}
	public SchdVO(Integer schdNo, ActVO act, Integer unitPrice, Integer lowNum, Integer highNum, Integer unpaidNum,
			Integer paidNum, Timestamp ancDate, Timestamp drpoSchdDate, Timestamp holdDate, Timestamp aplyTime,
			Timestamp cutTime, Integer applStatus) {
		super();
		this.schdNo = schdNo;
		this.act = act;
		this.unitPrice = unitPrice;
		this.lowNum = lowNum;
		this.highNum = highNum;
		this.unpaidNum = unpaidNum;
		this.paidNum = paidNum;
		this.ancDate = ancDate;
		this.drpoSchdDate = drpoSchdDate;
		this.holdDate = holdDate;
		this.aplyTime = aplyTime;
		this.cutTime = cutTime;
		this.applStatus = applStatus;
	}
	//沒有上下架日期跟付款人/未付款人
	public SchdVO(ActVO act, Integer unitPrice, Integer lowNum, Integer highNum, Timestamp holddate, Timestamp aplytime,
			Timestamp cuttime, Integer applStatus) {
		super();
		this.schdNo = schdNo;
		this.act = act;
		this.unitPrice = unitPrice;
		this.lowNum = lowNum;
		this.highNum = highNum;
		this.holdDate = holddate;
		this.aplyTime = aplytime;
		this.cutTime = cuttime;
		this.applStatus = applStatus;
	}
	
	public Integer getSchdNo() {
		return schdNo;
	}
	public void setSchdNo(Integer schdNo) {
		this.schdNo = schdNo;
	}
	public ActVO getAct() {
		return act;
	}
	public void setAct(ActVO act) {
		this.act = act;
	}
	public Integer getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
	}
	public Integer getLowNum() {
		return lowNum;
	}
	public void setLowNum(Integer lowNum) {
		this.lowNum = lowNum;
	}
	public Integer getHighNum() {
		return highNum;
	}
	public void setHighNum(Integer highNum) {
		this.highNum = highNum;
	}
	public Integer getUnpaidNum() {
		return unpaidNum;
	}
	public void setUnpaidNum(Integer unpaidNum) {
		this.unpaidNum = unpaidNum;
	}
	public Integer getPaidNum() {
		return paidNum;
	}
	public void setPaidNum(Integer paidNum) {
		this.paidNum = paidNum;
	}
	public Timestamp getAncDate() {
		return ancDate;
	}
	public void setAncDate(Timestamp ancDate) {
		this.ancDate = ancDate;
	}
	public Timestamp getDrpoSchdDate() {
		return drpoSchdDate;
	}
	public void setDrpoSchdDate(Timestamp drpoSchdDate) {
		this.drpoSchdDate = drpoSchdDate;
	}
	public Timestamp getHoldDate() {
		return holdDate;
	}
	public void setHoldDate(Timestamp holdDate) {
		this.holdDate = holdDate;
	}
	public Timestamp getAplyTime() {
		return aplyTime;
	}
	public void setAplytime(Timestamp aplytime) {
		this.aplyTime = aplyTime;
	}
	public Timestamp getCutTime() {
		return cutTime;
	}
	public void setCuttime(Timestamp cutTime) {
		this.cutTime = cutTime;
	}
	public Integer getApplStatus() {
		return applStatus;
	}
	public void setApplStatus(Integer applStatus) {
		this.applStatus = applStatus;
	}

	
}
