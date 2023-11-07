// 新增的初始化下拉選單函數
function initCategoryDropdown() {
    const categories = ['ParadisiacTheme', 'ParadisiacExquisite'];

    // 初始化新增商品的下拉選單
    const addSelectElement = document.getElementById("addCategorySelect");

    // 初始化編輯商品的下拉選單
    const editSelectElement = document.getElementById("editCategorySelect");

    categories.forEach(category => {
        const option1 = document.createElement("option");
        option1.value = category;
        option1.innerText = category;
        addSelectElement.appendChild(option1);

        const option2 = option1.cloneNode(true); // 複製選項以添加到另一個下拉選單
        editSelectElement.appendChild(option2);
    });
}

// 顯示或隱藏模態框及背景
function toggleModal(modalId, overlayId, display) {
    const modalElement = document.getElementById(modalId);
    const overlayElement = document.getElementById(overlayId);

    if (modalElement && overlayElement) {
        modalElement.style.display = display;
        overlayElement.style.display = display;
    } else {
        console.error("Element not found: ", modalId, overlayId);
    }
}

function hideAllModals() {
    toggleModal("addProductModal", "overlay", "none");
    toggleModal("editProductModal", "overlayEdit", "none");
}

document.addEventListener("DOMContentLoaded",function(){
    // 初始化下拉選單
    initCategoryDropdown();
    // 顯示新增商品模態框
    document.getElementById("addProductButton").addEventListener("click", function() {
        toggleModal("addProductModal", "overlay", "block");
    });

    // 點擊模態框外面的區域時，隱藏所有模態框
    document.getElementById("overlay").addEventListener("click", hideAllModals);
    document.getElementById("overlayEdit").addEventListener("click", hideAllModals);

    // 在取消按鈕上添加點擊事件來隱藏模態框
    document.getElementById("addCancelBtn").addEventListener("click", hideAllModals);
    document.getElementById("editCancelBtn").addEventListener("click", hideAllModals);

    // 初始化：調用fetchProducts函數來獲取和顯示商品數據
    fetchProducts();
});


let total = 0; // 全局變數
let offset = 0; // 初始偏移量
const limit = 5; // 每頁的商品數量
// 逐行解釋
// 定義一個非同步函數來獲取商品數據
async function fetchProducts() {
    try {
        // 考慮到分頁，我們在請求URL中加入limit和offset參數
        const response = await fetch(`http://localhost:8080/products?limit=${limit}&offset=${offset}`);

        // 判斷如果成功獲取數據
        if (response.ok) {
            // 將返回的JSON數據轉換為JavaScript對象
            const data = await response.json();
            // 假設後端回傳的物件有一個名為 "results" 的陣列
            const products = data.results;
            total = data.total;  // 更新總數
            // 調用函數來顯示商品數據
            displayProducts(products);

            // 檢查按鈕的禁用條件
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
    const firstButton = document.getElementById('firstPage');
    const lastButton = document.getElementById('lastPage');

    if (offset <= 0) {
        prevButton.disabled = true;
        firstButton.disabled = true;  // 如果已在第一頁，禁用第一頁按鈕
    } else {
        prevButton.disabled = false;
        firstButton.disabled = false;
    }

    if (offset + limit >= total) {
        nextButton.disabled = true;
        lastButton.disabled = true;   // 如果已在最後一頁，禁用最後一頁按鈕
    } else {
        nextButton.disabled = false;
        lastButton.disabled = false;
    }
}

// 上一頁和下一頁的事件監聽
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
// 第一頁和最後一頁的事件監聽
document.getElementById('firstPage').addEventListener('click', () => {
    offset = 0;
    fetchProducts();
});

document.getElementById('lastPage').addEventListener('click', () => {
    if (total % limit === 0) {
        offset = total - limit;
    } else {
        offset = total - (total % limit);
    }
    fetchProducts();
});


// 當頁面載入時，首次調用fetchProducts以獲取商品數據
fetchProducts();

// 顯示商品數據
function displayProducts(products) {
    const tbody = document.getElementById('productTbody');
    tbody.innerHTML = ''; // 清空表格
    products.forEach(product => {
        // 創建一行新的表格內容
        const row = `<tr>
            <td>${product.productId}</td>
            <td>${product.productName}</td>
            <td><img src="${product.imageUrl}" alt="${product.productName}" width="200"></td>
            <td>${product.category}</td>
            <td>${product.stock}</td>
            <td>${product.price}</td>
            <td>${product.description}</td>
            <td>
                <button onclick="editProduct(${product.productId})">編輯</button>
            </td>
            </tr>`;
        // 將新的表格內容加到tbody中
        tbody.innerHTML += row;
    });
}
// 初始化：調用fetchProducts函數來獲取和顯示商品數據
fetchProducts();

// 新增商品
document.getElementById("addProductForm").addEventListener("submit", async function(event) {
    // 取得下拉選單中選定的商品類別
    const selectedCategory = document.getElementById("addCategorySelect").value;

    event.preventDefault();  // 阻止表單的預設提交行為

    const productName = document.getElementById("productName").value;
    const price = document.getElementById("price").value;
    // 使用下拉選單的選定值作為商品類別
    const category = selectedCategory;
    const imageUrl = document.getElementById("imageUrl").value;
    const stock = document.getElementById("stock").value;
    const description = document.getElementById("description").value;
    // 取得其他欄位...

    const productData = {
        productName,
        price,
        category,
        imageUrl,
        stock,
        description
        // 其他欄位...
    };

    try {
        const response = await fetch("http://localhost:8080/products", {
            method: "POST",
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(productData)
        });

        if (response.status === 201) {
            // 關閉模態框
            hideAllModals();  // 使用此函數直接關閉模態框和overlay
            // 重新載入商品列表
            await fetchProducts();
        } else {
            console.log("新增商品失敗");
        }
    } catch (error) {
        console.error("新增商品時發生錯誤:", error);
    }
});

// 修改商品
let currentEditingProductId = null;  // 儲存當前正在編輯的商品 ID
// 編輯商品函數
async function editProduct(productId) {
    currentEditingProductId = productId;  // 設定當前正在編輯的商品 ID

    const selectedCategory = document.getElementById("editCategorySelect").value;

    // 顯示模態框和 overlay
    toggleModal("editProductModal", "overlayEdit", "block");


    const productData = await fetch(`http://localhost:8080/products/${productId}`);
    const product = await productData.json();

    // 把產品資料填入模態框的輸入欄位
    // （這邊省略了具體代碼，但概念就是把 product 物件的各個屬性填入對應的 input 欄位）
    document.getElementById("editProductName").value = product.productName;
    document.getElementById("editPrice").value = product.price;
    document.getElementById("editCategorySelect").value = product.category;
    document.getElementById("editImageUrl").value = product.imageUrl;
    document.getElementById("editStock").value = product.stock;
    document.getElementById("editDescription").value = product.description;
}

// 編輯商品的表單提交
document.getElementById("editProductForm").addEventListener("submit", async function(event) {
    event.preventDefault();

    // 從輸入欄位中取得編輯後的商品資料
    const productName = document.getElementById("editProductName").value;
    const price = document.getElementById("editPrice").value;
    const category = document.getElementById("editCategorySelect").value;
    const imageUrl = document.getElementById("editImageUrl").value;
    const stock = document.getElementById("editStock").value;
    const description = document.getElementById("editDescription").value;
    // 取得其他欄位...

    const productData = {
        productName,
        price,
        category,
        imageUrl,
        stock,
        description
    };

    try {
        const response = await fetch(`http://localhost:8080/products/${currentEditingProductId}`, {
            method: "PUT",
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(productData)
        });

        if (response.status === 200) {
            // 重新載入商品列表
            await fetchProducts();
        } else {
            console.log("編輯商品失敗");
        }
    } catch (error) {
        console.error("編輯商品時發生錯誤:", error);
    }

    // 使用 hideAllModals 函數來隱藏模態框和 overlay
    hideAllModals();
});

function filterProductsByStatus() {
    const status = document.getElementById('displayStatus').value;
    const rows = document.getElementById('productTbody').rows;

    for (let i = 0; i < rows.length; i++) {
        const rowStatus = rows[i].getAttribute('data-status'); // 假設每行都有一個data-status屬性表示商品的狀態
        if (status === 'ALL' || status === rowStatus) {
            rows[i].style.display = '';
        } else {
            rows[i].style.display = 'none';
        }
    }
}
