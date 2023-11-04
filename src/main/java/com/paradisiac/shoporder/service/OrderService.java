package com.paradisiac.shoporder.service;

import com.paradisiac.shoporder.dto.CreateOrderRequest;

public interface OrderService {

    Integer createOrder(Integer memNo, CreateOrderRequest createOrderRequest);
}
