<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\OrderController;
use App\Events\OrderPlaced;
use Illuminate\Support\Facades\Log;

class CheckoutController extends Controller
{
    public function index()
    {
        // Verifica se o usuário está autenticado
        if (!Auth::check()) {
            return redirect()->route('login')->with('error', 'Please log in to access the checkout.');
        }

        $user = Auth::user();
        $paymentInfo = $user ->paymentInfo;
        $userName = $user->fullname;
        
        // Busca o ID do carrinho do usuário
        $shoppingCart = DB::table('shoppingCart')
            ->where('id_authenticated_user', $user->id)
            ->first();

        if (!$shoppingCart) {
            return redirect()->route('mainpage.index')->with('error', 'Your shopping cart is empty.');
        }

        // Busca os produtos no carrinho do usuário
        $cartItems = DB::table('shoppingCartProduct')
            ->where('id_shopping_cart', $shoppingCart->id)
            ->join('product', 'shoppingCartProduct.id_product', '=', 'product.id')
            ->select('product.title', 'product.price', 'shoppingCartProduct.id_shopping_cart')
            ->get();

        // Calcula os subtotais e o total geral
        $cartItems = $cartItems->map(function ($item) {
            $item->subtotal = $item->price; // Ajustar se houver quantidade no design futuro
            return $item;
        });

        $totalPrice = $cartItems->sum('subtotal');

        return view('pages.checkout', [
            'cartItems' => $cartItems,
            'totalPrice' => $totalPrice,
            'paymentInfo' => $paymentInfo,
            'userName' => $userName,
            'shoppingCart' => $shoppingCart,
        ]);
    }

    public function processOrder(Request $request)
{
    // Verifica se o usuário está autenticado
    if (!Auth::check()) {
        return redirect()->route('login')->with('error', 'You must be logged in to place an order.');
    }

    $user = Auth::user();

    // Validação dos dados do formulário
    $request->validate([
        'fullname' => 'required|string|max:255',
        'shippedaddress' => 'required|string|max:255',
        'cardnumber' => 'required|string|max:19',
    ]);

    // Busca o carrinho do usuário
    $shoppingCart = DB::table('shoppingCart')
        ->where('id_authenticated_user', $user->id)
        ->first();

    if (!$shoppingCart) {
        return redirect()->route('mainpage.index')->with('error', 'Your shopping cart is empty.');
    }

    // Busca os produtos no carrinho
    $cartItems = DB::table('shoppingCartProduct')
        ->where('id_shopping_cart', $shoppingCart->id)
        ->join('product', 'shoppingCartProduct.id_product', '=', 'product.id')
        ->select('product.id as id_product', 'product.title', 'product.price', 'shoppingCartProduct.id_shopping_cart')
        ->get();

    if ($cartItems->isEmpty()) {
        return redirect()->route('mainpage.index')->with('error', 'Your shopping cart is empty.');
    }

    // Calcula o preço total
    $totalPrice = $cartItems->sum('price');

    if ($totalPrice <= 0) {
        return redirect()->route('mainpage.index')->with('error', 'Invalid order total.');
    }

    // Insere o pedido na tabela orders
    $orderData = [
        'id_authenticated_user' => $user->id,
        'shippedaddress' => $request->input('shippedaddress'), // Pode ser alterado pelo usuário
        'totalprice' => $totalPrice,
        'orderdate' => now(),
        'arrivaldate' => now()->addDays(7),
        'orderstatus' => 'processing',
    ];

    $orderId = DB::table('orders')->insertGetId($orderData);

    // Associa os itens do carrinho ao pedido
    foreach ($cartItems as $item) {
        DB::table('order_product')->insert([
            'id_order' => $orderId,
            'id_product' => $item->id_product,
        ]);
    }

    // Limpa o carrinho após o pedido
    DB::table('shoppingCartProduct')->where('id_shopping_cart', $shoppingCart->id)->delete();

        event(new OrderPlaced($user->id));

    return redirect()->route('mainpage.index')->with('success', 'Your order has been placed successfully!');
}

}
