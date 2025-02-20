/*document.addEventListener('DOMContentLoaded', function () {
            function fetchNotification() {
                fetch('/notification')
                    .then(response => response.json())
                    .then(notification => {
                        const notificationContainer = document.getElementById('notification-container');
                        notificationContainer.innerHTML = '';
                        if (notification && notification.id) {
                            const notificationElement = document.createElement('div');
                            notificationElement.className = 'notification bg-blue-500 text-white p-4 rounded-lg shadow-lg mb-4 block text-center max-w-xs mx-auto';
                            notificationElement.textContent = notification.text;
                            notificationContainer.appendChild(notificationElement);

                            // Mark notification as read after 3 seconds
                            setTimeout(() => {
                                notificationElement.remove();
                                markNotificationAsRead(notification.id);
                            }, 3000);
                        }
                    })
                    .catch(error => {
                        console.error('Error fetching notification:', error);
                    });
            }

            function markNotificationAsRead(notificationId) {
                fetch(`/notification/${notificationId}/read`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                    }
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        console.log('Notification marked as read');
                    }
                })
                .catch(error => {
                    console.error('Error marking notification as read:', error);
                });
            }

            setInterval(fetchNotification, 5000); // Poll every 5 seconds
        });*/