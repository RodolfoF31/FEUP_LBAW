document.addEventListener('DOMContentLoaded', () => {
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

    document.querySelectorAll('.cart-button').forEach(button => {
        button.addEventListener('click', function(event){
            event.preventDefault();
            const product_id = this.dataset.productId;
            console.log('Adding product with ID:', product_id);

            fetch('/shoppingCart/add-product', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
                },
                body: JSON.stringify({ product_id: product_id })
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    updateCartItemCount();
                    updateCartSubtotal();
                    console.log('Product added successfully');
                } else {
                    alert(data.message);
                }
            })
            .catch(error => console.error('Error:', error));
        });
    });

    document.querySelectorAll('.wishlist-btn').forEach(button => {
        button.addEventListener('click', function(event){
            event.preventDefault();
            const product_id = this.dataset.productId;
            console.log('Adding product with ID:', product_id, 'to wishlist');

            fetch('/wishlist/add-product', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
                },
                body: JSON.stringify({ product_id: product_id })
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    console.log('Product added to wishlist successfully');
                } else {
                    alert(data.message);
                }
            })
            .catch(error => console.error('Error:', error));
        });
    });
});