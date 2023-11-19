package com.paradisiac.promotionlist.service;

import java.util.List;

import com.paradisiac.promotionlist.model.ProductDAO_interface;
import com.paradisiac.promotionlist.model.ProductJDBCDAO;
import com.paradisiac.promotionlist.model.ProductVO;
import com.paradisiac.util.HibernateUtil;


public class ProductService {
	
	ProductDAO_interface productDAO;
	
	public ProductService() {
		productDAO = new  ProductJDBCDAO(HibernateUtil.getSessionFactory());
	}
	public List<ProductVO> getAll() {
		return  productDAO.getAll();
	}
}
