// 1. 初始化設定
window.onload = function() {
    loadProducts();
}

// 2. 載入商品資料
function loadProducts() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'http://localhost:8080/products', true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var productsData = JSON.parse(xhr.responseText);
            displayProducts(productsData.results);
        }
    }
    xhr.send();
}

// 3. 顯示商品資料
function displayProducts(products) {
    var productsArea = document.getElementById('productsArea');
    productsArea.innerHTML = '';

    if (products.length == 0) {
        productsArea.innerHTML = '<p>查無此商品</p>';
        return;
    }

    products.forEach(product => {
        // 檢查商品狀態，如果是下架狀態，則跳過
        if (product.status === 'STATUSOff') {
            return; // 跳過此次迴圈，不渲染該商品
        }

        var productDiv = document.createElement('div');
        productDiv.className = 'productCard';

        var productImage = document.createElement('img');
        productImage.src = product.imageUrl;
        productDiv.appendChild(productImage);

        var productName = document.createElement('h3');
        productName.innerText = product.productName;
        productDiv.appendChild(productName);

        var productPrice = document.createElement('p');
        productPrice.innerText = "NT$ " + product.price;
        productDiv.appendChild(productPrice);

        // 新增Add To Cart按鈕
        var addToCartButton = document.createElement('button');
        addToCartButton.className = 'btn btn-primary';
        addToCartButton.innerHTML = '<i class="fas fa-shopping-cart"></i> Add To Cart';

        productDiv.appendChild(addToCartButton);

        productDiv.onclick = function() {
            window.location.href = `product.html?productId=${product.productId}`;
        };
        productsArea.appendChild(productDiv);
    });
}

// 4. 商品搜尋功能
function searchProducts() {
    const query = document.getElementById('searchInput').value;
    var xhr = new XMLHttpRequest();
    let apiUrl = 'http://localhost:8080/products?search=' + encodeURIComponent(query);
    xhr.open('GET', apiUrl, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var responseData = JSON.parse(xhr.responseText);
            displayProducts(responseData.results);
        }
    }
    xhr.send();
}

function handleEnter(event) {
    if (event.keyCode === 13) {
        searchProducts();
    }
}

// 5. 分頁功能
let total = 0;
let offset = 0;
const limit = 8;

async function fetchProducts() {
    try {
        const response = await fetch(`http://localhost:8080/products?limit=${limit}&offset=${offset}`);
        if (response.ok) {
            const data = await response.json();
            const products = data.results;
            total = data.total;
            displayProducts(products);
            checkButtons(data.total);
        } else {
            console.log("Failed to fetch products");
        }
    } catch (error) {
        console.error("An error occurred:", error);
    }
}

function checkButtons(total) {
    const prevButton = document.getElementById('prevPage');
    const nextButton = document.getElementById('nextPage');

    if (offset <= 0) {
        prevButton.disabled = true;
    } else {
        prevButton.disabled = false;
    }

    if (offset + limit >= total) {
        nextButton.disabled = true;
    } else {
        nextButton.disabled = false;
    }
}

document.getElementById('prevPage').addEventListener('click', () => {
    if (offset - limit >= 0) {
        offset -= limit;
        fetchProducts();
    }
});

document.getElementById('nextPage').addEventListener('click', () => {
    offset += limit;
    fetchProducts();
});

fetchProducts();


//     // 使用jQuery的Ajax方法
//     $.ajax({
//     url: '/productFront.html', // 這裡的URL應該與後端伺服器配置的路由相匹配
//     type: 'GET', // HTTP請求類型
//     success: function(response) {
//     // 成功獲取響應後，你可以對response進行操作
//     // 例如將response插入到頁面的某個部分
//     $('#productsArea').html(response);
//     },
//     error: function(xhr, status, error) {
//     // 如果有錯誤發生，這裡會接收錯誤信息
//     console.error("Error: " + status + " - " + error);
// }
// });