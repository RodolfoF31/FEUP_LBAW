document.addEventListener('DOMContentLoaded', function () {
    // Edit Review
    document.querySelectorAll('.edit-btn').forEach(button => {
        button.addEventListener('click', function () {
            const reviewItem = this.closest('.review-item');
            reviewItem.querySelector('.review-comment').classList.add('hidden');
            reviewItem.querySelector('.edit-form').classList.remove('hidden');
        });
    });

    // Update Review
    document.querySelectorAll('.update-btn').forEach(button => {
        button.addEventListener('click', function () {
            const reviewItem = this.closest('.review-item');
            const comment = reviewItem.querySelector('textarea').value;
            const rating = reviewItem.querySelector('select').value;
            const reviewId = reviewItem.dataset.reviewId;

            fetch(`/reviews/update/${reviewId}`, {
                method: 'POST',
                headers: {
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ comment, rating }),
            })
                .then(response => response.json())
                .then(data => {
                    if (data.message) {
                        alert(data.message);
                        reviewItem.querySelector('.review-comment').textContent = comment;
                        reviewItem.querySelector('.review-comment').classList.remove('hidden');
                        reviewItem.querySelector('.edit-form').classList.add('hidden');
                    }
                });
        });
    });

    // Delete Review
    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function () {
            const reviewItem = this.closest('.review-item');
            const reviewId = reviewItem.dataset.reviewId;

            fetch(`/reviews/destroy/${reviewId}`, {
                method: 'DELETE',
                headers: {
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
                },
            })
                .then(response => response.json())
                .then(data => {
                    if (data.message) {
                        alert(data.message);
                        reviewItem.remove();
                    }
                });
        });
    });
});
