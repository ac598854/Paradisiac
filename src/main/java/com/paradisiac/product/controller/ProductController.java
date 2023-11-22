package com.paradisiac.product.controller;

import com.paradisiac.product.AmazonS3ClientService;
import com.paradisiac.product.constant.ProductCategory;
import com.paradisiac.product.constant.ProductStatus;
import com.paradisiac.product.dto.ProductQueryParams;
import com.paradisiac.product.dto.ProductRequest;
import com.paradisiac.product.model.Product;
import com.paradisiac.product.service.ProductService;
import com.paradisiac.product.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import java.util.List;

@Validated
@RestController
@CrossOrigin(origins = "*")
public class ProductController {

    @Autowired
    private AmazonS3ClientService amazonS3ClientService;
    @Autowired
    private ProductService productService;

    @GetMapping("/products")
    public ResponseEntity<Page<Product>> getProducts(
            //查詢條件 Filtering
            @RequestParam (required = false) ProductCategory category,
            @RequestParam (required = false) String search,
            //排序 Sorting
            @RequestParam (defaultValue = "created_date") String orderBy,
            @RequestParam (defaultValue = "asc") String sort,
            //分頁 Pagination
            @RequestParam (defaultValue = "8") @Max(1000) @Min(0) Integer limit,
            @RequestParam (defaultValue = "0") @Min(0) Integer offset
    ){

        ProductQueryParams productQueryParams = new ProductQueryParams();
        productQueryParams.setCategory(category);
        productQueryParams.setSearch(search);
        productQueryParams.setOrderBy(orderBy);
        productQueryParams.setSort(sort);
        productQueryParams.setLimit(limit);
        productQueryParams.setOffset(offset);

        // 取得 product list
        List<Product> productList = productService.getProducts(productQueryParams);

        // 取得 product 總數
        Integer total = productService.countProduct(productQueryParams);

        // 分頁
        Page<Product> page = new Page<>();
        page.setLimit(limit);
        page.setOffset(offset);
        page.setTotal(total);
        page.setResults(productList);

        return ResponseEntity.status(HttpStatus.OK).body(page);
    }

    //查詢
    @GetMapping("/products/{productId}")
    public ResponseEntity<Product> getProduct(@PathVariable Integer productId){
        Product product = productService.getProductById(productId);

        if (product != null) {
            return ResponseEntity.status(HttpStatus.OK).body(product);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    //新增
    @PostMapping("/products")
    public ResponseEntity<Product> createProduct(
            @RequestParam("productName") String productName,
            @RequestParam("price") Integer price,
            @RequestParam("stock") Integer stock,
            @RequestParam("description") String description,
            @RequestParam("category") ProductCategory category,
            @RequestParam("status") ProductStatus status,
            @RequestParam("image") MultipartFile image) {

        // 上傳圖片到 S3 並獲取 URL
        String imageUrl = amazonS3ClientService.uploadFileToS3Bucket(image, true);

        // 創建 ProductRequest 對象，這假設 ProductRequest 有一個設置 imageUrl 的方法
        ProductRequest productRequest = new ProductRequest();
        productRequest.setProductName(productName);
        productRequest.setPrice(price);
        productRequest.setStock(stock);
        productRequest.setDescription(description);
        productRequest.setCategory(category);
        productRequest.setStatus(status); // 假設 status 是一個 Enum
        productRequest.setImageUrl(imageUrl); // 設置圖片的 URL

        // 調用 ProductService 來創建產品
        Integer productId = productService.createProduct(productRequest);
        Product product = productService.getProductById(productId);

        // 創建 ResponseEntity 並返回
        return ResponseEntity.status(HttpStatus.CREATED).body(product);
    }

    // GEt File方法 Post API傳到資料庫

    //修改
    @PutMapping("/products/{productId}")
    public ResponseEntity<Product> updateProduct(
            @PathVariable Integer productId,
            @RequestParam("productName") String productName,
            @RequestParam("price") Integer price,
            @RequestParam("stock") Integer stock,
            @RequestParam("description") String description,
            @RequestParam("category") ProductCategory category,
            @RequestParam("status") ProductStatus status,
            @RequestParam(value = "image", required = false) MultipartFile image) {

        // 首先，检查产品是否存在
        Product existingProduct = productService.getProductById(productId);
        if (existingProduct == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        // 如果有新的图片上传，处理图片上传到 S3
        String imageUrl = existingProduct.getImageUrl(); // 使用现有的图片URL
        if (image != null && !image.isEmpty()) {
            imageUrl = amazonS3ClientService.uploadFileToS3Bucket(image, true);
        }

        // 创建 ProductRequest 对象，并设置新的信息
        ProductRequest productRequest = new ProductRequest();
        productRequest.setProductName(productName);
        productRequest.setPrice(price);
        productRequest.setStock(stock);
        productRequest.setDescription(description);
        productRequest.setCategory(category);
        productRequest.setStatus(status);
        productRequest.setImageUrl(imageUrl); // 设置新的图片URL

        // 更新产品信息
        productService.updateProduct(productId, productRequest);

        // 获取更新后的产品信息
        Product updatedProduct = productService.getProductById(productId);

        return ResponseEntity.status(HttpStatus.OK).body(updatedProduct);
    }


    //刪除
    @DeleteMapping("/products/{productId}")
    public ResponseEntity<?> deleteProduct(@PathVariable Integer productId) {

        productService.deleteProductById(productId);

        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
