@extends('layouts.app')

@section('content')
<div class="min-h-screen flex items-center justify-center bg-gray-100">
    <div class="w-full max-w-md bg-white shadow-lg rounded-lg p-6">
        <h2 class="text-2xl font-bold text-center text-gray-800 mb-4">Reset Your Password</h2>
        <form method="POST" action="{{ route('password.reset.post') }}" class="space-y-4">
            @csrf

            <!-- Campos ocultos para e-mail e token -->
            <input type="hidden" name="email" value="{{ session('email') }}">
            <input type="hidden" name="token" value="{{ session('token') }}">

            <!-- Campo para nova senha -->
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700">New Password</label>
                <input id="password" type="password" name="password" required
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                    placeholder="Enter new password">
            </div>

            <!-- Campo para confirmação da nova senha -->
            <div>
                <label for="password_confirmation" class="block text-sm font-medium text-gray-700">Confirm Password</label>
                <input id="password_confirmation" type="password" name="password_confirmation" required
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                    placeholder="Confirm new password">
            </div>

            <!-- Botão de envio -->
            <div>
                <button type="submit"
                    class="w-full py-2 px-4 bg-blue-600 text-white font-medium rounded-md shadow-sm hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                    Reset Password
                </button>
            </div>
        </form>
    </div>
</div>
@endsection
