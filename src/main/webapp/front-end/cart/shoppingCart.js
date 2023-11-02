document.addEventListener("DOMContentLoaded", function () {
    const cart = document.getElementById("cart");
    const products = document.getElementById("products");
    const total = document.getElementById("total");

    const cartItems = [];
    
    products.addEventListener("click", function (event) {
        if (event.target.classList.contains("add-to-cart")) {
            const product = event.target.parentElement;
            const productId = product.dataset.id;
            const productName = product.dataset.name;
            const productPrice = parseFloat(product.dataset.price);

            addToCart(productId, productName, productPrice);
        }
    });

    function addToCart(id, name, price) {
        const item = {
            id: id,
            name: name,
            price: price
        };

        cartItems.push(item);

        updateCart();
    }

    function removeFromCart(id) {
        const index = cartItems.findIndex(item => item.id === id);
        if (index !== -1) {
            cartItems.splice(index, 1);
            updateCart();
        }
    }

    function updateCart() {
        cart.innerHTML = "";
        let totalPrice = 0;

        cartItems.forEach(item => {
            const li = document.createElement("li");
            li.textContent = `${item.name} - $${item.price}`;
            const removeButton = document.createElement("button");
            removeButton.textContent = "删除";
            removeButton.addEventListener("click", () => {
                removeFromCart(item.id);
            });
            li.appendChild(removeButton);
            cart.appendChild(li);

            totalPrice += item.price;
        });

        total.textContent = totalPrice.toFixed(2);
    }
});
