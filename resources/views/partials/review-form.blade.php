<!-- User Review Form -->
<div class="bg-base-200 p-6 rounded-lg shadow-md">
    <h3 class="text-lg font-semibold mb-4">Leave a Review</h3>
    <!-- Review Form -->
    <form action="{{ route('ReviewProduct.create') }}" method="POST">
        @csrf

        <!-- Hidden Input for Product ID -->
        <input type="hidden" name="id_product" value="{{ $product->id }}">

        <!-- Comment Input -->
        <div class="mb-4">
            <label for="review-text" class="block text-sm font-medium">Your Review</label>
            <textarea 
                id="review-text" 
                name="comment" 
                class="textarea textarea-bordered w-full mt-2" 
                placeholder="Write your review here..." 
                rows="4" 
                required>{{ old('comment') }}</textarea>
            @error('comment')
                <span class="text-red-500 text-sm">{{ $message }}</span>
            @enderror
        </div>

        <!-- Rating Input -->
        <div class="mb-4">
            <label for="rating" class="block text-sm font-medium">Rating</label>
            <select 
                id="rating" 
                name="rating" 
                class="select select-bordered w-full mt-2" 
                required>
                <option disabled selected>Choose a rating</option>
           @for ($i = 1; $i <= 5; $i++)
                <option value="{{ $i }}" {{ old('rating') == $i ? 'selected' : '' }}>
                    {{ $i }} - 
                    @switch($i)
                        @case(1)
                            Poor
                            @break
                        @case(2)
                            Decent
                            @break
                        @case(3)
                            Good
                            @break
                        @case(4)
                            Very Good
                            @break
                        @case(5)
                            Excellent
                            @break  
                    @endswitch
                </option>
                @endfor

            </select>
            @error('rating')
                <span class="text-red-500 text-sm">{{ $message }}</span>
            @enderror
        </div>

        <!-- Submit Button -->
        <div class="text-right">
            <button type="submit" class="btn btn-primary">Submit Review</button>
        </div>
    </form>
</div>
