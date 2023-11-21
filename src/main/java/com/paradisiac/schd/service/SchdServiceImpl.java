package com.paradisiac.schd.service;

import static com.paradisiac.department.service.Constants.PAGE_MAX_RESULT_Schd;

import java.util.List;

import com.paradisiac.schd.model.SchdDAO_Interface;
import com.paradisiac.schd.model.SchdHibernateDAO;
import com.paradisiac.schd.model.SchdVO;
import com.paradisiac.util.HibernateUtil;

public class SchdServiceImpl implements SchdService{
	
	private SchdDAO_Interface dao;
	
	public SchdServiceImpl() {
		dao = new SchdHibernateDAO(HibernateUtil.getSessionFactory());
	}
	

	@Override
	public SchdVO getSchdBySchdno(Integer schdno) {
		return dao.findByPrimaryKey(schdno);
	}

	@Override
	public List<SchdVO> getAllSchds(int currentPage) {
		return dao.getAll(currentPage);
	}

	@Override
	public List<SchdVO> getAllSchds() {
		return dao.getAll();
	}

	@Override
	public int getPageTotal() {
		long total = dao.getTotal();
		int pageQty = (int)(total % PAGE_MAX_RESULT_Schd == 0 ? (total / PAGE_MAX_RESULT_Schd) : (total / PAGE_MAX_RESULT_Schd + 1));
		return pageQty;
	}

	@Override
	public SchdVO addOrUpdateSchd(SchdVO schd) {
		return dao.insertOrUpdate(schd);
	}

}
