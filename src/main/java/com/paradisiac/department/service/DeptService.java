package com.paradisiac.department.service;

import java.util.List;
import java.util.Map;

import com.paradisiac.department.model.DeptVO;


public interface DeptService {
	DeptVO addDept(DeptVO dept);
	
	DeptVO updateDept(DeptVO dept);
	
	void deleteDept(Integer deptno);
	
	DeptVO getDeptByDeptno(Integer deptno);

	List<DeptVO> getAllDepts(int currentPage);

	int getPageTotal();
	

	
	
	

}
