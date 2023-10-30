package com.paradisiac.department.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "department")
public class DeptVO implements java.io.Serializable{
	@Id
	@Column(name = "dept_no")
	private Integer deptNo;
	@Column(name = "dept_name")
	private String deptName;
	
	public DeptVO() {
		
	}
	
	public DeptVO(Integer deptNo, String deptName) {
		this.deptNo = deptNo;
		this.deptName = deptName;
	}
	
	public Integer getDeptNo() {
		return deptNo;
	}
	public void setDeptNo(Integer deptNo) {
		this.deptNo = deptNo;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}


}
