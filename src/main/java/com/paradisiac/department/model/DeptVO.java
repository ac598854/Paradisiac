package com.paradisiac.department.model;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.google.gson.annotations.Expose;
import com.paradisiac.employee.model.*;
import com.paradisiac.fuc.model.*;


@Entity
@Table(name = "department")
public class DeptVO implements java.io.Serializable{
	
	@Expose
	@Id
	@Column(name = "dept_no" , updatable = false) //更新時這個屬性不需輸入
	private Integer deptNo;
	
	@Expose
	@Column(name = "dept_name")
	private String deptName;
	
	@Expose
	@Column(name = "fuc_no")
	private Integer fucNo;
	
	@Expose
	@Column(name = "dept_status")
	private boolean deptStatus;
	
	public Integer getFucNo() {
		return fucNo;
	}

	public void setFucNo(Integer fucNo) {
		this.fucNo = fucNo;
	}

	public boolean isDeptStatus() {
		return deptStatus;
	}

	public void setDeptStatus(boolean deptStatus) {
		this.deptStatus = deptStatus;
	}
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
	
	public DeptVO(Integer deptNo, String deptName,  Integer fucNo, boolean deptStatus) {
		this.deptNo = deptNo;
		this.deptName = deptName;
		this.fucNo = fucNo;
		this.deptStatus = deptStatus;
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
	
	//join fuc_no from fuc
	public com.paradisiac.fuc.model.FucVO getFucVO(){//Integer deptNo
		com.paradisiac.fuc.service.Fuc_Service fucSvc= new com.paradisiac.fuc.service.Fuc_ServiceImpl();
		com.paradisiac.fuc.model.FucVO fucVO = fucSvc.getFucByFucNo(fucNo);
		return fucVO;
	}

	

}
