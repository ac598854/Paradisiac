package com.paradisiac.shoporder.dao;

import com.paradisiac.shoporder.model.OrderItem;

import java.util.List;

public interface OrderDao {
    Integer createOrder(Integer memNo, Integer totalAmount);

    void  createOrderItems(Integer orderId, List<OrderItem> orderItemList);

}
