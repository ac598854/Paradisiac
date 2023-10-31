package com.paradisiac.productcategory.dto;

import org.springframework.lang.NonNull;

public class ProductCategoryRequest {

    @NonNull
    private Integer productCategoryNo;

    @NonNull
    private String productCategoryName;

    private String productCategoryDesc;

    @NonNull
    public Integer getProductCategoryNo() {
        return productCategoryNo;
    }

    public void setProductCategoryNo(@NonNull Integer productCategoryNo) {
        this.productCategoryNo = productCategoryNo;
    }

    @NonNull
    public String getProductCategoryName() {
        return productCategoryName;
    }

    public void setProductCategoryName(@NonNull String productCategoryName) {
        this.productCategoryName = productCategoryName;
    }

    public String getProductCategoryDesc() {
        return productCategoryDesc;
    }

    public void setProductCategoryDesc(String productCategoryDesc) {
        this.productCategoryDesc = productCategoryDesc;
    }
}
