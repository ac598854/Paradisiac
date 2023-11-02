package com.paradisiac.department.service;

import static com.paradisiac.department.service.Constants.PAGE_MAX_RESULT;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.Session;

import com.paradisiac.department.model.DeptDAOImpl;
import com.paradisiac.department.model.DeptDAO_interface;
import com.paradisiac.department.model.DeptVO;
import com.paradisiac.employee.model.EmpVO;
import com.paradisiac.util.HibernateUtil;

public class DeptServiceImpl implements DeptService{
	//private static final long PAGE_MAX_RESULT = 3;
	private DeptDAO_interface dao;
	
	public DeptServiceImpl() {
		dao = new DeptDAOImpl(HibernateUtil.getSessionFactory());
	}

	@Override
	public DeptVO addDept(DeptVO dept) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public DeptVO updateDept(DeptVO dept) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteDept(Integer deptno) {
		// TODO Auto-generated method stub
		
	}
//================================================
	@Override
	public Set<EmpVO> getDeptByDeptnoE(Integer deptno) {
		Set<EmpVO> deptEmpSet = dao.findByPrimaryKeyE(deptno);
		return deptEmpSet;
	}
	
	@Override
	public DeptVO getDeptByDeptno(Integer deptno) {
		return dao.findByPrimaryKey(deptno);
			
	}
	


	@Override
	public List<DeptVO> getAllDepts(int currentPage) {
		return dao.getAll(currentPage);
	}

	@Override
	public int getPageTotal() {
		long total = dao.getTotal();
		// 計算Emp數量每頁3筆的話總共有幾頁
		int pageQty = (int)(total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT) : (total / PAGE_MAX_RESULT + 1));
		return pageQty;
	}
	

	public List<DeptVO> getAll() {
		return dao.getAll();

	}




}
