package com.paradisiac.employee.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.google.gson.annotations.Expose;
import com.paradisiac.department.model.DeptVO;



@Entity
@Table(name = "employee")
public class EmpVO implements java.io.Serializable{
	
	public EmpVO(){
		
	}
	
	public EmpVO(Integer empno,String empPass){
		
	}


	@Expose
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)//自增主鍵
	@Column(name = "emp_no", updatable = false)
	private Integer empno;
	
	// fetch 預設為 EAGER
	@Expose
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "dept_no", referencedColumnName = "dept_no")	
	private DeptVO dept;
	
//	@Expose
//	@Column(name = "dept_no")
//	private Integer deptno;
	
	@Expose
	@Column(name = "emp_status", columnDefinition = "tinyint")	
	private Integer empStatus;
	
	@Expose
	@Column(name = "emp_name")
	private String empName;
	
	@Expose
	@Column(name = "emp_mail")
	private String empMail;
	
	@Expose
	@Column(name = "emp_account")
	private String empAccount;
	
	@Expose
	@Column(name = "emp_pass")
	private String empPass;
	
	@Expose
	@Column(name = "emp_gender", columnDefinition = "tinyint")
	private Integer empGender;
	
	@Expose
	@Column(name = "emp_phone")
	private String empPhone;
	

	public Integer getEmpno() {
		return empno;
	}
	public void setEmpno(Integer empno) {
		this.empno = empno;
	}
	//=======聯合映射=================
	public DeptVO getDept() {
		return dept;
	}
	public void setDeptVO(DeptVO dept) {
		this.dept = dept;
	}
	//==============================
	public Integer getEmpStatus() {
		return empStatus;
	}
	public void setEmpStatus(Integer empStatus) {
		this.empStatus = empStatus;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getEmpAccount() {
		return empAccount;
	}
	public void setEmpAccount(String empAccount) {
		this.empAccount = empAccount;
	}
	public String getEmpPass() {
		return empPass;
	}
	public void setEmpPass(String empPass) {
		this.empPass = empPass;
	}
	public Integer getEmpGender() {
		return empGender;
	}
	public void setEmpGender(Integer empGender) {
		this.empGender = empGender;
	}
	public String getEmpPhone() {
		return empPhone;
	}
	public void setEmpPhone(String empPhone) {
		this.empPhone = empPhone;
	}
	public String getEmpMail() {
		return empMail;
	}
	public void setEmpMail(String empEmail) {
		this.empMail = empEmail;
	}
	
	//for join deptName from deptNo
//	public com.paradisiac.department.model.DeptVO getDeptVO(){
//		com.paradisiac.department.service.DeptServiceImpl deptSvc = new com.paradisiac.department.service.DeptServiceImpl();
//		com.paradisiac.department.model.DeptVO deptVO = deptSvc.getDeptByDeptno(deptno); //deptno是EmpVO class的變數(不是DeptVO的deptNo)
//		return deptVO;
//	}
	


	


}
