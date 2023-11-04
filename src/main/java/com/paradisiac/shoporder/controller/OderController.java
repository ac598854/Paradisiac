package com.paradisiac.shoporder.controller;

import com.paradisiac.shoporder.dto.CreateOrderRequest;
import com.paradisiac.shoporder.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController
public class OderController {

    @Autowired
    private OrderService orderService;

    @PostMapping("/mems/{memNo}/orders")
    public ResponseEntity<?> createOrder(@PathVariable Integer memNo,
                                         @RequestBody @Valid CreateOrderRequest createOrderRequest){
        Integer orderId =  orderService.createOrder(memNo, createOrderRequest);

        return ResponseEntity.status(HttpStatus.CREATED).body(orderId);
    }
}
