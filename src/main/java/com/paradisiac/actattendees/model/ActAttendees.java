package com.paradisiac.actattendees.model;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.paradisiac.actorder.model.ActOrder;
@Entity
@Table(name = "act_attendees")
public class ActAttendees {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "atn_no")
	private Integer atnNo;
	
	@ManyToOne
	@JoinColumn(name="act_order_no",referencedColumnName = "act_order_no")
	private ActOrder actOrder;
	
	@Column(name="atn_name")
	private String atnName;
	
	@Column(name="atn_id_number")
	private String atnIdNumber;
	
	@Column(name="atn_tel")
	private String atnTel;

	public ActAttendees() {
		super();
	}

	public Integer getAtnNo() {
		return atnNo;
	}

	public void setAtnNo(Integer atnNo) {
		this.atnNo = atnNo;
	}

	public ActOrder getActOrder() {
		return actOrder;
	}

	public void setActOrder(ActOrder actOrder) {
		this.actOrder = actOrder;
	}

	public String getAtnName() {
		return atnName;
	}

	public void setAtnName(String atnName) {
		this.atnName = atnName;
	}

	public String getAtnIdNumber() {
		return atnIdNumber;
	}

	public void setAtnIdNumber(String atnIdNumber) {
		this.atnIdNumber = atnIdNumber;
	}

	public String getAtnTel() {
		return atnTel;
	}

	public void setAtnTel(String atnTel) {
		this.atnTel = atnTel;
	}

	@Override
	public int hashCode() {
		return Objects.hash(atnNo);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ActAttendees other = (ActAttendees) obj;
		return Objects.equals(atnNo, other.atnNo);
	}

	@Override
	public String toString() {
		return "ActAttendees [atnNo=" + atnNo + ", atnName=" + atnName + ", atnIdNumber=" + atnIdNumber + ", atnTel="
				+ atnTel + "]";
	}


	
}
