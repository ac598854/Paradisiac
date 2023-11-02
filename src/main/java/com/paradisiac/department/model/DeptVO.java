package com.paradisiac.department.model;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.google.gson.annotations.Expose;
import com.paradisiac.employee.model.*;


@Entity
@Table(name = "department")
public class DeptVO implements java.io.Serializable{
	
	@Expose
	@Id
	@Column(name = "dept_no" , updatable = false)
	private Integer deptNo;
	
	@Expose
	@Column(name = "dept_name")
	private String deptName;
	
	//新增一個變數為員工集合, 集合裡放EmpVO====================
	@Expose
	@OneToMany(mappedBy = "dept", cascade = CascadeType.ALL)
	@OrderBy("emp_no asc")
	private Set<EmpVO> emps;
	
	public Set<EmpVO> getEmps() {
		return emps;
	}

	public void setEmps(Set<EmpVO> emps) {
		this.emps = emps;
	}

	//=================================================
	
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
