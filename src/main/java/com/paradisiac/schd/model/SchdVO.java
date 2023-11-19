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
	private Integer unpaidNum;
	@Column(name = "paid_num") //dafault 0
	private Integer paidNum;
	@Column(name = "anc_date", insertable = false) //null
	private Timestamp ancDate;  
	@Column(name = "drop_schd_date", insertable = false) //null
	private Timestamp drpoSchdDate;
	@Column(name = "holddate")
	private Timestamp holdate;
	@Column(name = "aplytime")
	private Timestamp aplytime;
	@Column(name = "cuttime")
	private Timestamp cuttime;
	@Column(name = "appl_status", columnDefinition = "TINYINT")
	private Integer applStatus;
	
	//建構子
	public SchdVO() {
		
	}
	public SchdVO(Integer schdNo, ActVO act, Integer unitPrice, Integer lowNum, Integer highNum, Integer unpaidNum,
			Integer paidNum, Timestamp ancDate, Timestamp drpoSchdDate, Timestamp holdate, Timestamp aplytime,
			Timestamp cuttime, Integer applStatus) {
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
		this.holdate = holdate;
		this.aplytime = aplytime;
		this.cuttime = cuttime;
		this.applStatus = applStatus;
	}
	//沒有上下架日期跟付款人/未付款人
	public SchdVO(Integer schdNo, ActVO act, Integer unitPrice, Integer lowNum, Integer highNum, Timestamp holdate, Timestamp aplytime,
			Timestamp cuttime, Integer applStatus) {
		super();
		this.schdNo = schdNo;
		this.act = act;
		this.unitPrice = unitPrice;
		this.lowNum = lowNum;
		this.highNum = highNum;
		this.holdate = holdate;
		this.aplytime = aplytime;
		this.cuttime = cuttime;
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
	public Timestamp getHoldate() {
		return holdate;
	}
	public void setHoldate(Timestamp holdate) {
		this.holdate = holdate;
	}
	public Timestamp getAplytime() {
		return aplytime;
	}
	public void setAplytime(Timestamp aplytime) {
		this.aplytime = aplytime;
	}
	public Timestamp getCuttime() {
		return cuttime;
	}
	public void setCuttime(Timestamp cuttime) {
		this.cuttime = cuttime;
	}
	public Integer getApplStatus() {
		return applStatus;
	}
	public void setApplStatus(Integer applStatus) {
		this.applStatus = applStatus;
	}

	
}
