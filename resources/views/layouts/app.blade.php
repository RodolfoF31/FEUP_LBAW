<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!--<link href="{{ url('css/milligram.min.css') }}" rel="stylesheet"> -->
    <link href="{{ asset('css/login.css') }}" rel="stylesheet">
    <link href="{{ asset('css/register.css') }}" rel="stylesheet">
    <link href="{{ asset('css/checkout.css') }}" rel="stylesheet"> 
    <link href="{{ asset('css/mainpage.css') }}" rel="stylesheet"> 
    <link href="{{ asset('css/shoppingCart.css') }}" rel="stylesheet">
    

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    

    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.12.14/dist/full.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://js.pusher.com/7.0/pusher.min.js" defer></script>
    <!-- Scripts -->
    <script type="text/javascript">
        // Fix for Firefox autofocus CSS bug
        // See: http://stackoverflow.com/questions/18943276/html-5-autofocus-messes-up-css-loading/18945951#18945951
    </script>
    <script type="text/javascript" src="{{ url('js/app.js') }}" defer></script>
    <script type="text/javascript" src="{{ url('js/mainpage.js') }}" defer></script>
    <script type="text/javascript" src="{{ url('js/shoppingCart.js') }}" defer></script>
    <script type="text/javascript" src="{{ url('js/product-detail.js') }}" defer></script>
    @stack('scripts')
    <script src="{{ asset('js/manageOrders.js') }}" defer></script>
    <script src="{{ asset('js/manageUsers.js') }}" defer></script>
    <script src="{{ asset('js/notifications.js') }}" defer></script>
</head>

<body>
    @php
        $isAdmin = Auth::check() && DB::table('admin')->where('id', Auth::id())->exists();
    @endphp

    @if($isAdmin)
        <x-admin-header /> 
    @else
        <x-header /> 
    @endif
    <main>
        <section id="content">
            @yield('content') <!-- Renderiza o conteúdo da página -->
        </section>
    </main>

    <script>
        window.Laravel = {
            pusherAppKey: '{{ env('PUSHER_APP_KEY') }}',
            pusherCluster: '{{ env('PUSHER_APP_CLUSTER') }}',
            userId: '{{ Auth::check() ? Auth::id() : '' }}',
        };
    </script>


    <div id="notification-container" class="fixed top-16 left-0 mt-4 ml-4"></div>
</body>

</html>