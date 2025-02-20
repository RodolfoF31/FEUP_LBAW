    <div class="card card-compact bg-base-100 w-64 shadow-xl book-card" data-product-id="{{ $product->id }}">
    <a href="{{ route('product.show', $product->id) }}" class="block product-link">
        <figure class="h-40 w-full overflow-hidden">
            <img src="{{ asset($product->image) }}" alt="{{ $product->title }}" class="object-cover w-full h-full" />
        </figure>
    </a>
        <div class="card-body">
            <h2 class="card-title">{{ $product->title }}</h2>
            <p>Description: {{ $product->description }}</p>
            <p>Price: ${{ $product->price }}</p>
            <p>Stock: {{ $product->stock }}</p>
            <p>Author: {{ $product->author->name }}</p>
            <p>Category: {{ $product->category->categoryname }}</p>
            <p class="mt-1 text-sm font-semibold">
                Rating: 
                <span class="font-normal">
                    @if ($product->reviews->isNotEmpty())
                    {{ number_format($product->reviews->avg('rating'), 1) }}
                    @else
                    Unrated
                    @endif
                </span>
            </p>
            <div class="card-actions flex justify-between space-x-2">
                <button class="btn btn-primary btn-sm cart-btn" data-product-id="{{ $product->id }}">Add to Cart</button>
                <button class="btn btn-secondary btn-sm wishlist-btn" data-product-id="{{ $product->id }}">Wishlist</button>
            </div>
        </div>
    </div>
