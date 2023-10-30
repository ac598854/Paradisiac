package com.paradisiac.product.controller;

import com.paradisiac.product.model.Product;
import com.paradisiac.product.service.ProductService;
import com.paradisiac.productcategory.model.ProductCategory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ProductController {

    @Autowired
    private ProductService productService;

    @GetMapping("/test/{productNo}")
    public ResponseEntity<Product> getProduct(@PathVariable Integer productNo){

        Product product = productService.getProductById(productNo);

        if(product != null){
            return ResponseEntity.status(HttpStatus.OK).body(product);
        }else {
            System.out.println("沒拿到");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

}
