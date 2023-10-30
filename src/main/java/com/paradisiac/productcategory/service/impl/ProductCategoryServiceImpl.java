package com.paradisiac.productcategory.service.impl;

import com.paradisiac.productcategory.dao.ProductCategoryDao;
import com.paradisiac.productcategory.model.ProductCategory;
import com.paradisiac.productcategory.service.ProductCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ProductCategoryServiceImpl implements ProductCategoryService {

    @Autowired
    private ProductCategoryDao productcategoryDao;

    @Override
    public ProductCategory getProductCategoryById(Integer productCategoryNo) {
        return productcategoryDao.getProductCategoryById(productCategoryNo);
    }

}
