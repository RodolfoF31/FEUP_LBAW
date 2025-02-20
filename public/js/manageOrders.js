document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll('.confirm-status').forEach(button => {
        button.addEventListener('click', function(event) {
            event.preventDefault();
            const orderId = this.dataset.orderId;
            const orderStatus = document.querySelector(`select[data-order-id="${orderId}"]`).value;

            fetch('/admin/update-order-status', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
                },
                body: JSON.stringify({ order_id: orderId, orderstatus: orderStatus })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Order status updated successfully');
                } else {
                    alert('Failed to update order status');
                }
            })
            .catch(error => console.error('Error:', error));
        });
    });
});