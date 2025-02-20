<div class="card card-side bg-base-100 shadow-xl mt-8 mx-4 h-auto">
  <figure class="w-48 h-72 flex-shrink-0">
    <img src="{{ asset($product->image) }}" alt="Book Cover" class="object-cover h-full w-full" />
  </figure>
  <div class="card-body">
    <h2 class="card-title">{{$product->title}}</h2>
    <p class="mt-2 text-sm">
      {{ Str::limit($product->description, 700) }}
    </p>
    <p class="mt-2 text-sm font-semibold">
      Price: <span class="font-normal">{{$product->price}} $</span>
    </p>
    <p class="mt-2 text-sm font-semibold">
      Stock: <span class="font-normal">{{$product->stock}}</span>
    </p>
    <p class="mt-2 text-sm font-semibold">
      Author: <span class="font-normal">{{$product->author->name}}</span>
    </p>
    <p class="mt-2 text-sm font-semibold">
      Category: <span class="font-normal">{{$product->category->categoryname}}</span>
    </p>
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
    <div class="card-actions justify-start mt-4">
      <button class="btn btn-primary cart-button" data-product-id="{{ $product->id }}">Add to Cart</button>
      <button class="btn btn-secondary ml-2 wishlist-btn" data-product-id="{{ $product->id }}">Add to Wishlist</button>
    </div>
  </div>
</div>
