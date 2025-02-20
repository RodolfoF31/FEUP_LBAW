@push('styles')
<!-- Link to the header CSS file -->
<link href="{{ url('css/header.css') }}" rel="stylesheet">
@endpush

<!-- <header class="flex items-center justify-center bg-[#403E3E] box-border w-full h-[8vh] m-0 px-4 relative z-10">

    @if (Route::is('mainpage.index'))
    <input type="search" id="search-input" placeholder="Search" class="font-teachers w-[13vw] h-[65%] m-0 pl-[60px] bg-[#5F5F5F] bg-[url('/svg/search.svg')] bg-no-repeat bg-[length:35px_35px] bg-[15px_center] outline-none border-none text-white text-[1.5em] transition-[background-position,width] duration-400 ease-in-out hover:w-[30vw] focus:w-[30vw]">
    @endif
    <div class="flex justify-center items-center m-auto p-4 w-[76%] h-full">

        <div class="flex items-center justify-end h-full flex-1">
            <a href="{{ route('shoppingCart') }}" class="pr-10 ml-10 border-r-3 border-[#202020]"><button class="font-teachers font-normal h-full m-0 p-0 bg-transparent border-none text-[1.2em] transition duration-400 ease-in-out hover:text-[#ACA49B]">Shopping Cart</button></a>
            @if (!Auth::check())
            <a href="{{ route('login')}}" class="ml-10"><button class="font-teachers font-normal h-full m-0 p-0 bg-transparent border-none text-[1.2em] transition duration-400 ease-in-out hover:text-[#ACA49B]">Log In/Register</button></a>
            @else
            <a href="{{ route('profile.show') }}" class="ml-10"><button class="font-teachers font-normal h-full m-0 p-0 bg-transparent border-none text-[1.2em] transition duration-400 ease-in-out hover:text-[#ACA49B]">My Profile</button></a>
            @endif
        </div>

        <a href="{{ route('mainpage.index') }}">
            <img src="/svg/PortosBookshelfLogo.png" alt="Porto's Bookshelf Logo" class="z-10 m-[140px_0_0_0] p-0 w-[300px] h-[300px] flex-shrink-0 object-contain select-none" />
        </a>

        <div class="flex items-center justify-start h-full flex-1">
            <button class="ml-0 pr-10 border-r-3 border-[#202020]"><span class="font-teachers font-normal h-full m-0 p-0 bg-transparent border-none text-[1.2em] transition duration-400 ease-in-out hover:text-[#ACA49B]">About Us</span></button>
            <button class="ml-10 pr-10 border-r-3 border-[#202020]"><span class="font-teachers font-normal h-full m-0 p-0 bg-transparent border-none text-[1.2em] transition duration-400 ease-in-out hover:text-[#ACA49B]">Contact Us</span></button>
            <button class="ml-10"><span class="font-teachers font-normal h-full m-0 p-0 bg-transparent border-none text-[1.2em] transition duration-400 ease-in-out hover:text-[#ACA49B]">FAQ</span></button>
        </div>
    </div>
    @if (Auth::check())
    <a class="flex items-center justify-center m-0 p-0 h-full w-auto aspect-square" href="{{ url('/logout') }}">
        <svg
            fill="#000000"
            width="70px"
            height="70px"
            viewBox="0 0 32 32"
            xmlns="http://www.w3.org/2000/svg"
            class="w-[60%] h-[60%]">
            <g id="Fill">
                <path d="M25,2H16V4h9a1,1,0,0,1,1,1V27a1,1,0,0,1-1,1H16v2h9a3,3,0,0,0,3-3V5A3,3,0,0,0,25,2Z" />
                <path class="transition-transform duration-300 ease-in-out" d="M21.58,17V15H7l4-4L9.58,9.55l-5,5a2,2,0,0,0,0,2.83l5,5L11,21,7,17Z" />
            </g>
        </svg>
    </a>
    @endif

</header>-->


<div class="navbar bg-base-100">
    <div class="flex">
        <a href="{{ route('mainpage.index') }}" class="btn btn-ghost text-xl"> <img src="/svg/NewLogo.svg" alt="Logo" class="h-10 aspect-square">
            Porto's Bookshelf</a>
    </div>
    <div class="flex-1 justify-end px-4">

        @if (!Auth::check())
        <button class="active" onclick="window.location.href='{{ route('login') }}'">
            <span class="btm-nav-label">Log In/Register</span>
        </button>
        <div class="divider lg:divider-horizontal"></div>
        @endif
        <!-- About Us -->
        <button class="active" onclick="window.location.href='{{ route('about') }}'">
            <span class="btm-nav-label">About Us</span>
        </button>
        <div class="divider lg:divider-horizontal"></div>

        <!-- Contact Us -->
        <button class="active" onclick="window.location.href='{{ route('contact') }}'">
            <span class="btm-nav-label">Contact Us</span>
        </button>
        <div class="divider lg:divider-horizontal"></div>

        <!-- FAQ -->
        <button class="active" onclick="window.location.href='{{ route('faq') }}'">
            <span class="btm-nav-label">FAQ</span>
        </button>


    </div>
    <div class="flex-none gap-2">
        @if (Route::is('mainpage.index'))
        <div class="form-control">
            <input type="text" id="search-input" placeholder="Search" class="input input-bordered w-24 md:w-auto" />
        </div>
        @endif

        @php
            $cartItemCount = 0;
            $cartSubTotal = 0;
            if(Auth::check()){
                $cartItemCount = Auth::user()->shoppingCart->getItemCount();
                $cartSubTotal = Auth::user()->shoppingCart->getValue();
            } else {
                $cart = json_decode(Cookie::get('cart', '[]'), true);
                foreach ($cart as $product_id){
                    $product = App\Models\Product::find($product_id);
                    if ($product){
                        $cartItemCount++;
                        $cartSubTotal += $product->price;
                    }
                }
            }
        @endphp

        <div class="dropdown dropdown-end">
            <div tabindex="0" role="button" class="btn btn-ghost btn-circle">
                <div class="indicator">
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="h-5 w-5"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            stroke-width="2"
                            d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
                    </svg>
                    <span id="cart-item-count" class="badge badge-sm indicator-item {{ $cartItemCount > 0 ? 'bg-red-500' : '' }}"></span>             
                </div>
            </div>
            <div
                tabindex="0"
                class="card card-compact dropdown-content bg-base-100 z-[1] mt-3 w-52 shadow">
                <div class="card-body">
                    <span id="cart-subtotal" class="text-info">Subtotal: {{ $cartSubTotal }} €</span>
                    <div class="card-actions">
                        <button class="btn btn-primary btn-block" onclick="window.location.href='{{ route('shoppingCart') }}'">View cart</button>
                    </div>
                </div>
            </div>
        </div>

        @if (Auth::check())

        <div class="dropdown dropdown-end">
            <div tabindex="0" role="button" class="btn btn-ghost btn-circle avatar">
                <div class="w-10 rounded-full">
                    <img
                        alt="Profile Picture"
                        src="{{ Auth::user()->avatar ? asset('storage/avatars/' . Auth::user()->avatar) : asset('avatars/default.jpg') }}" />
                </div>
            </div>
            <ul
                tabindex="0"
                class="menu menu-sm dropdown-content bg-base-100 rounded-box z-[1] mt-3 w-52 p-2 shadow">
                <li>
                    <a href="{{ route('profile.show') }}"="justify-between">
                        Profile
                    </a>
                </li>
                <li><a href="{{ url('/logout') }}">Logout</a></li>
            </ul>
        </div>
        @endif

    </div>
</div>