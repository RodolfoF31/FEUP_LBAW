@extends('layouts.app')

@section('content')
<div class="container mx-auto p-6 bg-base-200 rounded-lg shadow-md">
    <h1 class="text-2xl font-semibold text-center mb-6">Manage Orders</h1>
    <div class="overflow-x-auto">
        <table class="table w-full">
            <thead>
                <tr>
                    <th class="text-center text-lg">ID</th>
                    <th class="text-center text-lg">Username</th>
                    <th class="text-center text-lg">Order Date</th>
                    <th class="text-center text-lg">Arrival Date</th>
                    <th class="text-center text-lg">Total Price</th>
                    <th class="text-center text-lg">Number of Items</th>
                    <th class="text-center text-lg">Order Status</th>
                    <th class="text-center text-lg">Action</th>
                </tr>
            </thead>
            <tbody>
                @foreach($orders as $order)
                <tr>
                    <td class="text-center text-lg">{{ $order->id }}</td>
                    <td class="text-center text-lg">{{ $order->user->username }}</td>
                    <td class="text-center text-lg">{{ $order->orderdate }}</td>
                    <td class="text-center text-lg">{{ $order->arrivaldate }}</td>
                    <td class="text-center text-lg">{{ $order->totalprice }}</td>
                    <td class="text-center text-lg">{{ $order->orderProducts->count() }}</td>
                    <td class="text-center text-lg">
                        <select class="select select-bordered w-full" data-order-id="{{ $order->id }}">
                            <option value="processing" {{ $order->orderstatus == 'processing' ? 'selected' : '' }}>Processing</option>
                            <option value="shipped" {{ $order->orderstatus == 'shipped' ? 'selected' : '' }}>Shipped</option>
                            <option value="delivered" {{ $order->orderstatus == 'delivered' ? 'selected' : '' }}>Delivered</option>
                            <option value="in transit" {{ $order->orderstatus == 'in transit' ? 'selected' : '' }}>In Transit</option>
                        </select>
                    </td>
                    <td class="text-center text-lg">
                        <button class="btn btn-primary confirm-status" data-order-id="{{ $order->id }}">Confirm</button>
                    </td>
                </tr>
                @endforeach
            </tbody>
        </table>
    </div>
</div>
@endsection