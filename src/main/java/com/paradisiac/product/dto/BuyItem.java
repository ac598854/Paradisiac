package com.paradisiac.product.dto;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

public class BuyItem {

    @NotNull
    private Integer productId;

    @Min(1)
    @NotNull
    private Integer quantity;

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
}
