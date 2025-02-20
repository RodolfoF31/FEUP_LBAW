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

document.addEventListener('DOMContentLoaded', () => {
    updateCartItemCount();
    updateCartSubtotal();
    

    document.querySelectorAll('.cart-btn').forEach(button => {
        button.addEventListener('click', function(event){
            event.preventDefault();
            event.stopPropagation();
            const product_id = this.closest('.book-card').dataset.productId;
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
            .catch(error => {
                console.error('Error:', error);
                // Change button color to red for 3 seconds
                button.style.backgroundColor = 'red';
                setTimeout(() => {
                    button.style.backgroundColor = '';
                }, 3000);
            });
        });
    });

    document.querySelectorAll('.product-link').forEach(link => {
        link.addEventListener('click', function(event) {
            if (event.target.closest('.cart-btn') || event.target.closest('.wishlist-btn')) {
                event.preventDefault();
            }
        });
    });
});