package com.paradisiac.actorder.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Objects;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;



import com.paradisiac.actattendees.model.ActAttendees;
import com.paradisiac.employee.model.EmpVO;
import com.paradisiac.schd.model.SchdVO;
@Entity
@Table(name = "act_order")
public class ActOrder implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "act_order_no")
	private Integer actOrderNo;//一對多，一筆訂單主檔多個訂單明細
	
	
	@Column(name = "mem_no",nullable = false,updatable= false)//一個訂單一個會員
	private Integer memNo;
	
	@ManyToOne
	@JoinColumn(name = "schd_no",nullable = false,updatable= false,referencedColumnName ="schd_no")//一個訂單一個檔期
	private SchdVO schdVO;
	
	@ManyToOne
	@JoinColumn(name = "emp_no",insertable=false,referencedColumnName ="emp_no" )//一個員工處理多筆訂單，(多個資料表都有可能都是一個員工處理)
	private EmpVO empVO;
	
	@Column(name = "order_time",nullable = false,updatable= false)
	private Timestamp orderTime;
	
	@Column(name = "a_atn_num",nullable = false,updatable= false)
	private Integer aAtnNum;
	
	@Column(name = "order_status",nullable = false,columnDefinition ="TINYINT")
	private Integer orderStatus;
	
	@Column(name = "order_amount",nullable = false,updatable= false)//要取活動類別表格單價乘活動人數
	private Integer orderAmount;
	
	@OneToMany(mappedBy="actOrder",cascade=CascadeType.ALL)
	private Set<ActAttendees> actAttendees;

	public ActOrder() {
		super();
	}

	public Integer getActOrderNo() {
		return actOrderNo;
	}

	public void setActOrderNo(Integer actOrderNo) {
		this.actOrderNo = actOrderNo;
	}

	public Integer getMemNo() {
		return memNo;
	}

	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}

	public SchdVO getSchdVO() {
		return schdVO;
	}

	public void setSchdVO(SchdVO schdVO) {
		this.schdVO = schdVO;
	}

	public EmpVO getEmpVO() {
		return empVO;
	}

	public void setEmpVO(EmpVO empVO) {
		this.empVO = empVO;
	}

	public Timestamp getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Timestamp orderTime) {
		this.orderTime = orderTime;
	}

	public Integer getaAtnNum() {
		return aAtnNum;
	}

	public void setaAtnNum(Integer aAtnNum) {
		this.aAtnNum = aAtnNum;
	}

	public Integer getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(Integer orderStatus) {
		this.orderStatus = orderStatus;
	}

	public Integer getOrderAmount() {
		return orderAmount;
	}

	public void setOrderAmount(Integer orderAmount) {
		this.orderAmount = orderAmount;
	}
	

	public Set<ActAttendees> getActAttendees() {
		return actAttendees;
	}

	public void setActAttendees(Set<ActAttendees> actAttendees2) {
		this.actAttendees = (Set<ActAttendees>) actAttendees2;
	}

	@Override
	public int hashCode() {
		return Objects.hash(actOrderNo);//比對資料用優先序1
	}

	@Override
	public boolean equals(Object obj) {//比對資料用優先序1
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ActOrder other = (ActOrder) obj;
		return Objects.equals(actOrderNo, other.actOrderNo);
	}

	@Override
	public String toString() {
		return "ActOrder [actOrderNo=" + actOrderNo + ", memNo=" + memNo + ", schdVO=" + schdVO + ", empVO=" + empVO
				+ ", orderTime=" + orderTime + ", aAtnNum=" + aAtnNum + ", orderStatus=" + orderStatus
				+ ", orderAmount=" + orderAmount + ", actAttendees=" + actAttendees + "]";
	}



	
	
	
}
