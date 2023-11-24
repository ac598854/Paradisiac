//==================================獲取當前頁面的路徑名稱==============================================
let pathName = window.document.location.pathname;
//==================================從路徑名稱中提取出項目名稱==============================================
let projectName = pathName.substring(0, pathName.substring(1).indexOf("/") + 1);

//==================================取得會員servlet URL==============================================
$(document).ready(function(){
    // 加載頁尾
    $("#footer").load(projectName + "/front-end/index/footer.jsp");

    // 處理會員登入
    $.ajax({
        type: "POST",
        url: projectName + "/front-end/members/members.do?action=indexLogin",
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


//==================================當頁面加載時取得productId並調用API==============================================
document.addEventListener('DOMContentLoaded', function() {

    // 從 URL 獲取 productId
    const urlParams = new URLSearchParams(window.location.search);
    const productId = urlParams.get('productId');

    // 使用productId調用API來獲取商品詳情
    fetch(projectName + `/products/${productId}`)
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

//==================================轉換種類名稱的函數==============================================
function convertCategoryToChinese(category) {
    switch (category) {
        case 'ParadisiacTheme':
            return '主題衣服';
        case 'ParadisiacExquisite':
            return '精品配件';
        case 'ParadisiacThemeActionFigures':
            return '主題公仔';
        case 'ParadisiacExquisiteCloththing':
            return '精品衣服';
        case 'ParadisiacThemehousehold':
            return '主題日常用品';
        default:
            return category;  // 如果有其他種類，則直接返回
    }
}

//==================================顯示商品詳情的函數==============================================
function displayProductDetail(product) {
    const detailDiv = document.getElementById('productDetail');
    detailDiv.innerHTML = '';  // 清空現有的商品詳情

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

//==================================加載並展示相似商品==============================================
function loadSimilarProducts() {
    fetch(projectName + '/products')
        .then(response => response.json())
        .then(data => {
            const productsGrid = document.querySelector('.products-grid');
            productsGrid.innerHTML = ''; // 清空當前顯示的相似商品

            // 從所有商品中隨機選擇四個
            const shuffled = data.results.sort(() => 0.5 - Math.random());
            const selected = shuffled.slice(0, 4);

            selected.forEach(product => {
                const productDiv = document.createElement('div');
                productDiv.className = 'productCard';
                productDiv.addEventListener('click', () => {
                    displayProductDetail(product);  // 更新商品詳情
                    loadSimilarProducts();          // 重新加載相似商品
                });

                const productImage = document.createElement('img');
                productImage.src = product.imageUrl;
                productDiv.appendChild(productImage);

                const productName = document.createElement('h3');
                productName.innerText = product.productName;
                productDiv.appendChild(productName);

                const productPrice = document.createElement('p');
                productPrice.innerText = "NT$ " + product.price;
                productDiv.appendChild(productPrice);

                productsGrid.appendChild(productDiv);
            });
        })
        .catch(error => {
            console.error('Error:', error);
        });
}
