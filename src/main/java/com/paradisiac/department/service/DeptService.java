package com.paradisiac.department.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.paradisiac.department.model.DeptVO;
import com.paradisiac.employee.model.EmpVO;


public interface DeptService {
	DeptVO addDept(DeptVO dept);
	
	DeptVO updateDept(DeptVO dept);
	
	void deleteDept(Integer deptno);
	
	Set<EmpVO> getDeptByDeptnoE(Integer deptno);
	
	DeptVO getDeptByDeptno(Integer deptno);
	//Set<EmpVO> getDeptByDeptno(Integer deptno);

	List<DeptVO> getAllDepts(int currentPage);

	int getPageTotal();
	

	
	
	

}
