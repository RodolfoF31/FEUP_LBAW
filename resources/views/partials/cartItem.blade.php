<div class="cart-item flex justify-between items-center p-4 border-b border-gray-300" data-shopping-cart-product-id="{{ $shoppingCartProduct->id }}">
    <div class="item-metric flex-1 text-center text-white font-bold">
        {{ isset($shoppingCartProduct->product) ? $shoppingCartProduct->product->title : $shoppingCartProduct->title }}
        
    </div>
    <div class="item-metric flex-1 text-center text-white font-bold book_price">
        {{ isset($shoppingCartProduct->product) ? $shoppingCartProduct->product->price : $shoppingCartProduct->price }}€
    </div>
    <div class="item-metric flex-1 text-center">
        <button class="btn btn-error remove-btn">Remove</button>
    </div>
</div>