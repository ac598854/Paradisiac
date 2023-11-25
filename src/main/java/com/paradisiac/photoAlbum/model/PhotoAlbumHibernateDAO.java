package com.paradisiac.photoAlbum.model;

import static com.paradisiac.department.service.Constants.PAGE_MAX_RESULT;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.paradisiac.photoAlbum.model.PhotoAlbumVO;
import com.paradisiac.util.HibernateUtil;
import com.paradisiac.filter.OpenSessionInViewFilter;
import com.paradisiac.photo.model.PhoWithAlbDTO;



public class PhotoAlbumHibernateDAO implements PhotoAlbumDAO_interface{
	//不用再下SQL指令, 載入驅動, 關閉連線
	//不用再pstmt裡set參數
	private SessionFactory factory;

	public PhotoAlbumHibernateDAO(SessionFactory factory) {
		this.factory = factory;
	}
	
	private Session getSession() {
		return factory.getCurrentSession();
	}

	
	//===新增===============================================

	@Override
	public int insert(PhotoAlbumVO phaVO) {
		try {
			getSession().save(phaVO);
			return 1;
		} catch (Exception e) {
			return -1;
		}		 	
	}
	//===修改===============================================
	@Override
	public PhotoAlbumVO update(PhotoAlbumVO phaVO) {
		getSession().update(phaVO);
		return phaVO;		
	}
	//===刪除===============================================
	@Override
	public int delete(Integer albNo) {
		PhotoAlbumVO phaVO = getSession().get(PhotoAlbumVO.class, albNo);
		if (phaVO != null) {
			getSession().delete(phaVO);
			// 回傳給 service，1代表刪除成功
			return 1;
		} else {
			// 回傳給 service，-1代表刪除失敗
			return -1;
		}
		
	}
	//===查單筆===============================================
	@Override
	public PhotoAlbumVO findByPrimaryKey(Integer albNo) {
		return getSession().get(PhotoAlbumVO.class, albNo);
	}
	//下拉式選單在用的getAll
	@Override
	public List<PhotoAlbumVO> getAll() {
		List phaList = getSession().createQuery("from PhotoAlbumVO", PhotoAlbumVO.class).list();
		return phaList;
	}
	//===查多筆===============================================
	@Override
	public List<PhotoAlbumVO> getAll(int currentPage) {
		int first = (currentPage - 1) * PAGE_MAX_RESULT;
		return getSession().createQuery("from PhotoAlbumVO", PhotoAlbumVO.class)
				.setFirstResult(first)
				.setMaxResults(PAGE_MAX_RESULT)
				.list();
	}
	
	@Override
	public long getTotal() {
		return getSession().createQuery("select count(*) from PhotoAlbumVO", Long.class).uniqueResult();
	}
	//查詢全部相片============================================
	@Override
	public List<PhoWithAlbDTO> searchAllPhoto(Integer albNo){	
		List<PhoWithAlbDTO> list = getSession()
			       .createQuery("from PhoWithAlbDTO where albNo = :albNo", PhoWithAlbDTO.class)
			       .setParameter("albNo", albNo)
			       .list();
		return list;
	}
	
	@Override
	public List<PhoWithAlbDTO> searchAllPhoto(Integer albNo, int currentPage){
		int first = (currentPage - 1) * PAGE_MAX_RESULT;
		List<PhoWithAlbDTO> list = getSession()
			       .createQuery("from PhoWithAlbDTO where albNo = :albNo", PhoWithAlbDTO.class)
			       .setParameter("albNo", albNo)
			       .setFirstResult(first)
			       .setMaxResults(PAGE_MAX_RESULT)
			       .list();
		return list;
	}
	
	@Override
	public int getTotalQty(Integer albNo) {
		long total= getSession().createQuery("select count(*) from PhoWithAlbDTO where albNo = :albNo", Long.class)
				.setParameter("albNo", albNo)
				.uniqueResult(); //總筆數

		int pageQty = (int)(total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT) : (total / PAGE_MAX_RESULT + 1));
		return pageQty;
			
	}
	//用會員編號查相簿編號=======================================
	public Integer findByMem(Integer memno) {
		String hql = "SELECT albNo FROM PhotoAlbumVO WHERE memNo = :memno";
		Integer pha = (Integer) getSession().createQuery(hql, Integer.class).setParameter("memno", memno).uniqueResult();
		
	    return pha;//資料庫設定一位會員只有一本相本

	}


	

}
