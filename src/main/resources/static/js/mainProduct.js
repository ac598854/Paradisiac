// 當頁面加載時取得productId並調用API
document.addEventListener('DOMContentLoaded', function() {

    // 從 URL 獲取 productId
    const urlParams = new URLSearchParams(window.location.search);
    const productId = urlParams.get('productId');

    // 使用productId調用API來獲取商品詳情
    fetch(`http://localhost:8080/products/${productId}`)
        .then(response => response.json())
        .then(product => {
            displayProductDetail(product);
        })
        .catch(error => {
            console.error('Error:', error);
        });

    // 加載相似商品
    loadSimilarProducts();
});

// 轉換種類名稱的函數
function convertCategoryToChinese(category) {
    switch (category) {
        case 'ParadisiacTheme':
            return '主題商品';
        case 'ParadisiacExquisite':
            return '精品商品';
        default:
            return category;  // 如果有其他種類，則直接返回
    }
}
// 顯示商品詳情的函數
function displayProductDetail(product) {
    const detailDiv = document.getElementById('productDetail');

    // 商品圖片
    const productImage = document.createElement('img');
    productImage.src = product.imageUrl;
    detailDiv.appendChild(productImage);

    // 創建一個表格來顯示商品資料
    const productTable = document.createElement('table');
    detailDiv.appendChild(productTable);

    const productDetails = [
        ['商品名稱', product.productName],
        ['種類', convertCategoryToChinese(product.category)], // 使用轉換函數
        ['價格', "NT$ " + product.price],
        ['庫存', product.stock], // 假設有一個stock屬性
        ['描述', product.description]
    ];

    productDetails.forEach(detail => {
        const row = productTable.insertRow();
        const cell1 = row.insertCell(0);
        const cell2 = row.insertCell(1);
        cell1.textContent = detail[0];
        cell2.textContent = detail[1];
    });
}

function loadSimilarProducts() {
    fetch('http://localhost:8080/products')
        .then(response => response.json())
        .then(data => {
            // 從所有商品中隨機選擇四個
            const shuffled = data.results.sort(() => 0.5 - Math.random());
            const selected = shuffled.slice(0, 4);

            const productsGrid = document.querySelector('.products-grid');
            selected.forEach(product => {
                const productDiv = document.createElement('div');
                productDiv.className = 'productCard';

                const productImage = document.createElement('img');
                productImage.src = product.imageUrl;
                productDiv.appendChild(productImage);

                const productName = document.createElement('h3');
                productName.innerText = product.productName;
                productDiv.appendChild(productName);

                const productPrice = document.createElement('p');
                productPrice.innerText = "NT$ " + product.price; // 假設price是數字格式
                productDiv.appendChild(productPrice);

                productsGrid.appendChild(productDiv);
            });
        })
        .catch(error => {
            console.error('Error:', error);
        });
}
