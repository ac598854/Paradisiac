document.addEventListener('DOMContentLoaded', function() {
    // 這裡 'userId' 應從用戶的登入狀態獲取，這裡僅為示例
    const userId = 1; // 使用實際從登入狀態或會話獲取的用戶ID
    fetchOrders(userId);
});

function fetchOrders(userId) {
    fetch(`/users/${userId}/orders`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.statusText);
            }
            return response.json();
        })
        .then(page => {
            if (!Array.isArray(page.results)) {
                throw new Error('Expected an array of orders but got: ', page.results);
            }
            console.log(page); // 檢查API響應的結構
            createOrdersTable(page.results); // 使用page.results來創建表格
        })
        .catch(error => {
            console.error('There has been a problem with your fetch operation:', error);
        });
}

let currentOpenOrderId = null; // 用来追踪当前展开的订单ID
function createOrdersTable(orders) {
    const ordersTableContainer = document.getElementById('ordersTableContainer');
    if (!ordersTableContainer) {
        console.error('ordersTableContainer element not found');
        return;
    }
    ordersTableContainer.innerHTML = '';

    const table = document.createElement('table');
    table.className = 'table narrow-table'; // 添加新的 CSS 類
    const thead = document.createElement('thead');
    const headerRow = thead.insertRow();

    ['Order ID', 'Created Date', 'Total Amount'].forEach(text => {
        const headerCell = document.createElement('th');
        headerCell.textContent = text;
        headerRow.appendChild(headerCell);
    });

    table.appendChild(thead);

    const tbody = document.createElement('tbody');
    orders.forEach(order => {
        const row = tbody.insertRow();
        row.innerHTML = `<td>${order.orderId}</td>
                         <td>${order.createdDate}</td>
                         <td>${order.totalAmount}</td>`;
        const detailsRow = tbody.insertRow();
        detailsRow.id = `details-${order.orderId}`;
        detailsRow.style.display = 'none';

        row.addEventListener('click', () => toggleOrderDetails(order, detailsRow));
    });

    table.appendChild(tbody);
    ordersTableContainer.appendChild(table);
}

function toggleOrderDetails(order, detailsRow) {
    // 如果點擊的是當前已展開的訂單，則隱藏它
    if (currentOpenOrderId === order.orderId) {
        detailsRow.style.display = 'none';
        currentOpenOrderId = null;
        return;
    }

    // 隱藏之前展開的訂單詳細信息
    if (currentOpenOrderId !== null) {
        const previousDetailsRow = document.getElementById(`details-${currentOpenOrderId}`);
        if (previousDetailsRow) {
            previousDetailsRow.style.display = 'none';
        }
    }

    // 顯示當前訂單的詳細信息
    detailsRow.innerHTML = `<td colspan="3">${createOrderDetailsTable(order.orderItemList)}</td>`;
    detailsRow.style.display = '';
    currentOpenOrderId = order.orderId;
}

function createOrderDetailsTable(orderItems) {
    let table = '<table class="small-table" style="width: 100%">';
    table += '<tr><th>商品名稱</th><th>數量</th><th>金額</th></tr>';
    orderItems.forEach(item => {
        table += `<tr><td>${item.productName}</td><td>${item.quantity}</td><td>${item.amount}</td></tr>`;
    });
    table += '</table>';
    return table;
}
