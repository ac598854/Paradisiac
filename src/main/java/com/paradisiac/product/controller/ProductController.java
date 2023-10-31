package com.paradisiac.product.controller;

import com.paradisiac.product.dto.ProductRequest;
import com.paradisiac.product.model.Product;
import com.paradisiac.product.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Controller
@CrossOrigin(origins = "*")
public class ProductController {

    @Autowired
    private ProductService productService;


    // Endpoint 用於返回HTML模板
    @GetMapping("/productsView")
    public String viewProducts(Model model) {
        return "productsView";  // 返回Thymeleaf模板名稱
    }
    @GetMapping("/getProducts")
    public ResponseEntity<List<Product>> getProducts(){
        List<Product> productList = productService.getProducts();

        return ResponseEntity.status(HttpStatus.OK).body(productList);
    }

    //查詢
    @GetMapping("/getProduct/{productNo}")
    public ResponseEntity<Product> getProduct(@PathVariable Integer productNo){

        Product product = productService.getProductById(productNo);

        if(product != null){
            return ResponseEntity.status(HttpStatus.OK).body(product);
        }else {
            System.out.println("沒拿到");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    //新增
    @PostMapping("/createProducts")
    public ResponseEntity<Product> createProduct(@RequestBody @Valid ProductRequest productRequest){
        Integer productNo = productService.createProduct(productRequest);

        Product product = productService.getProductById(productNo);

        return ResponseEntity.status(HttpStatus.CREATED).body(product);
    }

    //修改
    @PutMapping("/updateProducts/{productNo}")
    public ResponseEntity<Product> updateProduct(@PathVariable Integer productNo,
                                                 @RequestBody @Valid ProductRequest productRequest){

        // 用productId檢查product是否存在
        Product product = productService.getProductById(productNo);

        if(product == null){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        //修改商品的數據
        productService.updateProduct(productNo, productRequest);

        Product updateProduct = productService.getProductById(productNo);

        return ResponseEntity.status(HttpStatus.OK).body(updateProduct);
    }

    //刪除
    @DeleteMapping("/deleteProducts/{productNo}")
    public ResponseEntity<?> deleteProduct(@PathVariable Integer productNo){
        productService.deleteProductById(productNo);

        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }


}
