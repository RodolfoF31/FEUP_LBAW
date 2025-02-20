document.addEventListener('DOMContentLoaded', function() {
    const pusherAppKey = window.Laravel.pusherAppKey;
    const pusherCluster = window.Laravel.pusherCluster;

    const pusher = new Pusher(pusherAppKey, {
        cluster: pusherCluster,
        encrypted: true
    });

    const userId = window.Laravel.userId;

    const ordersChannel = pusher.subscribe('orders');
    const wishlistChannel = pusher.subscribe('wishlist');
    const cartChannel = pusher.subscribe('shoppingCart');

    function displayNotification(data) {
        if (data.userId == userId) {
            console.log(`New notification: ${data.message}`);

            // Create notification element
            const notificationElement = document.createElement('div');
            notificationElement.className = 'notification bg-blue-500 text-white p-4 rounded-lg shadow-lg mb-4 block text-center max-w-xs mx-auto';
            notificationElement.textContent = data.message;

            // Append notification element to the container
            const notificationContainer = document.getElementById('notification-container');
            notificationContainer.appendChild(notificationElement);

            // Automatically remove the notification after 5 seconds
            setTimeout(() => {
                notificationElement.remove();
            }, 5000);
        }
    }

    // Order Placed Notification
    ordersChannel.bind('notification-orderplaced', displayNotification);

    // Order Status Changed Notification
    ordersChannel.bind('notification-orderstatuschanged', displayNotification);

    // Wishlist Product Available Notification
    wishlistChannel.bind('notification-wishlistproductavailable', displayNotification);

    // Product Cart Price Changed Notification
    cartChannel.bind('notification-productcartpricechanged', displayNotification);
});