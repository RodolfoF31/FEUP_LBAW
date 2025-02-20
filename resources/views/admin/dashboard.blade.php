@extends('layouts.app')

@push('scripts')
    <script src="{{ asset('js/manageCategoriesAdmin.js') }}" defer></script>
@endpush

@section('content')
<div class="container mx-auto text-center mt-16">
    <h1 class="text-3xl font-semibold">Admin Dashboard</h1>

    <div class="flex justify-start mt-8 space-x-8">
        @include('partials.authorManagement')
        @include('partials.adminManageCategory')
        @include('partials.userManagement', ['users' => $users])
    </div>
</div>
@endsection
