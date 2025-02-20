@extends('layouts.app')


@section('content')

<div class="min-h-screen flex items-center justify-center bg-gray-100">
    <div class="w-full max-w-md bg-white shadow-lg rounded-lg p-6">
        <h2 class="text-2xl font-bold text-center text-gray-800 mb-4">Verify Token</h2>
        <p class="text-center text-gray-600 mb-4">A reset token was sent to: <strong>{{ session('email') }}</strong></p>
        <form method="POST" action="{{ route('password.verifyToken') }}" class="space-y-4">
            @csrf
            <input type="hidden" name="email" value="{{ session('email') }}">
            <!-- Token Field -->
            <div>
                <label for="token" class="block text-sm font-medium text-gray-700">Token</label>
                <input id="token" type="text" name="token" required maxlength="6"
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
            </div>
            <!-- Submit Button -->
            <div>
                <button type="submit"
                    class="w-full py-2 px-4 bg-blue-600 text-white font-medium rounded-md shadow-sm hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                    Verify Token
                </button>
            </div>
        </form>
    </div>
</div>
@endsection
