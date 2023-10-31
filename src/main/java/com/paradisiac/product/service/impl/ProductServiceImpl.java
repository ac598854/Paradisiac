package com.paradisiac.product.service.impl;

import com.paradisiac.product.dao.ProductDao;
import com.paradisiac.product.dto.ProductRequest;
import com.paradisiac.product.model.Product;
import com.paradisiac.product.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDao productDao;

    @Override
    public List<Product> getProducts() {
        return productDao.getProducts();
    }
    @Override
    public Product getProductById(Integer productNo) {
        return productDao.getProductById(productNo);
    }

    @Override
    public Integer createProduct(ProductRequest productRequest) {
        return productDao.createProduct(productRequest);
    }

    @Override
    public void updateProduct(Integer productNo, ProductRequest productRequest) {
        productDao.updateProduct(productNo, productRequest);
    }

    @Override
    public void deleteProductById(Integer productNo) {
        productDao.deleteProductById(productNo);
    }
}
