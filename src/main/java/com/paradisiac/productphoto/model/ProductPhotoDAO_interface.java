package com.paradisiac.productphoto.model;

import java.util.List;

public interface ProductPhotoDAO_interface {
	ProductPhotoVO insert(ProductPhotoVO prophoVO);
	int update(ProductPhotoVO prophoVO);
	int delete(Integer prophono);
	ProductPhotoVO getById(Integer prophono);
	List<ProductPhotoVO> getAll();
}
