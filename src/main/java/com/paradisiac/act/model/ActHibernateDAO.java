package com.paradisiac.act.model;

import static com.paradisiac.department.service.Constants.PAGE_MAX_RESULT;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.paradisiac.schd.model.SchdVO;

public class ActHibernateDAO implements ActDAO_interface{
	
	private SessionFactory factory;

	public ActHibernateDAO(SessionFactory factory) {
		this.factory = factory;
	}
	
	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override //查單筆活動
	public ActVO findByPrimaryKey(Integer actNo) {
		return getSession().get(ActVO.class, actNo);
	}
	
	@Override //查單筆活動(所有檔期)
	public Set<SchdVO> findByPrimaryKeyS(Integer actNo){
		Set<SchdVO> actSchdSet = getSession().get(ActVO.class , actNo).getSchds(); 
		return actSchdSet;
	}

	@Override //下拉選單
	public List<ActVO> getAll() {
		List<ActVO> actList = getSession().createQuery("from ActVO", ActVO.class).list();
		return actList;
	}

	@Override//查全部(分頁)
	public List<ActVO> getAll(int currentPage) {
		int first = (currentPage - 1) * PAGE_MAX_RESULT;
		return getSession().createQuery("from ActVO order", ActVO.class)//order by actNo desc
				.setFirstResult(first)
				.setMaxResults(PAGE_MAX_RESULT)
				.list();
	}

	@Override
	public long getTotal() {
		return getSession().createQuery("select count(*) from ActVO", Long.class).uniqueResult();
	}
	
	public ActVO insertOrUpdate(ActVO actVO) {
		getSession().saveOrUpdate(actVO);
		return actVO;
	}
	//前端的需求-------
	public List<ActVO> getActiveAll(int currentPage){
		int first = (currentPage - 1) * PAGE_MAX_RESULT; //布林
		return getSession().createQuery("from ActVO where actStatus=:status", ActVO.class)
				.setParameter("status", true)
				.setFirstResult(first)
				.setMaxResults(PAGE_MAX_RESULT)
				.list();
	}
	
	@Override
	public long getActiveTotal() {
		return getSession().createQuery("select count(*) from ActVO where actStatus=:status", Long.class)
				.setParameter("status", true)
				.uniqueResult();
	}
	
	public Set<SchdVO> findByPrimaryKeyActiveS(Integer actNo){
		return new HashSet<SchdVO>(getSession().createQuery(	//schds 是檔期集合Set<SchdVO> schds, s是代號                    
	                            "select s from ActVO a join a.schds s " +
	                                    "where a.actNo = :actNo " +
	                                    "and s.ancDate < current_timestamp() " + //上架時間早於現在
	                                    "and s.drpoSchdDate > current_timestamp()", //下架時間晚於現在
	                            SchdVO.class)
	                    .setParameter("actNo", actNo)
	                    .getResultList()
	    );
	}
	//-------------

}
