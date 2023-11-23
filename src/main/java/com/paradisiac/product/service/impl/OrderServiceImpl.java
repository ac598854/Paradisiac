package com.paradisiac.product.service.impl;

import com.paradisiac.product.dao.ProductDao;
import com.paradisiac.product.dto.OrderQueryParams;
import com.paradisiac.product.model.Product;
import com.paradisiac.product.dao.OrderDao;
import com.paradisiac.product.dto.BuyItem;
import com.paradisiac.product.dto.CreateOrderRequest;
import com.paradisiac.product.model.Members;
import com.paradisiac.product.model.Order;
import com.paradisiac.product.model.OrderItem;
import com.paradisiac.product.service.OrderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Component
public class OrderServiceImpl implements OrderService {
    private final static Logger log = LoggerFactory.getLogger(OrderServiceImpl.class);

    @Autowired
    private OrderDao orderDao;

//    @Autowired
//    private UserDao userDao;

    @Autowired
    private ProductDao productDao;

//    @Override
//    public void isUserExist(Integer userId) {
//        User user =  userDao.getUserById(userId);
//
//        if(user == null){
//            log.warn("The user {} does not exist", userId);
//            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
//        }
//    }

    @Override
    public Integer countOrder(OrderQueryParams orderQueryParams) {
        return orderDao.countOrder(orderQueryParams);
    }

    @Override
    public List<Order> getOrders(OrderQueryParams orderQueryParams) {
        List<Order> orderList = orderDao.getOrders(orderQueryParams);

        for(Order order : orderList){
            List<OrderItem> orderItemList = orderDao.getOrderItemByOrderId(order.getOrderId());

            order.setOrderItemList(orderItemList);
        }
        return orderList;
    }

    @Override
    public Order getOrderById(Integer orderId) {
        Order order = orderDao.getOrderById(orderId);

        List<OrderItem> orderItemList = orderDao.getOrderItemByOrderId(orderId);
        order.setOrderItemList(orderItemList);

        return order;

    }

    @Transactional // 確保兩者同時新增成功，或是同時不新增成功
    @Override
    public Integer createOrder(Integer memno, CreateOrderRequest createOrderRequest) {

        int totalAmount = 0;
        List<OrderItem> orderItemList = new ArrayList<>();

        for(BuyItem buyItem: createOrderRequest.getBuyItemList()){
            Product product = productDao.getProductByIdForUpdate(buyItem.getProductId());

            //檢查 product 是否存在 stock是否足夠
            if(product == null){
                log.warn("The product {} does not exist", buyItem.getProductId());
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
            }else if(product.getStock() < buyItem.getQuantity()){
                log.warn("The quantity of product {} is insufficient and cannot be purchased. " +
                                "Remaining inventory {}, want to buy {}",
                        buyItem.getProductId(), product.getStock(), buyItem.getQuantity());
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "庫存不足！");
            }

            //扣除商品庫存
            productDao.updateStock(product.getProductId(), product.getStock() - buyItem.getQuantity());

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
        Integer orderId = orderDao.createOrder(memno, createOrderRequest );

        orderDao.createOrderItems(orderId, orderItemList);

        return orderId;
    }

    @Override
    public Members getMemberDetailsById(Integer memno) {
        return orderDao.getMemberById(memno);
    }
}
