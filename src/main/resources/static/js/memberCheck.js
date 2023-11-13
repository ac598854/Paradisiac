let pathName = window.document.location.pathname;
let projectName = pathName.substring(0, pathName.substring(1).indexOf("/") + 1);
document.addEventListener('DOMContentLoaded', function() {
    const cartItems = JSON.parse(sessionStorage.getItem('cartItems'));
    if (cartItems) {
        displayCartItems(cartItems);
    } else {
        // 處理沒有購物車數據的情況，比如顯示錯誤消息或重定向
        return "購物車是空的";
    }
});
//顯示購物車內的商品
function fetchCartItems() {
    fetch(projectName + '/Cart?action=shoppingCart', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        },
    })
        .then(response => {
            if (response.ok) {
                return response.json();
            } else {
                throw new Error('Failed to fetch cart items');
            }
        })
        .then(cartItems => {
            displayCartItems(cartItems);
        })
        .catch(error => {
            console.error('Error:', error);
        });
}

function displayCartItems(cartItems) {
    const tableBody = document.getElementById('cart-items-table').querySelector('tbody');
    tableBody.innerHTML = ''; // 清空現有內容

    for (const productName in cartItems) {
        const product = cartItems[productName];
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${productName}</td>
            <td>$${product.price}</td>
            <td>${product.quantity}</td>
            <td>$${product.price * product.quantity}</td>
        `;
        tableBody.appendChild(row);
    }
}


//表單信用卡轉帳選擇
document.getElementById('payment-method').addEventListener('change', function() {
    var paymentMethod = this.value;
    var creditCardInfo = document.getElementById('credit-card-info');
    var transferInfo = document.getElementById('transfer-info');

    // Hide both additional fields initially
    creditCardInfo.style.display = 'none';
    transferInfo.style.display = 'none';

    if (paymentMethod === 'credit-card') {
        creditCardInfo.style.display = 'block';
    } else if (paymentMethod === 'transfer') {
        transferInfo.style.display = 'block';
    }
});
