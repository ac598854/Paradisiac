//單一卡片測試加入Check Order
document.getElementById('product-card').addEventListener('click', function() {
    const productId = this.dataset.productId;
    fetch(`http://localhost:8081/products/${productId}`)
        .then(response => response.json())
        .then(product => {
            // Display product details in the checkout area
            const detailsDiv = document.getElementById('product-details');
            detailsDiv.innerHTML = '<h3>' + product.productName + '</h3>' +
                '<p>Price: ' + product.price + '</p>' +
                '<p>Description: ' + product.description + '</p>';

            // Update the checkout form with the product information
            const form = document.getElementById('shipping-form');
            form.innerHTML += '<input type="hidden" name="productId" value="' + product.id + '">' +
                '<input type="hidden" name="productName" value="' + product.name + '">' +
                '<input type="hidden" name="productPrice" value="' + product.price + '">';
        })
        .catch(error => {
            console.error('Error:', error);
        });
});

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
