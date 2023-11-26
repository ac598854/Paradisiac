package com.paradisiac.photo.service;

import java.util.List;

import com.paradisiac.photo.model.PhotoDAO_Interface;
import com.paradisiac.photo.model.PhotoHiberbateDAO;
import com.paradisiac.photo.model.PhotoVO;
import com.paradisiac.util.HibernateUtil;

public class PhotoServiceImpl implements PhotoService{
	private PhotoDAO_Interface dao;
	
	public PhotoServiceImpl() {
		dao = new PhotoHiberbateDAO(HibernateUtil.getSessionFactory());
	}

	@Override
	public void addPhoto(PhotoVO photo) {
		dao.insert(photo);
	}

	@Override
	public void updatePhoto(PhotoVO photo) {
		dao.update(photo);
	}

	@Override
	public void deletePhoto(Integer photoNo) {
		dao.delete(photoNo);
		
	}

	@Override
	public PhotoVO getPhotoByPK(Integer photoNo) {
		return dao.findByPrimaryKey(photoNo);
	}

	@Override
	public List<PhotoVO> getAllPhoto(int currentPage) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getPageTotal() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override //一次新增多張相片
	public void addPhoto(List<PhotoVO> photoList) {
		System.out.println("service:call insert()===================");
		dao.insert(photoList);
		
	}
	@Override //一次刪除多張相片
	public void deletePhoto(String[] selectedPhotos) {
		dao.delete(selectedPhotos); //送出要刪除的相片pk 字串list
		
	}



}
