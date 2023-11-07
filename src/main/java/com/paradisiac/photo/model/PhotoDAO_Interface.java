package com.paradisiac.photo.model;

import java.util.List;


public interface PhotoDAO_Interface {
	public void insert(PhotoVO photoVO);
	
	public void update(PhotoVO photoVO);
	
	public void delete(Integer photoVO);
	
	public PhotoVO findByPrimaryKey(Integer photoVO);
	
	public List<PhotoVO> getAll(); //宣告泛型<PhotoVO>
	
	List<PhotoVO> getAll(int currentPage);
	
	long getTotal();
	
	List<PhotoVO> getPhotosList();
	
	public void insert(List<PhotoVO> photoList);
	
	public void delete(String[] selectedPhotos);

}
