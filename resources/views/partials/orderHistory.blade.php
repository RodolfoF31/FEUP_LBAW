<div id="orderItem" class="carousel-item h-full aspect-[3/4] cursor-pointer hover:scale-110 ease-in-out duration-300 pl-4" onclick="window.location.href='{{ route('order.show', ['id' => $id]) }}'">
    <div class="stack w-full h-full">
        @foreach ($products as $index => $product)
        @if ($index >= 3)
        @break
        @endif
        <img src="{{ $product['image'] }}" class="rounded-box h-full w-full object-cover" />
        @endforeach
    </div>
</div>