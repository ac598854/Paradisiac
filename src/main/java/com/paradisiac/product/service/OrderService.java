package com.paradisiac.product.service;

import com.paradisiac.product.dto.CreateOrderRequest;
import com.paradisiac.product.dto.OrderQueryParams;
import com.paradisiac.product.model.Order;

import java.util.List;

public interface OrderService {

    void isUserExist(Integer userId);

    Integer countOrder(OrderQueryParams orderQueryParams);

    List<Order> getOrders(OrderQueryParams orderQueryParams);

    Order getOrderById(Integer orderId);

    Integer createOrder(Integer userId, CreateOrderRequest createOrderRequest);


}
