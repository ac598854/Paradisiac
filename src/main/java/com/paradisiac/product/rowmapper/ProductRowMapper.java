package com.paradisiac.product.rowmapper;

import com.paradisiac.product.model.Product;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductRowMapper implements RowMapper<Product> {

    @Override
    public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
        Product product = new Product();

        product.setProductNo(rs.getInt("product_no"));
        product.setProductCategoryNo(rs.getInt("product_category_no"));
        product.setProductName(rs.getString("product_name"));
        product.setProductPrice(rs.getInt("product_price"));
        product.setProductQuantity(rs.getInt("product_quantity"));
        product.setProductStatus(rs.getBoolean("product_status"));
        product.setProductTotalReviewCount((rs.getInt("product_total_review_count")));
        product.setProductTotalReviewStatus(rs.getInt("product_total_review_status"));

        return product;
    }
}
