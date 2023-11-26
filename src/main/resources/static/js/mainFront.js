//==================================獲取當前頁面的路徑名稱==============================================
let pathName = window.document.location.pathname;
//==================================從路徑名稱中提取出項目名稱==============================================
let projectName = pathName.substring(0, pathName.substring(1).indexOf("/") + 1);

//==================================取得會員servlet URL==============================================

$(document).ready(function(){
    // 加載頁尾
    $("#footer").load(projectName+"/front-end/index/footer.jsp");

    // 處理會員登入
    $.ajax({
        type: "POST",
        url:  projectName + "/front-end/members/members.do?action=indexLogin",
        success: function(data) {
            // ... 登入邏輯
            const responseMessage = parseInt(data);
            var guided = projectName + '/front-end/index/guided.jsp';
            var guidedSignout= projectName + '/front-end/index/guidedSignout.jsp';
            if (responseMessage === 1) {
                $("#dynamicContent").load(guided);
            } else if (responseMessage === 0) {

                $("#dynamicContent").load(guidedSignout);
            }
        },
        error: function(error) {
            console.log("AJAX error:", error);
        }
    });
});

//==================================檢查頁面是否需要重新載入以清除快取==============================================
window.onpageshow = function(event) {
    var hasReloaded = sessionStorage.getItem('hasReloaded');

    if (event.persisted || hasReloaded === null) {
        // 清除瀏覽器快取
        window.location.reload(true);

        // 設定標誌表示已經進行過重新載入
        sessionStorage.setItem('hasReloaded', 'true');
    }
};

//==================================當頁面加載時，呼叫 loadProducts 函數載入商品資料==============================================
window.onload = function() {
    loadProducts();
}

//==================================載入商品資料==============================================
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
        productsArea.innerHTML = '<p class="no-products-message">No Products For You...</p>';
        return;
    }

    // 定義一個幫助函數來渲染商品項目
    function renderProduct(product, promotionDiscount) {
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

        // 新增 Add To Cart 按鈕
        var addToCartButton = document.createElement('button');
        addToCartButton.className = 'btn btn-primary';
        addToCartButton.innerHTML = '<i class="fas fa-shopping-cart add-to-cart" data-id="${product.prodNo}" data-name="${product.prodName}" data-price="${product.prodPrice}"></i> Add To Cart';
        addToCartButton.addEventListener('click', function() {
           addToCart(product.productName, promotionDiscount ? Math.ceil(promotionDiscount * product.price) : product.price, product.description, product.stock, product.productId);
        });

        addToCartButton.addEventListener('click', function(event) {
            event.stopPropagation();
        });

        productDiv.appendChild(addToCartButton);

        // 添加點擊事件來觸發模態框
        productDiv.addEventListener('click', function() {
            showProductDetailsModal(product);
        });

        console.log("if之前"+promotionDiscount);
        // 如果有相符的促銷折扣，則顯示在商品價格下面
       if (promotionDiscount) {
		    var discountedPrice = Math.ceil(promotionDiscount * product.price);
		    productPrice.innerText = `促銷價:NT$ ${discountedPrice}`; // 修改商品價格為促銷價格
		}

        productsArea.appendChild(productDiv);
    }

    // 對每個商品進行渲染
    products.forEach(product => {
        // 檢查商品狀態，如果是下架狀態，則跳過
        if (product.status === 'STATUSOff') {
            return; // 跳過此次迴圈，不渲染該商品
        }

        // 在渲染商品前，先取得促銷資訊
        getPromotion().then(promotions => {
            let foundPromotion = null;

            for (const promotionInfo of Object.values(promotions)) {
                if (promotionInfo.productNo === product.productId) {
                    foundPromotion = promotionInfo;
                    break; // 找到符合的促銷資訊後即停止搜尋
                }
            }

            const promotionDiscount = foundPromotion ? foundPromotion.discount : null;
            renderProduct(product, promotionDiscount);
        }).catch(error => {
            console.error('Error fetching promotions:', error);
            renderProduct(product, null); // 如果取得失敗，渲染商品但沒有促銷資訊
        });
    });
}

//==================================顯示商品詳情的模態框函數==============================================
function showProductDetailsModal(product) {
    // 更新模態框內容的代碼保持不變
    document.getElementById('modalProductName').innerText = product.productName;
    document.getElementById('modalProductImage').src = product.imageUrl;
    document.getElementById('modalProductPrice').innerText = "NT$ " + product.price;
    document.getElementById('modalProductDescription').innerText = product.description;
    document.getElementById('modelProductStock').innerText = "庫存剩餘： "+ product.stock + " 個";

    // 顯示模態框的代碼保持不變
    var productModal = new bootstrap.Modal(document.getElementById('productDetailModal'));
    productModal.show();

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

function addToCart(productName, price, description, stock,productId) {
    if (cart[productName]) {
        if (cart[productName].quantity >= stock) {
            Swal.fire({
                title: '加入購物車失敗',
                html: `<span style="font-weight: bold; font-family: 'Comic Sans MS', cursive; font-size: 20px;">${productName} 的庫存不足，無法再添加更多到購物車中。</span>`,
                icon: 'error',
                timer: 2000, // 設置自動消失時間（毫秒）
                showConfirmButton: false // 不顯示確認按鈕
            });
            return; // 超出庫存，不允許再添加
        } else {
            cart[productName].quantity++;
            Swal.fire({
                title: '已加入購物車',
                html: `<span style="font-weight: bold; font-family: 'Comic Sans MS', cursive; font-size: 20px;">${productName}已成功加入購物車</span>`,
                icon: 'success',
                timer: 2000, // 設置自動消失時間（毫秒）
                showConfirmButton: false // 不顯示確認按鈕
            });
        }
    } else {

        if (stock === 0) {
            Swal.fire({
                title: '加入購物車失敗',
                html: `<span style="font-weight: bold; font-family: 'Comic Sans MS', cursive; font-size: 20px;">${productName}暫時無法加入購物車，庫存不足。</span>`,
                icon: 'error',
                timer: 2000, // 設置自動消失時間（毫秒）
                showConfirmButton: false // 不顯示確認按鈕
            });
            return;
        }

        cart[productName] = {
            productId: productId,
            price: price,
            description: description,
            quantity: 1,
        };
        Swal.fire({
            title: '已加入購物車',
            html: `<span style="font-weight: bold; font-family: 'Comic Sans MS', cursive; font-size: 20px;">${productName}已成功加入購物車</span>`,
            icon: 'success',
            timer: 2000, // 設置自動消失時間（毫秒）
            showConfirmButton: false // 不顯示確認按鈕
        });
    }

    post();
    updateCartItemCount();
}


document.addEventListener("DOMContentLoaded", function () {
    cartItemCountElement = document.getElementById('cartItemCount');
    reload();
    getPromotion();

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
//        .then(data => {
//            if (data.add) {
//                alert(data.add);
//            }
//        });
}
//========================頁面加載時GET購物車====================================//
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
                console.log(cart);
                updateCartItemCount();
            }
        })
        .catch(error => {
            console.log(error);
        });
};
//========================getPromotion=================================//
function getPromotion() {
    return new Promise((resolve, reject) => {
        fetch(projectName + '/PromotionListServlet', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    throw new Error('沒有取得回應');
                }
            })
            .then(data => {
                resolve(data);
            })
            .catch(error => {
                console.log(error);
                reject(error); // 在發生錯誤時 reject Promise
            });
    });
}

//========================商品搜尋功能====================================//
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

// 處理鍵盤輸入，當按下 Enter 鍵時進行搜尋
function handleEnter(event) {
    if (event.keyCode === 13) {
        searchProducts();
    }
}

//==================================分頁功能==============================================
let total = 0;
let offset = 0;
const limit = 8;

// fetchProducts 函數用於獲取並顯示分頁的商品
async function fetchProducts() {
    try {
        const response = await fetch(projectName + `/products?limit=${limit}&offset=${offset}`);
        if (response.ok) {
            const data = await response.json();
            const products = data.results;
            total = data.total;
            displayProducts(products);
            updatePaginationButtons(total);
        } else {
            console.log("Failed to fetch products");
        }
    } catch (error) {
        console.error("An error occurred:", error);
    }
}

// 更新分頁按鈕
function updatePaginationButtons() {
    const paginationContainer = document.getElementById('paginationContainer');
    if (!paginationContainer) return;
    paginationContainer.innerHTML = '';

    const totalPages = Math.ceil(total / limit);
    const currentPage = Math.floor(offset / limit) + 1;

    // 第一頁按鈕
    const firstPageButton = createPageButton('第一頁', currentPage === 1, () => {
        offset = 0;
        fetchProducts();
    });
    paginationContainer.appendChild(firstPageButton);

    // 上一頁按鈕
    const prevPageButton = createPageButton('上一頁', currentPage === 1, () => {
        if (offset - limit >= 0) {
            offset -= limit;
            fetchProducts();
        }
    });
    paginationContainer.appendChild(prevPageButton);

    // 分頁數字按鈕
    for (let i = 1; i <= totalPages; i++) {
        const pageButton = createPageButton(i.toString(), currentPage === i, () => {
            offset = (i - 1) * limit;
            fetchProducts();
        });
        paginationContainer.appendChild(pageButton);
    }

    // 下一頁按鈕
    const nextPageButton = createPageButton('下一頁', currentPage === totalPages, () => {
        if (offset + limit < total) {
            offset += limit;
            fetchProducts();
        }
    });
    paginationContainer.appendChild(nextPageButton);

    // 最後一頁按鈕
    const lastPageButton = createPageButton('最後一頁', currentPage === totalPages, () => {
        offset = (totalPages - 1) * limit;
        fetchProducts();
    });
    paginationContainer.appendChild(lastPageButton);
}

// 創建分頁按鈕的輔助函數
function createPageButton(text, disabled, onClick) {
    const button = document.createElement('button');
    button.textContent = text;
    button.disabled = disabled;
    button.onclick = onClick;
    return button;
}


// 頁面加載時調用 fetchProducts
window.onload = function() {
    fetchProducts();
}


//==================================商品種類點擊==============================================
const categories = [
    { text: '主題衣服', value: 'ParadisiacTheme' },
    { text: '精品配件', value: 'ParadisiacExquisite' },
    { text: '主題公仔', value: 'ParadisiacThemeActionFigures' },
    { text: '精品衣服', value: 'ParadisiacExquisiteCloththing' },
    { text: '主題日常用品', value: 'ParadisiacThemehousehold' }
];

//商品種類添加點擊事件
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


//==================================顯示所有商品==============================================
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


//==================================根據類別過濾商品的函數==============================================
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