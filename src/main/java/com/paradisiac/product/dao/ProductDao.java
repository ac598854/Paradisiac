package com.paradisiac.product.dao;

import com.paradisiac.product.dto.ProductRequest;
import com.paradisiac.product.model.Product;

import java.util.List;

public interface ProductDao {
    List<Product> getProducts();

    Product getProductById(Integer productNo);

    Integer createProduct(ProductRequest productRequest);

    void updateProduct(Integer productNo, ProductRequest productRequest);

    void deleteProductById(Integer productNo);

}
