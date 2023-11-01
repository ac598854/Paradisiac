//package com.paradisiac.productcategory.dao.impl;
//
//import com.paradisiac.productcategory.dao.ProductCategoryDao;
//import com.paradisiac.productcategory.model.ProductCategory;
//import com.paradisiac.productcategory.rowmapper.ProductCategoryRowMapper;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
//import org.springframework.stereotype.Component;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//@Component
//public class ProductCategoryDaoImpl implements ProductCategoryDao {
//
//    @Autowired
//    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
//
//
//    @Override
//    public ProductCategory getProductCategoryById(Integer productCategoryNo) {
//        String sql = "SELECT product_category_no, product_category_name, product_category_desc " +
//                "FROM product_category WHERE product_category_no = :productCategoryNo";
//
//        Map<String, Object> map = new HashMap<>();
//        map.put("productCategoryNo", productCategoryNo);
//
//        List<ProductCategory> productCategoryList = namedParameterJdbcTemplate
//                .query(sql, map, new ProductCategoryRowMapper());
//
//        if(productCategoryList.size() > 0 ){
//            return productCategoryList.get(0);
//        }else {
//            return null;
//        }
//    }
//}
