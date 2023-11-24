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
function fetchOrders(memno, pageNumber = 1) {
    const limit = 10;
    const offset = (pageNumber - 1) * limit;

    fetch(projectName + `/members/orders?limit=${limit}&offset=${offset}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.statusText);
            }
            return response.json();
        })
        .then(page => {
            if (!page || !page.results) {
                throw new Error('Expected an array of orders but got: ', page.results);
            }
            createOrdersTable(page.results);
            createPagination(page, memno); // 確保在這裡調用
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
    table += '<tr><th>商品圖片</th><th>商品名稱</th><th>數量</th><th>金額</th></tr>';
    orderItems.forEach(item => {
        let formattedQuantity = item.quantity.toLocaleString('zh-TW');
        let formattedAmount = `NT$${item.amount.toLocaleString('zh-TW')}`;
        // 在每行中添加商品圖片
        table += `<tr>
                    <td><img src="${item.imageUrl}" alt="${item.productName}" style="width:50px; height:auto;"></td>
                    <td>${item.productName}</td>
                    <td>${formattedQuantity}</td>
                    <td>${formattedAmount}</td>
                  </tr>`;
    });
    table += '</table>';
    return table;
}



//==================================訂單分頁實現==============================================
function createPagination(page, memno) {
    const paginationContainer = document.getElementById('paginationContainer');
    if (!paginationContainer) return;
    paginationContainer.innerHTML = '';

    // 第一頁按鈕
    const firstPageButton = document.createElement('button');
    firstPageButton.textContent = '第一頁';
    firstPageButton.disabled = page.currentPage === 1;
    firstPageButton.onclick = function() {
        fetchOrders(memno, 1);
    };
    paginationContainer.appendChild(firstPageButton);

    // 上一頁按鈕
    const prevPageButton = document.createElement('button');
    prevPageButton.textContent = '上一頁';
    prevPageButton.disabled = page.currentPage === 1;
    prevPageButton.onclick = function() {
        fetchOrders(memno, page.currentPage - 1);
    };
    paginationContainer.appendChild(prevPageButton);

    // 分頁按鈕
    for (let i = 1; i <= page.totalPages; i++) {
        const pageButton = document.createElement('button');
        pageButton.textContent = i;
        pageButton.disabled = page.currentPage === i;
        pageButton.onclick = function() {
            fetchOrders(memno, i);
        };
        paginationContainer.appendChild(pageButton);
    }

    // 下一頁按鈕
    const nextPageButton = document.createElement('button');
    nextPageButton.textContent = '下一頁';
    nextPageButton.disabled = page.currentPage === page.totalPages;
    nextPageButton.onclick = function() {
        fetchOrders(memno, page.currentPage + 1);
    };
    paginationContainer.appendChild(nextPageButton);

    // 最後一頁按鈕
    const lastPageButton = document.createElement('button');
    lastPageButton.textContent = '最後一頁';
    lastPageButton.disabled = page.currentPage === page.totalPages;
    lastPageButton.onclick = function() {
        fetchOrders(memno, page.totalPages);
    };
    paginationContainer.appendChild(lastPageButton);
}

