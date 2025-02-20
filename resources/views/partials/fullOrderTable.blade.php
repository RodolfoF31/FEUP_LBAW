<tr>
    <th class="text-center">Order {{$index+1}}</th>
    <td>{{ $order->orderdate }} </td>
    <td>{{ $order->arrivaldate }}</td>
    <td>{{ $order->shippedaddress }}</td>
    <td class="{{ $order->orderstatus == 'processing' ? 'text-error' : ($order->orderstatus == 'delivered' ? 'text-success' : 'text-warning') }}">
        {{ $order->orderstatus }}
    </td>
    <td> {{ $order->totalprice }} €</td>
    <td><button class="btn btn-primary" onclick="window.location.href='{{ route('order.show', ['id' => $order->id]) }}'">View</button></td>
</tr>