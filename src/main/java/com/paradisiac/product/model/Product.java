package com.paradisiac.product.model;

public class Product {
    private Integer productNo;
    private Integer productCategoryNo;
    private String productName;
    private Integer productPrice;
    private Integer productQuantity;
    private Boolean productStatus;
    private Integer productTotalReviewCount;
    private Integer productTotalReviewStatus;

    public Integer getProductNo() {
        return productNo;
    }

    public void setProductNo(Integer productNo) {
        this.productNo = productNo;
    }

    public Integer getProductCategoryNo() {
        return productCategoryNo;
    }

    public void setProductCategoryNo(Integer productCategoryNo) {
        this.productCategoryNo = productCategoryNo;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Integer getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(Integer productPrice) {
        this.productPrice = productPrice;
    }

    public Integer getProductQuantity() {
        return productQuantity;
    }

    public void setProductQuantity(Integer productQuantity) {
        this.productQuantity = productQuantity;
    }

    public Boolean getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(Boolean productStatus) {
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
