@extends('layouts.app')


@push('scripts')
<script type="text/javascript" src="{{ url('js/order.js') }}" defer></script>
@endpush

@section('content')
<a class="btn btn-accent ml-20 mt-5 pl-5" href="{{ url()->previous()}}"><svg class=" h-1/2 aspect-square" fill="#000000" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 26.676 26.676" xml:space="preserve"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g> <path d="M26.105,21.891c-0.229,0-0.439-0.131-0.529-0.346l0,0c-0.066-0.156-1.716-3.857-7.885-4.59 c-1.285-0.156-2.824-0.236-4.693-0.25v4.613c0,0.213-0.115,0.406-0.304,0.508c-0.188,0.098-0.413,0.084-0.588-0.033L0.254,13.815 C0.094,13.708,0,13.528,0,13.339c0-0.191,0.094-0.365,0.254-0.477l11.857-7.979c0.175-0.121,0.398-0.129,0.588-0.029 c0.19,0.102,0.303,0.295,0.303,0.502v4.293c2.578,0.336,13.674,2.33,13.674,11.674c0,0.271-0.191,0.508-0.459,0.562 C26.18,21.891,26.141,21.891,26.105,21.891z"></path> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> </g> </g></svg></a>
<div class="flex flex-row items-start  p-10">

    <ul class="timeline timeline-vertical">
        <li>
            <div class="timeline-start timeline-box">Processing</div>
            <div class="timeline-middle">
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                    class="text-primary h-5 w-5">
                    <path
                        fill-rule="evenodd"
                        d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z"
                        clip-rule="evenodd" />
                </svg>
            </div>
            <hr class="{{ $order->orderstatus == 'shipped' || $order->orderstatus == 'delivered' || $order->orderstatus == 'in transit' ? 'bg-primary' : '' }} my-4" />
        </li>
        <li>
            <hr class="{{ $order->orderstatus == 'shipped' || $order->orderstatus == 'delivered' || $order->orderstatus == 'in transit' ? 'bg-primary' : '' }} my-4" />
            <div class="timeline-middle">
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                    class="{{ $order->orderstatus == 'shipped' || $order->orderstatus == 'delivered' || $order->orderstatus == 'in transit' ? 'text-primary' : '' }} h-5 w-5">
                    <path
                        fill-rule="evenodd"
                        d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z"
                        clip-rule="evenodd" />
                </svg>
            </div>
            <div class="timeline-end timeline-box">Shipped</div>
            <hr class="{{ $order->orderstatus == 'delivered' || $order->orderstatus == 'in transit' ? 'bg-primary' : '' }} my-4" />
        </li>

        <li>
            <hr class="{{ $order->orderstatus == 'delivered' || $order->orderstatus == 'in transit'  ? 'bg-primary' : '' }} my-4" />
            <div class="timeline-middle">
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                    class="{{ $order->orderstatus == 'delivered' || $order->orderstatus == 'in transit' ? 'text-primary' : '' }} h-5 w-5">
                    <path
                        fill-rule="evenodd"
                        d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z"
                        clip-rule="evenodd" />
                </svg>
            </div>
            <div class="timeline-start timeline-box">In transit</div>
            <hr class="{{ $order->orderstatus == 'delivered' ? 'bg-primary' : '' }} my-4" />
        </li>



        <li>
            <hr class="{{ $order->orderstatus == 'delivered' ? 'bg-primary' : '' }} my-4" />
            <div class="timeline-end timeline-box">Delivered</div>
            <div class="timeline-middle">
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                    class="{{ $order->orderstatus == 'delivered' ? 'text-primary' : '' }} h-5 w-5">
                    <path
                        fill-rule="evenodd"
                        d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z"
                        clip-rule="evenodd" />
                </svg>
            </div>
        </li>
    </ul>

    <div class="overflow-x-auto flex-1">
        <table class="table">
            <!-- head -->
            <thead>
                <tr>
                    <th></th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                </tr>
            </thead>
            <tbody>
                @foreach($productsCount as $index => $productCount)
                @include('partials.orderTable', ['index' => $index, 'product' => $productCount['product'], 'quantity' => $productCount['count']])
                @endforeach
            </tbody>
            <thead>
                <tr>
                <tbody>

                    <th class="font-bold text-primary text-xl">Total</th>
                    <th></th>
                    <th class="font-bold text-primary text-xl">{{ $order->totalprice }} €</th>
                    <th ></th>
                </tbody>
                </tr>
            </thead>
        </table>
    </div>

</div>

<div class="flex justify-around p-4 ,-4">
    <p class="text-secondary text-xl" >Order  Date: {{ $order->orderdate }}</p>
    <p class="text-secondary text-xl" >Arrival Date: {{ $order->arrivaldate }}</p>
</div>

<div id='confirmCancel' role="alert" class="alert mb-4 hidden">
    <svg
        xmlns="http://www.w3.org/2000/svg"
        fill="none"
        viewBox="0 0 24 24"
        class="stroke-info h-6 w-6 shrink-0">
        <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
    </svg>
    <span>Are you sure you want to delete this order?</span>
    <div>
        <button id='cancelAlert' class="btn btn-sm">Cancel</button>
        <form action="{{ route('order.delete', ['id' => $order->id]) }}" method="POST">
            @csrf
            @method('DELETE')
            <button class="btn btn-sm btn-primary">Confirm</button>
        </form>
    </div>
</div>

<div class="flex justify-center"><button id="main-cancel-btn" class="btn btn-primary">Cancel Order</button></div>

@endsection