@extends('layouts.app')

@section('content')
    <div class="container mx-auto p-4">
        <div class="header-container text-center mb-10">
            <h1 id="page-header" class="text-4xl font-bold text-orange-600">Shopping Cart</h1>
        </div>
        <div class="shopping-cart bg-neutral p-6 rounded-lg shadow-lg mb-24">
            <div class="cart-header flex justify-between font-bold bg-orange-600 text-white p-4 rounded-t-lg">
                <div class="header-metric flex-1 text-center">Item</div>
                <div class="header-metric flex-1 text-center">Price</div>
                <div class="header-metric flex-1 text-center"></div>
            </div>

            @foreach ($shoppingCartProducts as $shoppingCartProduct)
                @include('partials.cartItem', ['shoppingCartProduct' => $shoppingCartProduct])
            @endforeach
        </div>
        <div class="footer mt-6 text-center font-bold fixed bottom-0 left-0 w-full bg-gray-100 p-4">
            <div class="container mx-auto">
                <p id="shoppingCart-total" class="text-2xl mb-2"></p>
                <a href="{{ route('checkout') }}">
                    <button id="checkout" class="btn btn-primary">Proceed to Checkout</button>
                </a>
            </div>
        </div>
    </div>
@endsection