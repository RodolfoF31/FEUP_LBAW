@extends('layouts.app')

<style>
  .scrollbar-hide {
    -ms-overflow-style: none;
    scrollbar-width: none;
  }

  .scrollbar-hide::-webkit-scrollbar {
    display: none;
  }
</style>

@push('scripts')
<script src="{{ asset('js/searchBar.js') }}" defer></script>
@endpush

@section('content')
<div class="container mx-auto p-4">

  <h1 class="text-3xl font-bold text-center mb-8">Porto's Bookshelf Products</h1>

  <div id="category-wrapper" class="carousel rounded-box overflow-x-auto w-full">
    <div class="flex space-x-6 overflow-x-scroll scrollbar-hide">
      @foreach ($categories as $category)
      <div class="carousel-item flex-shrink-0 rounded-full">
        <!--
        <a
          href="{{ route('mainpage.index', ['category' => $category->id]) }}"
          class="btn btn-primary w-64 h-28 text-2xl flex items-center justify-center">
          {{ $category->categoryname }}
        </a>
-->
        <input type="radio" id="category-{{ $category->id }}" name="category" value="{{ $category->id }}" class="hidden">
        <label id="label-category" for="category-{{ $category->id }}" class="btn btn-primary w-64 h-28 text-2xl flex items-center justify-center">
          {{ $category->categoryname }}
        </label>
      </div>
      @endforeach
    </div>
  </div>

  <div class="flex justify-center items-center mt-8 hidden" id="loading">
    <span class="loading loading-spinner loading-lg"></span>
  </div>

  <div id="books-container" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-4 mt-8">
    @foreach ($products as $product)
    @include('partials.product', ['product' => $product])
    @endforeach
  </div>
</div>
@endsection