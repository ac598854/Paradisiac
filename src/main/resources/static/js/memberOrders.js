//==================================獲取當前頁面的路徑名稱==============================================
let pathName = window.document.location.pathname;
//==================================從路徑名稱中提取出項目名稱==============================================
let projectName = pathName.substring(0, pathName.substring(1).indexOf("/") + 1);

//==================================取得會員servlet URL==============================================
var contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",1));

$(document).ready(function(){
    // 加載頁尾
    $("#footer").load("http://localhost:8081/Paradisiac/front-end/index/footer.jsp");

    // 處理會員登入
    $.ajax({
        type: "POST",
        url: "http://localhost:8081" + projectName + "/front-end/members/members.do?action=indexLogin",
        success: function(data) {
            // ... 登入邏輯
            const responseMessage = parseInt(data);
            var guided = contextPath + '/front-end/index/guided.jsp';
            var guidedSignout= contextPath + '/front-end/index/guidedSignout.jsp';
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


//==================================當文檔加載完成後，執行以下函數==============================================
document.addEventListener('DOMContentLoaded', function() {
    fetchMemberInfo()
        .then(memno => fetchOrders(memno))
        .catch(error => console.error('Error fetching member info:', error));
});

//==================================獲取會員信息==============================================
function fetchMemberInfo() {
    return fetch(projectName + `/members/sessionInfo`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            if (!data || !data.memno) {
                throw new Error('Member number not found in session');
            }
            return data.memno;
        });
}
//==================================獲取訂單資訊==============================================
function fetchOrders(memno) {
    fetch(projectName + `/members/orders`)
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

//==================================用來追蹤當前展開的訂單ID==============================================
let currentOpenOrderId = null;
//==================================建訂單表格==============================================
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

    ['訂單編號', '訂單日期', '總金額'].forEach(text => {
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

//==================================切換訂單詳情的顯示==============================================
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
//==================================創建訂單詳情表格==============================================
function createOrderDetailsTable(orderItems) {
    let table = '<table class="small-table" style="width: 100%">';
    table += '<tr><th>商品名稱</th><th>數量</th><th>金額</th></tr>';
    orderItems.forEach(item => {
        table += `<tr><td>${item.productName}</td><td>${item.quantity}</td><td>${item.amount}</td></tr>`;
    });
    table += '</table>';
    return table;
}