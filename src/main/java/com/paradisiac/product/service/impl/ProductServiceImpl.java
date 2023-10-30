package com.paradisiac.product.service.impl;

import com.paradisiac.product.dao.ProductDao;
import com.paradisiac.product.model.Product;
import com.paradisiac.product.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDao productDao;

    @Override
    public Product getProductById(Integer productNo) {
        return productDao.getProductById(productNo);
    }
}
