package com.paradisiac.shoporder.service.impl;

import com.paradisiac.product.dao.ProductDao;
import com.paradisiac.product.model.Product;
import com.paradisiac.shoporder.dao.OrderDao;
import com.paradisiac.shoporder.dto.BuyItem;
import com.paradisiac.shoporder.dto.CreateOrderRequest;
import com.paradisiac.shoporder.model.OrderItem;
import com.paradisiac.shoporder.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Component
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private ProductDao productDao;

    @Transactional // 確保兩者同時新增成功，或是同時不新增成功
    @Override
    public Integer createOrder(Integer memNo, CreateOrderRequest createOrderRequest) {
        int totalAmount = 0;
        List<OrderItem> orderItemList = new ArrayList<>();

        for(BuyItem buyItem: createOrderRequest.getBuyItemList()){
            Product product = productDao.getProductById(buyItem.getProductId());

            //計算總價錢
            int amount = buyItem.getQuantity() * product.getPrice();
            totalAmount = totalAmount + amount;

            // 轉換 BuyItem to OrderItem
            OrderItem orderItem = new OrderItem();
            orderItem.setProductId(buyItem.getProductId());
            orderItem.setQuantity(buyItem.getQuantity());
            orderItem.setAmount(amount);

            orderItemList.add(orderItem);
        }

        // 創建訂單
        Integer orderId = orderDao.createOrder(memNo, totalAmount);

        orderDao.createOrderItems(orderId, orderItemList);

        return orderId;
    }
}
