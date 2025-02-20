@extends('layouts.app')

@section('content')
<div class="min-h-screen flex items-center justify-center bg-gray-100">
    <div class="w-full max-w-4xl bg-white shadow-lg rounded-lg p-8 space-y-8">
        <!-- Header -->
        <div class="text-center">
            <h1 class="text-4xl font-bold text-gray-800">Get in Touch</h1>
            <p class="text-lg text-gray-600">We'd love to hear from you! Reach out to us for any questions, feedback, or support.</p>
        </div>

        <!-- Address Section -->
        <div>
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">Our Address</h2>
            <p class="text-lg text-gray-700">PortoBookShelf HQ</p>
            <p class="text-lg text-gray-700">123 Library Lane</p>
            <p class="text-lg text-gray-700">Porto, Portugal</p>
        </div>

        <!-- Contact Information -->
        <div>
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">Contact Information</h2>
            <p class="text-lg text-gray-700"><strong>Email:</strong> support@portobookshelf.com</p>
            <p class="text-lg text-gray-700"><strong>Phone:</strong> +351 123 456 789</p>
            <p class="text-lg text-gray-700"><strong>Hours:</strong> Monday to Friday, 9 AM - 6 PM</p>
        </div>

        <!-- Social Media Links -->
        <div>
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">Follow Us</h2>
            <p class="text-lg text-gray-700">
                <a href="https://facebook.com" target="_blank" class="text-blue-500 hover:underline">Facebook</a> |
                <a href="https://instagram.com" target="_blank" class="text-pink-500 hover:underline">Instagram</a> |
                <a href="https://twitter.com" target="_blank" class="text-blue-400 hover:underline">Twitter</a> |
                <a href="https://linkedin.com" target="_blank" class="text-blue-700 hover:underline">LinkedIn</a>
            </p>
        </div>

        <!-- FAQ Link -->
        <div>
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">Need Quick Answers?</h2>
            <p class="text-lg text-gray-700">Check our <a href="{{ route('faq') }}" class="text-blue-600 hover:underline">FAQ page</a> for frequently asked questions.</p>
        </div>
    </div>
</div>
@endsection
