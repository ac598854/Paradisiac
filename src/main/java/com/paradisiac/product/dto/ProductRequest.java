package com.paradisiac.product.dto;

import org.springframework.lang.NonNull;

public class ProductRequest {
    @NonNull
    private Integer productNo;
    @NonNull
    private Integer productCategoryNo;
    @NonNull
    private String productName;
    @NonNull
    private Integer productPrice;
    @NonNull
    private Integer productQuantity;
    @NonNull
    private Boolean productStatus;
    private Integer productTotalReviewCount;
    private Integer productTotalReviewStatus;

    @NonNull
    public Integer getProductNo() {
        return productNo;
    }

    public void setProductNo(@NonNull Integer productNo) {
        this.productNo = productNo;
    }

    @NonNull
    public Integer getProductCategoryNo() {
        return productCategoryNo;
    }

    public void setProductCategoryNo(@NonNull Integer productCategoryNo) {
        this.productCategoryNo = productCategoryNo;
    }

    @NonNull
    public String getProductName() {
        return productName;
    }

    public void setProductName(@NonNull String productName) {
        this.productName = productName;
    }

    @NonNull
    public Integer getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(@NonNull Integer productPrice) {
        this.productPrice = productPrice;
    }

    @NonNull
    public Integer getProductQuantity() {
        return productQuantity;
    }

    public void setProductQuantity(@NonNull Integer productQuantity) {
        this.productQuantity = productQuantity;
    }

    @NonNull
    public Boolean getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(@NonNull Boolean productStatus) {
        this.productStatus = productStatus;
    }

    public Integer getProductTotalReviewCount() {
        return productTotalReviewCount;
    }

    public void setProductTotalReviewCount(Integer productTotalReviewCount) {
        this.productTotalReviewCount = productTotalReviewCount;
    }

    public Integer getProductTotalReviewStatus() {
        return productTotalReviewStatus;
    }

    public void setProductTotalReviewStatus(Integer productTotalReviewStatus) {
        this.productTotalReviewStatus = productTotalReviewStatus;
    }
}
