document.addEventListener('DOMContentLoaded', function() {
    // 這裡 'userId' 應從用戶的登入狀態獲取，這裡僅為示例
    const userId = 2; // 使用實際從登入狀態或會話獲取的用戶ID
    fetchOrders(userId);
});

// 新增函數以處理點擊訂單事件
function showOrderDetails(order) {
    const orderDetailsElement = document.getElementById('order-details');
    orderDetailsElement.innerHTML = `
        <h3>Order #${order.orderId}</h3>
        ${order.orderItemList.map(item => `
            <p>${item.productName} - Quantity: ${item.quantity} - Amount: ${item.amount}</p>
        `).join('')}
    `;
    orderDetailsElement.style.display = 'block'; // 顯示訂單詳情
}

function fetchOrders(userId) {
    fetch(`/users/${userId}/orders`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.statusText);
            }
            return response.json();
        })
        .then(page => {
            const orders = page.results; // 使用分頁中的結果
            const ordersListElement = document.getElementById('orders');
            // 清空現有的訂單列表
            ordersListElement.innerHTML = '';
            // 建立訂單元素並添加到頁面
            orders.forEach(order => {
                const orderElement = document.createElement('div');
                orderElement.className = 'order-item';
                orderElement.innerHTML = `
                <div class="order-header">Order Id: ${order.orderId}</div>
                <div class="order-summary">
                    <div>Ordered On: ${order.createdDate}</div>
                    <div>Order Total: ${order.totalAmount}</div>
                </div>
            `;
                orderElement.addEventListener('click', function() {
                    this.classList.toggle('active'); // 當前被點擊的訂單元素
                    var details = this.nextElementSibling; // 訂單詳情元素
                    if (details.style.display === "block") {
                        details.style.display = "none";
                    } else {
                        details.style.display = "block";
                    }
                });
                // 添加訂單詳情元素
                const orderDetailsElement = document.createElement('div');
                orderDetailsElement.className = 'order-details';
                orderDetailsElement.innerHTML = getOrderDetailsHTML(order);                ordersListElement.appendChild(orderElement);
                ordersListElement.appendChild(orderDetailsElement); // 新增的代碼
            });
        })
        .catch(error => {
            console.error('There has been a problem with your fetch operation:', error);
        });

}

// 新增的函數用於生成訂單詳情的HTML
function getOrderDetailsHTML(order) {
    return order.orderItemList.map(item => `
        <p>${item.productName} - Quantity: ${item.quantity} - Amount: ${item.amount}</p>
    `).join('');
}
