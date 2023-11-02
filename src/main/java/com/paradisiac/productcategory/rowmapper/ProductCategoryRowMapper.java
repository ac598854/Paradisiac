package com.paradisiac.productcategory.rowmapper;

import com.paradisiac.productcategory.model.ProductCategory;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductCategoryRowMapper implements RowMapper<ProductCategory> {

    @Override
    public ProductCategory mapRow(ResultSet rs, int rowNum) throws SQLException {
        ProductCategory productCategory = new ProductCategory();

        productCategory.setProductCategoryNo(rs.getInt("product_category_no"));
        productCategory.setProductCategoryName(rs.getString("product_category_name"));
        productCategory.setProductCategoryDesc(rs.getString("product_category_desc"));

        return productCategory;
    }
}

//    // String 轉 Enum
//    String categoryStr = rs.getString("category");
//    ProductCategory category = ProductCategory.valueOf(categoryStr);
//        product.setCategory(category);
//
//// 簡化寫法
////        product.setCategory(ProductCategory.valueOf(rs.getString("category")));
