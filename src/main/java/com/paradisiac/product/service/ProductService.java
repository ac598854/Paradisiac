package com.paradisiac.product.service;

import com.paradisiac.product.dto.ProductQueryParams;
import com.paradisiac.product.dto.ProductRequest;
import com.paradisiac.product.model.Product;

import java.util.List;

public interface ProductService {
    List<Product> getProducts(ProductQueryParams productQueryParams);

    Product getProductById(Integer productId);

    Integer createProduct(ProductRequest productRequest);

    void updateProduct(Integer productId, ProductRequest productRequest);

    void deleteProductById(Integer productId);

    Integer countProduct(ProductQueryParams productQueryParams);

}
