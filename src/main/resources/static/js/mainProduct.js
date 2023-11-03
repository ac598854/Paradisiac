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
});

// 顯示商品詳情的函數
function displayProductDetail(product) {
    const detailDiv = document.getElementById('productDetail');
    // 商品名稱
    const productName = document.createElement('h1');
    productName.innerText = product.productName;
    detailDiv.appendChild(productName);

    // 商品圖片
    const productImage = document.createElement('img');
    productImage.src = product.imageUrl;
    detailDiv.appendChild(productImage);

    // 商品價格
    const productPrice = document.createElement('p');
    productPrice.innerText = "NT$ " + product.price;
    detailDiv.appendChild(productPrice);

    // 商品描述 (假設Product物件有一個description屬性)
    const productDescription = document.createElement('p');
    productDescription.innerText = product.description;
    detailDiv.appendChild(productDescription);
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

