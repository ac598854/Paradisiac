package com.paradisiac.act.service;

import static com.paradisiac.department.service.Constants.PAGE_MAX_RESULT;

import java.util.List;
import java.util.Set;

import com.paradisiac.act.model.ActDAO_interface;
import com.paradisiac.act.model.ActHibernateDAO;
import com.paradisiac.act.model.ActVO;
import com.paradisiac.department.model.DeptDAOImpl;
import com.paradisiac.department.model.DeptDAO_interface;
import com.paradisiac.schd.model.SchdVO;
import com.paradisiac.util.HibernateUtil;

public class ActServiceImpl implements ActService{
	
	private ActDAO_interface dao;
	
	public ActServiceImpl() {
		dao = new ActHibernateDAO(HibernateUtil.getSessionFactory());
	}

//	@Override
//	public Integer addAct(ActVO act) {
//		try {
//			dao.insert(act);
//			return 1;
//		}catch(Exception e) {
//			return -1;
//		}
//	}
//
//	@Override
//	public ActVO updateAct(ActVO act) {
//		return dao.update(act);
//	}

	@Override
	public Set<SchdVO> getSchdByActno(Integer actno) {
		Set<SchdVO> actschdSet = dao.findByPrimaryKeyS(actno);
		return actschdSet;
	}

	@Override
	public ActVO getActByActno(Integer actno) {
		return dao.findByPrimaryKey(actno);
	}

	@Override
	public List<ActVO> getAllActs(int currentPage) {
		return dao.getAll(currentPage);
	}

	@Override
	public int getPageTotal() {
		long total = dao.getTotal();
		int pageQty = (int)(total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT) : (total / PAGE_MAX_RESULT + 1));
		return pageQty;
	}
	
	public List<ActVO> getAllActs(){ //下拉選單
		return dao.getAll();
	}
	
	public ActVO addOrUpdateAct(ActVO act) {
		return dao.insertOrUpdate(act);		
	}
	//前端的需求-------
	public List<ActVO> getAllActiveActs(int currentPage){
		return dao.getActiveAll(currentPage);
	}
	
	public int getPageActiveTotal() {
		long total = dao.getActiveTotal();
		int pageQty = (int)(total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT) : (total / PAGE_MAX_RESULT + 1));
		return pageQty;
	}
	
	public Set<SchdVO> getActiveSchdByActno(Integer actno){
		Set<SchdVO> actschdSet = dao.findByPrimaryKeyActiveS(actno);
		return actschdSet;
	}
	//-------------


}
