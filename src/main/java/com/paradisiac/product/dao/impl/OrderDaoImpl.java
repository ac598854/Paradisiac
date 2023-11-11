package com.paradisiac.product.dao.impl;

import com.paradisiac.product.dao.OrderDao;
import com.paradisiac.product.dto.CreateOrderRequest;
import com.paradisiac.product.dto.OrderQueryParams;
import com.paradisiac.product.model.Order;
import com.paradisiac.product.model.OrderItem;
import com.paradisiac.product.rowmapper.OrderItemRowMapper;
import com.paradisiac.product.rowmapper.OrderRowMapper;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class OrderDaoImpl implements OrderDao {

    @Autowired
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    //計算訂單
    @Override
    public Integer countOrder(OrderQueryParams orderQueryParams) {
        String sql = "SELECT count(*) FROM psorder WHERE 1 = 1";

        Map<String, Object> map = new HashMap<>();

        //查詢條件
        sql = addFilteringSql(sql, map, orderQueryParams);

        Integer total = namedParameterJdbcTemplate.queryForObject(sql, map, Integer.class);

        return total;
    }

    //查詢所有訂單
    @Override
    public List<Order> getOrders(OrderQueryParams orderQueryParams) {
        String sql = "SELECT order_id, mem_no, total_amount, order_name, order_phone, address, " +
                "status, created_date, last_modified_date " +
                "FROM psorder WHERE 1 = 1";

        Map<String, Object> map = new HashMap<>();

        //查詢條件
        sql = addFilteringSql(sql, map, orderQueryParams);

        //排序
        sql = sql + " ORDER BY created_date DESC";

        //分頁
        sql = sql + " LIMIT :limit OFFSET :offset";
        map.put("limit", orderQueryParams.getLimit());
        map.put("offset", orderQueryParams.getOffset());

        List<Order> orderList = namedParameterJdbcTemplate.query(sql, map, new OrderRowMapper());

        return orderList;
    }

    //查詢單一訂單
    @Override
    public Order getOrderById(Integer orderId) {
        String sql = "SELECT order_id, mem_no, total_amount, order_name, order_phone, address, " +
                "status, created_date, last_modified_date " +
                "FROM psorder WHERE order_id = :orderId";

        Map<String,Object> map = new HashMap<>();
        map.put("orderId", orderId);

        List<Order> orderList = namedParameterJdbcTemplate.query(sql, map, new OrderRowMapper());

        if (orderList.size() > 0 ){
            return orderList.get(0);
        }else {
            return null;
        }
    }

    //查詢單一訂單明細
    @Override
    public List<OrderItem> getOrderItemByOrderId(Integer orderId) {
        String sql = "SELECT oi.order_item_id, oi.order_id, oi.product_id, oi.quantity, oi.amount, p.product_name, p.image_url" +
                " FROM order_item as oi " +
                "LEFT JOIN product as p ON oi.product_id = p.product_id " +
                "WHERE oi.order_id = :orderId";

        Map<String, Object> map = new HashMap<>();
        map.put("orderId", orderId);

        List<OrderItem> orderItemList = namedParameterJdbcTemplate.query(sql, map, new OrderItemRowMapper());

        return orderItemList;
    }

    //創建訂單
    @Override
    public Integer createOrder(Integer memNo, CreateOrderRequest createOrderRequest) {
        String sql = "INSERT INTO psorder(mem_no, total_amount, order_name, order_phone, " +
                "address, status, created_date, last_modified_date) " +
                "VALUES(:memNo, :totalAmount, :orderName, :orderPhone, " +
                ":address, :status, :createdDate, :lastModifiedDate)";

        Map<String, Object> map = new HashMap<>();
        map.put("memNo", memNo);
        map.put("totalAmount", createOrderRequest.getTotalAmount());
        map.put("orderName", createOrderRequest.getOrderName());
        map.put("orderPhone", createOrderRequest.getOrderPhone());
        map.put("address", createOrderRequest.getAddress());
        map.put("status", createOrderRequest.getStatus());

        Date now = new Date();
        map.put("createdDate", now);
        map.put("lastModifiedDate", now);

        KeyHolder keyHolder = new GeneratedKeyHolder();

        namedParameterJdbcTemplate.update(sql, new MapSqlParameterSource(map), keyHolder);

        int orderId = keyHolder.getKey().intValue();

        return orderId;

    }

    //創建訂單明細
    @Override
    public void createOrderItems(Integer orderId, List<OrderItem> orderItemList) {

        // 使用 for loop 一條一條 sql 加入數據 ， 效率較低
//        for(OrderItem orderItem : orderItemList){
//
//            String sql = "INSERT INTO order_item(order_id, product_id, quantity, amount) " +
//                    "VALUES(:orderId, :productId, :quantity, :amount)";
//
//            Map<String, Object> map = new HashMap<>();
//            map.put("orderId", orderId);
//            map.put("productId", orderItem.getProductId());
//            map.put("quantity", orderItem.getQuantity());
//            map.put("amount", orderItem.getAmount());
//
//            namedParameterJdbcTemplate.update(sql, map);
//        }

        //使用 batchUpdate 一次性加入數據，效率更高
        String sql = "INSERT INTO order_item(order_id, product_id, quantity, amount) " +
                "VALUES(:orderId, :productId, :quantity, :amount)";

        MapSqlParameterSource[] parameterSources = new MapSqlParameterSource[orderItemList.size()];

        for(int i = 0; i < orderItemList.size(); i++){
            OrderItem orderItem = orderItemList.get(i);

            parameterSources[i] = new MapSqlParameterSource();
            parameterSources[i].addValue("orderId", orderId);
            parameterSources[i].addValue("productId", orderItem.getProductId());
            parameterSources[i].addValue("quantity", orderItem.getQuantity());
            parameterSources[i].addValue("amount", orderItem.getAmount());
        }

        namedParameterJdbcTemplate.batchUpdate(sql, parameterSources);
    }

    private String addFilteringSql(String sql, Map<String, Object> map, OrderQueryParams orderQueryParams){
        if(orderQueryParams.getMemNo() != null){
            sql = sql + " AND mem_no = :memNo";
            map.put("memNo", orderQueryParams.getMemNo());
        }
        return sql;
    }
}
