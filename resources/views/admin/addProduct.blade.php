@extends('layouts.app')

@section('content')
<div class="flex items-center justify-center min-h-screen bg-gray-300">
    <div class="bg-white shadow-md rounded-lg p-8 w-full max-w-2xl">
        <h1 class="text-3xl font-bold mb-6 text-center">Add Product</h1>
        
        <form action="{{ route('admin.addProduct.submit') }}" method="POST" enctype="multipart/form-data" class="space-y-6">
            @csrf
            
            <div>
                <label class="block text-lg font-medium mb-2">Upload Image</label>
                <input type="file" name="book_image" class="file-input file-input-bordered w-full" />
            </div>

            
            <div>
                <label class="block text-lg font-medium mb-2">Book Title</label>
                <input type="text" name="book_title" placeholder="Enter book title" class="input input-bordered w-full" value="{{ old('book_title') }}" required />

            </div>

            
            <div>
                <label class="block text-lg font-medium mb-2">Book Description</label>
                <textarea name="book_description" placeholder="Enter book description" class="textarea textarea-bordered w-full"></textarea>
            </div>

            
            <div class="flex gap-4">
                <div class="flex-1">
                    <label class="block text-lg font-medium mb-2">Price</label>
                    <input type="number" name="book_price" placeholder="Enter price in USD" class="input input-bordered w-full" step="0.01" />
                </div>
                <div class="flex-1">
                    <label class="block text-lg font-medium mb-2">Stock</label>
                    <input type="number" name="book_stock" placeholder="Enter stock quantity" class="input input-bordered w-full" />
                </div>
            </div>

            
            <div class="flex gap-4">
                <!-- Category Dropdown -->
                <div class="flex-1">
                    <label class="block text-lg font-medium mb-2">Category</label>
                    <select 
                        id="book_category" 
                        name="book_category" 
                        class="select select-bordered w-full mt-2"
                        required>
                        <option disabled selected>Choose a category</option>
                        @foreach($categories as $category)
                            <option value="{{ $category->categoryname }}" {{ old('book_category') == $category->categoryname ? 'selected' : '' }}>
                                {{ $category->categoryname }}
                            </option>
                        @endforeach
                    </select>
                </div>

                <!-- Author Dropdown -->
                <div class="flex-1">
                    <label class="block text-lg font-medium mb-2">Author</label>
                    <select 
                        id="book_author" 
                        name="book_author" 
                        class="select select-bordered w-full mt-2"
                        required>
                        <option disabled selected>Choose an author</option>
                        @foreach($authors as $author)
                            <option value="{{ $author->name }}" {{ old('book_author') == $author->name ? 'selected' : '' }}>
                                {{ $author->name }}
                            </option>
                        @endforeach
                    </select>
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary w-full mt-4">Add Product</button>
        </form>
    </div>
</div>

<script>
    function selectCategory(categoryName) {
    document.getElementById('selectedCategory').value = categoryName;
    document.getElementById('selectedCategoryDisplay').innerText = categoryName;
}

    function selectAuthor(author) {
        document.getElementById('selectedAuthor').value = author;
        document.getElementById('selectedAuthorDisplay').textContent = `Selected Author: ${author}`;
    }
</script>
@endsection
