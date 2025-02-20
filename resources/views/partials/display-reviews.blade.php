<div class="mt-8">
    <h3 class="text-lg font-semibold mb-4">User Reviews</h3>
    <div class="space-y-4" id="reviews-container">
        @forelse ($reviews as $review)
        <div class="bg-base-100 p-4 rounded-lg shadow-md review-item" data-review-id="{{ $review->id }}">
            <p class="text-sm mb-2">
                <span class="text-gray-500 mr-2">{{ date('Y-m-d', strtotime($review->date)) }}</span>
                <strong>{{ $review->user->fullname }}</strong> rated 
                <span class="font-bold">{{ $review->rating }}/5</span>
            </p>
            <p class="text-sm review-comment">{{ $review->comment }}</p>

            @if ($review->id_authenticated_user === Auth::id())
            <div class="flex space-x-4 mt-4">
                <button class="text-blue-500 edit-btn">Edit</button>
                <form class="delete-form">
                    @csrf
                    <button type="button" class="text-red-500 delete-btn">Delete</button>
                </form>
            </div>

            <!-- Edit Form -->
            <div class="edit-form hidden">
                <textarea class="textarea textarea-bordered w-full mt-2">{{ $review->comment }}</textarea>
                <select class="select select-bordered w-full mt-2">
                    @for ($i = 1; $i <= 5; $i++)
                        <option value="{{ $i }}" {{ $review->rating == $i ? 'selected' : '' }}>
                            {{ $i }}
                        </option>
                    @endfor
                </select>
                <button class="btn btn-primary btn-sm mt-2 update-btn">Update</button>
            </div>
            @endif
        </div>
        @empty
        <p class="text-sm text-gray-500">No reviews yet. Be the first to leave a review!</p>
        @endforelse
    </div>
</div>
