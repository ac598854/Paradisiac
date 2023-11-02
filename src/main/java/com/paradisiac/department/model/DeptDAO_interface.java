package com.paradisiac.department.model;

import java.util.List;
import java.util.Set;

import com.paradisiac.department.model.DeptVO;
import com.paradisiac.employee.model.EmpVO;


public interface DeptDAO_interface {
	//此介面定義增刪改查方法
	public Integer insert(DeptVO deptVO);
	
	public Integer update(DeptVO deptVO);
	
	public Integer delete(Integer deptNo);
	
	//public DeptVO findByPrimaryKey(Integer deptNo);
	
	public Set<EmpVO> findByPrimaryKeyE(Integer deptNo);//回傳員工集合
	
	public DeptVO findByPrimaryKey(Integer deptNo);
	
	public List<DeptVO> getAll(); //宣告泛型<DeptVO>
	
	List<DeptVO> getAll(int currentPage);
	
	long getTotal();
	
	List<DeptVO> getDeptsList();

}
