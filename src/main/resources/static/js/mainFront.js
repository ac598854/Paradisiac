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
        addToCartButton.onclick = addToCart; // 綁定事件
        // 更新 addToCartButton 的 onclick 設定
        addToCartButton.onclick = function(event) {
            addToCart(event); // 這裡傳遞事件對象
        };

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


//6.商品種類點擊
const categories = [
    { text: '主題商品', value: 'ParadisiacTheme' },
    { text: '精品商品', value: 'ParadisiacExquisite' }
];
//為每個商品種類添加點擊事件
document.querySelectorAll('.list-group-item').forEach(item => {
    item.addEventListener('click', function() {
        // 找到點擊的類別對應的值
        const category = categories.find(c => c.text === this.textContent)?.value;
        if (category) {
            filterProductsByCategory(category);
        }
    });
});

// 根據類別過濾商品的函數
function filterProductsByCategory(categoryValue) {
    $.ajax({
        url: `http://localhost:8080/products?category=${encodeURIComponent(categoryValue)}`,
        type: 'GET',
        success: function(response) {
            // 確保傳遞給 displayProducts 的是一個陣列
            if (response && response.results) {
                // 如果 response.results 是陣列，則直接使用
                displayProducts(response.results);
            } else {
                // 如果 response 就是陣列或其他問題，應進行錯誤處理
                console.error('Unexpected response structure:', response);
                // 可以選擇顯示錯誤訊息或者其他用戶友善的處理方式
                productsArea.innerHTML = '<p>無法顯示商品資訊，請稍後再試。</p>';
            }
        },
        error: function(xhr, status, error) {
            console.error("Error: " + status + " - " + error);
        }
    });
}

//更新購物車的數量
function addToCart() {
    var cartCountElement = document.getElementById('cartCount');
    var currentCount = parseInt(cartCountElement.textContent);
    cartCountElement.textContent = currentCount + 1;

    // 阻止事件冒泡
    event.stopPropagation();
}



fetchProducts();