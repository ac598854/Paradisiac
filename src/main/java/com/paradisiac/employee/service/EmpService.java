package com.paradisiac.employee.service;

import java.util.List;

import com.paradisiac.employee.model.EmpJDBCDAO;
import com.paradisiac.employee.model.EmpDAO_interface;
import com.paradisiac.employee.model.EmpVO;

public class EmpService {
	private EmpDAO_interface dao;
	
	public EmpService() {
		dao = new EmpJDBCDAO(); //EmpJDBCDAO 已實作 EmpDAO_interface
	}

	
	//以下是service的增刪改查方法=====================================================
	public EmpVO updateEmp(Integer empno, Integer deptno, Integer empStatus,
			String empName, String empMail, String empAccount, String empPass, Integer empGender, String empPhone) {

		EmpVO empVO = new EmpVO();

		empVO.setEmpno(empno);
		empVO.setDeptno(deptno);
		empVO.setEmpStatus(empStatus);
		empVO.setEmpName(empName);
		empVO.setEmpMail(empMail);
		empVO.setEmpAccount(empAccount);
		empVO.setEmpPass(empPass);
		empVO.setEmpGender(empGender);
		empVO.setEmpPhone(empPhone);
		
		dao.update(empVO);

		return empVO;
	}

	public void deleteEmp(Integer empno) {
		dao.delete(empno);
	}

	public EmpVO getOneEmp(Integer empno) {
		return dao.findByPrimaryKey(empno);
	}

	public List<EmpVO> getAll() {
		return dao.getAll();
	}
	
	public EmpVO addEmp(Integer empno, Integer deptno, Integer empStatus,
			String empName, String empMail, String empAccount, String empPass, Integer empGender, String empPhone) {

		EmpVO empVO = new EmpVO();

		empVO.setEmpno(empno);
		empVO.setDeptno(deptno);
		empVO.setEmpStatus(empStatus);
		empVO.setEmpName(empName);
		empVO.setEmpMail(empMail);
		empVO.setEmpAccount(empAccount);
		empVO.setEmpPass(empPass);
		empVO.setEmpGender(empGender);
		empVO.setEmpPhone(empPhone);
		
		dao.insert(empVO);

		return empVO; //把屬性設定好打包成EmpVO型別的物件回傳
	}

}
