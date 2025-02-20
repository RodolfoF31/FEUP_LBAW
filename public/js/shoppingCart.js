document.addEventListener('DOMContentLoaded', () => {
    updateCartTotal();
    updateCartItemCount();
    updateCartSubtotal();
    document.querySelectorAll('.remove-btn').forEach(button => {
        button.addEventListener('click', function(){
            const cart_item = this.closest('.cart-item');
            const shopping_cart_product_id = cart_item.dataset.shoppingCartProductId;
            console.log('Removing product with ID:', shopping_cart_product_id);

            fetch('/shoppingCart/remove-product', {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
                },
                body: JSON.stringify({ id: shopping_cart_product_id })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    cart_item.remove();
                    updateCartTotal();
                    updateCartItemCount();
                    updateCartSubtotal();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => console.error('Error:', error));
        });
    });
    /*
    document.querySelectorAll('.cart-item').forEach(button => {
        button.addEventListener('click', function() {
            const productId = this.dataset.productId;
            window.location.href = `/product/${productId}`;
        });
    });
    */
});

function updateCartTotal(){
    const cart_price_total = document.getElementById('shoppingCart-total');
    const book_prices_array = Array.from(document.querySelectorAll('.book_price'));
    const total_prices_sum = book_prices_array.reduce((accumulator, priceElement) => {
        return accumulator + parseFloat(priceElement.textContent.replace('€', ''));
    }, 0);
    cart_price_total.textContent = 'Shopping Cart Total = ' + total_prices_sum.toFixed(2) + '€';
}

function updateCartItemCount() {
    fetch('/api/cart/item-count')
        .then(response => response.json())
        .then(data => {
            const cartItemCountElement = document.getElementById('cart-item-count');
            cartItemCountElement.textContent = data.itemCount;
            if (data.itemCount > 0) {
                cartItemCountElement.classList.add('bg-red-500');
            } else {
                cartItemCountElement.classList.remove('bg-red-500');
            }
        })
        .catch(error => {
            console.error('Error fetching cart item count:', error);
        });
}

function updateCartSubtotal() {
        fetch('/api/cart/subtotal')
            .then(response => response.json())
            .then(data => {
                const cartSubtotalElement = document.getElementById('cart-subtotal');
                cartSubtotalElement.textContent = `Subtotal: ${data.subtotal} €`;
            })
            .catch(error => {
                console.error('Error fetching cart subtotal:', error);
            });
    }