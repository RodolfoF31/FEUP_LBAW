document.addEventListener("DOMContentLoaded", () => {
    const banConfirmationModal = document.getElementById('ban-confirmation-modal');
    const banConfirmationMessage = document.getElementById('ban-confirmation-message');
    const confirmBanButton = document.getElementById('confirm-ban');
    let userIdToBan = null;

    document.querySelectorAll('.ban-user').forEach(button => {
        button.addEventListener('click', function(event) {
            event.preventDefault();
            userIdToBan = this.dataset.userId;
            banConfirmationMessage.textContent = `Confirm ban user with ID ${userIdToBan}?`;
            banConfirmationModal.classList.remove('hidden');
        });
    });

    document.getElementById('cancel-ban').addEventListener('click', () => {
        banConfirmationModal.classList.add('hidden');
        userIdToBan = null;
    });

    confirmBanButton.addEventListener('click', () => {
        if (userIdToBan) {
            fetch('/admin/ban-user', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
                },
                body: JSON.stringify({ user_id: userIdToBan })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('User banned successfully');
                    location.reload();
                } else {
                    alert('Failed to ban user');
                }
            })
            .catch(error => console.error('Error:', error))
            .finally(() => {
                banConfirmationModal.classList.add('hidden');
                userIdToBan = null;
            });
        }
    });
});