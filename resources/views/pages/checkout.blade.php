@extends('layouts.app')

@section('content')
<div class="min-h-screen flex flex-col items-center bg-gray-100 py-6">
    <div class="w-full max-w-4xl bg-white shadow-lg rounded-lg p-6">
        <!-- Customer Information -->
        <h2 class="text-2xl font-bold text-gray-800 mb-4">Customer Information</h2>
        <form method="POST" action="{{ route('checkout.process', ['shoppingCartId' => $shoppingCart->id]) }}" id="checkout-form">
            @csrf
            <!-- Campo oculto para o totalPrice -->
            <input type="hidden" name="totalPrice" id="totalPrice" value="{{ $totalPrice }}">

            <!-- Display Information -->
            <div id="customer-info-view">
                <div class="space-y-4">
                    <div>
                        <p class="text-sm font-medium text-gray-700">Full Name:</p>
                        <p class="text-lg text-gray-800 font-semibold">{{ $userName }}</p>
                    </div>
                    <div>
                        <p class="text-sm font-medium text-gray-700">Shipping Address:</p>
                        <p class="text-lg text-gray-800 font-semibold">{{ $paymentInfo->shippedaddress ?? 'Not provided' }}</p>
                    </div>
                    <div>
                        <p class="text-sm font-medium text-gray-700">Card Number:</p>
                        <p class="text-lg text-gray-800 font-semibold">{{ $paymentInfo->cardnumber ?? 'Not provided' }}</p>
                    </div>
                </div>
                <button type="button" id="edit-info-btn"
                    class="mt-4 py-2 px-4 bg-[#7383fb] text-white font-medium rounded-md shadow-sm hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                    Edit Information
                </button>
                <p class="text-sm text-gray-500 mt-2">*This information edit will only be valid for this order.</p>
            </div>

            <!-- Editable Form (Hidden Initially) -->
            <div id="customer-info-edit" class="hidden">
                <div class="space-y-4">
                    <!-- Full Name -->
                    <div>
                        <label for="fullname" class="block text-sm font-medium text-gray-700">Full Name</label>
                        <input type="text" id="fullname" name="fullname" value="{{ old('fullname', $userName) }}"
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>
                    <!-- Address -->
                    <div>
                        <label for="shippedaddress" class="block text-sm font-medium text-gray-700">Shipping Address</label>
                        <input type="text" id="shippedaddress" name="shippedaddress"
                            value="{{ old('shippedaddress', $paymentInfo->shippedaddress ?? '') }}"
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>
                    <!-- Card Number -->
                    <div>
                        <label for="cardnumber" class="block text-sm font-medium text-gray-700">Card Number</label>
                        <input type="text" id="cardnumber" name="cardnumber"
                            value="{{ old('cardnumber', $paymentInfo->cardnumber ?? '') }}"
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>
                </div>
                <button type="button" id="cancel-edit-btn"
                    class="mt-4 py-2 px-4 bg-red-600 text-white font-medium rounded-md shadow-sm hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2">
                    Cancel
                </button>
            </div>

            <!-- Shopping Cart Items -->
            <h2 class="text-2xl font-bold text-gray-800 mt-6 mb-4">Your Cart</h2>
            <div class="space-y-4">
                @foreach ($cartItems as $item)
                <div class="flex justify-between items-center border-b pb-2">
                    <div>
                        <p class="text-lg font-medium text-gray-700">{{ $item->title }}</p>
                        <p class="text-sm text-gray-500">€{{ number_format($item->price, 2) }}</p>
                    </div>
                    <p class="text-lg font-medium text-gray-700">€{{ number_format($item->subtotal, 2) }}</p>
                </div>
                @endforeach
                <div class="flex justify-between items-center border-t pt-2">
                    <p class="text-lg font-bold text-gray-800">Total</p>
                    <p class="text-lg font-bold text-gray-800">€{{ number_format($totalPrice, 2) }}</p>
                </div>
            </div>

            <!-- Submit Button -->
            <div class="mt-6">
                <button type="submit"
                    class="w-full py-3 px-4 bg-[#fa53da] text-white font-medium rounded-md shadow-sm hover:bg-[#7383fb] focus:outline-none focus:ring-2 focus:rbg-[#7383fb] focus:ring-offset-2">
                    Place Order
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Toggle Editable Fields -->
<script>
    document.getElementById('edit-info-btn').addEventListener('click', function () {
        document.getElementById('customer-info-view').classList.add('hidden');
        document.getElementById('customer-info-edit').classList.remove('hidden');
    });

    document.getElementById('cancel-edit-btn').addEventListener('click', function () {
        document.getElementById('customer-info-edit').classList.add('hidden');
        document.getElementById('customer-info-view').classList.remove('hidden');
    });

    // Form validation before submission
    document.getElementById('checkout-form').addEventListener('submit', function (e) {
        const totalPrice = parseFloat(document.getElementById('totalPrice').value);

        if (isNaN(totalPrice) || totalPrice <= 0) {
            e.preventDefault();
            alert('Your cart is empty or the total price is invalid. Please review your cart before placing the order.');
        }
    });
</script>
@endsection
