package com.paradisiac.product.controller;

import com.paradisiac.product.dto.CreateOrderRequest;
import com.paradisiac.product.dto.OrderQueryParams;
import com.paradisiac.product.model.Members;
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

        // 從HttpSession中獲取用戶的memno，以驗證用戶身份
        Integer memno = (Integer) session.getAttribute("memno");
        // 如果用戶未驗證，返回未授權的HTTP響應
        if (memno == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        // 創建OrderQueryParams對象，用於查詢訂單
        OrderQueryParams orderQueryParams = new OrderQueryParams();
        orderQueryParams.setMemno(memno);
        orderQueryParams.setLimit(limit);
        orderQueryParams.setOffset(offset);

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

        // 返回包含訂單列表和分頁信息的HTTP響應
        return ResponseEntity.status(HttpStatus.OK).body(page);
    }


    // 獲取會員詳細信息
    @GetMapping("/members/details")
    public ResponseEntity<Members> getMemberDetails(HttpSession session) {
        // 從HttpSession中獲取用戶的memno，以驗證用戶身份
        Integer memno = (Integer) session.getAttribute("memno");
        // 如果用戶未驗證，返回HTTP 404未找到的響應
        if (memno == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        // 調用orderService獲取會員詳細信息並返回HTTP OK響應
        Members member = orderService.getMemberDetailsById(memno);
        return ResponseEntity.ok(member);
    }

    //新增訂單
    @PostMapping("/members/orders")
    public ResponseEntity<Order> createOrder(
            @RequestBody @Valid CreateOrderRequest createOrderRequest,HttpSession session){
        // 從HttpSession中獲取用戶的memno，以驗證用戶身份
        Integer memno = (Integer) session.getAttribute("memno");
        // 如果用戶未驗證，返回未授權的HTTP響應
        if (memno == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        // 調用orderService創建訂單
        Integer orderId =  orderService.createOrder(memno, createOrderRequest);

        // 根據訂單ID獲取訂單信息
        Order order = orderService.getOrderById(orderId);

        // 返回HTTP已創建的響應，包括創建的訂單信息
        return ResponseEntity.status(HttpStatus.CREATED).body(order);
    }

    // 獲取會話信息，主要是用戶的memno
    @GetMapping("/members/sessionInfo")
    public ResponseEntity<?> getSessionInfo(HttpSession session) {
        // 從HttpSession中獲取用戶的memno，以驗證用戶身份
        Integer memno = (Integer) session.getAttribute("memno");
        // 如果用戶未驗證，返回未授權的HTTP響應
        if (memno == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("用戶未登入");
        }
        // 返回包含memno的HTTP OK響應
        return ResponseEntity.ok(Collections.singletonMap("memno", memno));
    }
}
