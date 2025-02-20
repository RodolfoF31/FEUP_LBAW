<div class="navbar bg-base-100">
    <div class="flex">
        <a href="{{ route('mainpage.index') }}" class="btn btn-ghost text-xl">
            <img src="/svg/NewLogo.svg" alt="Logo" class="h-10 aspect-square">
            Porto's Bookshelf
        </a>
    </div>
    <div class="flex-1 justify-end px-4">

        <button class="active" onclick="window.location.href='{{ route('admin.dashboard') }}'">
            <span class="btm-nav-label">Dashboard</span>
        </button>
        <div class="divider lg:divider-horizontal"></div>
        
        <button class="active" onclick="window.location.href='{{ route('admin.addProduct') }}'">
            <span class="btm-nav-label">Add Product</span>
        </button>
        <div class="divider lg:divider-horizontal"></div>

        
        <button class="active" onclick="window.location.href='{{ route('admin.manageProducts') }}'">
            <span class="btm-nav-label">Manage Products</span>
        </button>
        <div class="divider lg:divider-horizontal"></div>

       
        <button class="active" onclick="window.location.href='{{ route('admin.manageOrders') }}'">
            <span class="btm-nav-label">Manage Orders</span>
        </button>
    </div>
    <div class="flex-none gap-2">
        <div class="dropdown dropdown-end">
            <div tabindex="0" role="button" class="btn btn-ghost btn-circle avatar">
                <div class="w-10 rounded-full">
                    <img
                        alt="Profile Picture"
                        src="{{ Auth::user()->avatar ? asset('storage/avatars/' . Auth::user()->avatar) : asset('avatars/default.jpg') }}" />
                </div>
            </div>
            <ul tabindex="0" class="menu menu-sm dropdown-content bg-base-100 rounded-box z-[1] mt-3 w-52 p-2 shadow">
                <li>
                    <a href="{{ route('profile.show') }}"="justify-between">Profile</a>
                </li>
                <li><a href="{{ url('/logout') }}">Logout</a></li>
            </ul>
        </div>
    </div>
</div>
