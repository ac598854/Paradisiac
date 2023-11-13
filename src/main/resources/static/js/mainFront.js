//==================================獲取當前頁面的路徑名稱==============================================
let pathName = window.document.location.pathname;
//==================================從路徑名稱中提取出項目名稱==============================================
let projectName = pathName.substring(0, pathName.substring(1).indexOf("/") + 1);
//==================================頁面顯示和重新載入==============================================
window.onpageshow = function(event) {
    // 檢查是否已經進行過重新載入
    var hasReloaded = sessionStorage.getItem('hasReloaded');

    if (event.persisted || hasReloaded === null) {
        // 清除瀏覽器快取
        window.location.reload(true);

        // 設定標誌表示已經進行過重新載入
        sessionStorage.setItem('hasReloaded', 'true');
    }
};
//==================================載入商品資料==============================================
window.onload = function() {
    loadProducts();
}
function loadProducts() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', projectName + '/products', true); // 修改為動態路徑
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var productsData = JSON.parse(xhr.responseText);
            displayProducts(productsData.results);
        }
    }
    xhr.send();
}

//==================================顯示商品資料==============================================
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
        addToCartButton.innerHTML = '<i class="fas fa-shopping-cart add-to-cart" data-id="${product.prodNo}" data-name="${product.prodName}" data-price="${product.prodPrice}"></i> Add To Cart';
        addToCartButton.addEventListener('click', function() {
            addToCart(product.productName, product.price, product.description,product.stock,product.productId);
        });

        // 設置點擊事件，不再綁定原本的addToCart函數
        addToCartButton.addEventListener('click', function(event) {
            event.stopPropagation();
        })// 阻止事件冒泡到父元素

        productDiv.appendChild(addToCartButton);

        productDiv.onclick = function() {
            window.location.href = projectName + `/product.html?productId=${product.productId}`;
        };
        productsArea.appendChild(productDiv);
    });
}
//==============================加入購物車============================//
const cart = {};
let cartItemCountElement; // 購物車內數量

function updateCartItemCount() {
    let totalProductCount = 0;
    for (const product in cart) {
        totalProductCount += cart[product].quantity;
    }
    cartItemCountElement.textContent = totalProductCount;
}

function addToCart(productName, price,description,stock,productId) {
    console.log(productId);
    if (cart[productName]) {
        cart[productName].quantity++;
    } else {
        cart[productName] = {
            productId:productId,
            price: price,
            description: description,
            quantity: 1,
            stock:stock
        };
    }
    console.log(cart);
    post();
    updateCartItemCount();
}

document.addEventListener("DOMContentLoaded", function () {
    cartItemCountElement = document.getElementById('cartItemCount');
    reload();

    //            const cartButton = document.getElementById("shoppingCart");
    //            cartButton.addEventListener("click", function () {
    //                const cartPageURL = "cart.html";
    //                window.location.href = cartPageURL;
    //            });
});

//====================POST===========================================//
function post() {

    const cartJSON = JSON.stringify(cart);
    console.log("傳送的數據:" + cartJSON);
    const dataToSend = { action: 'checkout', cartData: cartJSON };

    fetch(projectName + '/Cart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json;charset=utf-8'
        },
        body: JSON.stringify(dataToSend)
    }).then(response => {
        if (response.ok) {
            return response.json();
        } else {
            throw  Error('沒有取得回應');
        }
    })
        .then(data => {
            if (data.add) {
                alert(data.add);
            }
        });
}
//========================頁面加載時GET====================================//
function reload() {
    fetch(projectName + '/Cart', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
        .then(response => {
            if (response.ok) {
                return response.json();
                console.log(response.json());
            } else {
                throw new Error('沒有取得回應');
            }
        })
        .then(data => {

            if (data.error) {
                console.log(data.error);
            } else {
                for (const productName in data) {
                    cart[productName] = data[productName];
                }

                updateCartItemCount();
            }
        })
        .catch(error => {
            console.log(error);
        });
};
//========================商品搜尋====================================//
function searchProducts() {
    const query = document.getElementById('searchInput').value;
    var xhr = new XMLHttpRequest();
    let apiUrl = projectName + '/products?search=' + encodeURIComponent(query);
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

//========================分頁====================================//
let total = 0;
let offset = 0;
const limit = 8;

async function fetchProducts() {
    try {
        const response = await fetch(projectName + `/products?limit=${limit}&offset=${offset}`);
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

//========================商品種類點擊===================================//
const categories = [
    { text: '主題商品', value: 'ParadisiacTheme' },
    { text: '精品商品', value: 'ParadisiacExquisite' },
    { text: '主題公仔', value: 'ParadisiacThemeActionFigures' },
    { text: '精品衣服', value: 'ParadisiacExquisiteCloththing' },
    { text: '主題日常用品', value: 'ParadisiacThemehousehold' }
];
//為每個商品種類添加點擊事件
document.querySelectorAll('.list-group-item').forEach(item => {
    item.addEventListener('click', function() {
        // 移除所有類別上的 "active" 標籤
        document.querySelectorAll('.list-group-item').forEach(i => {
            i.classList.remove('active');
        });

        // 僅對當前點擊的類別加上 "active" 標籤
        this.classList.add('active');

        // 判斷點擊的是否是 "All Categories"
        if (this.textContent === 'All Categories') {
            displayAllProducts(); // 呼叫函數以顯示所有商品
        } else {
            // 如果不是 "All Categories"，則找到點擊的類別對應的值
            const category = categories.find(c => c.text === this.textContent)?.value;
            if (category) {
                filterProductsByCategory(category); // 過濾該類別的商品並顯示
            }
        }
    });
});

//========================商品分類過濾===================================//
// 顯示所有商品的函數
function displayAllProducts() {
    $.ajax({
        url: projectName + '/products', // 不帶類別參數，表示請求所有商品
        type: 'GET',
        success: function(response) {
            if (response && response.results) {
                displayProducts(response.results);
            } else {
                console.error('Unexpected response structure:', response);
                productsArea.innerHTML = '<p>無法顯示商品資訊，請稍後再試。</p>';
            }
        },
        error: function(xhr, status, error) {
            console.error("Error: " + status + " - " + error);
        }
    });
}
// 根據類別過濾商品的函數
function filterProductsByCategory(categoryValue) {
    $.ajax({
        url: projectName + `/products?category=${encodeURIComponent(categoryValue)}`,
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
