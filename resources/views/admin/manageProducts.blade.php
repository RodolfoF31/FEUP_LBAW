@extends('layouts.app')

@section('content')
<div class="container mx-auto p-4">
    
    <h1 class="text-3xl font-bold text-center mb-8">Manage Products</h1>
    
    
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-4">
        @foreach ($products as $product)
            @include('partials.adminProductCard', ['product' => $product])
        @endforeach
    </div>
</div>
@endsection
