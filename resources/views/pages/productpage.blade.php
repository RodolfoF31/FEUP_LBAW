@extends('layouts.app')

@section('content')
@include('partials.product-detail')
  <div class="mt-12 mx-4">
    <h2 class="text-2xl font-bold text-center mb-6">Reviews</h2>
    @include('partials.review-form')
    @include('partials.display-reviews')
  </div>
@endsection

@push('scripts')
<script src="{{ asset('js/reviews.js') }}"></script>
@endpush