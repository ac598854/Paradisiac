package com.paradisiac.product.dao.impl;

import com.paradisiac.product.dto.ProductRequest;
import com.paradisiac.product.model.Product;
import com.paradisiac.product.dao.ProductDao;
import com.paradisiac.product.rowmapper.ProductRowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class ProductDaoImpl implements ProductDao {

    @Autowired
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    @Override
    public List<Product> getProducts() {
        String sql = "SELECT product_no, product_category_no, product_name, product_price, product_quantity, " +
                "product_status, product_total_review_count, product_total_review_status " +
                "FROM product";

        Map<String, Object> map = new HashMap<>();

        List<Product> productList = namedParameterJdbcTemplate.query(sql, map, new ProductRowMapper());

        return productList;
    }

    @Override
    public Product getProductById(Integer productNo) {
        String sql = "SELECT product_no, product_category_no, product_name, product_price, product_quantity, " +
                "product_status, product_total_review_count, product_total_review_status " +
                "FROM product WHERE product_no = :productNo";

        Map<String, Object> map = new HashMap<>();
        map.put("productNo", productNo);

        List<Product> productList = namedParameterJdbcTemplate
                .query(sql, map, new ProductRowMapper());

        if(productList.size() > 0 ){
            return productList.get(0);
        }else {
            return null;
        }
    }

    @Override
    public Integer createProduct(ProductRequest productRequest) {
        String sql = "INSERT INTO product(product_category_no, product_name, product_price, product_quantity, " +
                "product_status, product_total_review_count, product_total_review_status ) " +
                "VALUE (:productCategoryNo, :productName, :productPrice, :productQuantity, :productStatus," +
                ":productTotalReviewCount, :productTotalReviewStatus)";

        Map<String, Object> map = new HashMap<>();
        map.put("productCategoryNo", productRequest.getProductCategoryNo());
        map.put("productName", productRequest.getProductName());
        map.put("productPrice", productRequest.getProductPrice());
        map.put("productQuantity", productRequest.getProductQuantity());
        map.put("productStatus", productRequest.getProductStatus());
        map.put("productTotalReviewCount", productRequest.getProductTotalReviewCount());
        map.put("productTotalReviewStatus", productRequest.getProductTotalReviewStatus());

        // 儲存資料庫自動生成的productId
        KeyHolder keyHolder = new GeneratedKeyHolder();

        namedParameterJdbcTemplate.update(sql, new MapSqlParameterSource(map), keyHolder);

        int productNo = keyHolder.getKey().intValue();

        return productNo;

    }

    @Override
    public void updateProduct(Integer productNo, ProductRequest productRequest) {
        String sql = "UPDATE product SET product_category_no = :productCategoryNo, product_name = :productName, product_price = :productPrice, " +
                "product_quantity = :productQuantity, product_status = :productStatus, product_total_review_count = :productTotalReviewCount, " +
                "product_total_review_status = :productTotalReviewStatus " +
                "WHERE product_no = :productNo";

        Map<String, Object> map = new HashMap<>();
        map.put("productNo", productNo);

        map.put("productCategoryNo", productRequest.getProductCategoryNo());
        map.put("productName", productRequest.getProductName());
        map.put("productPrice", productRequest.getProductPrice());
        map.put("productQuantity", productRequest.getProductQuantity());
        map.put("productStatus", productRequest.getProductStatus());
        map.put("productTotalReviewCount", productRequest.getProductTotalReviewCount());
        map.put("productTotalReviewStatus", productRequest.getProductTotalReviewStatus());

        namedParameterJdbcTemplate.update(sql, map);

    }

    @Override
    public void deleteProductById(Integer productNo) {
        String sql = "DELETE FROM product WHERE product_no = :productNo";

        Map<String, Object> map = new HashMap<>();
        map.put("productNo", productNo);

        namedParameterJdbcTemplate.update(sql, map);
    }

}
