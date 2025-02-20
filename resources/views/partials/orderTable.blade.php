<tr>
    <th>{{ $index + 1 }} </th>
    <td><a class="link" href="{{ route('product.show', $product['id']) }}"> {{ $product['title']}} </a></td>
    <td> {{ $product['price'] * $quantity }} €</td>
    <td> {{ $quantity }} </td>
</tr>