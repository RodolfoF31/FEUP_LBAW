@extends('layouts.app')

@section('content')
@include('partials.product-detail', ['product' => $product])
<div class="flex items-center justify-center min-h-screen">
    <div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-md">
        <h2 class="text-2xl font-semibold text-center mb-6">Edit Your Review</h2>
        <form action="{{ route('reviews.update', $review->id) }}" method="POST">
            @csrf
            @method('PUT')

            <!-- Rating -->
            <div class="mb-4">
                <label for="rating" class="block text-sm font-medium text-gray-700">Rating</label>
                <select name="rating" id="rating" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">
                    @for ($i = 1; $i <= 5; $i++)
                        <option value="{{ $i }}" {{ $review->rating == $i ? 'selected' : '' }}>
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
            </div>

            <!-- Comment -->
            <div class="mb-4">
                <label for="comment" class="block text-sm font-medium text-gray-700">Comment</label>
                <textarea name="comment" id="comment" rows="4" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">{{ $review->comment }}</textarea>
            </div>

            <!-- Buttons -->
            <div class="flex justify-between items-center">
                <a href="{{ route('product.show', $review->id_product) }}" class="text-gray-500 hover:text-gray-700 text-sm">Cancel</a>
                <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white font-medium py-2 px-4 rounded-lg">
                    Update Review
                </button>
            </div>
        </form>
    </div>
</div>
@endsection
