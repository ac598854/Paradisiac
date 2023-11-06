package com.paradisiac.product.dao;

import com.paradisiac.product.dto.ProductQueryParams;
import com.paradisiac.product.dto.ProductRequest;
import com.paradisiac.product.model.Product;

import java.util.List;

public interface ProductDao {
    List<Product> getProducts(ProductQueryParams productQueryParams);

    Product getProductById(Integer productId);

    Integer createProduct(ProductRequest productRequest);

    void updateProduct (Integer productId, ProductRequest productRequest);

    void updateStock(Integer productId, Integer stock);

    void deleteProductById (Integer productId);

    Integer countProduct (ProductQueryParams productQueryParams);

}
