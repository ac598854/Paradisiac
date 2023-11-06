package com.paradisiac.product.dto;

import com.paradisiac.product.dto.BuyItem;

import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import java.util.List;

public class CreateOrderRequest {
    @Valid
    @NotEmpty
    private List<BuyItem> buyItemList;

    public List<BuyItem> getBuyItemList() {
        return buyItemList;
    }

    public void setBuyItemList(List<BuyItem> buyItemList) {
        this.buyItemList = buyItemList;
    }
}
