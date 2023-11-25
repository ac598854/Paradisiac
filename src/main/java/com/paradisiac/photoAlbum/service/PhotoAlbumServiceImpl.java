package com.paradisiac.photoAlbum.service;


import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.paradisiac.photo.model.PhoWithAlbDTO;
import com.paradisiac.photoAlbum.model.PhotoAlbumDAO_interface;
import com.paradisiac.photoAlbum.model.PhotoAlbumHibernateDAO;
import com.paradisiac.photoAlbum.model.PhotoAlbumVO;

import com.paradisiac.util.HibernateUtil;

public class PhotoAlbumServiceImpl implements PhotoAlbumService_interface{
	final public static int PAGE_MAX_RESULT = 3;
	private PhotoAlbumDAO_interface dao;
	
	public PhotoAlbumServiceImpl() {
		dao = new PhotoAlbumHibernateDAO(HibernateUtil.getSessionFactory());

	}

	@Override
	public int addPha(PhotoAlbumVO phaVO) {
		try {
			dao.insert(phaVO);
			return 1;
		} catch (Exception e) {
			return -1;
		}
	}

	@Override
	public PhotoAlbumVO updatePha(PhotoAlbumVO phaVO) {
		dao.update(phaVO);
		return phaVO;
	}

	@Override
	public void deletePha(Integer albNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public PhotoAlbumVO getPhaByPK(Integer albNo) {
		return dao.findByPrimaryKey(albNo);
	}

	@Override 
	public List<PhotoAlbumVO> getAllPha(int currentPage) {
		return dao.getAll(currentPage);
	}

	@Override
	public int getPageTotal() {
		long total = dao.getTotal();
		// 計算數量每頁3筆的話總共有幾頁
		int pageQty = (int)(total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT) : (total / PAGE_MAX_RESULT + 1));
		return pageQty;
	}

	@Override
	public List<PhotoAlbumVO> getPhaByCompositeQuery(Map<String, String[]> map) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public Integer getPhaByMem(Integer memno) {
		return dao.findByMem(memno);
	}



}
