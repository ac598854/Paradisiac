package com.paradisiac.actorder.model;

import java.sql.Timestamp;

public class ActOrderVO implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	private Integer actorderno;
	private Integer memno;
	private Integer schdno;
	private Integer empno;
	private Timestamp ordertime;
	private Integer aatnnum;
	private Boolean orderstatus;
	private Integer paymethod;
	private Boolean paystatus;
	private Timestamp paytime;
	private Integer orderamount;

	public ActOrderVO() {
	}

	public ActOrderVO(Integer actorderno, Integer memno, Integer schdno, Integer empno, Timestamp ordertime,
			Integer aatnnum, Boolean orderstatus, Integer paymethod, Boolean paystatus, Timestamp paytime,
			Integer orderamount) {
		super();
		this.actorderno = actorderno;
		this.memno = memno;
		this.schdno = schdno;
		this.empno = empno;
		this.ordertime = ordertime;
		this.aatnnum = aatnnum;
		this.orderstatus = orderstatus;
		this.paymethod = paymethod;
		this.paystatus = paystatus;
		this.paytime = paytime;
		this.orderamount = orderamount;
	}

	public Integer getActorderno() {
		return actorderno;
	}

	public void setActorderno(Integer actorderno) {
		this.actorderno = actorderno;
	}

	public Integer getMemno() {
		return memno;
	}

	public void setMemno(Integer memno) {
		this.memno = memno;
	}

	public Integer getSchdno() {
		return schdno;
	}

	public void setSchdno(Integer schdno) {
		this.schdno = schdno;
	}

	public Integer getEmpno() {
		return empno;
	}

	public void setEmpno(Integer empno) {
		this.empno = empno;
	}

	public Timestamp getOrdertime() {
		return ordertime;
	}

	public void setOrdertime(Timestamp ordertime) {
		this.ordertime = ordertime;
	}

	public Integer getAatnnum() {
		return aatnnum;
	}

	public void setAatnnum(Integer aatnnum) {
		this.aatnnum = aatnnum;
	}

	public Boolean getOrderstatus() {
		return orderstatus;
	}

	public void setOrderstatus(Boolean orderstatus) {
		this.orderstatus = orderstatus;
	}

	public Integer getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(Integer paymethod) {
		this.paymethod = paymethod;
	}

	public Boolean getPaystatus() {
		return paystatus;
	}

	public void setPaystatus(Boolean paystatus) {
		this.paystatus = paystatus;
	}

	public Timestamp getPaytime() {
		return paytime;
	}

	public void setPaytime(Timestamp paytime) {
		this.paytime = paytime;
	}

	public Integer getOrderamount() {
		return orderamount;
	}

	public void setOrderamount(Integer orderamount) {
		this.orderamount = orderamount;
	}

	

	

}