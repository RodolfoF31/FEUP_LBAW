<li class="flex justify-between items-center bg-base-100 p-3 rounded-md">
    <span>{{ $category->categoryname }}</span>
    <button type="button" class="text-error hover:text-red-700 delete-category-button" data-category-id="{{ $category->id }}">
        &#x2715;
    </button>
</li>