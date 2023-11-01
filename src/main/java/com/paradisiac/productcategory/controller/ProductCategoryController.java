package com.paradisiac.productcategory.controller;

import com.paradisiac.productcategory.model.ProductCategory;
import com.paradisiac.productcategory.service.ProductCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin(origins = "*")
public class ProductCategoryController {

    @Autowired
    private ProductCategoryService productCategoryService;

    @GetMapping("/productCategory/{productCategoryNo}")
    public ResponseEntity<ProductCategory> getProductCategory(@PathVariable Integer productCategoryNo){

        ProductCategory productCategory = productCategoryService.getProductCategoryById(productCategoryNo);

        if(productCategory != null){
            return ResponseEntity.status(HttpStatus.OK).body(productCategory);
        }else {
            System.out.println("沒拿到");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }


}
