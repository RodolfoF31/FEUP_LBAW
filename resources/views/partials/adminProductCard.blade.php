<div class="card card-compact bg-base-100 w-64 shadow-xl">
    <figure class="h-40 w-full overflow-hidden">
        <img src="{{ asset($product->image) }}" alt="{{ $product->title }}" class="object-cover w-full h-full" />
    </figure>
    <div class="card-body">
        <h2 class="card-title">{{ $product->title }}</h2>
        <p>Description: {{ $product->description }}</p>
        <p>Price: ${{ $product->price }}</p>
        <p>Stock: {{ $product->stock }}</p>
        <p>Author: {{ $product->author->name }}</p>
        <p>Category: {{ $product->category->categoryname }}</p>
        <div class="card-actions flex justify-between">
            <a href="{{ route('products.edit', $product->id) }}" class="btn btn-secondary btn-sm">Edit</a>
            <form action="{{ route('products.destroy', $product->id) }}" method="POST" onsubmit="return confirm('Are you sure you want to delete this product?')">
            @csrf
            @method('DELETE')
            <button type="submit" class="btn btn-error btn-sm text-white">Remove</button>
            </form>
        </div>
    </div>
</div>
