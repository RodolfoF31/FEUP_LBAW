@extends('layouts.app')

@section('content')
<div style="font-family: Arial, sans-serif; color: #333; text-align: center; margin: 20px auto; max-width: 600px; padding: 20px; background-color: #f4f4f9; border: 1px solid #ddd; border-radius: 10px;">
    <h2 style="font-size: 24px; color: #4b3832; font-weight: bold; margin-bottom: 20px;">Password Reset Token</h2>
    <p style="font-size: 16px; color: #333;">Hello,</p>
    <p style="font-size: 16px; color: #333; margin-bottom: 20px;">Your password reset token is:</p>
    <h1 style="font-size: 48px; font-weight: bold; color: #4b3832; margin: 20px 0;">{{ $mailData['token'] }}</h1>
    <p style="font-size: 16px; color: #333; margin-bottom: 20px;">This token is valid for <strong>15 minutes</strong>. Please enter it in the application to reset your password.</p>
    <p style="font-size: 14px; color: #666;">If you did not request this, you can safely ignore this email.</p>
</div>
@endsection
