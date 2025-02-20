document.addEventListener('DOMContentLoaded', function () {
    console.log("editProfile.js loaded");
    const editToggle = document.getElementById('edit-toggle');
    const saveButton = document.getElementById('save-button');
    const formFields = document.querySelectorAll('#profile-form input');
    const showLoading = document.getElementById('loading');
    const wishlistItems = document.querySelectorAll('#wishlistItem');
    const orderItems = document.querySelectorAll('#orderItem');

    const newPassword = document.getElementById('new-password');
    const confirmPassword = document.getElementById('confirm-password');

    let isRequestInProgress = false;
    let originalValues = {};

    formFields.forEach(field => {
        field.disabled = true;
        field.classList.remove('editable');
    });
    saveButton.style.display = 'none';

    async function fetchData(url, options, element) {
        if (isRequestInProgress) return;
        isRequestInProgress = true;
        const deletingSpinner = element.querySelector('#deleting');
        const button = element.querySelector('button');

        deletingSpinner.classList.remove('hidden');
        button.classList.add('hidden');

        try {
            const response = await fetch(url, options);
            const data = await response.json();
            if (data.success) {
                console.log('Product removed from wishlist successfully');
                element.remove();
            } else {
                alert(data.message);
                button.classList.remove('hidden');
            }
        } catch (error) {
            console.error('Error fetching data:', error);
            button.classList.remove('hidden');
        } finally {
            deletingSpinner.classList.add('hidden');
            isRequestInProgress = false;
        }
    }

    orderItems.forEach(orderItem => {
        orderItem.addEventListener('click', function () {
            const orderId = this.dataset.orderId;
            fetch(`/order/show/${orderId}`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
                }
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Order details:', data);
                })
                .catch(error => console.error('Error:', error));
        });
    });

    wishlistItems.forEach(wishlistItem => {
        wishlistItem.addEventListener('click', function () {
            const bookId = this.querySelector('button').dataset.productId;
            console.log('clicked book id: ', bookId);

            fetchData(`/wishlist/remove-product`, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
                },
                body: JSON.stringify({ product_id: bookId })
            }, this);
        });
    });

    editToggle.addEventListener('click', function () {
        console.log('Edit toggle clicked');

        const isEditing = saveButton.style.display === 'block';

        if (!isEditing) {
            console.log('Entering edit mode');
            formFields.forEach(field => {
                originalValues[field.id] = field.value;
            });
        } else {
            console.log('Exiting edit mode, restoring original values');
            formFields.forEach(field => {
                field.value = originalValues[field.id];
            });
        }

        formFields.forEach(field => {
            field.disabled = isEditing;
            field.classList.toggle('editable', !isEditing);
            if (!isEditing) {
                field.removeAttribute('disabled');
            } else {
                field.setAttribute('disabled', 'disabled');
            }
        });

        saveButton.style.display = isEditing ? 'none' : 'block';
        editToggle.textContent = isEditing ? 'Edit Profile' : 'Cancel';
    });

    saveButton.addEventListener('click', function (event) {
        console.log('Save button clicked');
        if (newPassword.value !== confirmPassword.value) {
            console.log('Passwords do not match!');
            event.preventDefault();
            alert('Passwords do not match!');
            editToggle.click();
            return;
        }
        formFields.forEach(field => {
            field.removeAttribute('disabled');
        });
        showLoading.classList.remove('hidden');
        saveButton.style.display = 'none';
        editToggle.style.display = 'none';
    });


});
