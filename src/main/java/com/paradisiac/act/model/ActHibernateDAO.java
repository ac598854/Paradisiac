package com.paradisiac.act.model;

import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.paradisiac.schd.model.SchdVO;

import static com.paradisiac.department.service.Constants.PAGE_MAX_RESULT;

public class ActHibernateDAO implements ActDAO_interface{
	
	private SessionFactory factory;

	public ActHibernateDAO(SessionFactory factory) {
		this.factory = factory;
	}
	
	private Session getSession() {
		return factory.getCurrentSession();
	}
	//新增
	@Override
	public int insert(ActVO actVO) {
		try {
			getSession().save(actVO);
			return 1;
		} catch (Exception e) {
			return -1;
		}	
	}
	//修改
	@Override
	public ActVO update(ActVO actVO) {
		getSession().update(actVO);
		return actVO;	
	}

	@Override //查單筆活動
	public ActVO findByPrimaryKey(Integer actNo) {
		return getSession().get(ActVO.class, actNo);
	}
	
	@Override //查單筆活動(所有檔期)
	public Set<SchdVO> findByPrimaryKeyS(Integer actNo){
		Set<SchdVO> actSchdSet = getSession().get(ActVO.class, actNo).getSchds(); 
		return actSchdSet;
	}

	@Override //下拉選單
	public List<ActVO> getAll() {
		List actList = getSession().createQuery("from ActVO", ActVO.class).list();
		return actList;
	}

	@Override//查全部(分頁)
	public List<ActVO> getAll(int currentPage) {
		int first = (currentPage - 1) * PAGE_MAX_RESULT;
		return getSession().createQuery("from ActVO", ActVO.class)
				.setFirstResult(first)
				.setMaxResults(PAGE_MAX_RESULT)
				.list();
	}

	@Override
	public long getTotal() {
		return getSession().createQuery("select count(*) from ActVO", Long.class).uniqueResult();
	}


}
