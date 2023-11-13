package com.paradisiac.product.dao;

import com.paradisiac.product.dto.CreateOrderRequest;
import com.paradisiac.product.dto.OrderQueryParams;
import com.paradisiac.product.model.Order;
import com.paradisiac.product.model.OrderItem;

import java.util.List;

public interface OrderDao {

    Integer countOrder(OrderQueryParams orderQueryParams);

    List<Order> getOrders(OrderQueryParams orderQueryParams);

    Order getOrderById (Integer orderId);

    List<OrderItem> getOrderItemByOrderId(Integer orderId);

    Integer createOrder(Integer memno, CreateOrderRequest createOrderRequest);

    void  createOrderItems(Integer orderId, List<OrderItem> orderItemList);

}
