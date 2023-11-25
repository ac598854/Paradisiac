package com.paradisiac.schd.model;

import static com.paradisiac.department.service.Constants.PAGE_MAX_RESULT_Schd;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.paradisiac.act.model.ActVO;

public class SchdHibernateDAO implements SchdDAO_Interface{
	
	private SessionFactory factory;

	public SchdHibernateDAO(SessionFactory factory) {
		this.factory = factory;
	}
	
	private Session getSession() {
		return factory.getCurrentSession();
	}
	//查單筆
	@Override
	public SchdVO findByPrimaryKey(Integer schdNO) {
		return getSession().get(SchdVO.class, schdNO);
	}
	//查全部(下拉選單-依照活動編號排列)
	@Override
	public List<SchdVO> getAll() {
		List<SchdVO> schdList = getSession().createQuery("from SchdVO order by act.actNo", SchdVO.class).list();
		return schdList;
	}
	//查全部
	@Override
	public List<SchdVO> getAll(int currentPage) {
		int first = (currentPage - 1) * PAGE_MAX_RESULT_Schd;
		return getSession().createQuery("from SchdVO order by act.actNo", SchdVO.class)
				.setFirstResult(first)
				.setMaxResults(PAGE_MAX_RESULT_Schd)
				.list();
	}
	
	@Override
	public long getTotal() {
		return getSession().createQuery("select count(*) from SchdVO", Long.class).uniqueResult();
	}
	//新增或修改
	@Override
	public SchdVO insertOrUpdate(SchdVO schdVO) {
		getSession().saveOrUpdate(schdVO);
		return schdVO;
	}

	@Override
	public void addPaidNum(Integer schdNo, Integer aAtnNum) {		
		Query query = getSession().createQuery("UPDATE SchdVO SET paidNum = paidNum + :aAtnNum WHERE schdNo = :schdNo");
	    query.setParameter("schdNo", schdNo); 
	    query.setParameter("aAtnNum", aAtnNum); 
	    
	    query.executeUpdate();
	}
	
	@Override
	public void reducePaidNum(Integer schdNo, Integer aAtnNum) {		
		Query query = getSession().createQuery("UPDATE SchdVO SET paidNum = paidNum - :aAtnNum WHERE schdNo = :schdNo");
	    query.setParameter("schdNo", schdNo); 
	    query.setParameter("aAtnNum", aAtnNum); 
	    
	    query.executeUpdate();
	}

}
