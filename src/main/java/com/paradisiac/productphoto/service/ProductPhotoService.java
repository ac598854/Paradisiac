package com.paradisiac.productphoto.service;

import java.util.List;


import com.paradisiac.productphoto.model.ProductPhotoDAO_interface;
import com.paradisiac.productphoto.model.ProductPhotoDAO;
import com.paradisiac.productphoto.model.ProductPhotoVO;
import com.paradisiac.util.HibernateUtil;
	


public class ProductPhotoService {
	public ProductPhotoDAO_interface photoDAO;
	
	public ProductPhotoService() {
	photoDAO= new ProductPhotoDAO(HibernateUtil.getSessionFactory());
	}
	
	public ProductPhotoVO insert(ProductPhotoVO prophoVO) {
		return photoDAO.insert(prophoVO);
	}
	public int update(ProductPhotoVO prophoVO) {
		return photoDAO.update(prophoVO);
		
	}
	public int delete(Integer prophono) {
		return photoDAO.delete(prophono);

	}
	public ProductPhotoVO getByNo(Integer productno) {
		return photoDAO.getByNo(productno);
		
	}
	public List<ProductPhotoVO> getAll(){
		return photoDAO.getAll();
	
	}
	

}
