@extends('layouts.app')

@section('content')
<div class="container mx-auto p-4">
    <h1 class="text-3xl font-bold text-center mb-8">Edit Product</h1>

    <form action="{{ route('products.update', $product->id) }}" method="POST" enctype="multipart/form-data" class="max-w-lg mx-auto bg-white p-6 shadow-md">
        @csrf
        @method('PUT')
        
        <div class="mb-4">
            <label for="title" class="block text-sm font-medium text-gray-700">Title</label>
            <input type="text" id="title" name="title" value="{{ old('title', $product->title) }}" class="mt-1 block w-full border border-gray-300 rounded-md p-2" required>
        </div>
        
        <div class="mb-4">
            <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
            <textarea id="description" name="description" class="mt-1 block w-full border border-gray-300 rounded-md p-2" required>{{ old('description', $product->description) }}</textarea>
        </div>

        <div class="mb-4">
            <label for="price" class="block text-sm font-medium text-gray-700">Price</label>
            <input type="number" id="price" name="price" step="0.01" value="{{ old('price', $product->price) }}" class="mt-1 block w-full border border-gray-300 rounded-md p-2" required>
        </div>

        <div class="mb-4">
            <label for="stock" class="block text-sm font-medium text-gray-700">Stock</label>
            <input type="number" id="stock" name="stock" value="{{ old('stock', $product->stock) }}" min="0" class="mt-1 block w-full border border-gray-300 rounded-md p-2" required>
        </div>

        <div class="mb-4">
            <label for="id_category" class="block text-sm font-medium text-gray-700">Category</label>
            <select id="id_category" name="id_category" class="mt-1 block w-full border border-gray-300 rounded-md p-2" required>
                @foreach($categories as $category)
                <option value="{{ $category->id }}" {{ $category->id == old('id_category', $product->id_category) ? 'selected' : '' }}>
                    {{ $category->categoryname }}
                </option>
                @endforeach
            </select>
        </div>

        <div class="mb-4">
            <label for="id_author" class="block text-sm font-medium text-gray-700">Author</label>
            <select id="id_author" name="id_author" class="mt-1 block w-full border border-gray-300 rounded-md p-2" required>
                @foreach($authors as $author)
                <option value="{{ $author->id }}" {{ $author->id == old('id_author', $product->id_author) ? 'selected' : '' }}>
                    {{ $author->name }}
                </option>
                @endforeach
            </select>
        </div>

        <div class="mb-4">
            <label for="image" class="block text-sm font-medium text-gray-700">Image</label>
            <input type="file" id="image" name="image" class="mt-1 block w-full border border-gray-300 rounded-md p-2">
            @if($product->image)
            <p class="mt-2">Current Image: <img src="{{ asset($product->image) }}" alt="{{ $product->title }}" class="h-16 inline"></p>
            @endif
        </div>

        <button type="submit" class="btn btn-primary w-full">Update Product</button>
    </form>
</div>
@endsection
