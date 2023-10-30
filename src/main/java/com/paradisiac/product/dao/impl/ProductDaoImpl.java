package com.paradisiac.product.dao.impl;

import com.paradisiac.product.model.Product;
import com.paradisiac.product.dao.ProductDao;
import com.paradisiac.product.rowmapper.ProductRowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class ProductDaoImpl implements ProductDao {

    @Autowired
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;

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

}
