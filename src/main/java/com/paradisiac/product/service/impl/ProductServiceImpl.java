package com.paradisiac.product.service.impl;

import com.paradisiac.product.dao.ProductDao;
import com.paradisiac.product.dto.ProductQueryParams;
import com.paradisiac.product.dto.ProductRequest;
import com.paradisiac.product.model.Product;
import com.paradisiac.product.rowmapper.ProductRowMapper;
import com.paradisiac.product.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDao productDao;

    @Autowired
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;


    @Override
    public List<Product> getProducts(ProductQueryParams productQueryParams) {
        return productDao.getProducts(productQueryParams);
    }

    @Override
    public Product getProductById(Integer productId) {
        return productDao.getProductById(productId);
    }

    @Override
    public Integer createProduct(ProductRequest productRequest) {
        return productDao.createProduct(productRequest);
    }

    @Override
    public void updateProduct(Integer productId, ProductRequest productRequest) {
        productDao.updateProduct(productId, productRequest);
    }

    @Override
    public void deleteProductById(Integer productId) {
        productDao.deleteProductById(productId);
    }

    @Override
    public Integer countProduct(ProductQueryParams productQueryParams) {
        return productDao.countProduct(productQueryParams);
    }

    @Override
    public List<Product> getAllProductsForCart() {
        String sql = "SELECT product_id, product_name, category, image_url, price, stock, " +
                "description, created_date, last_modified_date, status " +
                "from product";

        return namedParameterJdbcTemplate.query(sql, new ProductRowMapper());
    }

}
