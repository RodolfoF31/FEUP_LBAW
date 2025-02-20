@extends('layouts.app')

@section('content')
<div class="min-h-screen bg-gray-100 flex items-center justify-center">
    <div class="w-full max-w-2xl bg-white shadow-lg rounded-lg p-6">
        <h1 class="text-2xl font-bold text-center text-gray-800 mb-6">Frequently Asked Questions (FAQ)</h1>
        <ul class="space-y-4">
            @foreach ([
                'How do I purchase a book?' => 'Navigate through the site, select the desired book, add it to your cart, and proceed to checkout.',
                'What payment methods do you accept?' => 'We accept credit cards, debit cards, e-wallets, and bank transfers.',
                'Can I pay on delivery (COD)?' => 'Unfortunately, we do not currently offer cash on delivery.',
                'How can I track my order?' => 'Track your order status in the "My Orders" section of your profile.',
                'How long does delivery take?' => 'Delivery takes between 3 to 7 business days, depending on your location.',
                'Do you offer free shipping?' => 'Yes! We offer free shipping for orders over €50.',
                'Can I cancel my order?' => 'Yes, as long as the order has not been processed for shipping. Check the "My Orders" section for details.',
                'How do I return a book?' => 'You can request a return within 30 days of delivery. Ensure the book is in its original condition.',
                'Are there any fees for returns?' => 'Returns are free for damaged or incorrect items. For other cases, a small fee may apply.',
                'Can I exchange a book?' => 'Yes, we offer exchanges for damaged or incorrect items. For other cases, contact support.',
                'Are the books new or used?' => 'All books sold on our store are new unless specified in the product description.',
                'Can I buy e-books from the store?' => 'Yes, we offer a selection of e-books. Downloads are available in the "My Orders" section after purchase.',
                'Do you ship internationally?' => 'Yes, we deliver to various countries. Check the checkout page for options available in your region.',
                'Can I change my delivery address after placing an order?' => 'You can change the address before the order is processed. Contact support to request the change.',
                'How do I contact support?' => 'Reach us through the "Contact Us" page, where you\'ll find our contact form and email address.',
            ] as $question => $answer)
            <li class="border-b border-gray-200">
                <button type="button" 
                        class="w-full flex items-center justify-between text-left text-lg font-medium text-gray-800 py-3 focus:outline-none"
                        onclick="this.nextElementSibling.classList.toggle('hidden'); this.querySelector('svg').classList.toggle('rotate-180');">
                    <span>{{ $question }}</span>
                    <!-- Seta -->
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 transform transition-transform duration-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                    </svg>
                </button>
                <div class="hidden text-gray-700 pl-4 pb-3">
                    {{ $answer }}
                </div>
            </li>
            @endforeach
        </ul>
    </div>
</div>
@endsection
