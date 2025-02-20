<div class="bg-white border rounded-lg shadow-md p-6 w-96"> <!-- Increased width -->
    <h2 class="text-xl font-semibold mb-4">Authors</h2>

    <ul class="space-y-2">
        @foreach ($authors as $author)
            <li class="flex justify-between items-center bg-gray-100 p-3 rounded-md"> <!-- Increased padding -->
                <span>{{ $author->name }}</span>
                <form 
                    action="{{ route('admin.authors.delete', $author->id) }}" 
                    method="POST" 
                    class="inline"
                    onsubmit="return confirm('Are you sure you want to delete this author?');">
                    @csrf
                    @method('DELETE')
                    <button type="submit" class="text-red-500 hover:text-red-700">
                        &#x2715;
                    </button>
                </form>
            </li>
        @endforeach
    </ul>

   
    <form action="{{ route('admin.authors.add') }}" method="POST" class="mt-6">
        @csrf
        <div class="mb-4">
            <input 
                type="text" 
                name="name" 
                class="border rounded-md p-3 w-full" 
                placeholder="Author name" 
                required
            />
        </div>
        <div class="mb-4">
            <textarea 
                name="biography" 
                class="border rounded-md p-3 w-full h-32 resize-none" 
                placeholder="Author biography" 
                required></textarea>
        </div>
        <div class="mb-4">
            <input 
                type="number" 
                name="rating" 
                class="border rounded-md p-3 w-full" 
                placeholder="Rating (0-5)" 
                min="0" 
                max="5" 
                required
            />
        </div>
        <button 
            type="submit" 
            class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600">
            Add
        </button>
    </form>
</div>
