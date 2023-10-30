package com.paradisiac.employee.model;

public class EmpVO implements java.io.Serializable{
	private Integer empno;
	private Integer deptno;
	private Integer empStatus;
	private String empName;
	private String empMail;
	private String empAccount;
	private String empPass;
	private Integer empGender;
	private String empPhone;
	
	public Integer getEmpno() {
		return empno;
	}
	public void setEmpno(Integer empno) {
		this.empno = empno;
	}
	public Integer getDeptno() {
		return deptno;
	}
	public void setDeptno(Integer deptno) {
		this.deptno = deptno;
	}
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
	public com.paradisiac.department.model.DeptVO getDeptVO(){
		com.paradisiac.department.service.DeptServiceImpl deptSvc = new com.paradisiac.department.service.DeptServiceImpl();
		com.paradisiac.department.model.DeptVO deptVO = deptSvc.getDeptByDeptno(deptno); //deptno是EmpVO class的變數(不是DeptVO的deptNo)
		return deptVO;
	}

	


}
