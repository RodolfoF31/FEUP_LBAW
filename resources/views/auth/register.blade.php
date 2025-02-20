@extends('layouts.app')

@push('styles')
<link href="{{ asset('css/register.css') }}" rel="stylesheet">
@endpush

@section('content')
<div class="book-background">
  <div class="book-page book-page-4"></div>
  <div class="book-page book-page-3"></div>
  <div class="book-page book-page-2"></div>
  <div class="book-page book-page-1"></div>
  <div class="register-layout">
    <div class="register-left">
      <form method="POST" action="{{ route('register') }}" class="register-form">
        {{ csrf_field() }}

        <!-- Nome Completo -->
        <label for="fullname">Full Name</label>
        <input id="fullname" type="text" name="fullname" value="{{ old('fullname') }}" required autofocus>
        @if ($errors->has('fullname'))
          <span class="error">{{ $errors->first('fullname') }}</span>
        @endif

        <!-- Nome de Usuário -->
        <label for="username">User Name</label>
        <input id="username" type="text" name="username" value="{{ old('username') }}" required>
        @if ($errors->has('username'))
          <span class="error">{{ $errors->first('username') }}</span>
        @endif

        <!-- Email -->
        <label for="email">E-Mail Address</label>
        <input id="email" type="email" name="email" value="{{ old('email') }}" required>
        @if ($errors->has('email'))
          <span class="error">{{ $errors->first('email') }}</span>
        @endif

        <!-- Senha -->
        <label for="password">Password</label>
        <input id="password" type="password" name="password" required>
        @if ($errors->has('password'))
          <span class="error">{{ $errors->first('password') }}</span>
        @endif

        <!-- Confirmar Senha -->
        <label for="password_confirmation">Confirm Password</label>
        <input id="password_confirmation" type="password" name="password_confirmation" required>

        <button type="submit" class="btn-submit">Register</button>
      </form>
    </div>
    <div class="register-right">
      <h1>Create an Account</h1>
      <p>Join Porto's BookShelf and explore infinite stories and adventures.</p>
      <p style="text-align: center;">Already have an account?</p>
      <a href="{{ route('login') }}" class="btn-login">Log In</a>
    </div>
  </div>
</div>
@endsection
