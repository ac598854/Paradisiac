package com.paradisiac.fuc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "fuc")
public class FucVO implements java.io.Serializable{
	
	@Id
	@Column(name = "fuc_no")
	private Integer fucNo;
	
	@Column(name = "fuc_name")
	private String fucName;

	public Integer getFucNo() {
		return fucNo;
	}

	public void setFucNo(Integer fucNo) {
		this.fucNo = fucNo;
	}

	public String getFucName() {
		return fucName;
	}

	public void setFucName(String fucName) {
		this.fucName = fucName;
	}


}
