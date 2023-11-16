package com.paradisiac.product.controller;

import com.paradisiac.product.dto.CreateOrderRequest;
import com.paradisiac.product.dto.OrderQueryParams;
import com.paradisiac.product.model.Order;
import com.paradisiac.product.service.OrderService;
import com.paradisiac.product.util.Page;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import java.util.List;
import java.util.Collections;

@Valid
@RestController
public class OderController {

    @Autowired
    private OrderService orderService;

    //查詢訂單
    @GetMapping("/members/orders")
    public ResponseEntity<Page<Order>> getOrders(
            @RequestParam(defaultValue = "10") @Max(1000) @Min(0) Integer limit,
            @RequestParam(defaultValue = "0") @Min(0) Integer offset,
            HttpSession session){

        Integer memno = (Integer) session.getAttribute("memno");
        if (memno == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        OrderQueryParams orderQueryParams = new OrderQueryParams();
        orderQueryParams.setMemno(memno);
        orderQueryParams.setLimit(limit);
        orderQueryParams.setOffset(offset);

        //檢查user是否存在
//        orderService.isUserExist(memNo);

        //取得order list
        List<Order> orderList = orderService.getOrders(orderQueryParams);

        //取得order總數
        Integer count = orderService.countOrder(orderQueryParams);

        // 計算總頁數
        Integer totalPages = (int) Math.ceil((double) count / limit);

        //分頁
        Page<Order> page = new Page<>();
        page.setLimit(limit);
        page.setOffset(offset);
        page.setTotal(count);
        page.calculatePageData();

        page.setResults(orderList);

        return ResponseEntity.status(HttpStatus.OK).body(page);
    }

    //新增訂單
    @PostMapping("/members/orders")
    public ResponseEntity<Order> createOrder(
            @RequestBody @Valid CreateOrderRequest createOrderRequest,HttpSession session){
        Integer memno = (Integer) session.getAttribute("memno");
        if (memno == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        Integer orderId =  orderService.createOrder(memno, createOrderRequest);

        Order order = orderService.getOrderById(orderId);

        return ResponseEntity.status(HttpStatus.CREATED).body(order);
    }

    @GetMapping("/members/sessionInfo")
    public ResponseEntity<?> getSessionInfo(HttpSession session) {
        Integer memno = (Integer) session.getAttribute("memno");
        if (memno == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("用戶未登入");
        }
        return ResponseEntity.ok(Collections.singletonMap("memno", memno));
    }
}
