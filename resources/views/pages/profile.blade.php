@extends('layouts.app')

@push('scripts')
<script src="{{ asset('js/editProfile.js') }}" defer></script>
@endpush


@section('content')
<style>
    body {
        height: 100vh;
    }

    main {
        height: calc(100vh - 8vh);
    }

    section {
        height: 100%;
    }

    #delete-modal {
        z-index: 9999;
    }
</style>

<div class="flex h-full w-full flex-row m-0 p-0 bg-gray-300">
    <div class="flex flex-col h-full w-4/6 bg-gray-400">
        <div class="relative overflow-auto flex flex-row items-center h-1/4 w-auto mt-20 mx-20 p-8 bg-white rounded-xl shadow-lg">
            <div class="relative group h-4/5 aspect-square mx-auto ml-8 avatar">
                <img class="block h-full aspect-square rounded-full sm:mx-0 sm:shrink-0 hover:brightness-50" src="{{ Auth::user()->avatar ? asset('storage/avatars/' . Auth::user()->avatar) : asset('avatars/default.jpg') }}" alt="avatar" class="avatar" />
                <div class="hover:ease-in-out duration-300 rounded-full absolute inset-0 flex items-center justify-center bg-black bg-opacity-50 opacity-0 group-hover:opacity-100 backdrop-blur-sm transition-opacity cursor-pointer" onclick="document.getElementById('avatar-input').click();">
                    <span class="text-white flex items-center justify-center h-full">Edit</span>
                    <form id="avatar-form" method="POST" action="{{ route('profile.updateAvatar', ['id' => Auth::user()->id]) }}" enctype="multipart/form-data" style="display: none;">
                        @csrf
                        <input type="file" id="avatar-input" name="avatar" onchange="document.getElementById('avatar-form').submit();">
                    </form>
                </div>
            </div>
            <div class="flex-grow text-center space-y-2 sm:text-left h-full flex items-center justify-center">
                <h1 class="text-6xl">{{ Auth::user()->username }}</h1>
            </div>
        </div>
        <div class="flex flex-col rounded-xl bg-gray-100 flex-1 mx-20 my-10 h-2/4 p-10 shadow-lg">
            <form class="h-full w-full" id="profile-form" method="POST" action="{{ route('profile.update', ['id' => Auth::user()->id]) }}">
                @csrf
                <div class="w-full h-3/4 flex flex-col text-sm gap-2 overflow-y-auto">
                    <div class="flex flex-col gap-1">
                        <label for="username" class="font-bold text-secondary-content">Username</label>
                        <input type="text" id="username" name="username" class="input input-bordered flex items-center gap-2 grow" placeholder="Username" value="{{ Auth::user()->username }}" disabled />
                    </div>

                    <div class="flex flex-col gap-1">
                        <label for="fullname" class="font-bold text-secondary-content">Full Name</label>
                        <input type="text" id="fullname" name="fullname" class="input input-bordered flex items-center gap-2 grow" placeholder="Full Name" value="{{ Auth::user()->fullname }}" disabled />
                    </div>

                    <div class="flex flex-col gap-1">
                        <label for="email" class="font-bold text-secondary-content">Email</label>
                        <input type="text" id="email" name="email" class="input input-bordered flex items-center gap-2 grow" placeholder="Email" value="{{ Auth::user()->email }}" disabled />
                    </div>

                    <div class="flex flex-col gap-1">
                        <label for="shippedaddress" class="font-bold text-secondary-content">Shipping Address</label>
                        <input type="text" id="shippedaddress" name="shippedaddress" class="input input-bordered flex items-center gap-2 grow" placeholder="Shipping Address" value="{{ Auth::user()->paymentInfo->shippedaddress }}" disabled />
                    </div>

                    <div class="flex flex-col gap-1">
                        <label for="nif" class="font-bold text-secondary-content">NIF</label>
                        <input type="text" id="nif" name="nif" class="input input-bordered flex items-center gap-2 grow" placeholder="NIF" value="{{ Auth::user()->paymentInfo->nif }}" disabled />
                    </div>

                    <div class="flex flex-col gap-1">
                        <label for="cardNumber" class="font-bold text-secondary-content">Card Number</label>
                        <input type="text" id="cardNumber" name="cardNumber" class="input input-bordered flex items-center gap-2 grow" placeholder="Card Number" value="{{ Auth::user()->paymentInfo->cardnumber }}" disabled />
                    </div>

                    <div class="flex flex-col gap-1">
                        <label for="new-password" class="font-bold text-secondary-content">New Password</label>
                        <input type="password" id="new-password" name="new-password" class="input input-bordered flex items-center gap-2 grow" placeholder="New Password" disabled />
                    </div>

                    <div class="flex flex-col gap-1">
                        <label for="confirm-password" class="font-bold text-secondary-content">Confirm Password</label>
                        <input type="password" id="confirm-password" name="confirm-password" class="input input-bordered flex items-center gap-2 grow" placeholder="Confirm Password" disabled />
                    </div>


                </div>

                <div class="flex justify-center my-10 space-x-5">
                    <button type="button" id="edit-toggle" class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600">Edit Profile</button>
                    <button type="submit" id="save-button" class="bg-green-500 text-white px-4 py-2 rounded-md hover:bg-green-600" style="display: none;">Save</button>
                    <button type="button" onclick="document.getElementById('delete-modal').classList.remove('hidden');" class="bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600">Delete Account</button>
                    <span class="loading loading-spinner loading-lg text-success  item-center hidden" id="loading"></span>
                </div>
            </form>
        </div>
    </div>
    <div class="w-20 bg-gray-500"></div>
    <div class="w-20 bg-gray-600"></div>

    <div class="designDiv"></div>
    <div class="designDiv2"></div>

    <div class="bg-base-100 flex flex-col w-full">
        <div class="flex h-60  flex-col mt-20 mx-10">
            <div class="flex flex-row mb-4">
                <h1>Purchased: </h1>
                <p>{{ count($orders) }} Orders</p>
            </div>
            <div class="carousel carousel-start bg-base-300 rounded-box max-w-lg space-x-4 py-4">
                @foreach ($orders as $order)
                @include('partials.orderHistory', ['products' => $order['products'], 'id' => $order['order']['id']])
                @endforeach
            </div>
        </div>
        <a class="link link-secondary my-8 mx-10" href="{{ route('order.all')}}">View Full Purchase history</a>

        <div class="divider divider-primary mx-10"></div>
        <div class="flex h-60 flex-col mt-10 mb-20 mx-10">
            <div class="flex flex-row mb-4">
                <h1>Wishlist</h1>
            </div>
            <div class="carousel carousel-start bg-base-300 rounded-box max-w-lg space-x-4 py-4 overflow-x-auto">
                @foreach ($wishlist as $productItem)
                @include('partials.wishlistProfile', ['product' => $productItem])
                @endforeach
            </div>
        </div>
    </div>
</div>

<!-- Delete account confirmation -->
<div id="delete-modal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
    <div class="bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-lg font-bold mb-4 text-gray-800">Are you sure you want to delete your account?</h2>
        <p class="text-gray-600 mb-6">This action cannot be undone.</p>
        <div class="flex justify-end space-x-4">
            <button onclick="document.getElementById('delete-modal').classList.add('hidden');" class="bg-gray-300 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-400">No</button>
            <form method="POST" action="{{ route('account.anonymize') }}">
                @csrf
                <button type="submit" class="bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600">Yes</button>
            </form>
        </div>
    </div>
</div>

@endsection