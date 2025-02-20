@extends('layouts.app')

@push('styles')
<link href="{{ asset('css/login.css') }}" rel="stylesheet">
@endpush

@section('content')
<div class="book-background">
  <div class="book-page book-page-4"></div>
  <div class="book-page book-page-3"></div>
  <div class="book-page book-page-2"></div>
  <div class="book-page book-page-1"></div>
  <div class="book-layout">
    <div class="book-left">
      <h1>Porto's BookShelf</h1>
        <p>Your gateway to infinite stories and adventures. Welcome back!</p>
    </div>
    <div class="book-right">
        <form method="POST" action="{{ route('login') }}" class="login-form">
            {{ csrf_field() }}

            <label for="email">E-mail Address</label>
            <input id="email" type="email" name="email" value="{{ old('email') }}" required autofocus>

            @if ($errors->has('email'))
                <span class="error">{{ $errors->first('email') }}</span>
            @endif

            <label for="password">Password</label>
            <input id="password" type="password" name="password" required>

            @if ($errors->has('password'))
                <span class="error">{{ $errors->first('password') }}</span>
            @endif

            <div class="forgot-password">
            <a href="{{ route('password.request') }}">Forgot your password?</a>
            </div>

            <div class="form-buttons">
                <a href="{{ route('register') }}" class="btn-register">Register</a>
                <button type="submit" class="btn-submit">Log In</button>
            </div>
        </form>
    </div>
</div>
@endsection
